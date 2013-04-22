unit pipe_mng_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Form2unt, Vcl.ExtCtrls,
  Vcl.Menus, drip_line_mng_unt, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, taal_unt;

type
  Tpipe_mng = class(TForm)
    pipe_lb: TListBox;
    Label1: TLabel;
    pipe_name: TEdit;
    Label4: TLabel;
    btn_save: TButton;
    btn_new: TButton;
    btn_delete: TButton;
    Label9: TLabel;
    pipe_diam: TEdit;
    drippipeU: TLabel;
    max_bar_lbl: TLabel;
    pipe_max_press: TEdit;
    procedure btn_saveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_deleteClick(Sender: TObject);
    procedure btn_newClick(Sender: TObject);
    procedure clear_form;
    procedure load_pipes;
    procedure redo_labels;
    procedure pipe_lbClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  pipe_mng: Tpipe_mng;

 type
   TPipe = Record
     id : integer;
     name : string[100];
     flow   : string[20];
     max_press : string[20];
     diam : string[20];
   end;

 type
   TSettings = Record
     password : string[20];
   end;

 var
   pipes_file      : File;
   temp_pipes_file : File;
   pipe : TPipe;
   current_pipe : TPipe;
   settings : TSettings;

implementation

uses irricalc, main_unt;

{$R *.dfm}
{$I-}

procedure Tpipe_mng.clear_form;
begin
   pipe_name.Text := '';
   pipe_max_press.Text := '0.0';
   pipe_diam.text := '0.0';
end;

procedure Tpipe_mng.DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
var pname : string;
begin

  if button = nbInsert then
  begin

     { while (pipes_db.active) and (not pipes_db.eof) do
      begin
         pname:=pipes_db.getfield('name');
         pipes_db.next;
      end;    }


  end;


  if   button = nbDelete then
  begin


  end;



end;

procedure Tpipe_mng.btn_newClick(Sender: TObject);
begin

   pipe_lb.ItemIndex := -1;
   clear_form;

end;

procedure Tpipe_mng.redo_labels;
begin

   max_bar_lbl.caption:=main_unt.units.press;
   //min_bar_lbl.caption:=units.press;
   drippipeU.Caption:=main_unt.units.diam;
   //flow_constant_unt_lbl.Caption:=units.press;

end;

procedure Tpipe_mng.btn_saveClick(Sender: TObject);
var name : string;
index, x, pid, amt : integer;
exp : double;
begin

   pipe.name := '';
   pipe.flow := '0';
   pipe.diam := '0';
   pipe.max_press := '0';

   AssignFile(pipes_file, 'pipes.ems');
   FileMode := fmOpenReadWrite;
   pid := 0;
   Reset(pipes_file,1);
   BlockRead(pipes_file, settings, sizeof(TSettings), amt);

   {New}
   if pipe_lb.ItemIndex = -1 then
   begin

   // Get next id

   while not Eof(pipes_file) do
   begin
      BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
      if pipe.id > pid then
         pid := pipe.id;
   end;

      pipe.id := pid+1;
      pipe.name := pipe_name.Text;
      seek(pipes_file,filesize(pipes_file));

      BlockWrite(pipes_file, pipe, sizeof(pipe));
      CloseFile(pipes_file);
      load_pipes;
      pipe_lb.Selected[pipe_lb.count - 1] := true;
      index := pipe_lb.count - 1;
      //exit;
   end;

   pid := Integer(pipe_lb.Items.Objects[pipe_lb.Items.IndexOf(pipe_lb.Items[pipe_lb.ItemIndex])]);

   AssignFile(temp_pipes_file, 'temp_pipes.ems');
   ReWrite(temp_pipes_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(pipes_file,1);
   Reset(temp_pipes_file,1);

   BlockRead(pipes_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_pipes_file, settings, sizeof(TSettings));

   {Update}
      // Display the file contents
      while not Eof(pipes_file) do
      begin
        BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
        if pid = pipe.id then
        begin
           pipe.name := pipe_name.Text;
           pipe.max_press := rtostr(main_unt.units.press_si(strtor(pipe_max_press.Text)), 10,2);
           pipe.diam := rtostr(main_unt.units.diam_si(strtor(pipe_diam.Text)), 10,2);
           BlockWrite(temp_pipes_file, pipe, sizeof(pipe));
        end
        else
        begin
           BlockWrite(temp_pipes_file, pipe, sizeof(pipe));
        end;
      end;

   // Close the file for the last time
   CloseFile(pipes_file);
   CloseFile(temp_pipes_file);

  DeleteFile('pipes.ems');
  Rename(temp_pipes_file, 'pipes.ems');

  index := pipe_lb.itemindex;
  load_pipes;
  pipe_lb.Selected[index] := true;


end;

procedure Tpipe_mng.Button1Click(Sender: TObject);
var value : string;
x : integer;
begin

    {value := InputBox('Pipe Pressure', 'Please enter a pressure:', '0');
    x := sizeof(current_pipe.max_press) - 1;
    press_lb.Items.Add(value);        }

end;

procedure Tpipe_mng.Button2Click(Sender: TObject);
begin

     //press_lb.DeleteSelected;

end;

procedure Tpipe_mng.Button3Click(Sender: TObject);
begin
   drip_line_mng.Show;
end;

procedure Tpipe_mng.btn_deleteClick(Sender: TObject);
var pid, index, amt : integer;
begin

if pipe_lb.count > 0 then
begin

    {$IOChecks off}

   index := pipe_lb.ItemIndex;
   if index = -1 then index := pipe_lb.Count - 1;

   pid := Integer(pipe_lb.Items.Objects[pipe_lb.Items.IndexOf(pipe_lb.Items[index])]);
   drip_line_mng.delete_from(pid, 2);

   AssignFile(pipes_file, 'pipes.ems');
   AssignFile(temp_pipes_file, 'temp_pipes.ems');
   ReWrite(temp_pipes_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(pipes_file,1);
   Reset(temp_pipes_file,1);

   BlockRead(pipes_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_pipes_file, settings, sizeof(TSettings));

      // Display the file contents
      while not Eof(pipes_file) do
      begin
        BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
        if pid <> pipe.id then
           BlockWrite(temp_pipes_file, pipe, sizeof(pipe));
      end;

   // Close the file for the last time
   CloseFile(pipes_file);
   CloseFile(temp_pipes_file);

  DeleteFile('pipes.ems');
  Rename(temp_pipes_file, 'pipes.ems');
  DeleteFile('temp_pipes.ems');

  load_pipes;

  if pipe_lb.count > 0 then
  begin
    pipe_lb.Selected[pipe_lb.count - 1] := true;
    pipe_lbClick(sender);
  end;

end;

end;

procedure Tpipe_mng.load_pipes;
var amt : integer;
begin
   pipe_lb.Clear;
   AssignFile(pipes_file, 'pipes.ems');
   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pipes_file,1);
   BlockRead(pipes_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pipes_file) do
   begin
     BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
     pipe_lb.Items.AddObject(pipe.name,  TObject(pipe.id));
   end;
   // Close the file for the last time
   CloseFile(pipes_file);
end;

procedure Tpipe_mng.pipe_lbClick(Sender: TObject);
var index, pid, x, amt : integer;
   pname : string;
begin

   index := pipe_lb.ItemIndex;
   if index = -1 then index := pipe_lb.Count - 1;

   pipe_lb.Selected[index] := true;

   clear_form;

   pid := Integer(pipe_lb.Items.Objects[pipe_lb.Items.IndexOf(pipe_lb.Items[index])]);
   AssignFile(pipes_file, 'pipes.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pipes_file,1);
   BlockRead(pipes_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pipes_file) do
   begin
     BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
     if pid = pipe.id then
     begin
        current_pipe := pipe;
        pipe_name.Text := pipe.name;

        {for x := 0 to 20 do
        begin
          if pipe.max_press[x] <> 0.00 then
             press_lb.Items.Add(rtostr(pipe.max_press[x], 10, 2));
        end; }
       // pipe_max_press.Text := rtostr(pipe.max_press,10,2);

        pipe_diam.Text := rtostr(main_unt.units.SI_space(strtor(pipe.diam)),10,2);
        pipe_max_press.Text := rtostr(main_unt.units.si_press(strtor(pipe.max_press)),10,2);
     end;
   end;

   // Close the file for the last time
   CloseFile(pipes_file);
end;

procedure Tpipe_mng.FormActivate(Sender: TObject);
var j : integer;
begin


    {$IOChecks off}

         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);


   //AssignFile(pipes_file, 'pipes.ems');
   if not fileexists('pipes.ems') then
   begin
      ReWrite(pipes_file);
      CloseFile(pipes_file);
   end;

   load_pipes;
   redo_labels;

   // Load first pipe if there are some
   if pipe_lb.Count > 0 then
   begin
      pipe_lb.ItemIndex := 0;
      pipe_lbClick(sender);
   end
   else
   begin
      btn_newClick(sender);
   end;

end;

procedure Tpipe_mng.FormCreate(Sender: TObject);
var s : string;
j : integer;
begin



end;

end.
