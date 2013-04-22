unit pgen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    company_password_input: TEdit;
    login_panel: TPanel;
    btn: TButton;
    input_password: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure btnClick(Sender: TObject);
    procedure company_password_inputClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

   type
   TSettings = Record
     password : string[20];
   end;

   var
   emitters_file : File;
   pipes_file : File;
   driplines_file : File;
   settings : TSettings;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var amt : integer;

begin

      settings.password := company_password_input.Text;

      AssignFile(emitters_file, 'emitters.ems');
      FileMode := fmOpenReadWrite;

      if not fileexists('emitters.ems') then
        Rewrite(emitters_file);

         Reset(emitters_file, 1);
         BlockWrite(emitters_file, settings, sizeof(settings));
         CloseFile(emitters_file);


      AssignFile(pipes_file, 'pipes.ems');
      FileMode := fmOpenReadWrite;

      if not fileexists('pipes.ems') then
         Rewrite(pipes_file);

         Reset(pipes_file, 1);
         BlockWrite(pipes_file, settings, sizeof(settings));
         CloseFile(pipes_file);


      AssignFile(driplines_file, 'driplines.ems');
      FileMode := fmOpenReadWrite;

      if not fileexists('driplines.ems') then
      Rewrite(driplines_file);

         Reset(driplines_file, 1);
         BlockWrite(driplines_file, settings, sizeof(settings));
         CloseFile(driplines_file);

      ShowMessage('Password Generated');
      company_password_input.Text := 'Enter a password for this company.';

end;

procedure TForm1.company_password_inputClick(Sender: TObject);
begin
   company_password_input.Text := '';
end;

procedure TForm1.btnClick(Sender: TObject);
begin


      if input_password.Text = 'aster_2013' then
      begin
         login_panel.Visible := false;
         exit;
      end;


end;

end.
