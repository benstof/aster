unit login_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  pipe_mng_unt, emitter_mng_unt, admin_unt,pressures_mng_unt, drip_line_mng_unt, taal_unt;

type
  Tlogin_form = class(TForm)
    input_password: TEdit;
    Label1: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    forwhat : integer;
    next : integer;
  end;

var
  login_form: Tlogin_form;
   emitters_file : File;
   pipes_file : File;
   driplines_file : File;

implementation

{$R *.dfm}


procedure Tlogin_form.BitBtn1Click(Sender: TObject);
var password : string;
amt : integer;

begin

   if forwhat = 0 then
   begin
      if input_password.Text = 'admin' then
      begin
         admin_form.Show;
         self.Hide;
         exit;
      end;
   end;

   if forwhat = 1 then
   begin

         if next = 0 then
         begin

            AssignFile(emitters_file, 'pressures.ems');
            FileMode := fmOpenRead;
            Reset(emitters_file,1);
            BlockRead(emitters_file, settings, sizeof(TSettings), amt);
            CloseFile(emitters_file);

            if (input_password.Text = settings.password) then
            begin
               pressures_mng.show;
               self.Hide;
               exit;
             end;

         end;

         if next = 1 then
         begin

            AssignFile(emitters_file, 'emitters.ems');
            FileMode := fmOpenRead;
            Reset(emitters_file,1);
            BlockRead(emitters_file, settings, sizeof(TSettings), amt);
            CloseFile(emitters_file);

            if (input_password.Text = settings.password) then
            begin
               emitter_mng.show;
               self.Hide;
               exit;
             end;

         end;


         if next = 2 then
         begin

            AssignFile(pipes_file, 'pipes.ems');
            FileMode := fmOpenRead;
            Reset(pipes_file,1);
            BlockRead(pipes_file, settings, sizeof(TSettings), amt);
            CloseFile(pipes_file);

            if (input_password.Text = settings.password) then
            begin
               pipe_mng.show;
               self.Hide;
               exit;
             end;

         end;


         if next = 3 then
         begin

            AssignFile(driplines_file, 'driplines.ems');
            FileMode := fmOpenRead;
            Reset(driplines_file,1);
            BlockRead(driplines_file, settings, sizeof(TSettings), amt);
            CloseFile(driplines_file);

            if (input_password.Text = settings.password) then
            begin
               drip_line_mng.show;
               self.Hide;
               exit;
            end;

         end;

   end;

end;

procedure Tlogin_form.FormActivate(Sender: TObject);
var j : integer;

begin
  input_password.Text := '';

           for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);

end;

end.
