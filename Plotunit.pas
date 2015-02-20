unit Plotunit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  extctrls,
  Dialogs, SDL_rchart, SDL_boxplot, StdCtrls, Buttons, Grids, BaseGrid,
  AdvGrid, AdvSprd, cxLabel, cxControls, cxContainer, cxEdit, cxTextEdit,
  Menus, cxLookAndFeelPainters, cxButtons, ComCtrls, cxGraphics,
  cxLookAndFeels, AdvObj, taal_unt, irricalc, dxSkinsCore, dxSkinBlack,
  dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus,
  dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010,
  dxSkinWhiteprint, dxSkinXmas2008Blue, cxStyles, dxSkinscxPCPainter,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator, Data.DB, cxDBData,
  cxGridChartView, cxGridLevel, cxClasses, cxGridCustomView,  units_unt,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid;

type

     grapobj = object
     _w1,_w2,_h1,_h2,bold : integer;
     w1,w2,h1,h2,wydte,hoogte : real;
     fixx,fixy   : real;
     ft,fl,fr,prt : integer;
     kanv        : tcanvas;
     procedure setlimit(pbox1 : tpaintbox; _kanv:tcanvas; ww1,ww2,hh1,hh2:real; nuut:boolean; l,r,t:integer);
     function px(xx:real):integer;
     function py(yy:real):integer;
     function xp(xx:real):real;
     function yp(yy:real):real;

     procedure movem(xx,yy : real);
     procedure drawm(xx,yy : real);
     procedure lline(xx1,yy1,xx2,yy2 : integer);
     procedure block(xx,yy,t1,t : integer);
     procedure diamant(xx,yy,t1,t : integer);
     procedure triang(xx,yy,t1,t : integer);
     procedure box(xx,wyd,y1,y2 :integer; coll : integer);
     procedure setpw(ww:real);
     end;




  TPlotForm = class(TForm)
    plot1: TAdvSpreadGrid;
    plot2: TAdvSpreadGrid;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    spaceCap: TcxTextEdit;
    Spacing: TcxLabel;
    discap: TcxTextEdit;
    discap1: TcxLabel;
    Dcap: TcxTextEdit;
    cxLabel1: TcxLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Y1: TcxLabel;
    s1: TcxButton;
    s2: TcxButton;
    s3: TcxButton;
    s4: TcxButton;
    header1: TcxLabel;
    x1: TcxLabel;
    s8: TcxButton;
    s5: TcxButton;
    s6: TcxButton;
    s7: TcxButton;
    s12: TcxButton;
    s9: TcxButton;
    s10: TcxButton;
    s11: TcxButton;
    s13: TcxButton;
    s14: TcxButton;
    s15: TcxButton;
    TabSheet2: TTabSheet;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    pbox2: TPaintBox;
    header2: TcxLabel;
    y2: TcxLabel;
    v1: TcxButton;
    v2: TcxButton;
    v3: TcxButton;
    v4: TcxButton;
    v5: TcxButton;
    v6: TcxButton;
    v7: TcxButton;
    v8: TcxButton;
    v9: TcxButton;
    v10: TcxButton;
    v11: TcxButton;
    v12: TcxButton;
    v13: TcxButton;
    v14: TcxButton;
    v15: TcxButton;
    x2: TcxLabel;
    spacecap2: TcxTextEdit;
    cxLabel5: TcxLabel;
    discap2: TcxTextEdit;
    cxLabel6: TcxLabel;
    dcap2: TcxTextEdit;
    cxLabel7: TcxLabel;
    TabSheet3: TTabSheet;
    fbox: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    font1: TLabel;
    Label3: TLabel;
    Greek: TCheckBox;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxStyle2: TcxStyle;
    cxStyle3: TcxStyle;
    cxStyle4: TcxStyle;
    cxStyle5: TcxStyle;
    cxStyle6: TcxStyle;
    cxStyle7: TcxStyle;
    cxStyle8: TcxStyle;
    cxStyle9: TcxStyle;
    cxStyle10: TcxStyle;
    cxStyle11: TcxStyle;
    cxStyle12: TcxStyle;
    cxStyle13: TcxStyle;
    cxStyle14: TcxStyle;
    cxStyle15: TcxStyle;
    PBox1: TPaintBox;
    mychart: TRChart;
    dchart: TRChart;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DcapKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure fboxClick(Sender: TObject);
    procedure GreekClick(Sender: TObject);
    procedure hideV;
    procedure AddPlot(pl,ee:integer; ddd, emitspas:double);
    function  Ccolor(j:integer):tcolor;
    procedure check_maxlos(maxlos, emitspas, ddd : double; ee : integer);
  private
    { Private declarations }
  public
    { Public declarations }

     Procedure SetUp(nuut : boolean);
     procedure SetGreek;
  end;

var
  PlotForm: TPlotForm;
  Grap : GrapObj;

implementation

{$R *.dfm}

uses form2unt,clipbrd,fontformunt, main_unt;

procedure TPlotForm.check_maxlos(maxlos, emitspas, ddd : double; ee : integer);
begin


   if maxlos=35 then
               begin
                  plotform.dchart.Scale1X.RangeHigh := emitspas*100+10;
                  plotform.dchart.Scale1Y.RangeHigh := ddd+30;
                  PlotForm.dChart.fillcolor:=plotform.ccolor(ee);
                  plotform.dChart.bar3D (emitspas*100-2.5,0,emitspas*100+2.5,ddd,5,45);
                  with plotform.plot1 do
                  begin
                     cells[1,ee]:=rtostr(emitspas*100,10,2);
                     cells[2,ee]:=rtostr(ddd,10,2);
                  end;
                  plotform.Addplot(1,ee,ddd, emitspas);
               end;

end;

function TPlotForm.Ccolor(j:integer):tcolor;
begin
   case j of
   1 : result:=clAqua;
   //1 : result:=clBlack
   2 : result:=clolive;   //blue;
   3 : result:=clCream;
   4 : result:=clyellow;  //clDkGray;
   5 : result:=clFuchsia;
   6 : result:=clGray;
   7 : result:=clGreen;
   8 : result:=clLime;
   9 : result:=clLtGray;
   10 : result:=clMaroon;
   11 : result:=clMedGray;
  // 12 : result:=clMoneyGreen
   12 : result:=clteal;
   13 : result:=clSkyBlue;  //clOlive;
   14 : result:=clPurple;
   15 : result:=clRed;
  end;
end;

procedure TPlotForm.hideV;
begin
       with plotform do
       begin
          s1.visible:=false;
          s2.visible:=false;
          s3.visible:=false;
          s4.visible:=false;
          s5.visible:=false;
          s6.visible:=false;
          s7.visible:=false;
          s8.visible:=false;
          s9.visible:=false;
          s10.visible:=false;
          s11.visible:=false;
          s12.visible:=false;
          s13.visible:=false;
          s14.visible:=false;
          s15.visible:=false;

          v1.visible:=false;
          v2.visible:=false;
          v3.visible:=false;
          v4.visible:=false;
          v5.visible:=false;
          v6.visible:=false;
          v7.visible:=false;
          v8.visible:=false;
          v9.visible:=false;
          v10.visible:=false;
          v11.visible:=false;
          v12.visible:=false;
          v13.visible:=false;
          v14.visible:=false;
          v15.visible:=false;
       end;
end;

procedure TPlotForm.AddPlot(pl,ee:integer; ddd, emitspas:double);
    var s : string;
    begin
       s:=rtostr(main_unt.units.SI_space(emitspas*100),10,0);
       with plotform do
       if pl=1 then
       begin
         case ee of
         1 : begin
                s1.Colors.Default:=ccolor(ee);
                s1.caption:=s;
                s1.Visible:=true;
             end;
         2 : begin
                s2.Colors.Default:=ccolor(ee);
                s2.caption:=s;
                s2.Visible:=true;
             end;
         3 : begin
                s3.Colors.Default:=ccolor(ee);
                s3.caption:=s;
                s3.Visible:=true;
             end;
         4 : begin
                s4.Colors.Default:=ccolor(ee);
                s4.caption:=s;
                s4.Visible:=true;
             end;
         5 : begin
                s5.Colors.Default:=ccolor(ee);
                s5.caption:=s;
                s5.Visible:=true;
             end;
         6 : begin
                s6.Colors.Default:=ccolor(ee);
                s6.caption:=s;
                s6.Visible:=true;
             end;
         7 : begin
                s7.Colors.Default:=ccolor(ee);
                s7.caption:=s;
                s7.Visible:=true;
             end;
         8 : begin
                s8.Colors.Default:=ccolor(ee);
                s8.caption:=s;
                s8.Visible:=true;
             end;
         9 : begin
                s9.Colors.Default:=ccolor(ee);
                s9.caption:=s;
                s9.Visible:=true;
             end;
         10 : begin
                 s10.Colors.Default:=ccolor(ee);
                 s10.caption:=s;
                 s10.Visible:=true;
             end;
         11 : begin
                 s11.Colors.Default:=ccolor(ee);
                 s11.caption:=s;
                 s11.Visible:=true;
             end;
         12 : begin
                 s12.Colors.Default:=ccolor(ee);
                 s12.caption:=s;
                 s12.Visible:=true;
             end;
         13 : begin
                 s13.Colors.Default:=ccolor(ee);
                 s13.caption:=s;
                 s13.Visible:=true;
             end;
         14 : begin
                 s14.Colors.Default:=ccolor(ee);
                 s14.caption:=s;
                 s14.Visible:=true;
             end;
         15 : begin
                 s15.Colors.Default:=ccolor(ee);
                 s15.caption:=s;
                 s15.Visible:=true;
             end;
         end;

         with dChart.TextLabels[ee] do
         begin
            //mode:=tlSimple;
            PosX:=emitspas*100;
            PosY:=ddd+15;
            Caption:=rtostr(ddd,10,0);
            visible:=true;
            TransParent:=true;
            colorborder:=clgreen;
            font.Name:='arial'; //'courier new';
         end;
      end
      else
      begin
         case ee of
         1 : begin
                v1.Colors.Default:=ccolor(ee);
                v1.caption:=s;
                v1.Visible:=true;
             end;
         2 : begin
                v2.Colors.Default:=ccolor(ee);
                v2.caption:=s;
                v2.Visible:=true;
             end;
         3 : begin
                v3.Colors.Default:=ccolor(ee);
                v3.caption:=s;
                v3.Visible:=true;
             end;
         4 : begin
                v4.Colors.Default:=ccolor(ee);
                v4.caption:=s;
                v4.Visible:=true;
             end;
         5 : begin
                v5.Colors.Default:=ccolor(ee);
                v5.caption:=s;
                v5.Visible:=true;
             end;
         6 : begin
                v6.Colors.Default:=ccolor(ee);
                v6.caption:=s;
                v6.Visible:=true;
             end;
         7 : begin
                v7.Colors.Default:=ccolor(ee);
                v7.caption:=s;
                v7.Visible:=true;
             end;
         8 : begin
                v8.Colors.Default:=ccolor(ee);
                v8.caption:=s;
                v8.Visible:=true;
             end;
         9 : begin
                v9.Colors.Default:=ccolor(ee);
                v9.caption:=s;
                v9.Visible:=true;
             end;
         10 : begin
                 v10.Colors.Default:=ccolor(ee);
                 v10.caption:=s;
                 v10.Visible:=true;
             end;
         11 : begin
                 v11.Colors.Default:=ccolor(ee);
                 v11.caption:=s;
                 v11.Visible:=true;
             end;
         12 : begin
                 v12.Colors.Default:=ccolor(ee);
                 v12.caption:=s;
                 v12.Visible:=true;
             end;
         13 : begin
                 v13.Colors.Default:=ccolor(ee);
                 v13.caption:=s;
                 v13.Visible:=true;
             end;
         14 : begin
                 v14.Colors.Default:=ccolor(ee);
                 v14.caption:=s;
                 v14.Visible:=true;
             end;
         15 : begin
                 v15.Colors.Default:=ccolor(ee);
                 v15.caption:=s;
                 v15.Visible:=true;
             end;
         end;
      end;
   end;

procedure grapobj.setpw(ww:real);
begin
   if prt=1 then exit;
   kanv.pen.width:=round(ww);
end;

procedure grapobj.block(xx,yy,t1,t : integer);
var j : integer;
begin
   if t1<=0 then t1:=t;
   for j:=t1 to t do
   begin
      lline(xx-j,yy-j,xx+j,yy-j);
      lline(xx+j,yy-j,xx+j,yy+j);
      lline(xx+j,yy+j,xx-j,yy+j);
      lline(xx-j,yy+j,xx-j,yy-j);
   end;
end;

procedure grapobj.diamant(xx,yy,t1,t : integer);
var j : integer;
begin
   if t1<=0 then t1:=t;
   for j:=t1 to t do
   begin
      lline(xx-j,yy,xx,yy+j);
      lline(xx,yy+j,xx+j,yy);
      lline(xx+j,yy,xx,yy-j);
      lline(xx,yy-j,xx-j,yy);
   end;
end;

procedure grapobj.box(xx,wyd,y1,y2 :integer; coll : integer);
var tp : array[1..4] of tpoint;
    j : integer;
begin
   kanv.pen.color:=coll;
   tp[1].x:=xx-wyd; tp[1].y:=y1;
   tp[2].x:=xx-wyd; tp[2].y:=y2;
   tp[3].x:=xx+wyd; tp[3].y:=y2;
   tp[4].x:=xx+wyd; tp[4].y:=y1;
   kanv.brush.color:=coll;
   kanv.polygon(tp);

   for j:=0 to 8 do
   begin
      kanv.pen.color:=clred;  //mergecol(clgray,coll,j,8);
      lline(tp[1].x+j,tp[1].y,tp[2].x+j,tp[2].y);

//      kanv.pen.color:=coll+j*10-10;
      lline(tp[3].x-j,tp[3].y,tp[4].x-j,tp[4].y);
   end;
end;

procedure grapobj.triang(xx,yy,t1,t : integer);
var j : integer;
begin
   if t1<=0 then t1:=t;
   for j:=t1 to t do
   begin
      lline(xx,yy-j,xx+j,yy+j);
      lline(xx+j,yy+j,xx-j,yy+j);
      lline(xx-j,yy+j,xx,yy-j);
   end;
end;

procedure grapobj.setlimit(pbox1 : tpaintbox; _kanv:tcanvas; ww1,ww2,hh1,hh2:real; nuut:boolean; l,r,t:integer);
begin
   kanv:=_kanv;
   kanv.pen.color:=clblack;
   kanv.brush.color:=clblack;
   w1:=ww1;
   w2:=ww2;
   h1:=hh1;
   h2:=hh2;
   fl:=l;
   fr:=r;
   ft:=t;
   {if pbox1=nil then
   begin
      _w1:=pwpix div 10;
      _w2:=pwpix-l-50;
      _h1:=phpix div 10;
      _h2:=round(phpix/2)-round(phpix*0.25);   //     1000-r;
      prt:=4;
   end
   else
   begin}
      prt:=1;
    {  with pbox1 do
      begin
         _w1:=0;
         _w2:=width-l;
         _h1:=0;
         _h2:=height-r;
      end;  }
      if nuut then pbox1.repaint;
//   end;
end;

function grapobj.px(xx:real):integer;
begin
  // if prt=4 then xx:=xx/1000*pwpix;
   result:=0;
   if (w2-w1)<>0 then
      result:=round((xx-w1)/(w2-w1)*(_w2)+fl);
end;

function grapobj.xp(xx:real):real;
begin
   result:=(xx-fl)/_w2*(w2-w1)+w1;
end;

function grapobj.py(yy:real):integer;
begin
 //  if prt=4 then yy:=yy/1000*phpix;
   result:=0;
   if h2-h1<>0 then
      result:=round((_h2+fr)-(yy-h1)/(h2-h1)*(_h2)-fr)+ft;
end;

function grapobj.yp(yy:real):real;
begin
   result:=(_h2-yy)/_h2*(h2-h1)+h1;
end;

procedure grapobj.movem(xx,yy : real);
begin
   fixx:=xx;
   fixy:=yy;
end;



procedure grapobj.drawm(xx,yy : real);
begin
   with kanv do
   begin
      moveto(px(fixx),py(fixy));
      lineto(px(xx),py(yy));
   end;
   movem(xx,yy);
end;

procedure grapobj.lline(xx1,yy1,xx2,yy2 : integer);
begin
   with kanv do
   begin
      moveto(xx1,yy1);
      lineto(xx2,yy2);
   end;
end;


procedure do_fontt(hanvas:tcanvas; ss:string; x,y,xh,yh,dir : real; lorg:integer);
var lfont : tlogfont;
    thefont,oldfont : hfont;
    //x,y,hh : integer;
    flags : word;
    len,len1,dx,exw,exh : real;
    extra : integer;
    sss : ansistring;
begin
   sss:='ARIAL'; // NARROW'; //'COURIER NEW';
   if grap.bold>1 then
      sss:='ARIAL BLACK';
   if grap.bold=-1 then
      sss:='MS SANS SERIF';
   exw:=0.15*grap.prt;
   exh:=0.15*grap.prt;

   {with grap do
      if prt=4 then
      begin
         exw:=exw*ppmm/11;
         exh:=exh*ppmm/11;
      end;}

   if grap.bold<1 then grap.bold:=1;
   //grap.bold:=10;
   with lfont do
   begin
      lfheight:=round(yh*1.3*9*exh);   {-12;}
      lfwidth:=round(xh*0.67*9*exw);   {10;}

     { with mainform.memo1 do
      begin
         lines.add('l h '+inttostr(lfheight));
         lines.add('l w '+inttostr(lfwidth));
         lines.add(ss);
      end;}


      lfescapement:=trunc(dir*10);
      lforientation:=100;
      lfweight:=10*grap.bold;
      lfitalic:=0;
      lfunderline:=0;
      lfstrikeout:=0;
      lfquality:=2;
      lfcharset:=0;
      lfoutprecision:=0;
      lfclipprecision:=0;
      lfpitchandfamily:=0;
    //  sss:=cfnt^.fontname;    //ffont.name;
      strcopy(lffacename,pchar(sss));
   end;

   thefont:=selectobject(hanvas.handle,createfontindirect(lfont));

   case lorg of
   4,5,6  :  flags:=ta_center;
   7,8,9  :  flags:=ta_right;
   1,2,3  :  flags:=ta_left;
   end;
   case lorg of
   1,4,7  : flags:=flags+ta_bottom;
   2,5,8  : flags:=flags+ta_baseline;
   3,6,9  : flags:=flags+ta_top;
   end;

   SetTextAlign(hanvas.handle,flags);

   //--------------
   settextcharacterextra(hanvas.handle,0);
      len1:=length(ss)*xh*9.0*exw;
      len:=hanvas.textwidth(ss);
      extra:=0;



   //-------------

   SetBkMode(hanvas.handle, {OPAQUE);  //}TRANSPARENT);

   with hanvas do
   begin
       SetTextColor(hanvas.handle,hanvas.pen.color);
       textout(round(x),round(y),ss);
   end;

   deleteobject(selectobject(hanvas.handle,thefont));
end;

function pw(ww:real):integer;
begin
   result:=round(ww);
   //if printer.printing then
      result:=trunc(ww/1000); //*pwpix)
  // else
   //   result:=700;
end;



//--------------------

Procedure TPlotForm.SetGreek;
begin

    label3.Font.name:= header1.style.font.name;

   if greek.Checked then
   begin

     label3.font.charset:=GREEK_CHARSET; //	charset_greek;

      dcap.Style.font.charset:=GREEK_CHARSET;
      discap.Style.font.charset:=GREEK_CHARSET;
      spacecap.Style.font.charset:=GREEK_CHARSET;

      header1.Style.font.charset:=GREEK_CHARSET;
      y1.Style.font.charset:=GREEK_CHARSET;
      x1.Style.font.charset:=GREEK_CHARSET;

      dcap2.Style.font.charset:=GREEK_CHARSET;
      discap2.Style.font.charset:=GREEK_CHARSET;
      spacecap2.Style.font.charset:=GREEK_CHARSET;

      header2.Style.font.charset:=GREEK_CHARSET;
      y2.Style.font.charset:=GREEK_CHARSET;
      x2.Style.font.charset:=GREEK_CHARSET;
   end
   else
   begin
      dcap.Style.font.charset:=ANSI_CHARSET;
      discap.Style.font.charset:=ANSI_CHARSET;
      spacecap.Style.font.charset:=ANSI_CHARSET;

      header1.Style.font.charset:=ANSI_CHARSET;
      y1.Style.font.charset:=ANSI_CHARSET;
      x1.Style.font.charset:=ANSI_CHARSET;

      dcap2.Style.font.charset:=ANSI_CHARSET;
      discap2.Style.font.charset:=ANSI_CHARSET;
      spacecap2.Style.font.charset:=ANSI_CHARSET;

      header2.Style.font.charset:=ANSI_CHARSET;
      y2.Style.font.charset:=ANSI_CHARSET;
      x2.Style.font.charset:=ANSI_CHARSET;
   end;
end;


procedure TPlotForm.Setup(nuut : boolean);
var max3,maxp,maxl,step,ket,max2,tmp,maxs : real;
   j,i,ii,b1,b2 : integer;
   bm : tbitmap;
begin

   maxp:=0;
   max2:=10;
   max3:=10;

   maxp:=0.25;
   maxl:=150;

   exit;


      with grap do
      begin


            if nuut then                                        //22
               setlimit(pbox1,pbox1.canvas,0,maxl,0,maxp,nuut,55,30,0)
            else
            begin
               maxl:=w2;
               maxp:=h2;
            end;
         maxl:=maxl*0.99;
         setpw(4);
         movem(0,maxp);
         drawm(0,0);
         drawm(maxl,0);
         drawm(maxl,maxp);
         drawm(0,maxp);
         kanv.pen.color:=clblue;
         if not nuut then kanv.pen.color:=clgreen;
         setpw(8);

      //   movem(0,0);
      //   drawm(100,0.8);

         (*
         if saq.wind>0 then
         begin
            for j:=2 to nospring do
            if j=2 then
               movem(spring[j,1]*windfak,spring[j,2])
            else
               drawm(spring[j,1]*windfak,spring[j,2]);
         end;
         *)

         kanv.pen.color:=clmaroon;
         setpw(4);
        // MaxS:=MaxSpace;
        // movem(MaxS,0); //spring[nospring,1]*windfak*2,0);
       //  drawm(MaxS,maxp*0.99);
       {  if abs(Maxs-spring[nospring,1])>2 then
         begin
            do_fontt(kanv,'Max Spacing',px(MaxS),py(maxp*0.5),4,6,90,4);
            do_fontt(kanv,rtostr(maxS,10,1),px(MaxS),py(maxp*0.5),4,6,90,6);
         end
         else
         begin
            do_fontt(kanv,'Max Spacing ',px(MaxS),py(maxp*0.8),4,6,0,7);
            do_fontt(kanv,rtostr(maxS,10,1)+' ',px(MaxS),py(maxp*0.75),4,6,0,9);
         end; }

         kanv.pen.color:=clblue;


         ket:=0;
         step:=25;

         setpw(2);
         
         while ket<maxl do
         begin
            movem(ket,0);
            if pbox1=nil then
               drawm(ket,maxp*0.05)
            else
               drawm(ket,0.025);
            //pbox1.canvas.textout(px(ket),py(0),rtostr(ket,10,2));
            do_fontt(kanv,rtostr_(ket,10,2),px(ket),py(0),5,8,0,6);

            ket:=ket+step;
         end;

         {ket:=spring[nospring,1];
         movem(ket,0);
         if pbox1=nil then
            drawm(ket,maxp*0.05)
         else
            drawm(ket,maxp*0.1);
         do_fontt(kanv,rtostr_(ket,10,1),px(ket),py(maxp*0.1),5,6,90,2);
          }

         ket:=0;
         step:=0.2;
         ket:=step;

         setpw(1);
         //kanv.pen.style:=psdot;

         while ket<maxp do
         begin
//            pbox1.canvas.pen.style:=psdot;
            movem(0,ket);
            if pbox1=nil then
               drawm(maxl{*0.02},ket)
            else
               drawm(5,ket);
            kanv.pen.color:=clblue;
            if py(ket)>8 then
               do_fontt(kanv,rtostr_(ket,10,2)+' ',px(0),py(ket),5,8,0,8);
            ket:=ket+step;
         end;
         kanv.pen.style:=pssolid;


         kanv.pen.color:=clblack;
         if pbox1=nil then
         begin
          //  do_fontt(kanv,'Head Losses [Bar]',pw(60),py(maxp/2)+5,8,8,90,4);
          //  do_fontt(kanv,'Rate ('+units.precip(true)+')',pw(100),py(maxp/2)+5,8,8,90,4);
          //  do_fontt(kanv,'Distance from sprinkler ('+units.len+')',px(maxl/2),(ph(910)+py(0))/2,8,8,0,6);
         end
         else
         begin
          //  do_fontt(kanv,'Head Losses [Bar]',px(0)-38*grap.prt,py(maxp/2)+5,8,8,90,4);
         //   do_fontt(kanv,units.precip(true),px(0)-25*grap.prt,py(maxp/2)+5,5,8,90,4);
          //  do_fontt(kanv,'Dripline Length [m]',px(maxl/2),py(0)+25*grap.prt,8,8,0,5);
         end;

      (*   if bmp then
        begin

           //bm.canvas.copyrect(tr,pbox5.canvas,tr1);
           clipboard.assign(bm);
           bm.free;
        end; *)


      end;
{   end
   else
      pbox1.repaint;}
end;



procedure TPlotForm.BitBtn1Click(Sender: TObject);
var bm : tbitmap;
    tt : trect;
begin
 //  dchart.CopyToClipboard(false);

   {  with pbox1.canvas do
     begin
        moveto(40,460);
        lineto(100,450);

        textout(200,450,'bottom');
     end;}

  tt.Left:=0;
  tt.Right:=pbox1.Width;
  tt.Top:=0;
  tt.Bottom:=pbox1.Height;

  bm:=tbitmap.Create;

  bm.Height:=tt.bottom;
  bm.Width:=tt.Right;
  case (sender as tcomponent).tag of
  1: bm.Canvas.CopyRect(tt,pbox1.canvas,tt);
  2: bm.Canvas.CopyRect(tt,pbox2.canvas,tt);
  end;
 // bm.savetofile('c:\junk\test.bmp');
  clipboard.assign(bm);
  bm.free;
end;

procedure TPlotForm.BitBtn3Click(Sender: TObject);
begin
   plot1.CopyToClipBoard;
end;

procedure TPlotForm.BitBtn4Click(Sender: TObject);
begin
   plot2.CopyToClipBoard;
end;

procedure TPlotForm.DcapKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 //  label3.Font.name:= header1.style.font.name;
 //  label3.font.charset:=GREEK_CHARSET; //	charset_greek;

   if sender=dcap then
      header1.caption:=Dcap.Text;
   if sender=discap then
      y1.Caption:=discap.Text;
   if sender=spacecap then
      x1.Caption:=spacecap.Text;

  if sender=dcap2 then
      header2.caption:=Dcap2.Text;
   if sender=discap2 then
      y2.Caption:=discap2.Text;
   if sender=spacecap2 then
      x2.Caption:=spacecap2.Text;

   label3.Caption:=dcap.Text;

end;

procedure setfname(s:string);
begin
   with Plotform do
   begin
      header1.style.font.name:=s;
      y1.style.font.name:=s;
      x1.style.font.name:=s;

      header2.style.font.name:=s;
      y2.style.font.name:=s;
      x2.style.font.name:=s;
   end;
end;

procedure TPlotForm.FormCreate(Sender: TObject);
var j : integer;
  s : string;
begin


   with waarde do
   begin
      greek.Checked:=readbool('Greek','Font',false);

      setgreek;

      dcap.Text:=readstring('Graph1','Caption','Caption');
      discap.Text:=readstring('Graph1','Distance','Distance');
      spacecap.Text:=readstring('Graph1','Spacing','Spacing');
      dcap2.Text:=readstring('Graph2','Caption','Caption');
      discap2.Text:=readstring('Graph2','Distance','Losses');
      spacecap2.Text:=readstring('Graph2','Spacing','Spacing');
   end;

    with screen do
         for j:=1 to fonts.count-1 do
                if GetFontFileName(fonts[j],[]) <>'' then
                begin
                   fbox.items.add(fonts[j]);
                end;

   with dchart do
   begin
      header1.caption:=Dcap.Text;
      y1.Caption:=discap.Text;
      x1.Caption:=spacecap.Text;

      header2.caption:=Dcap2.Text;
      y2.Caption:=discap2.Text;
      x2.Caption:=spacecap2.Text;

   end;
   

   s:=waarde.readstring('Graph1','Font',header1.Style.Font.Name);

   setfname(s);

end;

procedure TPlotForm.FormDestroy(Sender: TObject);
begin
   with waarde do
   begin

      writebool('Greek','Font',   greek.Checked);

      writestring('Graph1','Caption',dcap.Text);
      writestring('Graph1','Distance',discap.Text);
      writestring('Graph1','Spacing',spacecap.Text);

      writestring('Graph2','Caption',dcap2.Text);
      writestring('Graph2','Distance',discap2.Text);
      writestring('Graph2','Spacing',spacecap2.Text);

      writestring('Graph1','Font',header1.Style.Font.Name);

   end;
end;

procedure TPlotForm.FormActivate(Sender: TObject);
var j : integer;
begin

   font1.Caption:=header1.Style.Font.Name;

   for j:=0 to ComponentCount-1 do
      MMLAng.getname(components[j]);


end;

procedure TPlotForm.fboxClick(Sender: TObject);
var s : string;
begin
   s:=fbox.Items.Strings[fbox.itemindex];

   SetFname(s);


   FormActivate(Sender);
end;

procedure TPlotForm.GreekClick(Sender: TObject);
begin
   SetGreek;
end;

end.
