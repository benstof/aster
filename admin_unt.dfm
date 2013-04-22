object admin_form: Tadmin_form
  Left = 0
  Top = 0
  Caption = 'Admin '
  ClientHeight = 108
  ClientWidth = 231
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
    Left = 33
    Top = 22
    Width = 45
    Height = 13
    Caption = 'Company'
  end
  object Label2: TLabel
    Left = 32
    Top = 48
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object company_input: TEdit
    Left = 96
    Top = 19
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object company_password_input: TEdit
    Left = 96
    Top = 46
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object Button1: TButton
    Left = 80
    Top = 75
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 2
    OnClick = Button1Click
  end
end
