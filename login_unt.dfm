object login_form: Tlogin_form
  Left = 0
  Top = 0
  Caption = 'Login '
  ClientHeight = 88
  ClientWidth = 195
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
    Left = 112
    Top = 24
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object Label3: TLabel
    Left = 8
    Top = 22
    Width = 46
    Height = 13
    Caption = 'Password'
  end
  object input_password: TEdit
    Left = 63
    Top = 19
    Width = 121
    Height = 21
    PasswordChar = '#'
    TabOrder = 0
    Text = 'admin'
  end
  object BitBtn1: TBitBtn
    Left = 55
    Top = 53
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = BitBtn1Click
  end
end
