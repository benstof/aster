unit irrvar1;

interface

uses dglount,
    
     sysutils,
      vcl.Graphics;
     //caddraw;


const
   maxnode=20000;     {aantal nodes in 1 blok}
   maxblok=150*2*2;{80}     {aantal blokke in projek}
   maxbshift=5;      {aantal shifts waarin blok kan opereer}
   maxbloknodes=40*4;  {aantal peri punte om blok}
   maxshift=100; //40;      {totale aantal shifts}     //also in irrdef
   maxGroup=20;      {total flushing groups}
   maxPump =20;      {pumps in main}
   IProMax =250; //20*10;


type    {records nodig vir network calcs}
   pkoppel=record
      pnom : integer;
      flow1,flow2,fric : double;
      pres : double;    {net vir table record}
   end;


   //-------------------

   nnode=record
      Unumber    : string[10];      {user number/name}
      number     : integer;    {number in database}
      nblok      : integer;    {behoort aan blok No.}

      series     : string[30];      {20 series}
      model      : string[30];      {2023-1-1/2"M}        //40
      nozzle     : string[30];      {name  press etc}     //40

      part1      : string[15];
      part2      : string[15];
      part3      : string[15];
      part4      : string[15];
      tipeT       : string[8];      {Full Half Quarter}   //3/2005 now holds LORG
      patname    : string[20];  //20    {pattern name}

      id1,id2    : integer;    {identify}
      soort          : integer;    {1=pump 2=sprink 3=valve 4=fittin 5=other  6=booster pump}
                                    //for booster 6, if outflowdes>0 then pressure is added otherwise press = abs
                                    //old mir format (< ver13) type5 with negative press was = outflowdes=0 =absolute

      press,flow     : double;  {beskikbaar net bokant node}
      fric           : double;  {friction in all the pipes below}
      outflowdes     : double;  {consumption at node >> uitvloei design}
      pressdes       : double;  {desired pressure >> design for}
      outflow        : double;  {uitvloei met press beskikbaar}
      pipes          : integer;
      pkop           : array[1..4] of pkoppel;  {maks 4 pype / node}

      open_s,demand_s : byte;

      marc            : cadarctype; {cenx,ceny,starta,enda,radius,pen,ltipe,layer}
      z          : double;       {Z}
      width      : double;       {wydte vir reghoek spreier}
      Loss       : double;       {Wrywings verliese}
      Precip     : double;       {water lewering /uur}

      open,demand : boolean;   {valve open na onder en in shift 0, se of blok aan is}
             {demand waarde is outflowdes}
      {pshift         : array[0..20] of shiftrec;}
   end;

   //npnode =^nnode;



   irrec=object
       node    : array[-1..maxblok] of array of nnode;
      // newnode : array[-1..maxblok] of integer;        {se hoeveel nodes al genew is}
       nonode  : array[-1..maxblok] of integer;
       
       sourcenode : integer;     {main water originator}
       aantpump : integer;

   {
       pumpn,fittn,valven,othern,springn,boostern : str40;
       shapescale,IDscale,pumps,fitts,valves,others,springs,boosters : double;
       shape,vert : boolean;

       th,tw  : double;

       bFont,NFont,MainFont,ManiFont,LatFont : integer;
      }

       flushGroup    : array[1..maxgroup] of boolean;
       flushGroup1   : integer;   //active group
       flushVelocity : double;
       flushMVelocity: double;
       DOflushGroup  : boolean;

       nirx,niry  : double;

       (*
       fix,autojump,initdo,shapeok      : boolean;
       Hideredundent : boolean;

       ipat,irad,itext,iUtext,dowydte1,dowydte,Dowydtemm1 : boolean;   //
       ipres    : integer;


       ipump,ispring,ivalve,ifitt,iother,ibooster,ishape,iblock,nodeshiftcolor : boolean;
       *)

       fname   : Shortstring;

       //
       
       irrstat,laaste,pump2 : integer;   //number of second pump
       prodesc : array[1..3] of Shortstring;
       changed,zerror,dogetz : boolean;
       neardist : double;

       procedure init;
       function regpress(nn:nnode; gebruik:integer; sec:boolean):double;
       function ofdes(nn:nnode):double;
       procedure updatemainvalve(np:nnode);
       procedure clearnp(var np:nnode);
       procedure clearallpart;
       function pin(bb,n:integer) : nnode;
       function pin_user(n:integer) : nnode;
       procedure del(n:integer);
       function delblok(bb:integer; quick,wait:boolean) :boolean;
       procedure delall(quick:boolean);
       function getjumpinfo(var b1,b2,n1,n2,lati,mani,mani2,maini : integer; var nod1,nod2,nod3,nod4,nod5,nod6 : boolean):boolean;
       procedure idarea(ntip:integer; almal:boolean);
       function puit(n : integer; np:nnode) : boolean;
       procedure plotnode(pat,rad,text,idd:integer; hoe:integer; all:boolean);
       procedure plot1(np:nnode; pat,rad,text,idd:integer;hoe,blkk:integer);
       procedure irrimax(var minx,maxx,miny,maxy:double);
       function getnaasteall1(var l6: double) : boolean;
       function getnaastenode(var n : integer; var np:nnode; jmp:boolean):boolean;
       function reeds(n:integer;nr:nnode; var nom:integer):boolean;
       procedure getave_flowpress(node1:integer; var flow3,press3:double);
       procedure swap(n1,n2 : integer);
       procedure flash(pnn:nnode);
       procedure updateshapes;
       procedure AddIrrFonts;
       function fittype(j : integer; var d1,d2,d3,d4 : double;
                                     var t1,t2,t3,t4 : integer;   {soort}
                                     var y1,y2,y3,od,err : boolean;
                                     ShowErr : boolean) : integer;

       function IsFlushValve(nn:nnode; gNumber:integer; hydro:boolean):boolean;
       function valveAlready(blok : integer; np:nnode) : boolean;

       function GetNaasteNodePipe(var nommer,wie,kant,Pend : integer) : boolean;

    end;

    unitsobj=object
        lenunit1,pressunit1,flowunit1,diamunit1 : integer;
        {nom<0 meen gebruik default unit item}
        function len_si(ll:double;nom:integer):double;    {mm werk in meters}
        function press_SI(ll:double;nom:integer):double;   {MM werk in meter water hoogte}
        function flow_SI(ll:double;nom:integer):double;     {MM werk in l/s}
        function diam_SI(ll:double;nom:integer):double;
        function sdr_SI(ll:double;nom:integer):double;    {flow/sec/len = l/s/m}
        function precip_si(ll:double; nom:integer):double;   {mm werk in mm/h}
        function ha_si(ll:double; nom,units:integer):double;   {mm werk in ha}

        function SI_len(ll:double;nom:integer):double;    {mm werk in meters}
        function SI_press(ll:double;nom:integer):double;   {MM werk in meter water hoogte}
        function SI_flow(ll:double;nom:integer):double;     {MM werk in l/s}
        function SI_diam(ll:double;nom:integer):double;
        function SI_sdr(ll:double;nom:integer):double;    {l/s/m = flow/sec/len}
        function si_precip(ll:double;nom:integer):double;
        function si_ha(ll:double;nom,units:integer):double;

        function press(nom:integer):string;
        function flow(nom:integer):string;
        function leng(nom:integer):string;
        function diam(nom:integer):string;
        function velo(nom:integer):string;
        function precip(nom:integer):string;
        function Harea(nom:integer):string;
    end;

    shiftrec=record
       No                   : integer;      {on in this shift}
       flowavail,pressavail : double;         {available flow and pressure}
    end;

    subrec=record
      name,desc    : str20;
      blyne        : cadlinetype;
      status       : integer;         {design has changed since last calc}
      {0=new  1=calced  2=calced/changed}
      demand,pressdes : double;         {requered demand and pressure}
      color,nonode : integer;
      display : integer;              {0=none 1=fill color 2=}
      bx,by : array[1..maxbloknodes] of double;
   end;

    blkrec=record
      name,desc    : str20;
      blyne        : cadlinetype;
      status       : integer;         {design has changed since last calc}
      {0=new  1=calced  2=calced/changed}
      demand,pressdes : double;         {requered demand and pressure}
      regulatein   : double;            {regulator ?  11/03 now used to hold tramline spacing}
      color,nonode : integer;
      displayy : integer;             //5/2003 now holds the EU value  old {0=none 1=fill color 2=}
      bx,by : array[1..maxbloknodes] of double;
      shift : array[1..maxbshift] of shiftrec; {shift nommers waarin blok aan geskakel is}
      //ver 5.1
      sdrnode           : nnode;
      hspas,vspas,angl  : double;
      micro,stagg       : boolean;
      kortstop          : double;
   end;
      //ver10

   blkRecInfo = Record
      LatPercentAbove,LatPercentBelow : double;
      LatMeterAbove,LatMeterBelow     : double;
      ManPercentAbove,ManPercentBelow : double;
      ManMeterAbove,ManMeterBelow     : double;
      LatVeloc,ManVeloc               : double;
      EUN1,EUCV1                      : double;

      LatMaxPipe,ManMaxPipe  : integer;
      LatAuto                : boolean;
   end;

   blkRecPlant = record
       Pspas,RSpas : double;
      // Descrip : str40;
   end;

    blokobj=object
        noblok : integer;
        defchanged : boolean;
        iblok : array of blkrec; //array[-1..maxblok] of blkrec;
        iBlokInfo : array[-1..maxblok] of blkrecInfo;
        shiftcolor : array[1..maxblok] of integer;
        iBlokPlant : array[0..maxblok] of blkRecPlant;
        procedure loadshiftcolor;
        function totnonode:integer;        {sum all nodes in all bloks}
        function getblokflow(shift,bluk:integer):double;
        function getnaastepnt(var j:integer) : boolean;
        procedure copy(x1,y1:double;  xxx,yyy,direc:double; pipes,cop:boolean);
        procedure plotblok(hoe:integer);
        procedure plot1blok(j,hoe:integer);
        procedure blok_area(bb:integer);
        procedure flash(blck,tot:integer);
        function changed:boolean;
        function checkdupblok(blokk:integer) : integer;
        procedure AddBlokMem(pro : integer);
    end;

    IproObj = object
       No   : integer;
       ShowPro : integer;  //0=active 1=all 2=gray
       Show : array[1..IproMax] of boolean;

       Gpen,Gline : integer;
       Ghost      : boolean;

       Notes : array of string;

       //   default taken away from each Node project

       plotonlyThisShift : integer;

       penwidth,penwidth1,penwidth2,penwidth3 : double;
       Penwidthmm1,Penwidthmm2,Penwidthmm3    : double;



       pumpn,fittn,valven,othern,springn,boostern : str40;
       shapescale,IDscale,pumps,fitts,valves,others,springs,boosters,Gloscale : double;
       shape,vert,patSize : boolean;

       //Gloscale : shapes en patterns word met gloscale gesize
       //patsize true, patterns word met shape relsizes gescale.

       th,tw  : double;

       bFont,NFont,MainFont,ManiFont,LatFont : integer;

       fix,autojump,initdo,shapeok      : boolean;
       Hideredundent : boolean;

       ipat,irad,itext,iUtext,dowydte1,dowydte,Dowydtemm1 : boolean;   //
       ipres    : integer;

       ipump,ispring,ivalve,ifitt,iother,ibooster,ishape,iblock,IuserN,nodeshiftcolor : boolean;

       //from pipe project

       neardist,thP,twP,reguit,kort,mmm,Pmmm,ArrDist  : double;
       fixP    : boolean;

       semiloop,dashLength : double;

       Direction2 : double;   //used to tel pattern the color and direction

       ArrowOnLat : boolean;

       iflow1,iveloc1,itext1,iclass1 : boolean;
       iflow2,iveloc2,itext2,iclass2 : boolean;
       iflow3,iveloc3,itext3,iclass3,iPat3 : boolean;
       iPatname3 : string;

       leni,diami,lenslope,frici : boolean;
       Addunit    : boolean;
       classi     : byte;
       lenibo,diamibo,classibo,pipeslope,pipeshiftcolor,activepipes,fricibo : boolean;
       activeshift,Ldeci : integer;

       pipelabelnumber   : integer;

       //values for pattern label
       Lenval,ODval,IDval                        : double;
       HiFlowval,LoFlowval,HiVelocVal,LoVelocVal : double;
       HiPressVal,LoPressVal,Fric1Val,Fric2Val  : double;

       FlowVal2,LenVal2,FricVal2,PressVal2,VelocVal2,OdVal2,IdVal2 : string;

       //FlowQuantity Friction Lenght Class Oitside InsideDia Velocity
       Nameval2,Classval2,Codeval2 : string;   //name class
       PipePat  : boolean;  //tells pattern to substitute

       //

       function ProData(Ii:integer; var TotNode : integer) : boolean;
       function Data : boolean;
       procedure ClearAll;
       procedure irrimax(var minx,maxx,miny,maxy:double);
       procedure SetGhost(Ipro_,n:integer);
       procedure SetSaveStatus(diskfout:boolean);
       procedure delete_pack;
       procedure MovePack(xx2,yy2,dx,dy,dhoek:double);
       function blank(to_the_End:boolean) : integer;
       function copy1(n1,n2 : integer) : integer;
    end;


    var
    blok : integer;
    nirr : array[1..IproMax] of irrec;
    blk  : array[1..IproMax] of blokobj;
    sub  : subrec;
    units : unitsobj;
    maxnodemod,maxblokmod : integer;
    MainLt,ManLt,LatLt : integer;
    Ipro   : integer; //active irrigation project
    IproM  : IproObj;

    function getloss(nn:nnode; sped:double; sdr:boolean; PipeKd : double):double;

    function WShiftColor(j:integer):integer;

    procedure CorrectMarc;
implementation

uses irrvar2,irr2unt,varyunt,area2unt,setunt,cadohat,
 plotunt,
     cado3unt,
     windunt,
     fontvar,
     formunt,
     comunt,
     mouseunt,
     cadwrite,
     manager,
     vdialog,
     doenount,
     objunt,
     form2unt,
   //  VectorDraw,
     cadlunt,
     cad3pat,
     strvar,
     hatvar,
     cadount,
     irrpivot,
     gmenu;

procedure CorrectMarc;
var ee : double;
begin
   ee:=marc.enda;

   if (marc.enda=0) and (marc.starta=0) then
      marc.enda:=360;

   while marc.starta<0 do
   begin
      marc.starta:=360+marc.starta;
      if marc.enda<marc.starta then marc.enda:=marc.enda+360;
   end;
end;


procedure IproObj.MovePack(xx2,yy2,dx,dy,dhoek:double);
var n,bb : integer;
    nn   : nnode;
    zerror : boolean;
begin
   bb:=blok;
   mouse.wait;
   for blok:=0 to blk[Ipro].Noblok do
   begin
      with blk[Ipro].iblok[blok] do
      begin
         for n:=1 to nonode do
         begin
            //vrb(x1,y1,bx[n],by[n],afst,rigt);
            //pol(x1+xxx,y1+yyy,afst,rigt+direc,xx,yy);
            bx[n]:=bx[n]+dx;
            by[n]:=by[n]+dy;

            if dhoek<>0 then
            begin
               vrb(yy2,xx2,by[n],bx[n],afst,rigt);
               pol(yy2,xx2,afst,rigt+dhoek,by[n],bx[n]);
            end;
         end;
      end;
      with nirr[Ipro] do
         for n:=1 to nonode[blok] do
         begin
            nn:=node[blok,n];
            //vrb(x1,y1,nn.marc.cenx,nn.marc.ceny,afst,rigt);
            //pol(x1+xxx,y1+yyy,afst,rigt+direc,xx,yy);
            nn.marc.cenx:=nn.marc.cenx+dx;
            nn.marc.ceny:=nn.marc.ceny+dy;
            if dhoek<>0 then
            begin
               vrb(yy2,xx2,nn.marc.ceny,nn.marc.cenx,afst,rigt);
               pol(yy2,xx2,afst,rigt+dhoek,nn.marc.ceny,nn.marc.cenx);
            end;
            if not elevnode(nn) then zerror:=true;

            puit(n,nn);

            with nn.marc do
            confirm(cenx,ceny,2,2);

         end;
   end;
   mouse.go;
end;


function IproObj.copy1(n1,n2 : integer) : integer;
var j, tn : integer;
begin
   result:=1;
   if n1=n2 then exit;
   result:=2;
   if n2>IproMax then exit;
   result:=3;
   if prodata(n2,tn) then exit;

   result:=0;

  { copy
   blk[2]:=copy(blk[1]);

   blk[n2].noblok:=blk[n1].noblok;
   for j:=0 to blk[n1].noblok do
   begin
      blk[n2].iblok[j]     :=blk[n1].Iblok[j];    // : array[-1..maxblok] of blkrec;
      blk[n2].iBlokInfo[j] :=blk[n1].iBlokInfo[j] // array[-1..maxblok] of blkrecInfo;
      blk[n2].shiftcolor[j]:=blk[n1].shiftcolor[j] // array[1..maxblok] of integer;
      blk[n2].iBlokPlant   :=blk[n1].iBlokPlant[j]  // array[0..maxblok] of blkRecPlant;
   end;

    nirr[n2]:=nirr[n1];

   pirr[n2]:=pirr[n1];}

end;

function IproObj.blank(to_the_End:boolean) : integer;
var j,tn : integer;
begin
   result:=1;
   for j:=IproMax downto 1 do
      if not ProData(j,tn) then
      begin
         result:=j;
      end
      else
      begin
         if to_the_End then exit;
      end;
end;

procedure IproObj.delete_pack;

var j,k,i,bb : integer;
    //Ibl : array[0..maxblok] of blkrec;
    Ibl : array of blkrec;

begin

   setlength(ibl,maxblok+1);

   pirr[Ipro].delall(true);
   nirr[Ipro].delall(true);

   i:=0;
   for j:=Ipro to IproMax do
      for k:=0 to maxblok do
      begin
         if pirr[j].nopipe[k]>0 then i:=j;
         if nirr[j].nonode[k]>0 then i:=j;
      end;


   if I>Ipro then
   begin
      for j:=Ipro to I-1 do
      begin
         pirr[j]:=pirr[j+1];
         nirr[j]:=nirr[j+1];
         //----------------
         for bb:=0 to blk[j+1].Noblok do
            ibl[bb]:=blk[j+1].Iblok[bb];
         setlength(blk[j+1].Iblok,1);    //0   10/2009
         blk[j]:=blk[j+1];
         setlength(blk[j].Iblok,blk[j].NoBlok+1);
         for bb:=0 to blk[j].Noblok do
            blk[j].Iblok[bb]:=ibl[bb];
         //-----------------
      end;

      j:=Ipro;
      Ipro:=I;

      pirr[Ipro].delall(true);
      nirr[Ipro].delall(true);

      Ipro:=j;
   end;

   setlength(ibl,0);

end;

procedure IproObj.SetSaveStatus(diskfout:boolean);
var bb : integer;
begin
   for bb:=1 to Ipromax do
      nirr[bb].changed:=diskfout;
end;


procedure IproObj.SetGhost(Ipro_,n:integer);
begin
   Ghost:=false;
   general.oupen:=0;

   if n<=0 then exit;
   if ShowPro<2 then exit;
   if n=Ipro_ then exit;

   Gpen:=-cllTgray;
   Gline:=1;
   Ghost:=true;
end;


procedure IproObj.irrimax(var minx,maxx,miny,maxy:double);
var bb : integer;
begin
   for bb:=1 to Ipromax do
      if ((ShowPro=0) and (bb=Ipro)) or (ShowPro>0) then
         nirr[bb].irrimax(minx,maxx,miny,maxy);

   pivotform.maximum(minx,maxx,miny,maxy);
end;


function IproObj.ProData(Ii:integer; var TotNode : integer) : boolean;
var bb : integer;
begin
   result:=false;
   if blk[Ii].noblok>0 then result:=true;            //if more than blok 0
   if nirr[Ii].NoNode[0]>0 then result:=true;  // if blok0 has nodes

   TotNode:=0;
   for bb:=0 to blk[ii].noblok do
      TotNode:=totNode+nirr[Ii].NoNode[bb];
end;

function IproObj.Data : boolean;
var bb,t : integer;
begin
   result:=pivotform.HavePivots>0;

   for bb:=1 to Ipromax do
      result:=result or ProData(bb,t);
end;

procedure BlokObj.AddBlokMem(pro : integer);
var j,k : integer;
begin
  // for j:=1 to pro do
  // begin
      j:=pro;
      k:=length(blk[j].iblok);
      if k<maxblok then
         setlength(blk[j].iblok,maxblok);
  // end;
end;

procedure IproObj.ClearAll;
var bb : integer;
begin
   setlength(notes,0);

   //setlength(blk,1);
   for bb:=1 to Ipromax do
      setlength(blk[bb].iblok,1);

   for bb:=1 to Ipromax do
   begin
      Ipro:=bb;
      pirr[bb].delall(true);
      nirr[bb].delall(true);
      //blk[bb].noblok:=0;
   end;
   Ipro:=1;

   //PivotForm.NoPivots:=0;
   with PivotForm do
   fillchar(Ppivots,sizeof(pPivots),0);

end;



function blokobj.checkdupblok(blokk:integer) : integer;
var j : integer;
   x1,y1 : double;
begin
   result:=0;
   blok_area(blokk);
   x1:=(surfxmin+surfxmax)/2;
   y1:=(surfymin+surfymax)/2;
   for j:=1 to noblok do
      if j<>blokk then
      begin
         blok_area(j);
         if selfdexy(x1,y1,(surfxmin+surfxmax)/2,(surfymin+surfymax)/2) then result:=j;
      end;
end;


{============}

function WShiftColor(j:integer):integer;
begin
   result:=waarde.readint('IRRI-Shift','Color'+inttostr(blk[ipro].iblok[j].shift[1].no),1);
end;


procedure blokobj.loadshiftcolor;       //as set in irrdef
var n : integer;
begin
   for n:=1 to noblok do
      shiftcolor[n]:=waarde.readint('IRRI-Shift','Color'+inttostr(iblok[n].shift[1].no),1);
end;

function blokobj.changed:boolean;
var n : integer;
begin
   result:=true;
   for n:=0 to noblok do
      result:=result and (iblok[blok].status=1);

   result:=not result;
end;

function blokobj.getnaastepnt(var j:integer) : boolean;
var n : integer;
    nd : double;
begin
   nd:=1e9;
   result:=false;
   j:=1;
   with iblok[blok] do
   begin
      for n:=1 to nonode do
      begin
         afst:=potago(kursor.xpv,kursor.ypv,bx[n],by[n]);
         if afst<nd then
         begin
            nd:=afst;
            result:=true;
            j:=n;
         end;
      end;
      setecho(bx[j],by[j],true);
   end;
end;

procedure blokobj.copy(x1,y1:double; xxx,yyy,direc:double; pipes,cop:boolean);
var n ,bb,nob2: integer;
    //x1,y1 : double;
    xx,yy : double;
    nn:nnode;
    pp:npipe;
begin
   nob2:=blok;
   if cop then
   begin
      inc(noblok);
      nob2:=noblok;
      iblok[nob2]:=iblok[blok];
   end;
   with iblok[blok] do
   begin
      //x1:=bx[j];  y1:=by[j];
      for n:=1 to nonode do
      begin
         vrb(x1,y1,bx[n],by[n],afst,rigt);
         pol(x1+xxx,y1+yyy,afst,rigt+direc,xx,yy);
         iblok[nob2].bx[n]:=xx;
         iblok[nob2].by[n]:=yy;
      end;
   end;
   if pipes then
   begin
      with nirr[Ipro] do
         for n:=1 to nonode[blok] do
         begin
            nn:=node[blok,n];
            vrb(x1,y1,nn.marc.cenx,nn.marc.ceny,afst,rigt);
            pol(x1+xxx,y1+yyy,afst,rigt+direc,xx,yy);
            nn.marc.cenx:=xx;
            nn.marc.ceny:=yy;
            if not elevnode(nn) then zerror:=true;
            bb:=blok;
            blok:=nob2;
            if cop then
               puit(-1,nn)
            else
               puit(n,nn);
            blok:=bb;
         end;
      with pirr[Ipro] do
         for n:=1 to nopipe[blok] do
         begin
            pp:=pipe[blok,n];
            bb:=blok;
            blok:=nob2;
            if cop then
               puit(-1,pp)
            else
               puit(n,pp);
            blok:=bb;
         end;
   end;
end;


procedure blokobj.blok_area(bb:integer);
var n : integer;
    snit : snitrec;
begin
   with iblok[bb] do
   begin
      if nonode>maxbloknodes then nonode:=maxbloknodes;
      for n:=1 to nonode do
      begin
         surno:=nonode;
         snit.x:=bx[n];
         snit.y:=by[n];
         putsurface(n,snit);
      end;
   end;
   getsurflimit;
end;

function blokobj.getblokflow(shift,bluk:integer):double;
var n,ss : integer;
begin
   result:=0;
      if nirr[Ipro].nonode[bluk]>0 then
         with nirr[Ipro].node[bluk,1] do
            if soort=3 then           {valve by node 1}
            begin
               if (shift=0) then
               begin
                  result:=outflowdes;
                  exit;
               end;
               for n:=1 to maxbshift do
               begin
                  ss:=iblok[bluk].shift[n].no;
                  if ss=shift then                   {blok is oop in die shift}
                     result:=outflowdes;             {ontwerp demand van valve}
               end;
            end;
end;

procedure blokobj.flash(blck,tot:integer);
var j,hoe : integer;
    ff : boolean;
begin
   hoe:=0;
   ff:=waarde.readbool('Irrig','Shift-block',false);
   waarde.writebool('Irrig','Shift-block',false);
   for j:=1 to tot do
   begin
      plot1blok(blck,hoe);
      if hoe=1 then hoe:=0 else hoe:=1;
   end;
   waarde.writebool('Irrig','Shift-block',ff)
end;

function blokobj.totnonode:integer;
var j : integer;
begin
   result:=0;
   for j:=0 to noblok do
      result:=result+nirr[Ipro].nonode[j];
end;

procedure blokobj.plot1blok(j,hoe:integer);
var n,i : integer;
    th,tw,cenx,ceny : double;
    hs,ws  : double;
    dispIt : boolean;

    procedure plotblokhatch;
    var hat : hatrec;
        k : integer;
    begin
       if j<=0 then exit;
       if not waarde.readbool('Irrig','Shift-block',false) then exit;
       fillchar(hat,sizeof(hat),0);
       with iblok[j] do
       begin
          with hat.head do
          begin
             setlength(q,1);
             q[0]:=nonode;
             hat.head.dafst[5]:=waarde.readint('Irrig','Blok%',5);  //waarde.readint('Slope0','Fill%',100);

             hlayer:=cadlayer;
             cross:=2;
             pen:=WShiftColor(j); //{setcolor(}blk[Ipro].shiftcolor[j];
          end;

          setlength(hat.kord,1);
          setlength(hat.kord[0].krd,nonode+1);

          for k:=1 to nonode do
             with hat.kord[0].krd[k] do
             begin
                ax:=bx[k];
                ay:=by[k];
             end;


          zero_hat(hat);   
          tekenhat(hat,1,2,1);
          if cadplot then Writehat(hat,-1,false,true);
       end;
    end;


begin

   geths_ws(hs,ws);
   th:=waarde.readreal('Irrig','BlockTSize',3);
   tw:=th/2;
   with iblok[j] do
   begin
      lyne:=blyne;
      pen:=blyne.pen;


      if cadplot then   putlinetopar(blyne);

      cenx:=0;
      ceny:=0;

      plotblokhatch;


      DispIt:=waarde.readbool('Irrig','Dispbound',true);
      //if {(skerm<>0) or}  then
      for n:=1 to nonode do
      begin
         i:=n+1;
         if n=nonode then i:=1;
         cenx:=cenx+bx[n];
         ceny:=ceny+by[n];

         with lyne do
         begin
            vanx:=bx[n]; vany:=by[n];
            nax:=bx[i]; nay:=by[i];
         end;

         zero_line;

         with lyne do
            if dispIt and not buitewind(vanx,vany,nax,nay) then tekenlyn(hoe,4);

      end;

    //  exit;  ///////

      if hoe=0 then pen:=rubber;

      cfnt^.loadfont(Iprom.bfont);

      with waarde do
      if nonode>0 then
      begin
         cenx:=cenx/nonode+blyne.vanx;
         ceny:=ceny/nonode+blyne.vany;
         with lyne do
         begin
            vanx:=cenx; vany:=ceny;
            zero_line;
            cenx:=vanx; ceny:=vany;
         end;
         if readbool('Irrig','Blkname',false) then
         begin
            if skerm=0 then
               labell(name,cenx,ceny+mm(th*1.5),5,0,th,tw)
            else
               TAGS(name,cenx,ceny+mm(th*1.5),5,0,tw*ws,th*hs,pen);
            //cenx:=cenx+mm(4);
         end;
         if readbool('Irrig','Blkdesc',false) then
         begin
            if skerm=0 then
               labell(desc,cenx,ceny,5,0,th,tw)
            else
               TAGS(desc,cenx,ceny,5,0,tw*ws,th*hs,pen);
            //cenx:=cenx+mm(4);
         end;

         if readbool('Irrig','Blkno',false) then
         begin
            if skerm=0 then
               labell(inttostr(j),cenx,ceny-mm(th*1.5),5,0,th,tw)
            else
               TAGS(inttostr(j),cenx,ceny-mm(th*1.5),5,0,tw*ws,th*hs,pen);
         end;
      end;
   end;
end;

procedure blokobj.plotblok(hoe:integer);
var j : integer;
begin
   dxflay:='Blocks';
   if cadplot then cadlayer:=addlayer(dxflay);
   for j:=1 to noblok do
      if waarde.readbool('Irrig','DispBlock'+inttostr(j),true) then
         plot1blok(j,hoe);
end;

{-------user unit to SI unit-----}
function unitsobj.press(nom:integer):string;
begin
   if nom<0 then nom:=pressunit1;
   case nom of
   0 : result:='m';
   1 : result:='ft';
   2 : result:='Bars';
   3 : result:='psi';
   end;
end;
function unitsobj.flow(nom:integer):string;
begin
   if nom=-2 then
   begin
      case flowunit1 of
      0 : nom:=3;        //l/s  >l/h
      1 : nom:=3;        //m3/h > l/h
      2 : nom:=4;        //gpm > gph
      end;
   end;
   if nom<0 then nom:=flowunit1;
   case nom of
   0 : result:='l/s';
   1 : result:='m3/h';
   2 : result:='gpm';
   3 : result:='l/h';
   4 : result:='gph';
   5 : result:='l/m';
   end;
end;
function unitsobj.leng(nom:integer):string;
begin
   if nom<0 then nom:=lenunit1;
   case nom of
   0 : result:='m';
   1 : result:='ft';
   end;
end;
function unitsobj.velo(nom:integer):string;
begin
   result:=leng(nom)+'/sec';
end;

function unitsobj.diam(nom:integer):string;
begin
   if nom<0 then nom:=diamunit1;
   case nom of
   0 : result:='mm';
   1 : result:='inch';
   end;
end;

function unitsobj.precip(nom:integer):string;
begin
   if nom<0 then nom:=flowunit1;
   case nom of
   0,1,3 : result:='mm/h';
   2,4 : result:='inch/h';
   end;
end;

function unitsobj.Harea(nom:integer):string;
begin
   if hem.units=1 then
         result:='ha'
      else
         result:=hem.m2;
end;

function unitsobj.len_si(ll:double;nom:integer):double;    {mm werk in meters}
begin
   if nom<0 then nom:=lenunit1;
   case nom of
   0 : result:=ll;           {meters=meters}
   1 : result:=ll*0.305;     {1 ft =.305 m}
   end;
end;

function unitsobj.press_SI(ll:double;nom:integer):double;   {MM werk in meter water hoogte}
begin
   if nom<0 then nom:=pressunit1;
   case nom of
   0 : result:=ll;                    {meter = meter}
   1 : result:=ll*0.305;              {vt of water .305=meter}
   2 : result:=ll*10;  //*14.5*2.307*0.305;   {bars to psi to vt to meters}
   3 : result:=ll*2.307*0.305;        {Psi (2.307) ft of water (.305) to meters}
   end;
end;
function unitsobj.flow_SI(ll:double;nom:integer):double;     {MM werk in l/s}
begin
   if nom<0 then nom:=flowunit1;
   case nom of
   0 : result:=ll;                  {l/s=l/s}
   1 : result:=ll/0.227/15.852;     {m3/h 264.2 =gpm 0.063 =l/s}
   2 : result:=ll*0.063;            {GPM 0.063 =l/s}
   3 : result:=ll/3600;
   4 : result:=ll*0.063/60;          {GPH}
   5 : result:=ll/60;
   end;
end;
function unitsobj.diam_SI(ll:double;nom:integer):double;
begin
   if nom<0 then nom:=diamunit1;
   case nom of
   0 : result:=ll;                  {mm=mm}
   1 : result:=ll*25.4;             {inch 25.4 = mm}
   end;
end;
function unitsobj.sdr_SI(ll:double;nom:integer):double;    {l/s/m = flow/sec/len}
begin
   result:=ll/len_SI(1,-1)*flow_SI(1,-1);
end;
function unitsobj.precip_SI(ll:double;nom:integer):double;
begin
   if nom<0 then nom:=flowunit1;
   case nom of
   0,1,3,5 : result:=ll;                  {mm=mm}
   2,4     : result:=ll*25.4;             {inch 25.4 = mm}
   end;
end;
function unitsobj.HA_SI(ll:double;nom,units:integer):double;
begin
   if nom<0 then nom:=units;
   result:=ll;
   if nom<>1 then result:=ll*0.405;     {0.405ha = 1acres}
end;


function unitsobj.SI_len(ll:double;nom:integer):double;    {mm werk in meters}
begin
   if nom<0 then nom:=lenunit1;
   case nom of
   0 : result:=ll;           {meters=meters}
   1 : result:=ll/0.305;     {1 ft =.305 m}
   end;
end;
function unitsobj.SI_press(ll:double;nom:integer):double;   {MM werk in meter water hoogte}
begin
   if nom<0 then nom:=pressunit1;
   case nom of
   0 : result:=ll;                    {meter = meter}
   1 : result:=ll/0.305;              {vt of water .305=meter}
   2 : result:=ll/10; // /14.5/2.307/0.305;   {bars to psi to vt to meters}
   3 : result:=ll/2.307/0.305;        {Psi (2.307) ft of water (.305) to meters}
   end;
end;
function unitsobj.SI_flow(ll:double;nom:integer):double;     {MM werk in l/s}
begin
   if nom=-2 then
   begin
      case flowunit1 of
      0 : nom:=3;        //l/s  >l/h
      1 : nom:=3;        //m3/h > l/h
      2 : nom:=4;        //gpm > gph
      end;
   end;
   if nom<0 then nom:=flowunit1;
   case nom of
   0 : result:=ll;                  {l/s=l/s}
   1 : result:=ll*15.852*0.227;      {m3/h 264.2 =gpm 0.063 =l/s}
   2 : result:=ll/0.063;            {GPM 0.063 =l/s}
   3 : result:=ll*3600;
   4 : result:=ll/0.063*60;         {gph}
   5 : result:=ll*60;
   end;
end;
function unitsobj.SI_diam(ll:double;nom:integer):double;
begin
   if nom<0 then nom:=diamunit1;
   case nom of
   0 : result:=ll;                  {mm=mm}
   1 : result:=ll/25.4;             {inch 25.4 = mm}
   end;
end;
function unitsobj.SI_sdr(ll:double;nom:integer):double;    {l/s/m = flow/sec/len}
begin
   result:=ll/si_len(1,-1)*si_flow(1,-1);
end;
function unitsobj.SI_precip(ll:double;nom:integer):double;
begin
   if nom<0 then nom:=flowunit1;
   case nom of
   0,1,3,5 : result:=ll;                  {mm=mm}
   2,4     : result:=ll/25.4;             {inch 25.4 = mm}
   end;
end;
function unitsobj.SI_ha(ll:double;nom,units:integer):double;
begin
   if nom<0 then nom:=units;
   result:=ll;
   if nom<>1 then result:=ll/0.405;     {0.405 acres=1ha}
end;
{===================}

function getloss(nn:nnode; sped:double; sdr:boolean;PipeKd : double):double;
var pp,vv : double;
    p : integer;
begin
   result:=0;
   //exit;
   with nn do
   begin
      if not sdr then
      begin
         p:=pirr[Ipro].getprevpipe(nn.number,true,0);
         sped:=0;
         if p>0 then sped:=pspeed(pirr[Ipro].pipe[blok,p]);
      end;

      if sdr and (PipeKd<>0) then   //for sdr, if pipe has kd value, use it
      begin
         loss:=PipeKd;
      end;

      //loss:=1;
      result:=loss*sqr(sped)/(2*9.8);   // =kv2/2g

      if blok=0 then            //add to blok valves, ignore for passing valves
      begin
         if nn.nblok>0 then result:=0;
      end;
   end;
end;


procedure Irrec.AddIrrFonts;
begin
   with Iprom do
   with waarde do
   begin
      Bfont   :=Addfontname(readstring('Irrig','BlockFont','MM-STANDARD'));
      Nfont   :=Addfontname(readstring('Irrig','NodeFont','MM-STANDARD'));
      MainFont:=Addfontname(readstring('Irrig','MainFont','MM-STANDARD'));
      ManiFont:=Addfontname(readstring('Irrig','ManiFont','MM-STANDARD'));
      LatFont :=Addfontname(readstring('Irrig','LatFont','MM-STANDARD'));
   end;
end;

function irrec.valveAlready(blok : integer; np:nnode) : boolean;
var j : integer;
begin
   result:=false;
   if blok=0 then exit;
   if np.soort<>3 then exit;

   result:=true;
   for j:=1 to nonode[blok] do
      if node[blok,j].soort=3 then exit;

   result:=false;
end;


function irrec.regpress(nn:nnode; gebruik:integer; sec:boolean):double;
var prtype,prev:integer;
    doen : boolean;
begin
   with nn do
   begin
      result:=press;
      if sec then result:=result-getloss(nn,0,false,0);
      if (soort=5) then //and (nozzle='Regular') then
      begin
         prtype:=trunc(outflowdes);
         doen:=true;
         case prtype of
         0 : doen:=true;
         1 : doen:=gebruik=3;
         2 : doen:=gebruik=2;
         3 : doen:=gebruik=1;
         end;
         if doen then
         begin
            if (pressdes>0) and (press>pressdes) then
            begin
               prev:=pirr[Ipro].getprevpipe(nn.number,true,0);  //do not regulate empty pipe

               if waarde.readbool('Irrig','RegEmpty',false) then
               begin
                  result:=pressdes
               end
               else
                  if prev>0 then
                     if pirr[Ipro].pipe[blok,prev].pflow<=0 then   //nothing
                  else
                     result:=pressdes;
            end;
            if (pressdes<=0) and (press<abs(pressdes)) then result:=abs(pressdes);
         end;
      end;

      if (soort=6) then
         result:=getboostPres(press,nn);
   end;
end;

function irrec.ofdes(nn:nnode):double;
begin
   result:=nn.outflowdes;
   if nn.soort in [4,5] then result:=0;
end;

procedure irrec.idarea(ntip:integer; almal:boolean);
var n,bb,bloc : integer;
    flen : double;
    doen : boolean;
    np : nnode;
begin
   bb:=blok;
   for bloc:=0 to blk[Ipro].noblok do
   begin
      blok:=bloc;
      for n:=1 to nonode[blok] do
      begin
         np:=node[blok,n];
         doen:=inarea(np.marc.cenx,np.marc.ceny,0);
         doen:=doen and (almal or (blok=bb));
         if doen then
         case ntip of
         1 : doen:=np.soort=2;
         2 : doen:=np.soort=4;
         end;
         if doen then node[blok,n].id2:=1 else node[blok,n].id2:=0;
      end;
   end;
   blok:=bb;
   plotnode(0,0,0,1,1,true);
end;
                
function Irrec.IsFlushValve(nn:nnode; gNumber:integer; hydro:boolean):boolean;
var n,f : integer;
begin
   result:=false;
   if not nirr[Ipro].DOflushGroup then exit;
   if nn.series<>'FLUSH VALVE' then exit;
   if nn.soort<>4 then exit;
   if (nn.unumber<>'') then
   begin
      val(nn.unumber,n,f);
      if (f=0) and (n in [1..maxgroup]) then
      begin
         if gnumber<=0 then
         begin
            if flushGroup[n] then result:=true;   //hydro calc
         end
         else
            if (n=gnumber) and (flushGroup[n] or not hydro) then result:=true;  //report of hydro
      end;
   end;
end;


procedure irrec.flash(pnn:nnode);
var p,k : integer;
    r : double;
begin
   r:=1;
   k:=pnn.soort;
   pnn.soort:=2;
   with pnn.marc do            //3
   begin
      confirm(cenx,ceny,white,8);
      confirm(cenx,ceny,white,7);
   end;
   repeat
      pnn.marc.straal:=mm(r);
      nirr[1].plot1(pnn,0,1,0,0,1,0);
      nirr[1].plot1(pnn,0,1,0,0,0,0);
      r:=r+0.25;
   until r>5;
   pnn.soort:=k;
   nirr[1].plot1(pnn,2,2,2,2,1,0);
   with pnn.marc do
   begin
      confirm(cenx,ceny,-1,8);
      confirm(cenx,ceny,-1,7);
   end;
end;

procedure irrec.updatemainvalve(np:nnode);
var bb,i : integer;
    nn : nnode;
begin
   if (np.soort=3) then       //let valve also update blok flow data
   begin
      if blok>0 then
      begin
         blk[Ipro].iblok[blok].pressdes:=np.pressdes;
         blk[Ipro].iblok[blok].demand:=np.outflowdes;
         bb:=blok;
         blok:=0;
         with nirr[Ipro] do
         for i:=1 to nonode[0] do
         begin
            nn:=pin(0,i);
            if (nn.soort=3) and (nn.nblok=bb) then
            begin
               np.nblok:=bb;
               puit(i,np);     // save blok valve info in mainline
            end;
         end;
         blok:=bb;
      end;
   end;
end;

procedure irrec.init;
var j : integer;
begin
   //for j:=1 to 1 do new(node[blok,j]);
   setlength(node[0],2);

   blk[1].AddBlokMem(1);
   for j:=2 to Ipromax do
     setlength(blk[j].iblok,1);



   //newnode[blok]:=1;
   nonode[blok]:=0;
   Iprom.initdo:=true;
   updateshapes;
end;

function irrec.getjumpinfo(var b1,b2,n1,n2,lati,mani,mani2,maini : integer; var nod1,nod2,nod3,nod4,nod5,nod6 : boolean) : boolean;
begin
   lati:=0;
   mani:=0;
   mani2:=0;
   maini:=0;
   nod1:=false;
   nod2:=false;
   nod3:=false;
   nod4:=false;
   nod5:=false;
   nod6:=false;
   with waarde do
   begin
      result:=false;
      if not disp_.irrigation then exit;

      if waarde.readbool('Irrig','Disppipes',false) then
      begin
         lati:=readint('Irrig','Displat',2);
         mani:=readint('Irrig','Dispmani',2);
         mani2:=readint('Irrig','Dispmani2',2);
         maini:=readint('Irrig','Dispmain',2);
      end;
   end;

   //if not waarde.readbool('Irrig','Dispnodes',false) then exit;



   result:=true;


   nod1:=Iprom.ipump;
   nod2:=Iprom.ispring;
   nod3:=Iprom.ivalve;
   nod4:=Iprom.ifitt;
   nod5:=Iprom.iother;
   nod6:=Iprom.ibooster;

   b1:=0; b2:=blk[Ipro].noblok;
   n1:=0; n2:=blk[Ipro].noblok;
   if waarde.readbool('Irrig','Dispblock',false) then
   begin
      b1:=blok; b2:=blok;
   end;
    if waarde.readbool('Irrig','Dispnblock',false) then
   begin
      n1:=blok; n2:=blok;
   end;
end;


function irrec.delblok(bb:integer; quick,wait:boolean) :boolean;
var np:nnode;
    n : integer;
begin
   if wait then mouse.wait;
   blok:=bb;
   result:=false;
   for n:=nonode[bb] downto 1 do
   begin
      np:=pin(bb,n);
      if pirr[Ipro].nonepipe(np) then
      begin
         if not quick then nirr[1].plot1(np,2,2,2,2,0,0);
         del(n);
      end;
      if keypressed and pause_plot then exit;
   end;
   if wait then mouse.go;
   result:=true;
//   with blk[Ipro] do
  // begin
      if high(blk[Ipro].iblok)>=bb then
         blk[Ipro].iblok[bb].nonode:=0;
      if (bb=blk[Ipro].noblok) and (bb>0) then dec(blk[Ipro].noblok);
  // end;
end;

procedure irrec.delall(quick:boolean);
var np:nnode;
    n : integer;
begin
   blok:=0;
   mouse.wait;
   for n:=blk[Ipro].noblok downto 0 do
      if not nirr[Ipro].delblok(n,quick,false) then exit;
   mouse.go;
end;

function irrec.pin(bb,n:integer) : nnode;
var px : pitype;
    ss : boolean;
begin
   fillchar(result,sizeof(nnode),0);
   if n=-1 then n:=nonode[bb];
   if n>0 then result:=node[bb,n];

   if cstr.sdried then
   begin
      marc:=result.marc;
      zero_arc;
      px.pix:=marc.cenx;
      px.piy:=marc.ceny;
      px.piz:=units.si_len(result.z,-1);
      _dried(px);
      marc.cenx:=px.pix;
      marc.ceny:=px.piy;
      //arc_zero;
      result.marc:=marc;
      result.z:=px.piz;
   end;
end;

function irrec.pin_user(n:integer) : nnode;
var j : integer;
    
begin
   result:=pin(blok,n);


{   fillchar(result,sizeof(nnode),0);}
end;

function irrec.puit(n:integer; np:nnode) : boolean;
var j : integer;
begin
   result:=false;

   with np.marc do
   begin
      if pen=0 then pen:=10;
      if layer=0 then layer:=addlayer('IRR');  //\\
   end;

   if (n=-1) then
   begin
      if (nonode[blok]>=maxnode) then exit;     {te veel}
(*      if nonode[blok]+1>newnode[blok] then            {new memory}
      begin
         for j:=newnode[blok]+1 to nonode[blok]+1 do new(node[blok,j]);
         newnode[blok]:=nonode[blok]+1;
      end;  *)
      
      setlength(node[blok],nonode[blok]+2);

      CheckWatter(nonode[blok]+2,0);

      if dogetz and not elevnode(np) then zerror:=true;
            {elevate node to dtm surface}
     // if nonode[blok]=0 then blk[Ipro].iblok[blok].micro:=false;   //make regular nodes
   end;
   result:=true;

   if n=-1 then
   begin
      inc(nonode[blok]);
      n:=nonode[blok];
   end;

   marc:=np.marc;

   if np.soort=4 then np.pressdes:=0;

   with pirr[Ipro] do                  {update pype}
   for j:=1 to nopipe[blok] do
      with pipe[blok,j] do
      begin
         if p1=n then
         begin
            lyne.vanx:=marc.cenx;
            lyne.vany:=marc.ceny;
         end;
         if p2=n then
         begin
            lyne.nax:=marc.cenx;
            lyne.nay:=marc.ceny;
         end;
      end;
   np.number:=n;          {stoor nommer in number for plotting}
   node[blok,n]:=np;

   updatemainvalve(np);   //apply changes to main line valves

   //saved.statsirr;
end;

function loadishape(np : nnode) : boolean;
var tmp : Shortstring;
    sc  : double;
begin
   with Iprom do     //alle shapes is soos 1, nie Ipro
   begin
      case np.soort of
      1 : begin tmp:=PUMPn;     sc:=pumps; end;
      2 : begin tmp:=SPRINgn;  sc:=springs; end;
      3 : begin tmp:=VALVEn;  sc:=valves; end;
      4,7 : begin tmp:=FITTn;   sc:=fitts; end;
      5 : begin tmp:=OTHERn;  sc:=others; end;
      6 : begin tmp:=BOOSTERn;  sc:=boosters; end;
      end;
      if tmp[1]<>'#' then tmp:='#'+tmp;
      result:=true;
      if stypexy.name<>tmp then result:=loadshape(tmp);
      shape:=true;

      if not result then shapeok:=false;

      shapescale:=sc*gloScale;
   end;
end;

procedure irrec.plot1(np:nnode; pat,rad,text,idd:integer; hoe,blkk:integer);
var st,s7 : Shortstring;                {0=niks 1=ja 2=global}
    cadpat : cadpattype;
    mmrc : cadarctype;
    j,p2 : integer;
    patreeds,loaded,rotShape,Pcolor : boolean;
    xp,yp,hs,ws : double;
    pp2 : npipe;
begin

    rotShape:=waarde.readbool('Irrig','RotateShape',false);
    Pcolor  :=waarde.readbool('Irrig','PatColor',false);

      marc:=np.marc;
      if marc.pen=0 then marc.pen:=10;

      if marc.enda=0 then marc.enda:=360;

      if (skerm=1) and (not cwnd.inactive(np.marc.cenx,np.marc.ceny,wact)) then exit;

      if rad=2 then if Iprom.irad then rad:=1 else rad:=0;
      if pat=2 then if Iprom.ipat then pat:=1 else pat:=0;
      if text=2 then if (Iprom.itext or Iprom.iUtext or (Iprom.ipres>0) ) then text:=1 else text:=0;

      marc.straal:=marc.straal*hem.adjust;

      if (rad=0) or (np.soort<>2) then marc.straal:=mm(0.92);
      if (rad=1) and (np.soort<>2) then rad:=0;   //dont attemp radius if not emitter

      with general do
      if idd>=1 then          {id as idd=1 en id2=1 of as idd=2}
         if (idd=2) or (np.id2=1) then
            marc.pen:=idcolor1 else marc.pen:=idcolor2;

       if (idd=0) and (blkk>0) and Iprom.nodeshiftcolor then
       begin
          j:=WShiftColor(Blkk); //blk[1].shiftcolor[blkk];
          if (j>0) and (j<=maxpen) then marc.pen:=j;
       end;

      if np.soort=2 then  correctMarc;    //10/2010

      if not cstr.sdried then zero_arc;

      if cstr.sdried and cadplot then text:=0;

      case np.soort of
      1 : if not Iprom.ipump then exit;
      2 : if not Iprom.ispring then exit;
      3 : if not Iprom.ivalve then exit;
      4 : if not Iprom.ifitt or (Iprom.hideredundent and (np.series='Dummy')) then exit;
      5 : if not Iprom.iother then exit;
      6 : if not Iprom.ibooster then exit;
      end;

      if idd>=1 then
      begin
         with marc do
            confirm(cenx,ceny,pen,2);
      end;

      cfnt^.loadfont(Iprom.Nfont);

      patreeds:=false;
      mmrc:=marc;
      with marc do
      begin
         pen:=marc.pen;
         if hoe=0 then pen:=rubber;
         if (pat=1) and (np.patname<>'') then
         with cadpat do
         begin
            x:=np.marc.cenx;
            y:=np.marc.ceny;
            rotate:=0+rotation;     //keep horizontal
            scale:=1*Iprom.GloScale;

            if Iprom.PatSize then
            begin
               LoadIshape(np);
               scale:=Iprom.ShapeScale;
            end;

            name:=addpatname(np.patname,false);

            p2:=0;
            if Pcolor then p2:=marc.pen;

            if cadplot then            //irrland legend
            begin
               cadplot:=false;
               patreeds:=Tekenpat(cadpat,98,true,false,false,Pcolor,p2,'');
               cadplot:=true;
            end   
            else
               patreeds:=Tekenpat(cadpat,hoe,true,false,false,Pcolor,p2,'')
         end;

         if (text=1) then
         begin
            geths_ws(hs,ws);
            //ppen(-1,pen,1,0,false);
            ppen(marc.pen,1,0,false);
            if Iprom.iText then
            begin
               st:=inttostr(np.number);
               if skerm=0 then
                  labell(st,cenx,ceny,1,0,Iprom.th,Iprom.tw)
               else
                  TAGS(st,cenx,ceny,1,0,Iprom.tw*ws,Iprom.th*hs,pen);
            end;

            if (np.soort<>4) then
            begin
               if (np.soort<>3) or (blkk=0) then  //only let mainline show blok valve actual
               if Iprom.ipres in [2,3] then
               begin
                  st:='A'+rtostr_(units.si_press(np.press,-1),10,2);
                  if skerm=0 then
                     labell(st,cenx,ceny,7,0,Iprom.th,Iprom.tw)
                  else
                     TAGS(st,cenx,ceny,7,0,Iprom.tw*ws,Iprom.th*hs,pen);
               end;
               if Iprom.ipres in [1,3] then
               begin
                  st:='D'+rtostr_(units.si_press(np.pressdes,-1),10,2);
                  if skerm=0 then
                     labell(st,cenx,ceny,9,0,Iprom.th,Iprom.tw)
                  else
                     TAGS(st,cenx,ceny,9,0,Iprom.tw*ws,Iprom.th*hs,pen);
               end;
            end;


            if Iprom.iUText then
            begin
               st:=np.Unumber;
               j:=7;
               if np.tipeT[1]='1' then j:=1;
                if np.tipeT[1]='2' then j:=2;
               if np.tipeT[1]='3' then j:=3;
               if np.tipeT[1]='4' then j:=4;
               if np.tipeT[1]='5' then j:=5;
               if np.tipeT[1]='6' then j:=6;
               if np.tipeT[1]='7' then j:=7;
               if np.tipeT[1]='8' then j:=8;
               if np.tipeT[1]='9' then j:=9;
               if skerm=0 then
                  labell(st,cenx,ceny,j,0,Iprom.th,Iprom.tw)
               else
                  TAGS(st,cenx,ceny,j,0,Iprom.tw*ws,Iprom.th*hs,pen);
            end;
         end;
      end;
      marc:=mmrc;

      //if not patreeds then   //nothing else if pattern is there
      loaded:=not Iprom.ishape;
      if {(rad=0) and} Iprom.ishape and loadishape(np) and ( (skerm<>2) or general.dxfexplode) and (patreeds=false) then
      begin
         loaded:=true;
         if hoe=0 then marc.pen:=rubber;
         ppen(marc.pen,1,0,false);
         j:=1; //if (idd>0) and (blok=0) then j:=3;


         if Iprom.IDSCAle<1 then Iprom.IDSCALE:=1;
         if (idd=1) and (np.id2=1) then Iprom.ShapeScale:=Iprom.ShapeScale*Iprom.IDScale; //scale if idd

         if skerm=7 then
         begin
            s7:=stypexy.name+inttostr(marc.pen);
         {   if not Vdraw_BlockExist(s7) then
            begin
               Vdraw_addBlock(s7,marc.cenx,marc.ceny);
               with marc do
                  drawshape(0,cenx,ceny,cenx+100,ceny+100,0,1001,pen,j,false);
               Vdraw_EndBlock;
            end;
            Vdraw_InsertBlock(s7,marc.cenx,marc.ceny,np.z,1,0);    }
         end
         else
         begin
            rigt:=0;
            if rotshape then
            begin
               p2:=pirr[ipro].getprevpipe(np.number,false,0);
               if (p2>0) and (p2<=pirr[Ipro].nopipe[blkk]) then
               begin
                  pp2:=pirr[ipro].pipe[blkk,p2];
                  with pp2.llyne do
                     vrb(vanx,vany,nax,nay,afst,rigt);
               end;
            end;

            with marc do                               ////
               drawshape(0,cenx,ceny,cenx+100,ceny+100,rigt,1001,pen,j,false);
         end;
      end;

      if patreeds then loaded:=true;
      //if not patreeds then                //hide all if pattern is drawn
      if (rad=1) or (not Iprom.ishape or not loaded) then
      begin
         if waarde.readbool('Irrig','DotArc',false) then marc.ltipe:=1;

         correctMarc;

         if marc.starta<0 then
         begin
            marc.starta:=360+marc.starta;
            if marc.enda<marc.starta then marc.enda:=marc.enda+360;
         end;

         tekenarc(hoe);
         if abs(marc.starta-marc.enda)<>360 then
         with marc do
         begin
            lyne.pen:=pen;
            lyne.layer:=layer;
            lyne.vanx:=cenx;
            lyne.vany:=ceny;
            pol(-ceny,-cenx,straal,starta,xp,yp);
            lyne.nax:=-yp;
            lyne.nay:=-xp;
            tekenlyn(hoe,4);

            pol(-ceny,-cenx,straal,enda,xp,yp);
            lyne.nax:=-yp;
            lyne.nay:=-xp;
            tekenlyn(hoe,4);
         end;
      end;
end;


procedure irrec.del(n:integer);
var j : integer;
    pp : npipe;
begin
   if n=-1 then n:=nonode[blok];

   with pirr[Ipro] do                {delete pipes connected}
   for j:=nopipe[blok] downto 1 do
   begin
      pp:=pin(blok,j);
      if (pp.p1=n) or (pp.p2=n) then del(j);
   end;

   if n<nonode[blok] then
   begin
      pirr[Ipro].renumpipes(nonode[blok],n);
      node[blok,n]:=node[blok,nonode[blok]];
      node[blok,n].number:=n;
   end;
   dec(nonode[blok]);
   saved.statsirr;
end;

procedure irrec.swap(n1,n2 : integer);
var nn:nnode;
begin
   if (nirr[Ipro].nonode[blok]<n2) or
      (nirr[Ipro].nonode[blok]<n1) then exit;
   pirr[Ipro].renumpipes(n1,100000);
   pirr[Ipro].renumpipes(n2,n1);
   pirr[Ipro].renumpipes(100000,n2);
   nn:=nirr[Ipro].node[blok,n1];
   nirr[Ipro].node[blok,n1]:=node[blok,n2];
   nirr[Ipro].node[blok,n1].number:=n1;
   nirr[Ipro].node[blok,n2]:=nn;
   nirr[Ipro].node[blok,n2].number:=n2;
end;

procedure irrec.plotnode(pat,rad,text,idd:integer; hoe:integer; all:boolean);
var j,bb:integer;
    pp,ok:boolean;
begin
   if not waarde.readbool('Irrig','Dispnodes',false) then exit;

  { if (skerm=7) and ishape then
   begin
      for j:=1 to 5 do
      begin
         case j of
         1 : tmp:=PUMPn;
         2 : tmp:=SPRINgn;
         3 : tmp:=VALVEn;
         4 : tmp:=FITTn;
         5 : tmp:=OTHERn;
         end;
         if tmp[1]<>'#' then tmp:='#'+tmp;
         if loadshape(tmp) then
         begin
            drawshape(0,cenx,ceny,cenx+100,ceny+100,0,1001,pen,j,false);
   end;}

   for bb:=0 to blk[Ipro].noblok do
   begin
      pp:=true;
      if not all then pp:=bb=blok;


      ok:=true;
      if Iprom.plotonlyThisShift>0 then
      if (bb>0) then
      begin
         ok:=false;
         for j:=1 to maxbshift do
         if (Iprom.plotonlyThisShift=blk[Ipro].iblok[bb].shift[j].no) then ok:=true;

         pp:=ok;
      end;


      if not waarde.readbool('Irrig','DispBlock'+inttostr(bb),true) then pp:=false;

      {if Iprom.plotonlyThisShift>0 then
      if (bb>0) and (Iprom.plotonlyThisShift<>blk[Ipro].iblok[bb].shift[1].no) then pp:=false;}

      if pp then
      for j:=1 to nonode[bb] do
      begin
         if keypressed and pause_plot then exit;
         {1=pump 2=sprink 3=valve 4=fittin 5=other}
         case node[bb,j].soort of
         1 : dxflay:='Pump';
         2 : dxflay:='Emitter';
         3 : dxflay:='Valve';
         4 : dxflay:='Fitting';
         5 : dxflay:='Other';
         end;
         if cadplot then cadlayer:=addlayer(dxflay);

         ok:=true;
         if Iprom.plotonlyThisShift>0 then
         if (bb=0) and (node[bb,j].soort=3) then
         begin
            ok:=false;

            if node[bb,j].demand_s=0 then ok:=true;
            if (Iprom.plotonlyThisShift=node[bb,j].demand_s) then ok:=true;
            if (Iprom.plotonlyThisShift=node[bb,j].open_s) then ok:=true;
         end;

         if Iprom.IuserN then Ok:=node[bb,j].Unumber<>'';

         if ((bb=blok) or (not Iprom.iblock)) and ok then
            nirr[1].plot1(pin(bb,j),pat,rad,text,idd,hoe,bb);
      end;
   end;
end;

procedure irrec.clearallpart;
var j,n : integer;
begin
   for j:=0 to blk[Ipro].noblok do
      for n:=1 to nonode[j] do
         with node[j,n] do
         begin
            part1:='';
            part2:='';
            part3:='';
            part4:='';
         end;
   saved.statsirr;
end;

procedure irrec.clearnp(var np:nnode);
var j : integer;
begin
   fillchar(np,sizeof(nnode),0);
   np.marc.enda:=360;
   with np do
   begin
      open:=true;        {valve is open and use the demand}
      demand:=true;
   end;
end;

procedure irrec.irrimax(var minx,maxx,miny,maxy:double);
var j,bb:integer;
    pt : nnode;
begin
   if not disp_.irrigation then exit;
   for bb:=0 to blk[Ipro].noblok do
   begin
      for j:=1 to nonode[bb] do
      begin
         pt:=pin(bb,j);
         with pt.marc do
         begin
            if pt.soort<>2 then straal:=mm(1);     {nie sprinkler}
            if cenx-straal<minx then minx:=cenx-straal;
            if cenx+straal>maxx then maxx:=cenx+straal;
            if ceny-straal<miny then miny:=ceny-straal;
            if ceny+straal>maxy then maxy:=ceny+straal;
         end;
      end;
      if not cstr.sdried then
      with blk[Ipro].iblok[bb] do
         for j:=1 to nonode do
         begin
            if bx[j]<minx then minx:=bx[j];
            if bx[j]>maxx then maxx:=bx[j];
            if by[j]<miny then miny:=by[j];
            if by[j]>maxy then maxy:=by[j];
         end;
   end;
   pivotForm.maximum(minx,maxx,miny,maxy);
end;

function irrec.reeds(n:integer;nr:nnode; var nom:integer):boolean;
var j:integer;
    pt : nnode;
    xx,yy : double;
begin
   result:=false;
   nom:=0;
   xx:=nr.marc.cenx;
   yy:=nr.marc.ceny;
   for j:=1 to nonode[blok] do
   begin
      pt:=pin(blok,j);
      with pt.marc do
      begin
         if (n<>j) and (potago(cenx,ceny,xx,yy)<0.1) then
         begin
            nom:=j;
            result:=true;
            exit;
         end;
      end;
   end;
end;

function irrec.getnaasteall1(var l6: double) : boolean;
var bb,j,n,p : integer;
    np:nnode;
    doen,nnn,ppp,piv : boolean;
    b1,b2,n1,n2 : integer;
    lati,mani,maini,mani2 : integer;
    nod1,nod2,nod3,nod4,nod5,nod6 : boolean;

    function getnaastepypnode : boolean;
    var jj,ss  : integer;
        pp : npipe;
        np2 : nnode;
        doen,doen2 : boolean;
    begin
       n:=0;
       for jj:=1 to pirr[Ipro].nopipe[blok] do
       begin
          pp:=pirr[Ipro].pin(blok,jj);
          np2:=pin(blok,pp.p1);
          ss:=pp.gebruik;
          doen:=//lati and mani and mani2 and maini or
                ((lati>0) and (ss=1)) or
                ((mani>0) and (ss=2)) or
                ((mani2>0) and (ss=4)) or
                ((maini>0) and (ss=3));
          case np2.soort of
          1 : doen2:=nod1;
          2 : doen2:=nod2;
          3 : doen2:=nod3;
          4 : doen2:=nod4;
          5 : doen2:=nod5;
          6 : doen2:=nod6;
          end;

          doen:=doen and ppp and (blok>=b1) and (blok<=b2);

          doen2:=true;
          //doen2:=doen2 and nnn and (blok>=n1) and (blok<=n2);
          //  10/2010   uitgehaal sodat na pype kan spring al is nodes af.

          if Iprom.iUserN and (np2.Unumber='') then doen2:=false;
          if doen and doen2 then
          begin
             afst:=potago(kursor.xp,kursor.yp,np2.marc.cenx,np2.marc.ceny);
             if afst<neardist then
             begin
                neardist:=afst;
                n:=pp.p1;
             end;
          end;
          np2:=pin(blok,pp.p2);
          case np2.soort of
          1 : doen2:=nod1;
          2 : doen2:=nod2;
          3 : doen2:=nod3;
          4 : doen2:=nod4;
          5 : doen2:=nod5;
          6 : doen2:=nod6;
          end;

          doen2:=true;
          //doen2:=doen2 and nnn and (blok>=n1) and (blok<=n2);
          //10/2010 uitghaal

          if Iprom.iUserN and (np2.Unumber='') then doen2:=false;
          if doen and doen2 then
          begin
             afst:=potago(kursor.xp,kursor.yp,np2.marc.cenx,np2.marc.ceny);
             if afst<neardist then
             begin
                neardist:=afst;
                n:=pp.p2;
             end;
          end;
       end;
       result:=false;
       if n<>0 then
       begin
          result:=true;
          np:=pin(blok,n);
       end;
    end;

    function getnaasteNnode : boolean;
    var jj,ss  : integer;
        pp : npipe;
        np2 : nnode;
        doen,doen2 : boolean;
    begin
       n:=0;
       result:=false;
       if Iprom.iblock and (blok<>bb) then exit;

       for jj:=1 to nonode[blok] do
       begin
          np2:=pin(blok,jj);
          doen2:=false;
          case np2.soort of
          1 : doen2:=nod1;
          2 : doen2:=nod2;
          3 : doen2:=nod3;
          4 : doen2:=nod4;
          5 : doen2:=nod5;
          6 : doen2:=nod6;
          end;
          doen2:=doen2 and nnn and (blok>=n1) and (blok<=n2);
          if Iprom.iUserN and (np2.Unumber='') then doen2:=false;
          if doen2 then
          begin
             afst:=potago(kursor.xp,kursor.yp,np2.marc.cenx,np2.marc.ceny);
             if afst<neardist then
             begin
                neardist:=afst;
                n:=jj;
             end;
          end;
       end;

       if n<>0 then
       begin
          result:=true;
          np:=pin(blok,n);
       end;
    end;
begin
   bb:=blok;
   result:=false;
   nnn:=waarde.readbool('Irrig','Dispnodes',false);
   ppp:=waarde.readbool('Irrig','Disppipes',false);
   piv:=waarde.readbool('Irrig','Disppivots',true);

   if not nnn and not ppp and not piv then exit;


   neardist:=1e9;
   if piv and pivotForm.naastePivot(neardist) and (neardist<l6) then
   begin
      result:=true;
      nirx:=marc.cenx;
      niry:=marc.ceny;
      cadpunt.cadx:=nirx;
      cadpunt.cady:=niry;
      l6:=neardist;
   end;

   if not getjumpinfo(b1,b2,n1,n2,lati,mani,mani2,maini,nod1,nod2,nod3,nod4,nod5,nod6) then exit;

   for j:=0 to blk[Ipro].noblok do
   begin
      blok:=j;
      if getnaastepypnode and (neardist<l6) then
      begin
         result:=true;
         l6:=neardist;
         nirx:=np.marc.cenx;
         niry:=np.marc.ceny;
         cadpunt.cadx:=nirx;
         cadpunt.cady:=niry;
      end;



      if getnaasteNnode and (neardist<l6) then
      begin
         result:=true;
         l6:=neardist;
         nirx:=np.marc.cenx;
         niry:=np.marc.ceny;
         cadpunt.cadx:=nirx;
         cadpunt.cady:=niry;
      end;
   end;
   blok:=bb;
end;

function irrec.getnaastenode(var n : integer; var np:nnode; jmp:boolean):boolean;
var j  : integer;
    doen2 : boolean;
    b1,b2,n1,n2 : integer;
    lati,mani,maini,mani2 : integer;
    nod1,nod2,nod3,nod4,nod5,nod6 : boolean;
begin
   neardist:=1e9;

   result:=false;

   if not getjumpinfo(b1,b2,n1,n2,lati,mani,mani2,maini,nod1,nod2,nod3,nod4,nod5,nod6) then exit;
   n:=0;
   for j:=1 to nonode[blok] do
   begin
      np:=pin(blok,j);
      afst:=potago(kursor.xp,kursor.yp,np.marc.cenx,np.marc.ceny);
      case np.soort of
      1 : doen2:=nod1;
      2 : doen2:=nod2;
      3 : doen2:=nod3;
      4 : begin
             doen2:=nod4;
             if Iprom.hideredundent and (np.series='Dummy') then doen2:=false;
          end;
      5 : doen2:=nod5;
      6 : doen2:=nod6;
      end;
      if doen2 and (afst<neardist) then
      begin
         neardist:=afst;
         n:=j;
      end;
   end;
   result:=false;

   if n<>0 then
   begin
      result:=true;
      np:=pin(blok,n);
      if jmp then with np.marc do
         setecho(cenx,ceny,true);

      with np.marc do
      with cadpunt do
      begin
         layer:=1;
         cadx:=cenX;
         cady:=cenY;
         cadz:=cenz;
         general.pointz:=cenz;
         general.pointcode:=np.Unumber;
      end;

   end;
end;

function irrec.GetNaasteNodePipe(var nommer,wie,kant,Pend : integer) : boolean;
//wie  1=node 2=pipe(p1) gekry
//kant 1=pipe p1, 2=pipe p2
var n : integer;
   np,np2:nnode;
   l6,xx,yy : double;
   p  : integer;
   Pp : npipe;
begin
   l6:=1e9;
   result:=false;
   if getnaastenode(n,np,false) then
   begin
      l6:=NearDist;
      Nommer:=n;
      wie:=1;
      result:=true;
   end;

   //l6:=1e6;

   if pirr[Ipro].getnaastepipe(n,p,Pp,false) then
   begin
      Np:=nirr[Ipro].pin(blok,Pp.p1);
      Np2:=nirr[Ipro].pin(blok,Pp.p2);

      p:=1;
      if potago(Np2.marc.cenx,Np2.marc.ceny,kursor.xp,kursor.yp)<
         potago(Np.marc.cenx,Np.marc.ceny,kursor.xp,kursor.yp) then p:=2;


      vrb(Np.marc.cenx,Np.marc.ceny,Np2.marc.cenx,Np2.marc.ceny,afst,rigt);

      pol(Np.marc.cenx,Np.marc.ceny,afst*0.5,rigt,xx,yy);  //pend=2 net middel
      if Pend=1 then
         if p=1 then
            pol(Np.marc.cenx,Np.marc.ceny,afst*0.2,rigt,xx,yy)
         else
            pol(Np.marc.cenx,Np.marc.ceny,afst*0.8,rigt,xx,yy);

      if potago(kursor.xp,kursor.yp,xx,yy)<L6 then
      begin
         cadpunt.cadx:=xx;
         cadpunt.cady:=yy;
         wie:=2;
         nommer:=N;
         kant:=p;
         result:=true;
      end;
   end;
end;


procedure irrec.getave_flowpress(node1:integer; var flow3,press3:double);
var j,n,i:integer;
    pt : nnode;
    ok : boolean;
begin

   flow3:=0;
   press3:=0;
   n:=0;
   for j:=node1 to nonode[blok] do
   begin
      pt:=pin(blok,j);
      with pt do
      begin
         if soort=2 then             {spray}
         begin
            ok:=true;
            if blok=0 then ok:=demand;   //check nodes down valves   9/2001
            if ok then
            begin
               inc(n);
               flow3:=flow3+outflowdes;
               press3:=press3+pressdes;
            end;
         end;
         if (soort=3) and (demand) and (blok=0) and (outflowdes<>0) then  {valve and demand requested}
         begin
            inc(n);
            flow3:=flow3+outflowdes;
            press3:=press3+pressdes;
         end;
         for i:=1 to pipes do
            if pkop[i].pnom<=pirr[Ipro].nopipe[blok] then
               flow3:=flow3+getsdrflow(pirr[Ipro].pipe[blok,pkop[i].pnom],false,false);
      end;
   end;
   if n>1 then
   begin
      flow3:=flow3;
      press3:=press3/n;
   end;
end;

procedure irrec.updateshapes;
begin
   with waarde do
   with Iprom do
   begin
      pumpn:=readstring('Irrig','Pumpshp','ENGINE');
      fittn:=readstring('Irrig','Fittingshp','FTT');
      valven:=readstring('Irrig','Valveshp','HVALVE');
      springn:=readstring('Irrig','Sprinklershp','MINIWOB');
      othern:=readstring('Irrig','Othershp','OTHER');
      boostern:=readstring('Irrig','Boostershp','BOOSTER');

      pumps:=readreal('Irrig','Pumpscl',10);
      fitts:=readreal('Irrig','Fittingscl',1);
      valves:=readreal('Irrig','Valvescl',10);
      springs:=readreal('Irrig','Sprinklerscl',4);
      others:=readreal('Irrig','Otherscl',2);
      boosters:=readreal('Irrig','Boosterscl',2);

      gloScale:=readreal('Irrig','Nfactor',1);
      if gloscale<=0 then gloscale:=1;

      penwidth1:=waarde.readint('Irrig','Defpwidth',3);
      penwidth2:=waarde.readint('Irrig','Defpwidth2',2);
      penwidth3:=waarde.readint('Irrig','Defpwidth3',1);
      dowydte1:=waarde.readbool('Irrig','Uselwidth',true);

      PatSize:=readbool('Irrig','PatSize',false);

      Penwidthmm1:=readreal('Irrig','MainMM',0.5);
      Penwidthmm2:=readreal('Irrig','ManiMM',0.3);
      Penwidthmm3:=readreal('Irrig','LatMM',0.15);
      Dowydtemm1 :=readbool('Irrig','UseMMwidth',false);

      mainlt:=readint('Irrig','Main Ltype',0);
      if mainlt<0 then mainlt:=0;
      manlT:=readint('Irrig','Manifold Ltype',0);
      if manlt<0 then manlt:=0;
      Latlt:=readint('Irrig','Lat Ltype',0);
      if Latlt<0 then Latlt:=0;

      Hideredundent:=readbool('Irrig','Hideredundent',false);
   end;
end;


function irrec.fittype(j : integer; var d1,d2,d3,d4 : double;
                                    var t1,t2,t3,t4 : integer;
                                    var y1,y2,y3,od,err : boolean;
                                    ShowErr : boolean) : integer;
var  pt,pn : nnode;
     ll : array[1..4] of double;
     tt : array[1..4] of integer;
     p,n,i,pp : integer;
begin
   y1:=false;
   y2:=false;
   y3:=false;
   err:=false;
   od:=true;
   result:=0;
   for p:=1 to 4 do
   begin
      ll[p]:=1e5;
      tt[p]:=0;
   end;
   // {1=pump 2=sprink 3=valve 4=fittin 5=other}
   // 0=none 40=other 41=endstop 42=reducer 43=tpiece 44=crosspiece
   n:=0;
   with node[blok,j] do
   begin
      for p:=1 to pirr[Ipro].nopipe[blok] do
         with pirr[Ipro].pipe[blok,p] do
            if (p1=j) or (p2=j) then
            begin
               inc(n);
               ll[n]:=head.od; //head.diam;
               if ll[n]=0 then
               begin
                  ll[n]:=head.diam;
                  od:=false;
               end;

               tt[n]:=gebruik;
               if gebruik=1 then y1:=true;
               if gebruik=2 then y2:=true;
               if gebruik=3 then y3:=true;
            end;

      if (blok>0) and (soort=3) then   //possible valve to main line
      begin
         for pp:=1 to nirr[Ipro].nonode[0] do
         begin
            pn:=nirr[Ipro].node[0,pp];
            if (pn.soort=3) and (pn.nblok=blok) then     //add mainline pipes
            begin
               for p:=1 to pirr[Ipro].nopipe[0] do
               with pirr[Ipro].pipe[0,p] do
                  if (p1=pp) or (p2=pp)  then
                  if (n<4) then
                  begin
                     inc(n);
                     ll[n]:=head.od;      //head.diam;
                     tt[n]:=gebruik;
                     if gebruik=1 then y1:=true;
                     if gebruik=2 then y2:=true;
                     if gebruik=3 then y3:=true;
                  end
                  else
                  begin
                     if ShowErr then
                     _gmenu.warning('Error. Block('+inttostr(blok)+')  Node # '+inttostr(pp)+' has more than 4 pipes connected.','','',1);
                     exit;
                  end;
            end;
         end;
      end;
   end;
   if n>0 then result:=40+n;

   for n:=1 to 4 do
      for p:=n+1 to 4 do
         if ll[n]>ll[p] then
         begin
            swapxy(ll[n],ll[p],1);
            i:=tt[n]; tt[n]:=tt[p]; tt[p]:=i;
         end;
   for p:=1 to 4 do if ll[p]=1e5 then ll[p]:=0;
   d1:=ll[1]; d2:=ll[2]; d3:=ll[3]; d4:=ll[4];
   t1:=tt[1]; t2:=tt[2]; t3:=tt[3]; t4:=tt[4];
end;

end.
