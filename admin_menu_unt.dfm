object admin_menu: Tadmin_menu
  Left = 0
  Top = 0
  Caption = 'Admin Menu'
  ClientHeight = 142
  ClientWidth = 152
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 9
    Width = 129
    Height = 25
    Caption = 'Manage Pressures'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 40
    Width = 129
    Height = 25
    Caption = 'Manage Emitters'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 71
    Width = 129
    Height = 25
    Caption = 'Manage Pipes'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 102
    Width = 129
    Height = 25
    Caption = 'Manage Driplines'
    TabOrder = 3
    OnClick = Button4Click
  end
end
