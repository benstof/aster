program TestPro;

uses
  Forms,
  TestUnt in 'TestUnt.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
