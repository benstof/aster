program translator;

uses
  Vcl.Forms,
  translate_unt in 'translate_unt.pas' {Form1},
  taal_unt in '..\taal_unt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.