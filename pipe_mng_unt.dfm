object pipe_mng: Tpipe_mng
  Left = 0
  Top = 0
  Caption = 'Pipe Manager'
  ClientHeight = 244
  ClientWidth = 655
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 388
    Top = 31
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label4: TLabel
    Left = 352
    Top = 90
    Width = 65
    Height = 13
    Caption = 'Max Pressure'
  end
  object Label9: TLabel
    Left = 354
    Top = 60
    Width = 65
    Height = 13
    Caption = 'Diameter (ID)'
  end
  object drippipeU: TLabel
    Left = 609
    Top = 58
    Width = 38
    Height = 13
    Caption = 'pipeunit'
  end
  object max_bar_lbl: TLabel
    Left = 512
    Top = 90
    Width = 58
    Height = 13
    Caption = 'max_bar_lbl'
  end
  object pipe_lb: TListBox
    Left = 27
    Top = 28
    Width = 319
    Height = 165
    ItemHeight = 13
    TabOrder = 0
    OnClick = pipe_lbClick
  end
  object pipe_name: TEdit
    Left = 423
    Top = 28
    Width = 180
    Height = 21
    TabOrder = 1
  end
  object btn_save: TButton
    Left = 27
    Top = 210
    Width = 75
    Height = 26
    Caption = 'Save'
    TabOrder = 2
    OnClick = btn_saveClick
  end
  object btn_new: TButton
    Left = 108
    Top = 207
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 3
    OnClick = btn_newClick
  end
  object btn_delete: TButton
    Left = 189
    Top = 207
    Width = 68
    Height = 25
    Caption = 'Delete'
    TabOrder = 4
    OnClick = btn_deleteClick
  end
  object pipe_diam: TEdit
    Left = 423
    Top = 55
    Width = 180
    Height = 21
    TabOrder = 5
  end
  object pipe_max_press: TEdit
    Left = 423
    Top = 82
    Width = 106
    Height = 21
    TabOrder = 6
    Text = 'pipe_max_press'
  end
end
