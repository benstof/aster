object emitter_mng: Temitter_mng
  Left = 0
  Top = 0
  Caption = 'Emitter Manager'
  ClientHeight = 438
  ClientWidth = 716
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
    Left = 432
    Top = 25
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 446
    Top = 53
    Width = 13
    Height = 13
    Caption = 'CV'
  end
  object Label3: TLabel
    Left = 446
    Top = 79
    Width = 13
    Height = 13
    Caption = 'KD'
  end
  object Label4: TLabel
    Left = 394
    Top = 114
    Width = 65
    Height = 13
    Caption = 'Max Pressure'
  end
  object Label5: TLabel
    Left = 398
    Top = 141
    Width = 61
    Height = 13
    Caption = 'Min Pressure'
  end
  object Label6: TLabel
    Left = 415
    Top = 279
    Width = 44
    Height = 13
    Caption = 'Constant'
  end
  object Label7: TLabel
    Left = 409
    Top = 169
    Width = 50
    Height = 13
    Caption = 'Correction'
  end
  object Label8: TLabel
    Left = 416
    Top = 196
    Width = 43
    Height = 13
    Caption = 'Hazen W'
  end
  object Label26: TLabel
    Left = 393
    Top = 320
    Width = 137
    Height = 13
    Caption = 'Flow equation coefficient (&x)'
  end
  object max_bar_lbl: TLabel
    Left = 651
    Top = 118
    Width = 58
    Height = 13
    Caption = 'max_bar_lbl'
  end
  object min_bar_lbl: TLabel
    Left = 651
    Top = 146
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object em_coef_limits_lb: TLabel
    Left = 595
    Top = 325
    Width = 23
    Height = 13
    Caption = 'limits'
  end
  object btn_save: TButton
    Left = 374
    Top = 391
    Width = 75
    Height = 26
    Caption = 'Save'
    TabOrder = 0
    OnClick = btn_saveClick
  end
  object emitter_lb: TListBox
    Left = 8
    Top = 18
    Width = 360
    Height = 399
    ItemHeight = 13
    TabOrder = 1
    TabWidth = 10
    OnClick = emitter_lbClick
  end
  object em_name: TEdit
    Left = 465
    Top = 22
    Width = 180
    Height = 21
    TabOrder = 2
  end
  object em_cv: TEdit
    Left = 465
    Top = 49
    Width = 180
    Height = 21
    TabOrder = 3
  end
  object em_kd: TEdit
    Left = 465
    Top = 76
    Width = 180
    Height = 21
    TabOrder = 4
  end
  object em_max_press: TEdit
    Left = 465
    Top = 110
    Width = 180
    Height = 21
    TabOrder = 5
  end
  object em_min_press: TEdit
    Left = 465
    Top = 138
    Width = 180
    Height = 21
    TabOrder = 6
  end
  object em_constant: TEdit
    Left = 465
    Top = 276
    Width = 180
    Height = 21
    TabOrder = 7
  end
  object em_correction: TEdit
    Left = 465
    Top = 165
    Width = 180
    Height = 21
    TabOrder = 8
  end
  object btn_delete: TButton
    Left = 536
    Top = 391
    Width = 52
    Height = 25
    Caption = 'Delete'
    TabOrder = 9
    OnClick = btn_deleteClick
  end
  object btn_new: TButton
    Left = 455
    Top = 391
    Width = 75
    Height = 25
    Caption = 'New'
    TabOrder = 10
    OnClick = btn_newClick
  end
  object em_compensate: TRadioGroup
    Left = 465
    Top = 227
    Width = 180
    Height = 38
    Caption = 'Compensated'
    Columns = 2
    Items.Strings = (
      'Regular'
      'Pressure')
    TabOrder = 11
    OnClick = em_compensateClick
  end
  object press_reg_cb: TComboBox
    Left = 430
    Top = 339
    Width = 50
    Height = 21
    TabOrder = 12
    Text = '0.05'
    Visible = False
    Items.Strings = (
      '0.00'
      '0.01'
      '0.02'
      '0.03'
      '0.04'
      '0.05'
      '0.06'
      '0.07'
      '0.08'
      '0.09'
      '0.10'
      '0.11'
      '0.12'
      '0.13'
      '0.14'
      '0.15'
      '0.16'
      '0.17'
      '0.18'
      '0.19'
      '0.20')
  end
  object normal_reg_cb: TComboBox
    Left = 374
    Top = 341
    Width = 50
    Height = 21
    TabOrder = 13
    Text = '0.20'
    Visible = False
    Items.Strings = (
      '0.15'
      '0.16'
      '0.17'
      '0.18'
      '0.19'
      '0.20'
      '0.21'
      '0.22'
      '0.23'
      '0.24'
      '0.25'
      '0.26'
      '0.27'
      '0.28'
      '0.29'
      '0.30'
      '0.31'
      '0.32'
      '0.33'
      '0.34'
      '0.35'
      '0.36'
      '0.37'
      '0.38'
      '0.39'
      '0.40'
      '0.41'
      '0.42'
      '0.43'
      '0.44'
      '0.45'
      '0.46'
      '0.47'
      '0.48'
      '0.49'
      '0.50'
      '0.51'
      '0.52'
      '0.53'
      '0.54'
      '0.55'
      '0.56'
      '0.57'
      '0.58'
      '0.59'
      '0.60'
      '0.61'
      '0.62'
      '0.63'
      '0.64'
      '0.65'
      '0.66'
      '0.67'
      '0.68'
      '0.69'
      '0.70'
      '0.71'
      '0.72'
      '0.73'
      '0.74'
      '0.75'
      '0.76'
      '0.77'
      '0.78'
      '0.79'
      '0.80'
      '0.81'
      '0.82'
      '0.83'
      '0.84'
      '0.85'
      '0.86'
      '0.87'
      '0.88'
      '0.89'
      '0.90'
      '0.91'
      '0.92'
      '0.93'
      '0.94'
      '0.95'
      '0.96'
      '0.97'
      '0.98'
      '0.99'
      '1.00')
  end
  object em_hw: TComboBox
    Left = 465
    Top = 192
    Width = 57
    Height = 21
    Hint = 'The Hazen-Williams roughness factor for the pipe'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 14
    Text = '140'
    Items.Strings = (
      '100'
      '105'
      '110'
      '115'
      '120'
      '125'
      '130'
      '135'
      '140'
      '145'
      '150')
  end
  object em_ex: TEdit
    Left = 536
    Top = 317
    Width = 53
    Height = 21
    TabOrder = 15
  end
end