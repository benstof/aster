object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Password Generator'
  ClientHeight = 140
  ClientWidth = 269
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
    Left = 56
    Top = 80
    Width = 171
    Height = 25
    Caption = 'Generate Password'
    TabOrder = 0
    OnClick = Button1Click
  end
  object company_password_input: TEdit
    Left = 48
    Top = 40
    Width = 193
    Height = 21
    TabOrder = 1
    Text = 'Enter a password for this company.'
    OnClick = company_password_inputClick
  end
  object login_panel: TPanel
    Left = 8
    Top = 11
    Width = 253
    Height = 121
    TabOrder = 2
    object btn: TButton
      Left = 88
      Top = 59
      Width = 75
      Height = 25
      Caption = 'Login'
      TabOrder = 0
      OnClick = btnClick
    end
    object input_password: TEdit
      Left = 72
      Top = 24
      Width = 121
      Height = 21
      PasswordChar = '#'
      TabOrder = 1
    end
  end
end
