unit Form2unt;

interface

uses inifiles,winprocs,graphics,
     buttons,
     wintypes,
     sysutils,

     extctrls,
     //dglount,
     stdctrls;
     

     const
     maxlay2 =15;  {15;}

type     real10 = double;
         str10 = string[10];



(*       type layer2=record     {word in mineunt gebruik}
       van,na    : longint;
       desc,fnaam: str80;
       mdep,sg : real;
       end; *)


//       lay2type = array[1..maxlay2] of layer2;

    ascirec = record
    ccol,ycol,xcol,zcol,tcol        :  array[1..3] of integer;
    yxzfield  :integer;
    delim,notat                     : char;
    end;

     valobj = object

     
        waar : array[1..10] of integer;
        waarno : integer;

        foutjie : boolean;
        ini     : tinifile;



        (*
        procedure pushw(ww:integer);*)
        procedure popw;






        procedure sef;
        function r(edit : string; var vval : real; min,max : real) :boolean;
        function r10(edit : string; var vval : real10; min,max : real) :boolean;
        {min<=val<=max then OK}
        {min=max then any val=OK}
        {min>max then val<abs(max) then OK}
        function i(edit : string; var vval : integer; min,max : real) :boolean;
        function si(edit : string; var vval : smallint; min,max : real) :boolean;

        function readbool(w1,w2 : string; bool : boolean) : boolean;
        function readstring(w1,w2,w3 : string) : string;
        function readint(w1,w2 : string; w3 : longint) : longint;
        function readreal(w1,w2 : string; w3 : real) : real;
        procedure writebool(w1,w2 : string; bool : boolean);
        procedure writestring(w1,w2,w3 : string);
        procedure writeint(w1,w2 : string; w3 : longint);
        procedure writereal(w1,w2 : string; w3 : real);
        procedure erasesec(ss:string);
        {function modul(wat:integer):boolean;}
     end;

    hemobj = object
//       hemis : hemistype;
       units : integer;
       function stx : str10;
       function sty : str10;

       function m3 : str10;   {m3 /yards}
       function m2 : str10;   {m2 / cf}
       function m  : str10;   {m / ft}
       function mm : str10;   {mm / ft}
       function vol(v:real) : real;

       function y(sy,sx:real):real;    {y=y  e=-y}    {ptin ens}
       function x(sy,sx:real):real;    {x=x  n=-x}
       function iny(sy,sx:real):real;    {y=y  e=-x}   {pointinfo ens}
       function inx(sy,sx:real):real;    {x=x  n=-y}
       function ruy(sy,sx:real):real;    {y=y  e=x}   {lees ens}
       function rux(sy,sx:real):real;    {x=x  n=y}
       function h(hok : real10; decimalangle:boolean):real;
       function adjust : real;
//       procedure sett(hem : hemistype);
    end;

    

//function getvtxt(trans : string; wat,kar : string ; var value : real; var stri:string; regs:boolean):boolean;
function i360(hh : real; decimalangle : boolean):real;
function form_font(wat:integer) : string;
function strtor(wat : string) : real;
function i_s(wat : integer; l : integer) : string;
function s_s(wat : string; l : integer) : string;  {pad string}
function s__s(wat : string; l : integer) : string;  {str regs aligned}
function r_s(wat : real; l,d : integer) : string;   {rtostr sonder outspace}
function packspace(wat:string; cc:char):string;
function doublespace(wat:string):string;      //2 strings for every one
function rtostr(wat : real; l,d : integer) : string;
function rtostr_(wat : real; l,d : integer) : string; {met 0 deci indin frac=0}
function mergecol(col1,col2 : tcolor; nom,max:real) : tcolor;



function loadglyph(wat : string):hBitmap;
function outchar(tr:string; c1,c2 : char) : string;
procedure aanaf(var but : tspeedbutton; aan,aanaf_false : boolean);
procedure picaanaf(var but : timage; aan : boolean);
function min2int(i1,i2:integer):integer;
procedure outspace(var vra:string);

function numdec :integer;

var waarde : valobj;
    _asci  : ascirec;
    hem    : hemobj;

implementation

(*
function loadglyph(wat : string):hBitmap;
                   external 'mmw2.dll';*)

//function i360(hh : real):real;    external 'mm1.dll' index 1;



function i360(hh : real; decimalangle : boolean):real;
var cc : integer;
begin
//   cc:=general.fullcirc;
   if decimalangle then cc:=360;     //not decimal angle. check against 360 or 400
   while hh>cc do hh:=hh-cc;
   while hh<0 do hh:=cc+hh;
   result:=hh;
end;

function numdec :integer;
begin
   result:=waarde.readint('General','Pnt edit',3);
end;

function form_font(wat:integer) : string;
begin
   case wat of
   2 : result:='ISO';
   3 : result:='ITALIC';
   4 : result:='SCRIPTC';  {'SIMPLEX';}
   5 : result:='COMPLEX';
   6 : result:='GOTHICI';
   7 : result:='HB';
   8 : result:='CENT';
   9 : result:='HAND';
  10 : result:='DOTFONT';
  11 : result:='HELVITIA';
  12 : result:='ISO_EQ';
  13 : result:='ROMANS';
   else
       result:='MM-FONT';
   end;
end;

function loadglyph(wat : string):hBitmap;
var g : array[0..79] of char;
    j : integer;
begin

   fillchar(g,sizeof(g),' ');
   for j:=1 to length(wat) do wat[j]:=upcase(wat[j]);

   strpcopy(g,wat);
   result:=LoadBitmap(HINSTANCE,g);
end;

function min2int(i1,i2:integer):integer;
begin
   result:=i1;
   if i2<i1 then result:=i2;
end;

function outchar(tr:string; c1,c2 : char) : string;
var j,i,l,tt : integer;
    c3 : char;
begin
   tt:=8;
   result:='';
   c3:='_';
   if c1=c3 then c3:='=';

   {if c1<>' ' then
      for j:=1 to length(tr) do
         if tr[j]=' ' then tr[j]:=c3;}

   for j:=1 to length(tr) do
   begin
      if c1=#9 then   {tab}
      begin
         if tr[j]<>c1 then
            result:=result+tr[j]
         else
         begin
            L:=length(result);
            for i:=L+1 to (L div tt +2)*tt do
               result:=result+c2;
         end;
      end
      else
         if tr[j]=c1 then tr[j]:=c2;
   end;
   if c1<>#9 then result:=tr;
end;

function doublespace(wat:string):string;
var j : integer;
begin
   result:='';
   for j:=1 to length(wat) do
   begin
      result:=result+wat[j];
      if wat[j]=' ' then result:=result+' ';
   end;   
end;

function packspace(wat:string; cc:char):string;
var j : integer;
begin
   for j:=1 to length(wat) do
      if wat[j]=' ' then wat[j]:=cc;
   result:=wat;
end;

procedure sfout;
begin
   {messagebeep(MB_ICONEXCLAMATION);}   {1}
end;

procedure outspace(var vra:string);
var j : integer;
    tem : string;
begin
   tem:='';
   for j:=1 to length(vra) do if vra[j]<>' ' then tem:=tem+vra[j];
   vra:=tem;
end;

function i_s(wat : integer; l : integer) : string;
var tmp : string;
begin
   str(wat:l,tmp);
   result:=s_s(tmp,l);
end;

function s_s(wat : string; l : integer) : string;    {pad string}
begin
   wat:=wat+'                                          ';
   s_s:=copy(wat,1,l);
end;

function s__s(wat : string; l : integer) : string;    {pad string}
var ll : integer;
begin
   ll:=length(wat);
   if ll<l then
      result:=copy('                                         ',1,l-ll)+wat 
   else
      result:=copy(wat,1,l);
end;

function r_s(wat : real; l,d : integer) : string;
var tmp : string;
begin
   str(wat:l:d,tmp);
   result:=s_s(tmp,l);
end;

function rtostr(wat : real; l,d : integer) : string;
var tmp : string;
begin
   tmp:=r_s(wat,l,d);
   outspace(tmp);
   rtostr:=tmp;
end;

function rtostr_(wat : real; l,d : integer) : string;
var tmp : string;
begin
   if frac(wat)=0 then d:=0;
   result:=rtostr(wat,l,d);
end;

(*
procedure valobj.pushw(ww:integer);
begin
   {3=text
    4=pattern
    5=area define
    20=genstring z
    21=alignstring chainage
    die res = line lenght & angle}

  { if waarno<10 then
   begin
      inc(waarno);
      waar[waarno]:=ww;
      layer^.waar:=ww;
   end;}
   waarno:=1;
   layer^.waar:=ww;
end;
 *)
procedure valobj.popw;
begin
   {
   if waarno>=1 then
   begin
      dec(waarno);
      if waarno=0 then
         layer^.waar:=0
      else
         layer^.waar:=waar[waarno];
   end;
   }
end;



function valobj.r(edit : string; var vval : real; min,max : real) : boolean;
var rr : real10;
begin
   rr:=vval;
   r:=r10(edit,rr,min,max);
   vval:=rr;
end;

procedure valobj.sef;
begin
   if foutjie then
   begin
      foutjie:=false;
{      messagebeep(1);}
   end;
end;

procedure valobj.erasesec(ss:string);
begin
   ini.erasesection(ss);
end;

function valobj.readbool(w1,w2 : string; bool : boolean) : boolean;
begin

   result:=ini.readbool(w1,w2,bool);
end;

function valobj.readstring(w1,w2,w3 : string) : string;
begin
   result:=ini.readstring(w1,w2,w3);
end;

function valobj.readint(w1,w2 : string; w3 : longint) : longint;
var ww : string;
    vv : string;
    j : integer;
begin
   str(w3,vv);
   ww:=ini.readstring(w1,w2,vv);
   val(ww,w3,j);
   result:=w3;
end;

function valobj.readreal(w1,w2 : string; w3 : real) : real;
var ww : string;
    vv : string;
    j : integer;
begin
   str(w3:12:4,vv);
   outspace(vv);
   ww:=ini.readstring(w1,w2,vv);
   val(ww,w3,j);
   result:=w3;
end;

procedure valobj.writebool(w1,w2 : string; bool : boolean);
begin
   ini.writebool(w1,w2,bool);
end;

procedure valobj.writestring(w1,w2,w3 : string);
begin
   ini.writestring(w1,w2,w3);
end;

procedure valobj.writeint(w1,w2 : string; w3 : longint);
var vv : string;
begin
   str(w3,vv);
   ini.writestring(w1,w2,vv);
end;

procedure valobj.writereal(w1,w2 : string; w3 : real);
var vv : string;
begin
   str(w3:14:5,vv);
   outspace(vv);
   ini.writestring(w1,w2,vv);
end;


function valobj.r10(edit : string; var vval : real10; min,max : real) : boolean;
var j : integer;
    t : real;
    tmp : string;
begin
   r10:=true;
   tmp:=edit;
   outspace(tmp);
   val(tmp,t,j);
   if j=0 then
   begin
      if min=max then
      begin
         vval:=t;
         sef;
         exit;
      end;
      if min<max then
      begin
         if (t>=min) and (t<=max) then
         begin
            vval:=t;
            sef;

            exit;
         end;
      end;
      if min>max then
      begin
         if t<abs(max) then
         begin
            vval:=t;
            sef;
            exit;
         end;
      end;
   end;
   sfout;
   foutjie:=true;
   r10:=false;
end;

function valobj.si(edit : string; var vval : smallint; min,max : real) :boolean;
var j : integer;
begin
   j:=vval;
   result:=i(edit,j,min,max);
   vval:=j;
end;

function valobj.i(edit : string; var vval : integer; min,max : real) : boolean;
var j : integer;
    t : integer;
    tmp : string;
begin
   i:=true;
   tmp:=edit;
   outspace(tmp);
   val(tmp,t,j);
   if j=0 then
   begin
      if min=max then
      begin
         vval:=t;
         sef;
         exit;
      end;
      if min<max then
      begin
         if (t>=min) and (t<=max) then
         begin
            vval:=t;
            sef;
            exit;
         end;
      end;
      if min>max then
      begin
         if t<abs(max) then
         begin
            vval:=t;
            sef;
            exit;
         end;
      end;
   end;
   sfout;
   foutjie:=true;
   i:=false;
end;

function mergecol(col1,col2 : tcolor; nom,max:real) : tcolor;
var r1,g1,b1,r2,g2,b2 : longint;
    fak : real;
begin
   r1:=getrvalue(col1);
   g1:=getgvalue(col1);
   b1:=getbvalue(col1);

   r2:=getrvalue(col2);
   g2:=getgvalue(col2);
   b2:=getbvalue(col2);

   if max<2 then
      max:=2;
   if nom>=max-1 then
      nom:=max-1;


   fak:=nom/(max-1);

   result:=rgb(r1+round((r2-r1)*fak),
               g1+round((g2-g1)*fak),
               b1+round((b2-b1)*fak));

end;

procedure picaanaf(var but : timage; aan : boolean);
begin
   if aan then
      but.picture.bitmap.handle:=loadglyph('AAN') {LoadBitmap(HINSTANCE,'AAN')}
   else
      but.picture.bitmap.handle:=loadglyph('AF'); {LoadBitmap(HINSTANCE,'AF');}
end;

procedure aanaf(var but : tspeedbutton; aan,aanaf_false : boolean);
begin
   if aan then
   begin
      but.font.color:=clred;
      but.glyph.handle:=loadglyph('AAN');
   end
   else
   begin
      if not aanaf_false then
         but.glyph:=nil
      else                                  {af}
         but.glyph.handle:=loadglyph('AANCIR');
      but.font.color:=clgreen;
   end;
end;


function hemobj.adjust : real;
begin
   result:=1;
//   if units=2 then result:=feet;
end;

function hemobj.stx : str10;
begin
{   case hemis of
   suid : stx:='X';
   noord: stx:='N';
    else  stx:='X';
   end;}
end;

function hemobj.m3 : str10;
begin
   result:='m3';
   if units=2 then result:='yards';
end;

function hemobj.mm : str10;
begin
   result:='mm';
   if units=2 then result:='ft';
end;

function hemobj.m2 : str10;
begin

   result:='m2';
   if units=2 then result:='sf';
end;

function hemobj.m : str10;
begin
   result:='m';
   if units=2 then result:='ft';
end;

function hemobj.vol(v:real) : real;
begin
   result:=v;
   if units=2 then result:=v/(3*3*3);   {feet*feet*feet); to cub yards}
end;



function hemobj.sty : str10;
begin
{   case hemis of
   suid : sty:='Y';

   noord: sty:='E';
   else   sty:='Y';
   end;}
end;


function hemobj.y(sy,sx:real):real;
begin   {die regte suid coordinaat word gestuur }
{   case hemis of
   suid : y:=sy;
   noord: y:=-sy;
   else   y:=sy;
   end;}
end;

function hemobj.x(sy,sx:real):real;
begin
{   case hemis of
   suid : x:=sx;
   noord: x:=-sx;
   else   x:=sx;
   end;}
end;

function hemobj.iny(sy,sx:real):real;    {y=y  e=-x}   {pointinfo ens}
begin
{   case hemis of
   suid : iny:=sy;
   noord: iny:=-sx;
   else   iny:=sy;
   end;}
end;

function hemobj.inx(sy,sx:real):real;    {x=x  n=-y}
begin
{   case hemis of
   suid : inx:=sx;
   noord: inx:=-sy;
   else   inx:=sx;
   end;}
end;

function hemobj.ruy(sy,sx:real):real;    {y=y  e=x}   {lees ens}
begin
{   case hemis of
   suid : ruy:=sy;
   noord: ruy:=sx;
   else   ruy:=sy;
   end;}
end;

function hemobj.rux(sy,sx:real):real;    {x=x  n=y}
begin
{   case hemis of
   suid : rux:=sx;
   noord: rux:=sy;
   else   rux:=sx;
   end;}
end;

function hemobj.h(hok : real10; decimalangle:boolean):real;
var cc : real;
begin
{   cc:=general.fullcirc;
   if decimalangle then cc:=360;
   if (hemis=noord) or (hemis=wiskundig) then hok:=hok+cc/2;
   hok:=i360(hok,decimalangle);
   h:=hok;}
end;

{procedure hemobj.sett(hem : hemistype);
begin
   hemis:=hem;
end;}

function strtor(wat : string) : real;
var rr : real;
    ff,j : integer;
begin
   outspace(wat);

   for j:=1 to length(wat) do
      if wat[j]=',' then wat[j]:='.';

   val(wat,rr,ff);
   strtor:=rr;
end;



end.
