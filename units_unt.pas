unit units_unt;

interface

uses graphics,extctrls,windows,sysutils,form2unt;

// {$DEFINE MINING}     {Winsipp Mining}
// {$UNDEF MINING}         {Winsipp 2000)

const

   version='12.6';

     Canx = 120;   //replace the old 69

     maxspring = Canx+1;  //  70;          //prof points on spring
     maxspan  = 20;
     maxnode  = 1000;            //
     maxprof  = 50;
     maxpot =2000;
     maxgreen = 10000;





     feet = 0.305;

type unitrec = object
     uu : integer;       //1=Si;  2=english
     MetFlow : integer;  //1=l/s  2=l/h
     function flow : string;
     function len : string;
     function hoog : string;
     function precip(prof:boolean) : string;
     function riser : string;
     function press : string;
     function diam : string;

     function SI_len(ll:real):real;
     function diam_SI(ll:real):real;
     function SI_flow(ll:real):real;

     function flow_si : real;
     function len_si : real;
     function precip_si : real;
     function SI_press(ll:real):real;   {MM werk in meter water hoogte}

     function press_si(ll:real):real;
     function riser_si : real;

     function space_SI(ll:real):real;
     function SI_space(ll:real):real;

     function SI_diam(ll:real):real;
     function makeriser(s:string):string;
     function makepressure(s:string):string;
     function makeflow(s:string):string;
     end;



     grapobj = object
     _w1,_w2,_h1,_h2,bold : integer;
     w1,w2,h1,h2,wydte,hoogte : real;
     fixx,fixy   : real;
     ft,fl,fr,prt : integer;
     kanv        : tcanvas;
     //procedure setlimit(pbox1 : tpaintbox; _kanv:tcanvas; ww1,ww2,hh1,hh2:real; nuut:boolean; l,r,t:integer);
     function px(xx:real):integer;
     function py(yy:real):integer;
     function xp(xx:real):real;
     function yp(yy:real):real;

     procedure movem(xx,yy : real);
     procedure drawm(xx,yy : real);
     procedure lline(xx1,yy1,xx2,yy2 : integer);
     procedure xblock(xx,yy,t1,t : integer);
     procedure diamant(xx,yy,t1,t : integer);
     procedure triang(xx,yy,t1,t : integer);
     procedure box(xx,wyd,y1,y2 :integer; coll : integer);
     procedure setpw(ww:real);
     end;

     springrec = record
        name,nozzle,facility,tdate,ttime,filename,comment     : string;
        number   : integer;
        nospring : integer;
        s1,s2,flow,duration,pres,riser,revs,arc    : double;
        spring   : array[1..maxspring,1..2] of double;
        slopes   : array[1..maxspring] of double;
     end;

     benrec = record
        dist,flow,nozz,pres : real;
        m1,m2,prof : integer;
        Pad        : string[20];
     end;

     //=================plot==================
   real10 = real;

   ppolgon  = array[1..maxpot] of tPoint;
   bp       = ^ppolgon;

   ptpoint = record
        yy,xx : real;
        zz : real;
   end;

   drier = array[1..3] of ptpoint;
   //===============================================
  gridpt=record
     x,y,z : double;
     no    : integer;    //userno 1,2,3,4,5
     Pos   : string[1];
  end;



   UserRec = record
      Shape : integer;   //1 rect 2=L
      A,B,C,D  : double;
      Right,Up : double;
      Row,Head : Double;
   end;

   DataRec = record
     Date  : Shortstring;
     Number : Shortstring;
     Customer : shortstring;
     Dealer   : shortstring;
     Comments : shortstring;

     ActRec   : integer;
     nozzle,pressure,flow1,riser1,arc1 : Shortstring;

     espas,enum,rspas,rnum,offset,filename : Shortstring;
     Lay                 : integer;
     width,height                          : Shortstring;
     Format              : integer;   //layout, grid spr, grid catchcan
     KeepArea            : boolean;

     User                : UserRec;

     User_S1,User_S2,User_S3,User_S4,User_S5 : integer;

     wind : integer;

     gridx : array[1..4] of double;
     gridy : array[1..4] of double;   //sprinkler pos in ctach cans
  end;




var grap : grapobj;
     units : unitrec;

     Mining1 : boolean;

     HideSenninger : boolean;

     Pnaam : string;

     spanlen : real;
    // nospan  : integer;
     nonode  : integer;
     noprof  : integer;
     lastspeed : real;
     springs : array[1..maxprof] of springrec;
    // spans   : array[1..maxspan,1..2] of real;
     nodes   : array[1..maxnode] of benrec;

     Saq : DataRec;


   var
     pixx : array[0..410,0..410] of integer;
     pixs : array[1..161000] of integer;
     greenx,greeny,greenN : array[1..maxgreen] of integer;

     wetcolor,drycolor : integer;
     nogreen : integer;
     act,totpixs : integer;

     master : integer;

     enhanced : boolean;
     defdir : string;



function apprate(in_h:real):real;

function ApRateCaption : string;
function ApRateDesi : integer;

implementation

function unitrec.SI_flow(ll:real):real;     {MM werk in l/s}
var nom : integer;
begin
   nom:=metflow;
   case nom of
   0 : result:=ll;                  {l/s=l/s}
   1 : result:=ll*15.852*0.227;      {m3/h 264.2 =gpm 0.063 =l/s}
   2 : result:=ll/0.063;            {GPM 0.063 =l/s}
   3 : result:=ll*3600;
   4 : result:=ll/0.063*60;   {gph}
   5 : result:=ll*60;         {l/m}
   end;
end;

function unitrec.diam_SI(ll:real):real;
begin
   //nom:=diamunit1;
   case uu of
   1 : result:=ll;                  {mm=mm}
   2 : result:=ll*25.4;             {inch 25.4 = mm}
   end;
end;

function unitrec.SI_diam(ll:real):real;
begin
   //nom:=diamunit1;
   case uu of
   1 : result:=ll;                  {mm=mm}
   2 : result:=ll/25.4;             {inch 25.4 = mm}
   end;
end;

function unitrec.space_SI(ll:real):real;
begin
   //nom:=diamunit1;
   case uu of
   1 : result:=ll;                  {mm=mm}
   2 : result:=ll*2.54;             {inch 25.4 = mm}
   end;
end;


function unitrec.SI_space(ll:real):real;
begin
   //nom:=diamunit1;
   case uu of
   1 : result:=ll;                  {mm=mm}
   2 : result:=ll/2.54;             {inch 25.4 = mm}
   end;
end;

function unitrec.press_si(ll:real):real;    //psi  -  bar
begin
   case uu of
   1 : result:=ll;
   2 : result:=ll/14.5;
   end;
end;

function unitrec.SI_press(ll:real):real;   {MM werk in meter water hoogte}
begin
   case uu of
   1 : result:=ll;                    {meter = meter}
   2 : result:=ll*14.5;              {vt of water .305=meter}
   //3 : result:=ll/10; // /14.5/2.307/0.305;   {bars to psi to vt to meters}
  // 4 : result:=ll/2.307/0.305;        {Psi (2.307) ft of water (.305) to meters}
   end;
end;

function unitrec.SI_len(ll:real):real;    {mm werk in meters}
begin
   //nom:=lenunit1;
   case uu of
   1 : result:=ll;           {meters=meters}
   2 : result:=ll*3.28084;     {1 ft =.305 m}
   end;
end;

function ApRateCaption : string;
begin
   result:='Inch/h';
   if (units.uu=1) then result:='mm/h';

   if mining1 then
   begin
      result:='Gpm/ft2';
      if units.uu=1 then result:='l/h/m2';
   end;
end;

function ApRateDesi : integer;
begin
   result:=2;
   if units.uu=1 then result:=1;
   if mining1 and (units.uu=2) then result:=4;
end;


function apprate(in_h:real):real;
begin
   result:=in_h;
   if mining1 then
      if units.uu=2 then      //english   in/h > gpm/ft2
      begin     //cubfeet/ft2     minute   cubfeet/gallon
         result:=in_h/12           /60     *7.481;
      end
      else                    // metric     mm/h > l/h / m2
      begin    //mm/h = l/h/m2
         result:=in_h;
      end;
end;


function unitrec.makeriser(s:string):string;
var r : real;
    f : integer;
begin
   if s='' then s:='*';
   result:=s;
   if s='*' then exit;
   if uu=1 then
   begin
      val(s,r,f);
      result:=inttostr(round(r/2.54));
   end;
end;

function unitrec.makepressure(s:string):string;
var r : real;
    f : integer;
begin
   if s='' then s:='*';
   result:=s;
   if s='*' then exit;
   if uu=1 then
   begin
      val(s,r,f);
      result:=rtostr(r*14.5,10,2);
   end;
end;

function unitrec.makeflow(s:string):string;
var r : real;
    f : integer;
begin
   if s='' then s:='*';
   result:=s;
   if s='*' then exit;
   if uu=1 then
   begin
      val(s,r,f);
      result:=rtostr(r/0.063,10,2);

      if {mining1 or} (Metflow=2) then
         result:=rtostr(r/0.063/3600,10,2);

   end;
end;


function unitrec.riser_si : real;
begin
   case uu of
   1 : result:=2.54;
   2 : result:=1;
   end;
end;

function unitrec.flow : string;
begin
   case uu of
   1 : begin
          result:='l/s';
          if {mining1 or} (metflow=3) then result:='l/h';
          if {mining1 or} (metflow=5) then result:='l/m';
       end;
   2 : result:='gph';
   end;
end;

function unitrec.flow_si : real;   //gpm   -  l/s
begin
   case uu of
   1 : begin
          result:=0.063;
          if {mining1 or} (metflow=2)then result:=0.063*3600;     // l/h
          if {mining1 or} (metflow=5)then result:=0.063*60;     // l/h
       end;
   2 : result:=1;
   end;
end;

function unitrec.precip_si : real;
begin
   case uu of
   1 : result:=25.4;
   2 : result:=1;
   end;
end;

function unitrec.press : string;
begin
   case uu of
   1 : result:='bar';
   2 : result:='psi';
   end;
end;


function unitrec.len : string;
begin
   case uu of
   1 : result:='m';
   2 : result:='ft';
   end;
end;

function unitrec.len_si : real;
begin
   case uu of
   1 : result:=0.305;
   2 : result:=1;
   end;
end;


function unitrec.hoog : string;
begin
   case uu of
   1 : result:='mm';
   2 : result:='in';
   end;
end;



function unitrec.precip(prof:boolean) : string;
begin
   case uu of
   1 : begin
          result:='mm/h';
          if not prof and mining1 then result:='l/h/m2';
       end;
   2 : begin
          result:='in/h';
          if not prof and mining1 then result:='gpm/ft2'; //on profile its shown as in/h
       end;
   end;
end;

function unitrec.riser : string;
begin
   case uu of
   1 : result:='cm';
   2 : result:='inch';
   end;
end;

function unitrec.diam : string;
begin
   case uu of
   1 : result:='mm';
   2 : result:='inch';
   end;
end;


procedure grapobj.setpw(ww:real);
begin
   if prt=1 then exit;
   kanv.pen.width:=round(ww);
end;

procedure grapobj.xblock(xx,yy,t1,t : integer);
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
      kanv.pen.color:=mergecol(clgray,coll,j,8);
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




end.
