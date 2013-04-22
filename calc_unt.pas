unit calc_unt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.TabNotBk, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Image4: TImage;
    box1: TGroupBox;
    Bevel4: TBevel;
    Bevel2: TBevel;
    flow1: TLabel;
    diam1: TLabel;
    spoed1: TLabel;
    Bevel3: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    flowunt: TLabel;
    diamunt: TLabel;
    speedunt: TLabel;
    flow2: TLabel;
    diam2: TLabel;
    speed2: TLabel;
    rspoed: TRadioButton;
    rdiam: TRadioButton;
    rflow: TRadioButton;
    iflow: TEdit;
    idiam: TEdit;
    ispoed: TEdit;
    GroupBox1: TGroupBox;
    presbox: TGroupBox;
    Label6: TLabel;
    lossunit: TLabel;
    maxloss: TEdit;
    pres1: TRadioButton;
    pres2: TRadioButton;
    Panel1: TPanel;
    Label5: TLabel;
    Label4: TLabel;
    startpress: TEdit;
    endpress: TEdit;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label7: TLabel;
    slope: TEdit;
    GroupBox3: TGroupBox;
    Label9: TLabel;
    flowunit: TLabel;
    regspasunit: TLabel;
    Label19: TLabel;
    emitflow: TEdit;
    regular: TRadioButton;
    onlyend: TRadioButton;
    regspas: TEdit;
    GroupBox4: TGroupBox;
    book1: TTabbedNotebook;
    Bevel6: TBevel;
    Label11: TLabel;
    diamunit: TLabel;
    Label13: TLabel;
    lenresult: TLabel;
    diaminput: TEdit;
    Bevel5: TBevel;
    Label8: TLabel;
    Label10: TLabel;
    diamresult: TLabel;
    pipeunit: TLabel;
    leninput: TEdit;
    Label14: TLabel;
    pipeunit2: TLabel;
    Label16: TLabel;
    diamunit2: TLabel;
    Bevel7: TBevel;
    Label18: TLabel;
    totalloss: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    totlossunit: TLabel;
    egain: TLabel;
    floss: TLabel;
    leninput2: TEdit;
    diaminput2: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox5: TGroupBox;
    Label12: TLabel;
    pfric: TComboBox;
    clp: TBitBtn;
    BitBtn3: TBitBtn;
    HelpBtn: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

end.
