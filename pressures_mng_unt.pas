unit pressures_mng_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  Tpressures_mng = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pressures_mng: Tpressures_mng;

 type
   TPressure = Record
     id : integer;
     name : string[100];
     max_press : string[20];
   end;

 type
   TSettings = Record
     password : string[20];
   end;

 var
   pressures_file      : File;
   temp_pressures_file : File;
   press : TPressure;
   current_pipe : TPressure;
   settings : TSettings;

implementation

{$R *.dfm}

end.
