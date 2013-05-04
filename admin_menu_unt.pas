unit admin_menu_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
    pipe_mng_unt, emitter_mng_unt, admin_unt,pressures_mng_unt, drip_line_mng_unt, taal_unt;


type
  Tadmin_menu = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


var
  admin_menu: Tadmin_menu;
amt : integer;

implementation

uses login_unt;

{$R *.dfm}

procedure Tadmin_menu.Button1Click(Sender: TObject);
begin
            AssignFile(emitters_file, 'pressures.ems');
            FileMode := fmOpenRead;
            Reset(emitters_file,1);
            BlockRead(emitters_file, settings, sizeof(TSettings), amt);
            CloseFile(emitters_file);


               pressures_mng.show;
               self.Hide;
               exit;

end;

procedure Tadmin_menu.Button2Click(Sender: TObject);
begin
            AssignFile(emitters_file, 'emitters.ems');
            FileMode := fmOpenRead;
            Reset(emitters_file,1);
            BlockRead(emitters_file, settings, sizeof(TSettings), amt);
            CloseFile(emitters_file);


               emitter_mng.show;
               self.Hide;
               exit;

end;

procedure Tadmin_menu.Button3Click(Sender: TObject);
begin
            AssignFile(pipes_file, 'pipes.ems');
            FileMode := fmOpenRead;
            Reset(pipes_file,1);
            BlockRead(pipes_file, settings, sizeof(TSettings), amt);
            CloseFile(pipes_file);


               pipe_mng.show;
               self.Hide;
               exit;

end;

procedure Tadmin_menu.Button4Click(Sender: TObject);
begin
            AssignFile(driplines_file, 'driplines.ems');
            FileMode := fmOpenRead;
            Reset(driplines_file,1);
            BlockRead(driplines_file, settings, sizeof(TSettings), amt);
            CloseFile(driplines_file);


               drip_line_mng.show;
               self.Hide;
               exit;

end;

end.
