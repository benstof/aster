unit emitter_mng_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Form2unt, Vcl.ExtCtrls,
  Vcl.Menus, drip_line_mng_unt, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB,Vcl.DBCtrls, taal_unt;

type
  Temitter_mng = class(TForm)
    btn_save: TButton;
    emitter_lb: TListBox;
    em_name: TEdit;
    em_cv: TEdit;
    em_kd: TEdit;
    em_max_press: TEdit;
    em_min_press: TEdit;
    em_constant: TEdit;
    em_correction: TEdit;
    btn_delete: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    btn_new: TButton;
    em_compensate: TRadioGroup;
    press_reg_cb: TComboBox;
    Label26: TLabel;
    normal_reg_cb: TComboBox;
    em_hw: TComboBox;
    max_bar_lbl: TLabel;
    min_bar_lbl: TLabel;
    em_ex: TEdit;
    em_coef_limits_lb: TLabel;
    procedure btn_saveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure emitter_lbClick(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_newClick(Sender: TObject);
    procedure clear_form;
    procedure load_emitters;
    procedure em_compensateClick(Sender: TObject);
    procedure redo_labels;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  emitter_mng: Temitter_mng;

 type
   TEmitter = Record
     id : integer;
     name : string[100];
     cv   : string[20];
     kd   : string[20];
     max_press : string[20];
     min_press: string[20];
     constant : string[20];
     correction : string[20];
     hw : integer;
     pipe_diam : string[20];
     compensated : integer;
     exponent : string[20];


   end;

 type
   TSettings = Record
     password : string[20];
   end;

 var
   emitters_file      : File;
   temp_emitters_file : File;
   emitter : TEmitter;
   current_emitter : TEmitter;
   settings : TSettings;

implementation

uses main_unt;

{$R *.dfm}
{$I-}

procedure Temitter_mng.clear_form;
begin
   em_name.Text := '';
   em_cv.Text := '0.0';
   em_kd.Text := '0.0';
   em_max_press.text := '0.0';
   em_min_press.text := '0.0';
   em_constant.text := '0.0';
   em_correction.text := '0.0';
   em_hw.ItemIndex := 9;
   //em_pipe_diam.text := '0.0';

   em_compensate.itemindex := 0;
   normal_reg_cb.ItemIndex := 0;
   press_reg_cb.ItemIndex := 0;
   press_reg_cb.Visible := false;

end;

procedure Temitter_mng.btn_newClick(Sender: TObject);
begin

   emitter_lb.ItemIndex := -1;
   clear_form;

end;

procedure Temitter_mng.redo_labels;
begin

   max_bar_lbl.caption:=units.press;
   min_bar_lbl.caption:=units.press;
   //drippipeU.Caption:=irricalc.units.diam;
   //flow_constant_unt_lbl.Caption:=units.press;

end;

procedure Temitter_mng.btn_saveClick(Sender: TObject);
var name : string;
index, eid, amt : integer;
exp : double;
begin

   exp := strtor(em_ex.Text);
   index := em_compensate.ItemIndex;

   if index = 1 then
   begin
      if (exp < 0) or (exp > 0.2) then
      begin
         ShowMessage('Note. A Regular compensated emitter exponent is between "0" and "0.2"');
         exit;
      end;
   end
   else
   begin
      if (exp < 0.149) or (exp > 1) then
      begin
         ShowMessage('Note. A Pressure compensated emitter exponent is between "0.15" and "1"');
         exit;
      end;
   end;

   emitter.name := '';
   emitter.cv := '0';
   emitter.kd := '0';
   emitter.max_press := '0';
   emitter.min_press := '0';
   emitter.constant := '0';
   emitter.correction := '0';
   emitter.hw := 0;
   emitter.pipe_diam := '0';
   emitter.compensated := 0;
   emitter.exponent := '0';

     // Get next id
   AssignFile(emitters_file, 'emitters.ems');
   FileMode := fmOpenReadWrite;
   eid := 0;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   {New}
   if emitter_lb.ItemIndex = -1 then
   begin

   while not Eof(emitters_file) do
   begin
      BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
      if emitter.id > eid then
         eid := emitter.id;
   end;

      Reset(emitters_file,1);
      seek(emitters_file,filesize(emitters_file));
      emitter.name := em_name.Text;

      emitter.id := eid + 1;
      //Write(emitters_file, emitter);
      BlockWrite(emitters_file, emitter, sizeof(emitter));
      CloseFile(emitters_file);
      load_emitters;
      emitter_lb.Selected[emitter_lb.count - 1] := true;
      index := emitter_lb.count - 1;
      //exit;
   end;

   eid := Integer(emitter_lb.Items.Objects[emitter_lb.Items.IndexOf(emitter_lb.Items[emitter_lb.ItemIndex])]);
   AssignFile(temp_emitters_file, 'temp_emitters.ems');
   ReWrite(temp_emitters_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(emitters_file,1);
   Reset(temp_emitters_file,1);

   BlockRead(emitters_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_emitters_file, settings, sizeof(TSettings));


      {Update}
      while not Eof(emitters_file) do
      begin
        //Read(emitters_file, emitter);
        BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
        if eid = emitter.id then
        begin
           emitter.name := em_name.Text;

           emitter.cv := em_cv.Text;
           emitter.kd := em_kd.Text;
           emitter.max_press := rtostr(main_unt.units.press_si(strtor(em_max_press.Text)),10,2);
           emitter.min_press := rtostr(main_unt.units.press_si(strtor(em_min_press.Text)),10,2);
           emitter.constant := rtostr(main_unt.units.press_si(strtor(em_constant.Text)),10,2);
           emitter.correction := em_correction.Text;
           emitter.hw := em_hw.ItemIndex;
           emitter.compensated := em_compensate.ItemIndex;
           emitter.exponent := em_ex.text;

           //Write(temp_emitters_file, emitter);
           BlockWrite(temp_emitters_file, emitter, sizeof(emitter));
        end
        else
        begin
           //Write(temp_emitters_file, emitter);
           BlockWrite(temp_emitters_file, emitter, sizeof(emitter));
        end;
      end;

   // Close the file for the last time
   CloseFile(emitters_file);
   CloseFile(temp_emitters_file);

  DeleteFile('emitters.ems');
  Rename(temp_emitters_file, 'emitters.ems');
  DeleteFile('temp_emitters.ems');

  index := emitter_lb.itemindex;
  load_emitters;
  emitter_lb.Selected[index] := true;

end;

procedure Temitter_mng.Button1Click(Sender: TObject);
begin
   drip_line_mng.Show;
end;

procedure Temitter_mng.btn_deleteClick(Sender: TObject);
var eid, index, amt : integer;
begin

if emitter_lb.count > 0 then
begin

    {$IOChecks off}
   index := emitter_lb.ItemIndex;
   if index = -1 then index := emitter_lb.Count - 1;

   eid := Integer(emitter_lb.Items.Objects[emitter_lb.Items.IndexOf(emitter_lb.Items[index])]);

   //ename := emitter_lb.Items[emitter_lb.ItemIndex];
   AssignFile(emitters_file, 'emitters.ems');
   AssignFile(temp_emitters_file, 'temp_emitters.ems');
   ReWrite(temp_emitters_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(emitters_file,1);
   Reset(temp_emitters_file,1);

   BlockRead(emitters_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_emitters_file, settings, sizeof(TSettings));

      // Display the file contents
      while not Eof(emitters_file) do
      begin
        //Read(emitters_file, emitter);
        BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
        if eid <> emitter.id then
           //Write(temp_emitters_file, emitter);
           BlockWrite(temp_emitters_file, emitter, sizeof(emitter));
      end;

   // Close the file for the last time
   CloseFile(emitters_file);
   CloseFile(temp_emitters_file);

  DeleteFile('emitters.ems');

  RenameFile('temp_emitters.ems', 'emitters.ems');

  load_emitters;

  if emitter_lb.count > 0 then
  begin
     emitter_lb.Selected[emitter_lb.count - 1] := true;
     emitter_lbClick(sender);
  end;

  drip_line_mng.delete_from(eid, 1);

end;

end;


procedure Temitter_mng.emitter_lbClick(Sender: TObject);
var index, eid, amt : integer;
begin

   index := emitter_lb.ItemIndex;
   if index = -1 then index := emitter_lb.Count - 1;

   emitter_lb.Selected[index] := true;
   clear_form;

   eid := Integer(emitter_lb.Items.Objects[emitter_lb.Items.IndexOf(emitter_lb.Items[index])]);
   AssignFile(emitters_file, 'emitters.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(emitters_file) do
   begin
     //Read(emitters_file, emitter);
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     if eid = emitter.id then
     begin
     em_name.Text := emitter.name;
     em_cv.Text := emitter.cv;
     em_kd.Text := emitter.kd;
     em_correction.text := emitter.correction;
     em_hw.ItemIndex := emitter.hw;
     em_max_press.text := rtostr(main_unt.units.si_press(strtor(emitter.max_press)),10,2);
     em_min_press.text := rtostr(main_unt.units.si_press(strtor(emitter.min_press)),10,2);
     em_constant.text := rtostr(main_unt.units.si_press(strtor(emitter.constant)),10,2);
     em_compensate.itemindex := emitter.compensated;
     em_ex.Text := emitter.exponent;
     end;
   end;
   // Close the file for the last time
   CloseFile(emitters_file);

end;

procedure Temitter_mng.em_compensateClick(Sender: TObject);
var index : integer;
begin
   index := em_compensate.ItemIndex;
   normal_reg_cb.top := 318;

   em_ex.Text := '0';
   if index = 1 then
   begin
       em_coef_limits_lb.Caption := 'Between 0 and 0.2';
   end
   else
   begin
       em_coef_limits_lb.Caption := 'Between 0.15 and 1';
   end;
end;

procedure Temitter_mng.load_emitters;
var amt : integer;
begin
   emitter_lb.Clear;
   AssignFile(emitters_file, 'emitters.ems');
   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(emitters_file) do
   begin
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     emitter_lb.Items.AddObject(emitter.name,  TObject(emitter.id));
   end;

   // Close the file for the last time
   CloseFile(emitters_file);
end;

procedure Temitter_mng.FormActivate(Sender: TObject);
var j : integer;
begin

         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);


   {$IOChecks off}

   //AssignFile(emitters_file, 'emitters.ems');
   if not fileexists('emitters.ems') then
   begin
      ReWrite(emitters_file);
      CloseFile(emitters_file);
   end;

   load_emitters;
   redo_labels;

   // Load first Emitter if there are some
   if emitter_lb.Count > 0 then
   begin
      emitter_lb.ItemIndex := 0;
      emitter_lbClick(sender);
   end
   else
   begin
      btn_newClick(sender);
   end;

end;

procedure Temitter_mng.FormCreate(Sender: TObject);
var s : string;
j : integer;
begin


end;

end.
