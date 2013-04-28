object pressures_mng: Tpressures_mng
  Left = 0
  Top = 0
  Caption = 'pressures_mng'
  ClientHeight = 246
  ClientWidth = 617
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
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
  object max_bar_lbl: TLabel
    Left = 512
    Top = 90
    Width = 58
    Height = 13
    Caption = 'max_bar_lbl'
  end
  object pressure_lb: TListBox
    Left = 27
    Top = 28
    Width = 319
    Height = 165
    ItemHeight = 13
    TabOrder = 0
    OnClick = pressure_lbClick
  end
  object btn_save: TButton
    Left = 27
    Top = 207
    Width = 75
    Height = 26
    Caption = 'Save'
    TabOrder = 1
    OnClick = btn_saveClick
  end
  object btn_new: TButton
    Left = 108
    Top = 207
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 2
    OnClick = btn_newClick
  end
  object btn_delete: TButton
    Left = 189
    Top = 207
    Width = 68
    Height = 25
    Caption = 'Delete'
    TabOrder = 3
    OnClick = btn_deleteClick
  end
  object _name: TEdit
    Left = 423
    Top = 28
    Width = 180
    Height = 21
    TabOrder = 4
  end
  object _max: TEdit
    Left = 423
    Top = 82
    Width = 106
    Height = 21
    TabOrder = 5
    Text = '_max'
  end
end
