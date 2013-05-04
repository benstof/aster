unit pressures_mng_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Form2unt, Vcl.ExtCtrls,
  Vcl.Menus, drip_line_mng_unt, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, taal_unt;

type
  Tpressures_mng = class(TForm)
    pressure_lb: TListBox;
    btn_save: TButton;
    btn_new: TButton;
    btn_delete: TButton;
    _name: TEdit;
    Label1: TLabel;
    Label4: TLabel;
    _max: TEdit;
    max_bar_lbl: TLabel;
    procedure btn_saveClick(Sender: TObject);
    procedure load_pressures;
    procedure btn_newClick(Sender: TObject);
    procedure clear_form;
    procedure btn_deleteClick(Sender: TObject);
    procedure pressure_lbClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure redo_labels;
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
   pressure : TPressure;
   current_pressure : TPressure;
   settings : TSettings;

implementation

{$R *.dfm}

uses main_unt;

procedure Tpressures_mng.clear_form;
begin
   _name.Text := '';
   _max.Text := '0.0';
end;

procedure Tpressures_mng.redo_labels;
begin

   max_bar_lbl.caption:=main_unt.units.press;
   //min_bar_lbl.caption:=units.press;
   //drippipeU.Caption:=main_unt.units.diam;
   //flow_constant_unt_lbl.Caption:=units.press;

end;

procedure Tpressures_mng.FormActivate(Sender: TObject);
var j : integer;
begin


    {$IOChecks off}

         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);


   //AssignFile(pipes_file, 'pipes.ems');
   if not fileexists('pressures.ems') then
   begin
      ReWrite(pressures_file);
      CloseFile(pressures_file);
   end;

   load_pressures;
   redo_labels;

   // Load first pipe if there are some
   if pressure_lb.Count > 0 then
   begin
      pressure_lb.ItemIndex := 0;
      pressure_lbClick(sender);
   end
   else
   begin
      btn_newClick(sender);
   end;

end;

procedure Tpressures_mng.btn_deleteClick(Sender: TObject);
var pid, index, amt : integer;
begin

if pressure_lb.count > 0 then
begin

    {$IOChecks off}

   index := pressure_lb.ItemIndex;
   if index = -1 then index := pressure_lb.Count - 1;

   pid := Integer(pressure_lb.Items.Objects[pressure_lb.Items.IndexOf(pressure_lb.Items[index])]);
   //drip_line_mng.delete_from(pid, 2);

   AssignFile(pressures_file, 'pressures.ems');
   AssignFile(temp_pressures_file, 'temp_pressures.ems');
   ReWrite(temp_pressures_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(pressures_file,1);
   Reset(temp_pressures_file,1);

   BlockRead(pressures_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_pressures_file, settings, sizeof(TSettings));

      // Display the file contents
      while not Eof(pressures_file) do
      begin
        BlockRead(pressures_file, pressure, sizeof(TPressure), amt);
        if pid <> pressure.id then
           BlockWrite(temp_pressures_file, pressure, sizeof(pressure));
      end;

   // Close the file for the last time
   CloseFile(pressures_file);
   CloseFile(temp_pressures_file);

  DeleteFile('pressures.ems');
  Rename(temp_pressures_file, 'pressures.ems');
  DeleteFile('temp_pressures.ems');

  load_pressures;

  if pressure_lb.count > 0 then
  begin
    pressure_lb.Selected[pressure_lb.count - 1] := true;
    pressure_lbClick(sender);
  end;

  drip_line_mng.delete_from(pid, 3);

end;

end;

procedure Tpressures_mng.btn_newClick(Sender: TObject);
begin

   pressure_lb.ItemIndex := -1;
   clear_form;

end;

procedure Tpressures_mng.btn_saveClick(Sender: TObject);
var name : string;
index, x, pid, amt : integer;
exp : double;
begin

   pressure.name := '';
   pressure.max_press := '0';

   AssignFile(pressures_file, 'pressures.ems');
   FileMode := fmOpenReadWrite;
   pid := 0;
   Reset(pressures_file,1);
   BlockRead(pressures_file, settings, sizeof(TSettings), amt);

   {New}
   if pressure_lb.ItemIndex = -1 then
   begin

   // Get next id

   while not Eof(pressures_file) do
   begin
      BlockRead(pressures_file, pressure, sizeof(TPressure), amt);
      if pressure.id > pid then
         pid := pressure.id;
   end;

      pressure.id := pid+1;
      pressure.name := _name.Text;
      seek(pressures_file,filesize(pressures_file));

      BlockWrite(pressures_file, pressure, sizeof(pressure));
      CloseFile(pressures_file);
      load_pressures;
      pressure_lb.Selected[pressure_lb.count - 1] := true;
      index := pressure_lb.count - 1;
      //exit;
   end;


   pid := Integer(pressure_lb.Items.Objects[pressure_lb.Items.IndexOf(pressure_lb.Items[pressure_lb.ItemIndex])]);

   AssignFile(temp_pressures_file, 'temp_pressures.ems');
   ReWrite(temp_pressures_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(pressures_file,1);
   Reset(temp_pressures_file,1);

   BlockRead(pressures_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_pressures_file, settings, sizeof(TSettings));

   {Update}
      // Display the file contents
      while not Eof(pressures_file) do
      begin
        BlockRead(pressures_file, pressure, sizeof(TPressure), amt);
        if pid = pressure.id then
        begin
           pressure.name := _name.Text;
           pressure.max_press := rtostr(main_unt.units.press_si(strtor(_max.Text)), 10,2);
           BlockWrite(temp_pressures_file, pressure, sizeof(pressure));
        end
        else
        begin
           BlockWrite(temp_pressures_file, pressure, sizeof(pressure));
        end;
      end;

   // Close the file for the last time
   CloseFile(pressures_file);
   CloseFile(temp_pressures_file);

  DeleteFile('pressures.ems');
  Rename(temp_pressures_file, 'pressures.ems');

  index := pressure_lb.itemindex;
  load_pressures;
  pressure_lb.Selected[index] := true;


end;

procedure Tpressures_mng.load_pressures;
var amt : integer;
begin
   pressure_lb.Clear;
   AssignFile(pressures_file, 'pressures.ems');
   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pressures_file,1);
   BlockRead(pressures_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pressures_file) do
   begin
     BlockRead(pressures_file, pressure, sizeof(TPressure), amt);
     pressure_lb.Items.AddObject(pressure.name,  TObject(pressure.id));
   end;
   // Close the file for the last time
   CloseFile(pressures_file);
end;

procedure Tpressures_mng.pressure_lbClick(Sender: TObject);
var index, pid, x, amt : integer;
   pname : string;
begin

   index := pressure_lb.ItemIndex;
   if index = -1 then index := pressure_lb.Count - 1;

   pressure_lb.Selected[index] := true;

   clear_form;

   pid := Integer(pressure_lb.Items.Objects[pressure_lb.Items.IndexOf(pressure_lb.Items[index])]);
   AssignFile(pressures_file, 'pressures.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pressures_file,1);
   BlockRead(pressures_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pressures_file) do
   begin
     BlockRead(pressures_file, pressure, sizeof(Tpressure), amt);
     if pid = pressure.id then
     begin
        current_pressure := pressure;
        _name.Text := pressure.name;
        _max.Text := rtostr(main_unt.units.si_press(strtor(pressure.max_press)),10,2);
     end;
   end;

   // Close the file for the last time
   CloseFile(pressures_file);

end;

end.
