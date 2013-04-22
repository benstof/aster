unit main_unt;
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Buttons, form2unt, clipbrd, printers, inifiles, registry,
  ShellApi, ComCtrls, Tabnotbk, Menus, cxLookAndFeelPainters, cxButtons, Grids,
  BaseGrid, AdvGrid, AdvSprd, ImgList, cxGraphics, cxLookAndFeels, cxControls,
  dxNavBar, AdvObj, units_unt, taal_unt, emitter_mng_unt, Vcl.ToolWin,
  Vcl.ActnMan, Vcl.ActnCtrls, Vcl.ActnMenus, admin_unt, pipe_mng_unt,
  dxNavBarCollns, cxClasses, dxNavBarBase, drip_line_mng_unt, Data.FMTBcd,
  SimpleDS, Vcl.DBGrids, Data.DB, Datasnap.DBClient, Data.SqlExpr, irricalc;

type
  Tcalcbox = class(TForm)
    Label21: TLabel;
    Label20: TLabel;
    coefficient_variation: TEdit;
    MaxP: TEdit;
    Label24: TLabel;
    Bevel1: TBevel;
    pipeinputD: TEdit;
    drippipeU: TLabel;
    regspasD1: TEdit;
    regspasD2: TEdit;
    regspasD3: TEdit;
    regspasD4: TEdit;
    regspasD5: TEdit;
    regspasD6: TEdit;
    regspasD7: TEdit;
    nomflow: TLabel;
    dripflowU: TLabel;
    Label22: TLabel;
    Label26: TLabel;
    flow_constant: TEdit;
    Label23: TLabel;
    Label27: TLabel;
    Bevel8: TBevel;
    spacing_label: TLabel;
    cxB: TcxButton;
    calculate_btn: TcxButton;
    regspasD10: TEdit;
    regspasD9: TEdit;
    regspasD8: TEdit;
    Label28: TLabel;
    corFac: TEdit;
    Label29: TLabel;
    kd_factor: TEdit;
    Label31: TLabel;
    pfric: TComboBox;
    PageC1: TPageControl;
    TabSheet4: TTabSheet;
    Memo1: TMemo;
    TabSheet5: TTabSheet;
    Memo2: TMemo;
    Memo3: TMemo;
    Label30: TLabel;
    Label32: TLabel;
    spr1: TAdvSpreadGrid;
    GroupBox6: TGroupBox;
    BitBtn3: TBitBtn;
    psetup: TBitBtn;
    PrinterSetupDialog1: TPrinterSetupDialog;
    GroupBox7: TGroupBox;
    xbut: TBitBtn;
    Label33: TLabel;
    Label34: TLabel;
    ImageList1: TImageList;
    Label35: TLabel;
    mflow: TLabel;
    dripflowUat: TLabel;
    Mflowh: TLabel;
    ImAlso: TCheckBox;
    BitBtn4: TBitBtn;
    TabSheet6: TTabSheet;
    Memo4: TMemo;
    Label36: TLabel;
    comma: TCheckBox;
    Image1: TImage;
    regspasD15: TEdit;
    regspasD14: TEdit;
    regspasD13: TEdit;
    regspasD12: TEdit;
    regspasD11: TEdit;
    format1: TRadioGroup;
    ppl: TCheckBox;
    minp: TEdit;
    compensate_type: TRadioGroup;
    dripline_lb: TListBox;
    MainMenu1: TMainMenu;
    settings_mn: TMenuItem;
    ManageEmitters1: TMenuItem;
    units_metric_rb: TMenuItem;
    units_imp_rb: TMenuItem;
    Units2: TMenuItem;
    Flowls1: TMenuItem;
    Flowlh1: TMenuItem;
    max_bar_lbl: TLabel;
    min_bar_lbl: TLabel;
    flow_constant_unt_lbl: TLabel;
    spacing_unt_lbl: TLabel;
    N1: TMenuItem;
    alt_lang_cb: TMenuItem;
    em_ex: TEdit;
    ManagePipes1: TMenuItem;
    limits_type: TRadioGroup;
    ManageDriplines1: TMenuItem;
    dl_memo: TMemo;
    Calculator1: TMenuItem;
    Products: TLabel;
    Oflowh: TLabel;
    Flowlm1: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure HlpClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure calculate_btnClick(Sender: TObject);
    procedure cxBClick(Sender: TObject);
    procedure xbutClick(Sender: TObject);
    procedure psetupClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure alt_lang_cbClick(Sender: TObject);
    procedure compensate_typeClick(Sender: TObject);
    function get_reg_spas(ee:integer):string;
    procedure load_driplines;
    procedure dripline_lbClick(Sender: TObject);
    procedure ManageEmitters1Click(Sender: TObject);
    procedure Admin1Click(Sender: TObject);
    procedure units_metric_rbClick(Sender: TObject);
    procedure units_imp_rbClick(Sender: TObject);
    procedure redo_units;
    procedure redo_labels;
    procedure regspasD1Change(Sender: TObject);
    procedure ManagePipes1Click(Sender: TObject);
    procedure limits_typeClick(Sender: TObject);
    procedure ManageDriplines1Click(Sender: TObject);
    procedure Calculator1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    commas : boolean;
    formatI : integer;
    minlos : double;
    procedure PlotLoss(no : integer; emitspas,p2,p3:double);
  end;

    type emitrec = record
       flow,press : double;
     end;

var
  calcbox: Tcalcbox;
  emit : array[1..4000] of emitrec;
  flow_coefficient : string;

  units : unitrec;
  selected_emitter : TEmitter;
  selected_pipe : TPipe;
  //emitters_file      : File;

implementation

uses Plotunit, login_unt;



{$R *.DFM}
{$I-}

function getPipe(id: integer) : TPipe;
var amt : integer;
begin

   AssignFile(pipes_file, 'pipes.ems');
   if not fileexists('pipes.ems') then
      ReWrite(pipes_file);

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pipes_file,1);
   BlockRead(pipes_file, settings, sizeof(TSettings), amt);


   // Display the file contents
   while not Eof(pipes_file) do
   begin
     BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
     if id = pipe.id then
        result := pipe;
   end;

   CloseFile(pipes_file);

end;

function getEmitter(id: integer) : TEmitter;
var amt : integer;
begin

   AssignFile(emitters_file, 'emitters.ems');
   if not fileexists('emitters.ems') then
      ReWrite(emitters_file);


   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(emitters_file) do
   begin
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     if id = emitter.id then
        result := emitter;
   end;

   CloseFile(emitters_file);

end;

procedure Tcalcbox.load_driplines;
var x, amt : integer;
dlname : string;
mem_line : string[200];

begin

   dripline_lb.Clear;

   AssignFile(driplines_file, 'driplines.ems');
   if not fileexists('driplines.ems') then
      exit;

   FileMode := fmOpenRead;
   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(driplines_file) do
   begin

     BlockRead(driplines_file, dripline, sizeof(TDripline), amt);
     emitter := getEmitter(dripline.emitter_id);
     pipe := getPipe(dripline.pipe_id);
     dlname := pipe.name + ' - ' +emitter.name;
     dripline_lb.Items.AddObject(dlname,  TObject(dripline.id));

         {  for x := 0 to dripline.lines - 1 do
           begin
               BlockRead(driplines_file, mem_line, 200, amt);
           end;  }

   end;
   // Close the file for the last time
   CloseFile(driplines_file);

end;

procedure Tcalcbox.ManageDriplines1Click(Sender: TObject);
begin

    // Show emitter manager
    login_form.next := 3;
    login_form.forwhat := 1;
    login_form.Show;
end;

procedure Tcalcbox.ManageEmitters1Click(Sender: TObject);
begin

    // Show emitter manager
    login_form.next := 1;
    login_form.forwhat := 1;
    login_form.Show;

end;

procedure Tcalcbox.ManagePipes1Click(Sender: TObject);
begin

    // Show pipe manager
    login_form.next := 2;
    login_form.forwhat := 1;
    login_form.Show;

end;

procedure Tcalcbox.redo_labels;
begin

   max_bar_lbl.caption:=units.press;
   min_bar_lbl.caption:=units.press;
   dripflowU.Caption:=units.flow;
   dripflowUat.Caption:=units.flow;

   drippipeU.Caption:=units.diam;
   flow_constant_unt_lbl.Caption:=units.press;
   spacing_unt_lbl.Caption := '('+units.riser+')';

   pipeinputd.text := rtostr(main_unt.units.si_diam(strtor(selected_pipe.diam)),10,3);
   maxp.text := rtostr(main_unt.units.si_press(strtor(selected_emitter.max_press)),10,2);
   minp.text := rtostr(main_unt.units.si_press(strtor(selected_emitter.min_press)),10,2);
   flow_constant.text := rtostr(main_unt.units.si_press(strtor(selected_emitter.constant)),10,2);

   regspasd1.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas1','15'))),10,1);
   regspasd2.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas2','25'))),10,1);
   regspasd3.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas3','30'))),10,1);
   regspasd4.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas4','40'))),10,1);
   regspasd5.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas5','50'))),10,1);
   regspasd6.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas6','60'))),10,1);
   regspasd7.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas7','70'))),10,1);
   regspasd8.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas8','75'))),10,1);
   regspasd9.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas9','90'))),10,1);
   regspasd10.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas10','100'))),10,1);
   regspasd11.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas11','110'))),10,1);
   regspasd12.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas12','120'))),10,1);
   regspasd13.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas13','130'))),10,1);
   regspasd14.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas14','140'))),10,1);
   regspasd15.Text := rtostr(units.SI_space(strtor(waarde.readstring('Irricalc','Regspas15','150'))),10,1);

end;

procedure Tcalcbox.redo_units;
var j,i : integer;
   r, step : real;
begin
   //english1.checked:=false;
   //metric1.checked:=false;
   case units.uu of
   1 : units_metric_rb.checked:=true;
   2 : units_imp_rb.checked:=true;
   end;

   case units.MetFlow of
   0 : flowls1.Checked := true;
   3 : flowlh1.Checked := true;
   5 : flowlm1.Checked := true;
   end;

end;

procedure Tcalcbox.regspasD1Change(Sender: TObject);
var nom, temp : string;
space : double;
begin
   nom := inttostr((Sender as tcomponent).tag);
   space := units.space_si(strtor((Sender as tedit).Text));
   temp := s_s(rtostr(space,5,0),5);
   waarde.writestring('Irricalc','Regspas'+nom,temp);
end;

procedure Tcalcbox.units_metric_rbClick(Sender: TObject);
begin

   with units do
   begin
      case (Sender as tcomponent).tag of
      0 : begin
             uu:=2;
             MetFlow:=4;
             flowls1.Checked := false;
             flowlh1.Checked := false;
          end;
      1 : begin
             uu:=1;
             MetFlow:=0;   //l/s
             flowls1.Checked := true;
          end;
      2 : begin
             uu:=1;
             MetFlow:=3;   //l/h
             flowlh1.Checked := true;
          end;
      3 : begin
             uu:=1;
             MetFlow:=5;   //l/m
             flowlm1.Checked := true;
          end;
      end;

      waarde.writeint('Irricalc','Format1',888);
      waarde.writeint('Default','Units',uu);
      waarde.writeint('Default','MetFlow',MetFlow);

      redo_units;
      redo_labels;

   end;

end;

function speed(pflow,diam:double):double;    {input as l/s and mm  result=m/s}
begin
   result:=0;                       {feet/sec}               {meters}
   if diam>0 then result:=(0.408*pflow*15.852/sqr(diam/25.4))*0.305;
end;

function GetExeByExtension(sExt : string) : string;
var
   sExtDesc:string;
begin
   with TRegistry.Create do
   begin
     try
       RootKey:=HKEY_CLASSES_ROOT;
       if OpenKeyReadOnly(sExt) then
       begin
         sExtDesc:=ReadString('') ;
         CloseKey;
       end;
       if sExtDesc <>'' then
       begin
         if OpenKeyReadOnly(sExtDesc + '\Shell\Open\Command') then
         begin
           Result:= ReadString('') ;
         end
       end;
     finally
       Free;
     end;
   end;

   if Result <> '' then
   begin
     if Result[1] = '"' then
     begin
       Result:=Copy(Result,2,-1 + Pos('"',Copy(Result,2,MaxINt))) ;
     end
   end;
end;

function mag(a1,a2:real):real;        {X^Y     a1^a2}
begin
   result:=0;

   if a1<>0 then result:=exp(a2*ln(a1));
end;

function hazen(L,q,d,C,dw:real):real;    {Hazen Williams   met variables}
var v,tp,diamm,re,f:real;
begin
   result:=0;
   if c=0 then c:=150;  {plastic}
          {hazen will}
                   {friction in pipe + z2-z1 diff}
   if q/c>0.000000000001 then
      result:={1050}1.212e12*mag(Q/C,1.852)*mag(D,-4.87);
   result:=result*L/100;
end;

function printit(ww:string; Var x,y:integer) : boolean;   {true=newpage}
var ff,pp,SZ : integer;
begin
   with printer do
   begin
      ff:=canvas.font.size;
      //startit;
      pp:=getdevicecaps(handle,logpixelsx);
      canvas.font.size:=ff; {trunc(ff*pp/120*1.5);}  {2} {dotmatrix=120}
      canvas.textout(x,y,ww);
      sz:=canvas.textheight('A');
      inc(y,sz);
      canvas.font.size:=ff;
      result:=y+sz>pageheight;
   end;
end;

procedure delay(wat : integer);
var t1,t2,t3 : double;
begin
   t3:=wat/1000/3600/24;
   t1:=time;
   repeat
      t2:=time;
   until (t2-t1>t3);
end;

function getflow(p,k,x : double) : double;
    begin
       //p:=2;
       p:=p/10;  //10;  //meter to bar
       result:=k*mag(p,x)/60/60;                //l/s
    end;

function Tcalcbox.get_reg_spas(ee:integer):string;
var s4 : string;
begin

    s4 := waarde.readstring('Irricalc','Regspas'+inttostr(ee),'10');
    //readstring('Irricalc','Pfric','145');
    {case ee of
      1 : s4:=regspasD1.text;
      2 : s4:=regspasD2.text;
      3 : s4:=regspasD3.text;
      4 : s4:=regspasD4.text;
      5 : s4:=regspasD5.text;
      6 : s4:=regspasD6.text;
      7 : s4:=regspasD7.text;
      8 : s4:=regspasD8.text;
      9 : s4:=regspasD9.text;
      10: s4:=regspasD10.text;
      11: s4:=regspasD11.text;
      12: s4:=regspasD12.text;
      13: s4:=regspasD13.text;
      14: s4:=regspasD14.text;
      15: s4:=regspasD15.text;
    end;  }
    result := s4;

end;

procedure Tcalcbox.FormCreate(Sender: TObject);
var s : string;
j : integer;
begin


   getdir(0,s);
   waarde.ini:=tinifile.create(s+'\MM_Calc.INI');
   MMLang.initlang(s+'\MM_calc_language.def');
   pagec1.ActivePageIndex:=0;
   if fileexists('logo.bmp') then Image1.Picture.LoadFromFile('Logo.bmp');

   MMLang.language := waarde.readint('Irricalc','AltLanguage',1);

      if (waarde.readint('Irricalc','AltLanguage',1) = 1) then
      begin
         alt_lang_cb.checked:=true;
      end
      else
         alt_lang_cb.checked:=false;


         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);

      spacing_unt_lbl.Left := spacing_label.Width + 184;
end;

procedure Tcalcbox.FormActivate(Sender: TObject);
var j : integer;
begin

   load_driplines;
   if dripline_lb.Items.Count > 0 then
      dripline_lb.Selected[0] := true;

   with waarde do
   begin

      //ChangeUnits;
      formatI:=readint('Irricalc','FormatI',0);
      limits_type.ItemIndex:=readint('Irricalc','Format1',0);

      pfric.text:=readstring('Irricalc','Pfric','145');
      units.uu:=waarde.readint('Default','Units',2);
      units.MetFlow:=waarde.readint('Default','MetFlow',1);
      redo_units;



      ImAlso.checked:=readbool('Irrig','ImAlso',false);
      comma.checked:=readbool('Irrig','Comma',false);

      memo2.clear;  memo3.Clear;
      for j:=1 to 5 do
         memo2.lines.add(readstring('Irricalc','Head'+inttostr(j),''));
      for j:=1 to 5 do
         memo3.lines.add(readstring('Irricalc','Foot'+inttostr(j),''));

   end;

   if dripline_lb.Items.Count > 0 then
   begin
      dripline_lbClick(sender);
      compensate_typeClick(sender);
   end;

   redo_labels;

end;

procedure Tcalcbox.HlpClick(Sender: TObject);
begin
   Application.HelpCommand(HELP_CONTEXT, (sender as tbitbtn).helpcontext);
end;

procedure Tcalcbox.units_imp_rbClick(Sender: TObject);
begin
   units_imp_rb.Checked := true;
end;

procedure Tcalcbox.Admin1Click(Sender: TObject);
begin
    login_form.forwhat := 0;
    login_form.Show;
end;

procedure Tcalcbox.alt_lang_cbClick(Sender: TObject);

var j, alt : integer;

begin

   if alt_lang_cb.Checked then
   begin
      alt := 0;
      alt_lang_cb.checked:=false;
   end
   else
   begin
      alt := 1;
      alt_lang_cb.checked:=true;
   end;

   waarde.writeint('Irricalc','AltLanguage',alt);
   MMLang.language := alt;

      for j:=0 to ComponentCount-1 do
         MMLAng.getname(components[j]);

    spacing_unt_lbl.Left := spacing_label.Width + 184;

end;

procedure TCalcBox.PlotLoss(no:integer; emitspas,p2,p3:double);
var j : integer;
    lank,losses,la,lo : double;
begin
   p2:=minlos; //7;
   PlotForm.mychart.datacolor:=plotform.Ccolor(no);  //clred+j*100;

   la:=0;
   lo:=0;

   plotform.plot2.cells[no*2,1]:=rtostr(emitspas*100,10,2);

   for j:=1 to 2000 do
      begin
         lank:=j*emitspas;
         losses:=(Emit[j].press-p2)/10;

         if (j>1) and (emit[j].press<emit[j-1].press) then break;
         if emit[j].press>p3 then break;

         if lank>la then la:=lank;
         if losses>lo then lo:=losses;
         if j=1 then
            plotform.mychart.moveto(lank,losses)
         else
            plotform.mychart.drawto(lank,losses);

         plotform.plot2.cells[no*2-1,j+2]:=rtostr(lank,10,5);
         plotform.plot2.cells[no*2,j+2]:=rtostr(losses,10,5);
      end;

    PlotForm.mychart.datacolor:=plotform.ccolor(no);
    //plotform.dChart.bar3D (19,0,21,100,5,45);
    plotform.mychart.Scale1X.RangeHigh := lank;
    plotform.mychart.Scale1Y.RangeHigh := losses;
    plotform.mychart.ShowGraf;
end;

procedure Tcalcbox.calculate_btnClick(Sender: TObject);
type arr8 = array[0..8] of double;

var p1,p2,pf,maxlos,emitval,emitSpas,diam,k,x,EUCv,EUMin,CorFacV,kdfacV : double;
    f,sl,ee,emitNo,j,emitno2 : integer;
    losses : double;
    ss,s4 : string;
    grap,Pc : boolean;
    los1 : array[1..15,1..50] of double;
    ShowIt : boolean;
    ddd,maxlim, slope_press : double;
    e1 : integer;
    FillLength : double;
    Prange : Arr8;

    procedure qsort(a,b: integer);
    var svalue,temp    : double;
        _left,right,j    : integer;
    begin
       _left:=a;
       right:=b;

          svalue:=emit[1].flow;
          if a div 2+b div 2>0 then
             svalue:=emit[a div 2+b div 2].flow;

          repeat
             while emit[_left].flow<svalue do
                inc(_left);   {left:=left+1;}
             while svalue<emit[right].flow do
                dec(right);  {:=right-1;}
             if _left<=right then
             begin
                temp:=emit[_left].flow; emit[_left].flow:=emit[right].flow; emit[right].flow:=temp;
              //  temp:=emit[_left].press; emit[_left].press:=emit[right].press; emit[right].press:=temp;
                inc(_left);  {:=left+1;}
                dec(right); {:=right-1;}
             end;
          until right<=_left;
          if a<right then qsort(a,right);
          if _left<b then qsort(_left,b);
    end;

    function EU : double;
    var fff,x3,y3,avel,min,max : double;
        n1 : integer;
    begin
       min:=1e6;
       max:=-1e6;
       result:=0;

       if formatI=1 then
       begin
          for n1:=1 to emitno do
          begin
             if emit[n1].flow>max then max:=emit[n1].flow;
             if emit[n1].flow<min then min:=emit[n1].flow;
          end;

          avel:=(max+min)/2;

          if avel<>0 then
          begin
             result:=100-(max-min)/avel*100;
          end;
          exit;
       end;

       Qsort(1,emitNo);
       EU:=100;
       avel:=0;
       if emitNo div 4 >0 then
       begin
          fff:=0;

          for n1:=1 to emitNo do Avel:=Avel+emit[n1].flow;
          Avel:=Avel/EmitNo;

          for n1:=1 to emitNo div 4 do
             fff:=fff+emit[n1].flow;
         fff:=fff/(emitNo div 4);

         x3:=1;
         y3:=euCV/100;

         if x3>0 then result:=((1-1.27*y3/sqrt(x3))*fff/(aveL)*100);
         if result=0 then result:=100;

       end;
    end;

    procedure setup_header;
    var line : string[200];
        semi : string[20];
        press : string[10];
        x : integer;

    begin

      if formatI=0 then
        if units.uu = 1 then
              memo1.lines.add('                        Length (m) at Eu = 90%')
        else
              memo1.lines.add('                        Length (ft) at Eu = 90%')
      else
         if units.uu = 1 then
            memo1.lines.add('                        Length (m) at 10% flow variation')
         else
            memo1.lines.add('                        Length (ft) at 10% flow variation');

   if pc then
   begin
      memo1.lines.add('                               Zero Slope');

     { if compensate_type.itemindex = 0 then
      begin
               Prange[0]:=7;
               Prange[1]:=1.5;
               Prange[2]:=2;
               Prange[3]:=2.5;
               Prange[4]:=3;
               Prange[5]:=3.5;
               Prange[6]:=4;
               Prange[7]:=4.5;
      end
      else
      begin  }
               Prange[0]:=8;
               Prange[1]:=0.75;
               Prange[2]:=1;
               Prange[3]:=1.5;
               Prange[4]:=2;
               Prange[5]:=2.5;
               Prange[6]:=3;
               Prange[7]:=3.5;
               Prange[8]:=4;
     // end;

      semi := '   ';

      if commas then semi := ' ; ';
      line := '';

      if units.uu = 1 then
         press := 'bar'
         //line :='   Press (bar) > '
      else
         press := 'psi';
        // line :='   Press (psi) > ';

      line := ' Press('+press+') > ';

      for x := 1 to trunc(prange[0]) do
      begin
         line := line + semi + rtostr(main_unt.units.si_press(prange[x]),4,10);
      end;
      line := line + semi +'    Time to Fill @ ' + rtostr(main_unt.units.si_press(2),4,10) + press;
      memo1.lines.add(line);

      {
      if commas then
      begin
         if compensate_type.itemindex = 0 then
         begin

            if units.uu = 1 then
               memo1.lines.add('   Press (bar) > ;1.5  ; 2.0  ; 2.5  ;3.0   ;  3.5   ;  4.0  ; 4.5')
            else
               memo1.lines.add('   Press (psi) > ;1.5  ; 2.0  ; 2.5  ;3.0   ;  3.5   ;  4.0  ; 4.5');
         end
         else
         begin
            if units.uu = 1 then
               memo1.lines.add('   Press (bar) > ;0.5  ; 1.0  ; 1.5  ;2.0   ;  2.5   ;  3.0  ; 3.5  ; 4')
            else
               memo1.lines.add('   Press (psi) > ;7.25  ;  14.5  ;  21.75  ;  29   ;  36.25  ;   43.51  ;  50.76  ;  58')
         end
      end
      else
      begin
         if compensate_type.itemindex = 0 then
         begin
            if units.uu = 1 then
               memo1.lines.add('   Press (bar) > 1.5    2.0    2.5    3.0     3.5     4.0    4.5')
            else
               memo1.lines.add('   Press (psi) > 21.75    29    36.25    43.51     50.76     58    65.26');
         end
         else
         begin
            if units.uu = 1 then
               memo1.lines.add('   Press (bar) > 0.5    1.0    1.5    2.0     2.5     3.0    3.5    4')
            else
               memo1.lines.add('   Press (psi) > 7.25    14.5    21.75    29     36.25     43.51    50.76    58')
         end
      end;   }
   end
   else
   if commas then
      memo1.lines.add('       Slope > ;  3%  ;   2%  ;  1%  ;  0%  ;  -1%   ; -2%  ; -3% ; Time to Fill @ 0% slope ')
   else
      memo1.lines.add('       Slope >    3      2      1      0     -1     -2    -3%            Time to Fill @ 0% slope ');


         if compensate_type.itemindex = 0 then
         begin
           if units.uu = 1 then
              memo1.lines.add('Spacing(cm)------------------------------------------------------------')
           else
              memo1.lines.add('Spacing(inch)------------------------------------------------------------')
         end
         else
         begin
           if units.uu = 1 then
              memo1.lines.add('Spacing(cm)------------------------------------------------------------')
           else
              memo1.lines.add('Spacing(inch)------------------------------------------------------------');
         end;

    end;

    function pre_checks : boolean;
    begin
       result := false;

       if diam < 0.1 then
       begin
         ShowMessage('Please enter pipe diameter');
         result := true;
       end;

       if maxlos<=minlos then
       begin
         ShowMessage('Please enter maximum pressure above '+rtostr(minlos/10,10,2)+' bar');
         result := true;
       end;

       if PC and (minlos/10>1.49) then
       begin
        //  ShowMessage('Note. The minimum pressure cannot be above 1.49 bar when the "calculate by pressure limits" is selected');
        //  result := true;
        end;

       if PC and (minlos/10>0.74) and (compensate_type.ItemIndex = 1) then
       begin
          ShowMessage('Note. The minimum pressure cannot be above 0.74 bar when the "calculate by pressure limits" and "pressure compensated" is selected');
          result := true;
        end;

    end;

    function comma1 : string;
    begin
       result:=' ';
       if commas then result:=';';
    end;

    function getlength(p1,slope2,emitspas : double) : double;
    var  stop : boolean;
         slopee,lank,flow,emitspask,p3,eu1 : double;
    begin
       slopee:=slope2;
       stop:=false;
       flow:=getflow(p1,k,x);
       losses:=p1;
       result:=0;
      // emitspas:=espas;
       emitNo:=1;
       emit[emitNo].flow:=flow;
       emit[emitNo].press:=p1;

       lank:=0.5;

       if emitspas>0 then lank:=emitspas;

       repeat

          if emitspas>0 then
          begin
             p1:=hazen(emitspas,flow,diam,pf,0.01);
             p2:=kdFacV*sqr(speed(flow,diam))/(2*9.81);
             p3:=-slopee/100*EmitSpas;   //keep as m /10;    //m to bar
             losses:=losses+p1+p2+p3;
          end
          else
             losses:=hazen(lank,flow,diam,pf,0.01);

          eu1:=eu;

          if losses<=0 then losses:=100;

          if (losses>maxlos) or (EU1<EUMin) then
          begin
             stop:=true;
             if emitspas>0 then
                lank:=lank-emitspas
             else
                lank:=lank-0.25;
          end
          else
          begin
             if emitspas>0 then
                lank:=lank+emitspas
             else
                lank:=lank+0.25;
          end;

          if emitspas>0 then
          begin
             emitNo:=EmitNo+1;
             emit[emitNo].flow:=getflow(losses,k,x);
             emit[emitno].press:=losses;
             flow:=flow+emit[emitNo].flow;  //(trunc(lank/emitspas))*emitval;
          end;

       until stop or (lank>200000);

       result:=lank*CorFacV/100;
    end;

    function GetLength2(slope2,espas : double; reg : integer) : double;
    var l1,l2,p1,p2,base,min1,max1,ave : double;
        j,i : integer;
    begin

       slope_press := 0;
       base:=minlos;
       p1:=base;
       result:=0;
       repeat
          l1:=getlength(p1,slope2,espas);
          if l1>result then
          begin
              result:=l1;
              if slope2=0 then FillLength:=result;
              slope_press := p1;
          end;
          p1:=p1+((maxlos-base)/29.01);
       until p1>maxlos;

       if grap then
       begin
          l1:=25;
          p2:=minlos;  //7; //8; //p1; //20; //6;         //0.6 bar start - Manos
          l2:=maxlos;
          getlength(p2,slope2,espas);

          repeat
             for j:=2 to emitNo do
                if (j*emitspas<=L1) and ((j+1)*EmitSpas>L1) then
                begin
                   i:=trunc(l1/25);
                   los1[reg,I]:=(Emit[j].press-p2)/10;
                end;
             l1:=l1+25;
          until l1>800;
          maxlos:=l2;
       end;
    end;

    procedure Press_Length(Prange : arr8); //, range2 : integer);
    var x : integer;
    begin

       MaxLos:=Prange[1];

       for x := 1 to trunc(Prange[0]) do

       begin
          MaxLos:=Prange[x]*10;
          ddd:=units.si_len(getLength2(0,emitspas,ee));
          if maxlos=20 then FillLength:=ddd;
          ss:=ss+r_s(ddd,6,0)+comma1;
          //MaxLos:=MaxLos+5;
          plotform.check_maxlos(maxlos, emitspas, ddd, ee);
      end;

      // until Maxlos>range2;

    end;

     function FillSeconds(FillLength,EmitSpas : double) : string;
    var Flow_volume,Pipe_Volume, velocity : double;
    begin               //l/s

       //Die totale vloei van al die emitters teen nominale druk
       Flow_volume:=getflow(10,k,x)*FillLength/Emitspas; //nominal flow * number emitters   = l/s

       //Die totale volume van die pyp
       Pipe_volume:=FillLength*Sqr(Diam/2/1000)*3.14*1000;  // in liters

       //hoe lank neem dit teen die vloei van al die emitters om die pyp vol te maak.
       Result:=rtostr(Pipe_volume/Flow_Volume,10,0);   //   Liters / (liter/s) = Sekondes.

       {Velocity:=Speed(Volume,diam);
       result:=rtostr(FillLength/Velocity,10,0);}

    end;

begin

   plotform.Setup(true);
   plotform.hidev;

   grap:=false;
   p2:=0;
   pf:= strtor(pfric.Items[selected_emitter.hw]); //(pfric.text);
   maxlos:= strtor(selected_emitter.max_press) * 10; //.press_si(strtor(maxp.Text))*10;
   minlos:= strtor(selected_emitter.min_press) * 10; //.press_si(strtor(minp.Text))*10;
   //p1:=minlos;
   maxlim:=maxlos;
   corfacV:=100+ strtor(selected_emitter.correction); //(corfac.Text);
   KdfacV:= strtor(selected_emitter.kd); //(kd_factor.Text);
   eucv:= strtor(selected_emitter.cv); //(coefficient_variation.text);
   k:= strtor(selected_emitter.constant); //(flow_constant.Text);
   flow_coefficient := selected_emitter.exponent;
   x:= strtor(selected_emitter.exponent); //(flow_coefficient);
   Pc:=x<0.101;
   pc:=format1.ItemIndex=0;
   emitval:=getflow(10,k,x);   //start at 1m

  // diam:=strtor(PipeinputD.text);
   diam := strtor(selected_pipe.diam); //22.2;// 16.1;//selected_emitter.pipe_diam;
  // diam:=units.diam_si(diam);
   EUMin:=90;

   nomflow.Caption:=rtostr(units.si_flow(getflow(10,k,x)),10,3);
   Mflow.Caption:=rtostr(units.si_flow(getflow(maxlos,k,x)),10,3);
   MflowH.Caption:=maxp.Text+ ' ' +units.press;
   Oflowh.Caption:= rtostr(main_unt.units.si_press(1),10,2)   + ' ' +units.press;

   memo4.clear;
   memo1.clear;

   if (pre_checks) then exit;
   setup_header;

   e1:=0;
   for ee:=1 to 15 do
   begin
      emitspas := strtor(get_reg_spas(ee));
      emitspas:=emitspas/100;
      ss:='';

      if emitspas>0 then
      begin

         // Pressure
         if PC then
         begin
            Press_Length(prange);
         end

         // Slope
         else
            for sl:=-3 to 3 do
            begin
               ddd:=units.si_len(getLength2(sl,emitspas,ee));
               ss:=ss+r_s(ddd,6,0)+comma1;// + '('+r_s(slope_press,2,0)+')';

               if sl=0 then
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

                  with plotform.dChart.TextLabels[ee] do
                  begin
                     PosX:=emitspas*100;
                     PosY:=ddd+15;
                     Caption:=rtostr(ddd,10,0);
                     visible:=true;
                     TransParent:=true;
                     colorborder:=clgreen;
                  end;
               end;
            end;

         memo1.lines.add(r_s(units.si_space(emitspas)*100,7,2) +comma1+'      '+ss + '           ' +FillSeconds(FillLength,EmitSpas)+' Seconds');

      end;
   end;


   // Slope Display
   if not pc then
   begin
      EUMin:=90;
      memo1.lines.add('===============================================================');
      memo1.lines.add('');
      if units.uu = 1 then
         memo1.lines.add('                        Length (m) at 0% slope')
      else
         memo1.lines.add('                        Length (ft) at 0% slope');

      case formatI of
      0 :   if commas then
            memo1.lines.add('         EU >  ;   95.0% ; 92.5% ; 90.0%  ; 85.0%  ; 80.0%')
            else
            memo1.lines.add('         EU >      95%   92,5%   90%    85%    80%');
      1 :   if commas then
            memo1.lines.add('Flow variation >;    5.0% ;  7.5% ; 10.0%  ; 15.0%  ; 20.0%')
            else
            memo1.lines.add('Flow variation >     5%    7,5%   10%    15%    20%');
      end;
      if units.uu = 1 then
          memo1.lines.add('Spacing(cm)----------------------------------------------------')
      else
         memo1.lines.add('Spacing(inch)----------------------------------------------------');
   end;

      fillchar(los1,sizeof(los1),0);

      for ee:=1 to 15 do
      begin
         emitspas := strtor(get_reg_spas(ee));
         emitspas:=emitspas/100;   //cm to mmunits.len_si(emitspas0);
         ss:='';
         if emitspas>0 then
         begin
            for sl:=1 to 5 do
            begin
               case sl of
               1 : EUmin:=95;
               2 : EUmin:=92.5;
               3 : begin EUmin:=90; {grap:=true;} end;
               4 : EUmin:=85;
               5 : begin EUmin:=80; {grap:=true;} end;
               6 : EUmin:=10;
               end;

               if sl=3 then
               begin
                  grap:=true;
                  getLength2(0,emitspas,ee);  //to get losses
                  grap:=false;
                  plotform.Addplot(2,ee,ddd, emitspas);
               end;
               ss:=ss+r_s(units.si_len(getLength2(0,emitspas,ee)),6,0)+comma1;
            end;

            if not pc then memo1.lines.add(r_s(units.si_space(emitspas*100),10,2)+comma1+'      '+ss);
      end;
   end;

   // Losses Display
   ss:='Spacing (cm) ';
   for ee:=1 to 15 do
   begin
      s4 := get_reg_spas(ee);
      ss:=ss+comma1+' '+s_s(s4,6);
   end;
   memo4.lines.add(ss);
   memo4.lines.add('Length (m)');

   for sl:=1 to 50 do
   begin
      ss:=s_s(rtostr(sl*25,10,0),5)+'       ';
      showit:=false;
      for ee:=1 to 15 do
      begin
         emitspas := strtor(get_reg_spas(ee));
         emitspas:=emitspas/100;   //cm to mmunits.len_si(emitspas0);

         if emitspas>0 then
         begin
            //if sl=1 then PlotLoss(emitspas,p2);
            if los1[ee,sl]<>0 then
            begin
               showIt:=true;
               ss:=ss+comma1+' '+s_s(rtostr(los1[ee,sl],10,4),6);
            end
            else
               ss:=ss+comma1+' '+s_s(' ',6);
         end;
      end;
      if ShowIt then
         memo4.lines.add(ss);
   end;

   //plott loss
      for ee:=1 to 15 do
      begin
         emitspas := strtor(get_reg_spas(ee));
         p2:=minlos;  //7;
         emitspas:=emitspas/100;   //cm to mmunits.len_si(emitspas0);
         getlength(p2,0,emitspas);

         if emitspas>0 then
         begin
            plotform.addplot(2,ee,ddd, emitspas);
            PlotLoss(ee,emitspas,p2,maxLim);
         end;
      end;

   commas:=false;

   if ppl.Checked then plotform.show;

end;

procedure Tcalcbox.Calculator1Click(Sender: TObject);
begin
   //calcbox.Show;
   doirricalc(true,true);
end;

procedure Tcalcbox.cxBClick(Sender: TObject);
var sExe : string;
    i : integer;
begin
   sExe:=GetExeByExtension('.Html');
   ShellExecute( 2,'open','www.irrimaker.com', nil,nil, SW_SHOWNORMAL);
end;

procedure Tcalcbox.dripline_lbClick(Sender: TObject);
var index, id, amt, x : integer;
name : string;
mem_line : string[200];

begin

   Memo1.Clear;
   Memo1.Lines.Add('Press the Calculate button');


   index := dripline_lb.ItemIndex;
   if index = -1 then index := dripline_lb.Count - 1;

   id := Integer(dripline_lb.Items.Objects[dripline_lb.Items.IndexOf(dripline_lb.Items[index])]);

   AssignFile(driplines_file, 'driplines.ems');
   AssignFile(temp_driplines_file, 'temp_driplines.ems');
   ReWrite(temp_driplines_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(driplines_file, 1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);

   Reset(temp_driplines_file);


      dl_memo.Lines.Clear;
      while not Eof(driplines_file) do
      begin

        BlockRead(driplines_file, dripline, sizeof(TDripline), amt);


     if id = dripline.id then
     begin
        if waarde.readint('Irricalc','AltLanguage',1) = 1 then
        begin
           for x := 0 to length(dripline.lines_arr_trans) - 1 do
              if dripline.lines_arr_trans[x+1] <> '' then
                 dl_memo.Lines.Add(dripline.lines_arr_trans[x+1]);
        end
        else
        begin
           for x := 0 to length(dripline.lines_arr) - 1 do
              if dripline.lines_arr[x+1] <> '' then
                 dl_memo.Lines.Add(dripline.lines_arr[x+1])
        end;
     end;

        if id = dripline.id then
        begin

       // test := dripline.memo;
        emitter := getEmitter(dripline.emitter_id);
        pipe := getPipe(dripline.pipe_id);

        selected_emitter := emitter;
        selected_pipe := pipe;

        coefficient_variation.Text := emitter.cv;
        kd_factor.Text := emitter.kd;
        corFac.Text := emitter.correction;
        maxp.text := rtostr(main_unt.units.si_press(strtor(emitter.max_press)),10,2);
        minp.text := rtostr(main_unt.units.si_press(strtor(emitter.min_press)),10,2);
        flow_constant.text := rtostr(main_unt.units.si_press(strtor(emitter.constant)),10,2);
        pfric.ItemIndex := emitter.hw;
        compensate_type.itemindex := emitter.compensated;
        em_ex.text := emitter.exponent;
        compensate_typeClick(sender);
        pipeinputd.text := rtostr(main_unt.units.si_diam(strtor(pipe.diam)),10,3);


        end;

      end;

   // Close the file for the last time
   CloseFile(driplines_file);
   CloseFile(temp_driplines_file);

  {DeleteFile('driplines.ems');
  Rename(temp_driplines_file, 'driplines.ems');


   // Display the file contents
   while not Eof(emitters_file) do
   begin
     Read(emitters_file, emitter);
     if name = emitter.name then
     begin

        selected_emitter := emitter;
        coefficient_variation.Text := rtostr(emitter.cv,10,2);
        kd_factor.Text := rtostr(emitter.kd,10,2);
        corFac.Text := rtostr(emitter.correction,10,2);
        pipeinputd.text := rtostr(irricalc.units.si_diam(emitter.pipe_diam),10,3);
        maxp.text := rtostr(irricalc.units.si_press(emitter.max_press),10,2);
        minp.text := rtostr(irricalc.units.si_press(emitter.min_press),10,2);
        flow_constant.text := rtostr(irricalc.units.si_press(emitter.constant),10,2);

        pfric.ItemIndex := emitter.hw;
        compensate_type.itemindex := emitter.compensated;
        em_ex.text := rtostr(emitter.exponent, 10, 2);
        compensate_typeClick(sender);


     end;
   end;
   // Close the file for the last time
   CloseFile(emitters_file);   }

end;

procedure Tcalcbox.xbutClick(Sender: TObject);
var x,y,j : integer;
   s,ss : string;
   ok : boolean;

   function outComma(s:string):string;
   var j : integer;
   begin
      result:='';

      if pos('Length',s)>0 then
      begin
         result:=s;
         exit;
      end;

      for j:=1 to length(s) do
         if (s[j]<>' ') and (s[j]<>';') then result:=result+s[j];

      if comma.checked then
      for j:=1 to length(result) do
         if result[j]='.' then result[j]:=',';


   end;
   procedure PrintHead(xcel:boolean);
   begin
      if not ImAlso.Checked then exit;


      if Xcel then
      begin
        inc(y);
        spr1.cells[0,y]:='Emitter Information'; inc(y);
        inc(y);
        with Spr1 do
        begin
           Spr1.CellProperties[3,y].Alignment:=taLeftJustify;
           cells[0,y]:=label20.Caption;
              //spr1.alAlignments[3,y]:=taLeftJustify;
              cells[3,y]:=coefficient_variation.text;

           cells[4,y]:='    '+copy(label23.caption,1,39);
            cells[8,y]:=flow_constant.text; cells[9,y]:='bar'; inc(y);
           cells[0,y]:=label29.Caption;         cells[3,y]:=kd_factor.text;
           cells[5,y]:=label26.caption;               cells[8,y]:=flow_coefficient; inc(y);
           cells[0,y]:=label24.Caption;         cells[3,y]:=maxp.text;
           cells[5,y]:=label28.caption;               cells[8,y]:=corfac.text;  inc(y);

           cells[0,y]:=copy(label36.Caption,1,14); cells[3,y]:=minp.text;  cells[4,y]:='bar'; inc(y);

           cells[0,y]:=label27.Caption; cells[3,y]:=pipeinputd.text;
           cells[4,y]:=drippipeU.caption;
           cells[5,y]:=label31.caption; cells[8,y]:=pfric.text;   inc(y);
           Inc(y);
        end;
      end
      else
      begin
         printit('',x,y);

         printit('Emitter Information',x,y);
         printit('-------------------',x,y);

         printit(s_s(s_s(label20.Caption,35)+coefficient_variation.text,40)+'   '+copy(label23.caption,1,23)+'K   '+flow_constant.text,x,y);
         printit(s_s(s_s(label29.Caption,35)+kd_factor.text,40)+'   '+copy(label26.caption,1,25)+'  '+flow_coefficient,x,y);
         printit(s_s(s_s(label24.Caption,35)+maxp.text,40)+'   '+copy(label28.caption,1,25)+'  '+corfac.text,x,y);
         printit(s_s(s_s(label27.Caption,35)+pipeinputd.text,40)+'   '+copy(label31.caption+'    ',1,25)+'  '+pfric.text,x,y);

         printit('',x,y);
      end;   

   end;

begin
   case (sender as tcomponent).tag of
   1 : with printer do
       begin
          begindoc;
          printer.canvas.Font:=memo1.font;
          X:=10; Y:=10;

          for j:=0 to memo2.lines.count-1 do printit(memo2.lines[j],x,y);

          PrintHead(false);

          for j:=0 to memo1.lines.count-1 do printit(memo1.lines[j],x,y);
          for j:=0 to memo3.lines.count-1 do printit(memo3.lines[j],x,y);
         // for j:=0 to memo4.lines.count-1 do printit(memo3.lines[j],x,y);
          enddoc;
       end;
   2 : begin
          Y:=1;

          for j:=0 to spr1.rowcount-1 do
             for x:=0 to spr1.ColCount-1 do
               spr1.cells[x,j]:='';

          Commas:=true;

          calculate_btn.Visible:=false;
          pagec1.ActivePageIndex:=0;

          calculate_btnClick(Sender);

          calculate_btn.Visible:=true;
          pagec1.ActivePageIndex:=1;

          ok:=false;
          for j:=0 to memo2.lines.count-1 do
             if memo2.lines[j]<>'' then ok:=true;
          if ok then
             for j:=0 to memo2.lines.count-1 do
             begin
                spr1.cells[0,y]:=memo2.lines[j];
                inc(y);
             end;

          PrintHead(true);

          for j:=0 to memo1.lines.count-1 do
          begin
             s:=memo1.lines[j];
             x:=0;
             while length(s)>0 do
             begin
                ss:=copy(s,1,pos(';',s));
                if ss='' then
                begin
                   ss:=s;
                   s:='';
                end;
                spr1.cells[x,y]:=outcomma(ss);
                //Spr1.CellProperties[x,y].Alignment:=taLeftJustify;
                //spr1.Alignments[x,y]:=taLeftJustify;
                inc(x);
                s:=copy(s,pos(';',s)+1,length(s));
             end;
             inc(y);
          end;

          inc(y);

          for j:=0 to memo4.lines.count-1 do
          begin
             s:=memo4.lines[j];
             x:=0;
             while length(s)>0 do
             begin
                ss:=copy(s,1,pos(';',s));
                if ss='' then
                begin
                   ss:=s;
                   s:='';
                end;
                spr1.cells[x,y]:=outcomma(ss);
                inc(x);
                s:=copy(s,pos(';',s)+1,length(s));
             end;
             inc(y);
          end;

          for j:=0 to memo3.lines.count-1 do
          begin
             spr1.cells[0,y]:=memo3.lines[j];
             inc(y);
          end;

          Spr1.CopyToClipBoard;

          j:=30;
          while j<400 do
          begin
             xbut.Left:=j;
             delay(20);
             application.ProcessMessages;
             inc(j,3);
          end;

          while j>30 do
          begin
             xbut.Left:=j;
             delay(10);
             application.ProcessMessages;
             dec(j,6);
          end;

          xbut.Left:=30;

       end;
   end;
end;

procedure Tcalcbox.psetupClick(Sender: TObject);
begin
   PrinterSetupDialog1.execute;
end;

procedure Tcalcbox.limits_typeClick(Sender: TObject);
begin
   formatI:=limits_type.ItemIndex; //.tag;
   //calculate_btnClick(sender);
end;

procedure Tcalcbox.compensate_typeClick(Sender: TObject);
var index : integer;
begin

   index := compensate_type.ItemIndex;

end;

procedure Tcalcbox.BitBtn4Click(Sender: TObject);
var losses,flow,emitspas,diam,lank,p1,p2,p3,pf : double;
    kdFacV,Eflow,k,x : double;
    j : integer;
    mov : boolean;
begin
    Plotform.show;

    for j:=1 to 15 do
    begin
       emitspas := strtor(get_reg_spas(j));
       emitspas:=emitspas/100;   //cm to mmunits.len_si(emitspas0);

       with grap do
       begin
          losses:=0;
          flow:=0;
          kanv.pen.color:=clred+j*100;
          pf:=140;
          lank:=0;
          diam:=strtor(PipeinputD.text);
          KdfacV:=strtor(kd_factor.Text);
          k:=strtor(flow_constant.Text);
          x:=strtor(flow_coefficient);
          mov:=false;

          repeat
             p1:=hazen(emitspas,flow,diam,pf,0.01);
             p2:=kdFacV*sqr(speed(flow,diam))/(2*9.81);
             p3:=0; //-slopee/100*EmitSpas/10;    //m to bar
             losses:=losses+p1+p2+p3;

             if lank>=25 then
             if not mov then
             begin
                mov:=true;
                Movem(lank,losses/10);
              //  plotform.mychart.moveto(lank,losses/10);
             end
             else
             begin
                drawm(lank,losses/10);
              //  plotform.mychart.drawto(lank,losses/10);
             end;

             lank:=lank+emitspas;
             Eflow:=getflow(losses+10,k,x);
             flow:=flow+eflow;  //(trunc(lank/emitspas))*emitval;
          until lank>250;
       end;
    end;
end;

procedure Tcalcbox.FormDeactivate(Sender: TObject);
var j : integer;
    temp : string;

begin

 {  with waarde do
   begin

      writeint('Irricalc','Format1',limits_type.ItemIndex);
      writeint('Irricalc','FormatI', formatI);
      writebool('Irrig','ImAlso',ImAlso.checked);
      writebool('Irrig','Comma',comma.checked);
      writestring('Irricalc','Pfric',pfric.text);
      writestring('Irricalc','CompensateType',inttostr(compensate_type.itemindex));
      writestring('Irricalc','Pipeinput',pipeinputd.text);
      writestring('Irricalc','CV',coefficient_variation.Text);

      writestring('Irricalc','K',flow_constant.Text);
      writestring('Irricalc','Maxp',MaxP.Text);
      writestring('Irricalc','Minp',MinP.Text);
      waarde.writestring('Irricalc','CorrectionFactor',Corfac.Text);
      waarde.writestring('Irricalc','KDFactor',kd_factor.Text);

      for j:=0 to memo2.Lines.Count do
         writestring('Irricalc','Head'+inttostr(j+1),memo2.lines[j]);

      for j:=0 to memo3.Lines.Count do
         writestring('Irricalc','Foot'+inttostr(j+1),memo3.lines[j]);

      j:=3;
      writeint('Irricalc','Pressures',j);

   //   if regular.checked then j:=1 else j:=2;
      writeint('Irricalc','Emitplace',j);

   end;  }

end;

procedure Tcalcbox.FormDestroy(Sender: TObject);
begin
   FormDeactivate(Sender);
end;

end.
