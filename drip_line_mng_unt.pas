unit drip_line_mng_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Form2unt, Vcl.ExtCtrls,
  Vcl.Menus, Vcl.ComCtrls, Vcl.Grids, Vcl.DBGrids,
  Data.DB,Vcl.DBCtrls, taal_unt, Vcl.Buttons;
type
  Tdrip_line_mng = class(TForm)
    emitter_lb: TListBox;
    pipe_lb: TListBox;
    dripline_lb: TListBox;
    btn_add: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btn_delete: TButton;
    dl_memo: TMemo;
    btn_save: TButton;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    Label5: TLabel;
    pressures_lb: TListBox;
    procedure FormActivate(Sender: TObject);
    procedure load_pipes;
    procedure load_emitters;
    procedure emitter_lbClick(Sender: TObject);
    procedure pipe_lbClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure load_driplines;
    procedure btn_deleteClick(Sender: TObject);
    procedure delete_from(id : integer; what : integer);
    procedure btn_saveClick(Sender: TObject);
    procedure dripline_lbClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure up_btnClick(Sender: TObject);
    procedure load_pressures;
  private
    { Private declarations }
  public
    { Public declarations }


  end;

var
  drip_line_mng: Tdrip_line_mng;

 type

   TDripline = Record
     id : integer;
     order : integer;
     emitter_id : integer;
     pipe_id   : integer;
     lines_arr : array[1..100] of string[200];
     lines_arr_trans : array[1..100] of string[200];
     pressures_arr : array[1..20] of integer;

 end;

 type
   TSettings = Record
     password : string[20];
   end;

 var
   products : array of TDripline;
   driplines_file : File;
   temp_driplines_file : File;
   pressures_file : File;
   dripline : TDripline;
   settings : TSettings;
   pact : integer;

implementation

uses emitter_mng_unt, pipe_mng_unt, pressures_mng_unt;

{$R *.dfm}
{$I-}

procedure Tdrip_line_mng.load_pressures;
var amt : integer;
begin
   pressures_lb.Clear;
   AssignFile(pressures_file, 'pressures.ems');
   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pressures_file,1);
   BlockRead(pressures_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pressures_file) do
   begin
     //Read(emitters_file, emitter);
     BlockRead(pressures_file, pressure, sizeof(Tpressure), amt);
     pressures_lb.Items.AddObject(pressure.name,  TObject(pressure.id));
   end;
   // Close the file for the last time
   CloseFile(pressures_file);
end;

procedure Tdrip_line_mng.load_emitters;
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
     //Read(emitters_file, emitter);
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     emitter_lb.Items.AddObject(emitter.name,  TObject(emitter.id));
   end;
   // Close the file for the last time
   CloseFile(emitters_file);
end;

procedure Tdrip_line_mng.load_pipes;
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

function getPipe(id: integer) : TPipe;
var amt : integer;
begin

   AssignFile(pipes_file, 'pipes.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(pipes_file,1);
   BlockRead(pipes_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(pipes_file) do
   begin
     BlockRead(pipes_file, pipe, sizeof(TPipe), amt);
     if id = pipe.id then
        result := pipe;
   end;
   CloseFile(pipes_file);
end;

function getEmitter(id: integer) : TEmitter;
var amt : integer;
begin

   AssignFile(emitters_file, 'emitters.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(emitters_file) do
   begin
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     if id = emitter.id then
        result := emitter;
   end;

   CloseFile(emitters_file);
end;

function getDripline(id: integer) : TDripline;
var amt : integer;
x, c : integer;
begin

   AssignFile(driplines_file, 'driplines.ems');
   if not fileexists('driplines.ems') then
      ReWrite(driplines_file);


   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(driplines_file) do
   begin
     BlockRead(driplines_file, dripline, sizeof(dripline), amt);

     if id = dripline.id then
        result := dripline;
   end;

   CloseFile(driplines_file);

end;

procedure Tdrip_line_mng.load_driplines;
var dlname : string;
x, y, amt, c, dlid, p : integer;

begin
   p := 0;
   dripline_lb.Clear;

   AssignFile(driplines_file, 'driplines.ems');
   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);


   Setlength(products,1000);
   // Display the file contents
   while not Eof(driplines_file) do
   begin

     BlockRead(driplines_file, dripline, sizeof(TDripline), amt);

     products[p] := dripline;
     p := p + 1;
   end;

   // Close the file for the last time
   CloseFile(driplines_file);


   Setlength(products,p);
      for y := 0 to length(products) - 1 do
      begin

         dripline := products[y];
         emitter := getEmitter(dripline.emitter_id);
         pipe := getPipe(dripline.pipe_id);
         dlname := inttostr(dripline.order) + ')   ' + pipe.name + ' - ' +emitter.name;

         dripline_lb.Items.AddObject(dlname,  TObject(dripline.id));

      end;


end;

procedure Tdrip_line_mng.pipe_lbClick(Sender: TObject);
var index, pid, amt : integer;
begin

   index := pipe_lb.ItemIndex;
   if index = -1 then index := pipe_lb.Count - 1;

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
        current_pipe := pipe;
   end;
   // Close the file for the last time
   CloseFile(pipes_file);

end;

procedure Tdrip_line_mng.delete_from(id : integer; what : integer);
var skip : boolean;
amt, x : integer;
begin

   {$IOChecks off}

   AssignFile(driplines_file, 'driplines.ems');
   AssignFile(temp_driplines_file, 'temp_driplines.ems');
   ReWrite(temp_driplines_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(driplines_file,1);
   Reset(temp_driplines_file,1);

   BlockRead(driplines_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_driplines_file, settings, sizeof(TSettings));

      // Display the file contents
      while not Eof(driplines_file) do
      begin

        skip := false;
        BlockRead(driplines_file, dripline, sizeof(TDripline), amt);


        if what = 1 then
        begin
           if dripline.emitter_id = id then
              skip := true;
        end;

        if what = 2 then
        begin
           if dripline.pipe_id = id then
              skip := true;
        end;

        if not skip then
        begin
           BlockWrite(temp_driplines_file, dripline, sizeof(TDripline));

        end
        else
        begin

        end;

      end;

   // Close the file for the last time
   CloseFile(driplines_file);
   CloseFile(temp_driplines_file);

  DeleteFile('driplines.ems');
  RenameFile('temp_driplines.ems', 'driplines.ems');

end;

procedure Tdrip_line_mng.dripline_lbClick(Sender: TObject);
var index, dlid, amt, c, x, press_id, y: integer;

begin

   pressures_lb.ClearSelection;

   pact := dripline_lb.ItemIndex;
   index := dripline_lb.ItemIndex;
   if index = -1 then index := dripline_lb.Count - 1;

   dripline_lb.Selected[index] := true;
   dl_memo.Lines.Clear;

   dlid := Integer(dripline_lb.Items.Objects[dripline_lb.Items.IndexOf(dripline_lb.Items[index])]);
   AssignFile(driplines_file, 'driplines.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);


   while not Eof(driplines_file) do
   begin

     BlockRead(driplines_file, dripline, sizeof(TDripline), amt);

     if dlid = dripline.id then
     begin

        if waarde.readint('Irricalc','AltLanguage',1) = 1 then
        begin
           for x := 0 to length(dripline.lines_arr_trans) - 1 do
              if dripline.lines_arr_trans[x+1] <> '' then
                 dl_memo.Lines.Add(dripline.lines_arr_trans[x+1]);
        end
        else
        begin
           for x := 0 to length(dripline.lines_arr) - 1 do
              if dripline.lines_arr[x+1] <> '' then
                 dl_memo.Lines.Add(dripline.lines_arr[x+1])
        end;



                 for y := 1 to 20 do
                 begin
                    if dripline.pressures_arr[y] <> 0 then
                    begin
                       press_id := dripline.pressures_arr[y];
                       pressures_lb.Selected[press_id - 1] := true;
                    end;
                 end;




     end;

   end;

   // Close the file for the last time
   CloseFile(driplines_file);

end;

procedure Tdrip_line_mng.btn_deleteClick(Sender: TObject);
var dlid, index, amt : integer;
 x : integer;

begin

if dripline_lb.count > 0 then
begin


   index := dripline_lb.ItemIndex;
   if index = -1 then index := dripline_lb.Count - 1;

   dlid := Integer(dripline_lb.Items.Objects[dripline_lb.Items.IndexOf(dripline_lb.Items[index])]);

   AssignFile(driplines_file, 'driplines.ems');
   AssignFile(temp_driplines_file, 'temp_driplines.ems');
   ReWrite(temp_driplines_file,1);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(driplines_file,1);
   Reset(temp_driplines_file,1);

   BlockRead(driplines_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_driplines_file, settings, sizeof(TSettings));

      // Display the file contents
      while not Eof(driplines_file) do
      begin
        BlockRead(driplines_file, dripline, sizeof(TDripline), amt);

        if dlid <> dripline.id then
        begin
           BlockWrite(temp_driplines_file, dripline, sizeof(TDripline));

        end
        else
        begin


        end;

      end;

   // Close the file for the last time
   CloseFile(driplines_file);
   CloseFile(temp_driplines_file);

  DeleteFile('driplines.ems');
  Rename(temp_driplines_file, 'driplines.ems');
  DeleteFile('temp_driplines.ems');

  load_driplines;

end;

end;

procedure Tdrip_line_mng.btn_saveClick(Sender: TObject);
var dlid, index, amt, c, x,press_id, y : integer;
begin

if dripline_lb.count > 0 then
begin


   index := dripline_lb.ItemIndex;
   if index = -1 then index := dripline_lb.Count - 1;

   dlid := Integer(dripline_lb.Items.Objects[dripline_lb.Items.IndexOf(dripline_lb.Items[index])]);

   AssignFile(driplines_file, 'driplines.ems');
   AssignFile(temp_driplines_file, 'temp_driplines.ems');
   ReWrite(temp_driplines_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(driplines_file,1);
   Reset(temp_driplines_file,1);

   BlockRead(driplines_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_driplines_file, settings, sizeof(TSettings));

      while not Eof(driplines_file) do
      begin

        BlockRead(driplines_file, dripline, sizeof(TDripline), amt);

        if dlid = dripline.id then
        begin

           if waarde.readint('Irricalc','AltLanguage',1) = 1 then
           begin
              for x := 0 to 100 do
                 dripline.lines_arr_trans[x+1] := '';
              for x := 0 to dl_memo.Lines.Count - 1 do
                 dripline.lines_arr_trans[x+1] := dl_memo.Lines[x];
           end
           else
           begin
              for x := 0 to 100 do
                 dripline.lines_arr[x+1] := '';
              for x := 0 to dl_memo.Lines.Count - 1 do
                 dripline.lines_arr[x+1] := dl_memo.Lines[x];
           end;

           for x := 1 to 20 do
              dripline.pressures_arr[x] := 0;

           for x := 0 to pressures_lb.Count - 1 do
           begin

              press_id := Integer(pressures_lb.Items.Objects[pressures_lb.Items.IndexOf(pressures_lb.Items[x])]);

              if pressures_lb.Selected[x] then
              begin

                 for y := 1 to 20 do
                 begin
                    if dripline.pressures_arr[y] = 0 then
                    begin
                       dripline.pressures_arr[y] := press_id;
                       break;
                    end;
                 end;

              end;

           end;


           BlockWrite(temp_driplines_file, dripline, sizeof(dripline));


        end
        else
        begin

           BlockWrite(temp_driplines_file, dripline, sizeof(dripline));

        end;

      end;

   // Close the file for the last time
   CloseFile(driplines_file);
   CloseFile(temp_driplines_file);

  DeleteFile('driplines.ems');
  Rename(temp_driplines_file, 'driplines.ems');
  DeleteFile('temp_driplines.ems');

  load_driplines;

end;

end;

procedure Tdrip_line_mng.btn_addClick(Sender: TObject);
var add_it : boolean;
dlid, amt, c, x, order  : integer;

begin

   if (current_pipe.id > 0) and (current_emitter.id > 0) then
   begin

   add_it := true;

   AssignFile(driplines_file, 'driplines.ems');
   FileMode := fmOpenReadWrite;

   // Get next id
   dlid := 0;
   order := 0;

   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);

   while not Eof(driplines_file) do
   begin
      BlockRead(driplines_file, dripline, sizeof(TDripline), amt);


      if dripline.id > dlid then
         dlid := dripline.id;

      if dripline.order > order then
         order := dripline.order;

   end;

   Reset(driplines_file,1);
   BlockRead(driplines_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(driplines_file) do
   begin
     BlockRead(driplines_file, dripline, sizeof(TDripline), amt);


     if (current_pipe.id = dripline.pipe_id) and (current_emitter.id = dripline.emitter_id) then
        add_it := false;

   end;

   if add_it then
   begin
      seek(driplines_file,filesize(driplines_file));
      dripline.id := dlid+1;
      dripline.order := order+1;
      dripline.pipe_id := current_pipe.id;
      dripline.emitter_id := current_emitter.id;
      BlockWrite(driplines_file, dripline, sizeof(TDripline));
   end;

   CloseFile(driplines_file);
   load_driplines;


   end;

end;

procedure Tdrip_line_mng.up_btnClick(Sender: TObject);
var index, dlid, cid, amt, c, x : integer;
 dlname : string[200];
    j,tt,y : integer;
    temp_dripline : TDripline;

begin

   tt:=(sender as tspeedbutton).tag;
   j:=pact;

   case tt of
   1 : if pact>0 then j:=pact-1;
   2 : if pact<length(products) - 1 then j:=pact+1;
   end;

   temp_dripline := products[j];
   products[j] := products[pact];
   products[pact] := temp_dripline;

   pact:=j;

   //updatebmp(bitt[actbit,bact],true);

      dripline_lb.Items.Clear;



   AssignFile(driplines_file, 'driplines.ems');
   AssignFile(temp_driplines_file, 'temp_driplines.ems');
   ReWrite(temp_driplines_file);

   // Reopen the file in read only mode
   FileMode := fmOpenReadWrite;
   Reset(driplines_file,1);
   Reset(temp_driplines_file,1);

   BlockRead(driplines_file, settings, sizeof(TSettings), amt);
   BlockWrite(temp_driplines_file, settings, sizeof(TSettings));


      for y := 0 to length(products) - 1 do
      begin

         dripline := products[y];
         emitter := getEmitter(dripline.emitter_id);
         pipe := getPipe(dripline.pipe_id);
         dlname := inttostr(dripline.order) + ')   ' + pipe.name + ' - ' +emitter.name;

         dripline_lb.Items.AddObject(dlname,  TObject(dripline.id));


         BlockWrite(temp_driplines_file, dripline, sizeof(dripline));

        {   for x := 0 to dripline.lines - 1 do
           begin
               BlockWrite(temp_driplines_file, dripline.lines_arr[x+1], 200);
           end; }

      end;

   dripline_lb.itemindex:=pact;


   CloseFile(driplines_file);
   CloseFile(temp_driplines_file);

  DeleteFile('driplines.ems');
  Rename(temp_driplines_file, 'driplines.ems');
  DeleteFile('temp_driplines.ems');


end;

procedure Tdrip_line_mng.emitter_lbClick(Sender: TObject);
var index, eid, amt : integer;
begin

   index := emitter_lb.ItemIndex;
   if index = -1 then index := emitter_lb.Count - 1;

   eid := Integer(emitter_lb.Items.Objects[emitter_lb.Items.IndexOf(emitter_lb.Items[index])]);
   AssignFile(emitters_file, 'emitters.ems');

   // Reopen the file in read only mode
   FileMode := fmOpenRead;
   Reset(emitters_file,1);
   BlockRead(emitters_file, settings, sizeof(TSettings), amt);

   // Display the file contents
   while not Eof(emitters_file) do
   begin
     BlockRead(emitters_file, emitter, sizeof(TEmitter), amt);
     if eid = emitter.id then
        current_emitter := emitter;
   end;
   // Close the file for the last time
   CloseFile(emitters_file);

end;

procedure Tdrip_line_mng.FormActivate(Sender: TObject);
var j : integer;
begin

   dl_memo.Lines.Clear;

         for j:=0 to ComponentCount-1 do
            MMLAng.getname(components[j]);

   {$IOChecks off}

   AssignFile(pressures_file, 'pressures.ems');
   if not fileexists('pressures.ems') then
   begin
      ReWrite(pressures_file);
      CloseFile(pressures_file);
   end;
   load_pressures;


   AssignFile(pipes_file, 'pipes.ems');
   if not fileexists('pipes.ems') then
   begin
      ReWrite(pipes_file);
      CloseFile(pipes_file);
   end;
   load_pipes;

   AssignFile(emitters_file, 'emitters.ems');
   if not fileexists('emitters.ems') then
   begin
      ReWrite(emitters_file);
      CloseFile(emitters_file);
   end;
   load_emitters;

   AssignFile(driplines_file, 'driplines.ems');
   if not fileexists('driplines.ems') then
   begin
      ReWrite(driplines_file);
      CloseFile(driplines_file);
   end;
   load_driplines;

end;

procedure Tdrip_line_mng.FormCreate(Sender: TObject);
var s : string;
j : integer;
begin

   setlength(products,0);

end;

end.
