object Form1: TForm1
  Left = 706
  Top = 156
  Width = 715
  Height = 750
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 105
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 24
    Width = 45
    Height = 13
    Caption = 'Flow LpH'
  end
  object Label2: TLabel
    Left = 24
    Top = 56
    Width = 22
    Height = 13
    Caption = 'Coef'
  end
  object Label3: TLabel
    Left = 16
    Top = 96
    Width = 63
    Height = 13
    Caption = 'Pipe Dim MM'
  end
  object Label4: TLabel
    Left = 16
    Top = 128
    Width = 38
    Height = 13
    Caption = 'Slope %'
  end
  object Label5: TLabel
    Left = 336
    Top = 32
    Width = 56
    Height = 13
    Caption = 'Spacing cm'
  end
  object Label6: TLabel
    Left = 344
    Top = 80
    Width = 74
    Height = 13
    Caption = 'Pipe Length (m)'
  end
  object Memo1: TMemo
    Left = 24
    Top = 176
    Width = 641
    Height = 473
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object Edit1: TEdit
    Left = 112
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '1.7'
  end
  object Edit2: TEdit
    Left = 112
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '0.56'
  end
  object Edit3: TEdit
    Left = 112
    Top = 96
    Width = 121
    Height = 21
    TabOrder = 3
    Text = '16.1'
  end
  object Edit4: TEdit
    Left = 112
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '3'
  end
  object BitBtn1: TBitBtn
    Left = 312
    Top = 128
    Width = 185
    Height = 25
    Caption = 'BitBtn1'
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object Edit5: TEdit
    Left = 408
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 6
    Text = '40'
  end
  object Edit6: TEdit
    Left = 424
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 7
    Text = '200'
  end
end