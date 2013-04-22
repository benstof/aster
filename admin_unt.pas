unit admin_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IdGlobal, IdHash, IdHashMessageDigest,
  emitter_mng_unt,inifiles, Form2unt, taal_unt ;

type
  Tadmin_form = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    company_input: TEdit;
    company_password_input: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  admin_form: Tadmin_form;

 type
   TSettings = Record
     password : string[20];
   end;

 var
   emitters_file : File;
   pipes_file : File;
   driplines_file : File;
   settings : TSettings;
   emitters : TEmitter;


implementation

{$R *.dfm}

procedure Tadmin_form.Button1Click(Sender: TObject);
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


      self.Hide;
      exit;

end;

procedure Tadmin_form.FormActivate(Sender: TObject);
var j : integer;
begin

         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);

  company_input.Text := '';
  company_password_input.Text := '';

end;

procedure Tadmin_form.FormCreate(Sender: TObject);
var s : string;
j : integer;
begin





end;

end.
