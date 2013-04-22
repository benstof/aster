unit TestUnt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    Memo1: TMemo;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    Edit5: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Edit6: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses form2unt;

{$R *.dfm}




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


     function getflow(p,k,x : double) : double;
    begin
       //p:=2;
       p:=p/10;  //meter to bar
       result:=k*mag(p,x);  ///60/60;                //l/s
    end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var pres,flow,leng,spas,coef,emit,diam,slope,fric,slop,step,min,max,f1 : double;
begin
   leng:=strtor(edit6.Text);

   Spas:=strtor(edit5.text)/100;   //m
   Coef:=strtor(edit2.Text);
   Emit:=strtor(edit1.Text);
   diam:=strtor(edit3.text);
   slope:=strtor(edit4.Text);

   flow:=0;//emit;   //leng/spas*emit*0.95;
   pres:=1*10;
   step:=0;
   memo1.Clear;

   min:=1000;
   max:=-min;

   while step<Leng do
   begin
      //step:=step+spas;
      flow:=flow+getflow(pres,emit,coef);

      f1:=getflow(pres,emit,coef);
      if f1<min then min:=f1;
      if f1>max then max:=f1;

      fric:=hazen(spas,flow/3600,diam,145,1);
      slop:=slope/100*spas;
      memo1.lines.add(r_s(step,10,2)+r_s(fric,10,6)+r_s(slop,10,4)+r_s(pres-fric+slop,10,3));
      pres:=pres-fric+slop;


      memo1.lines.add('                                                                      '+rtostr(flow,10,2)+r_s(getflow(pres,emit,coef),10,4)+r_s((max-min)/(max/2+min/2)*100,10,3));

      step:=step+spas;
   end;



end;

end.
