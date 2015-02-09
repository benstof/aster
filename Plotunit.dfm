object PlotForm: TPlotForm
  Left = 450
  Top = 188
  Caption = 'Mm Calc Plot'
  ClientHeight = 633
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object plot1: TAdvSpreadGrid
    Left = 586
    Top = 48
    Width = 294
    Height = 181
    Cursor = crDefault
    ColCount = 3
    DefaultRowHeight = 21
    DrawingStyle = gdsClassic
    FixedCols = 1
    RowCount = 16
    FixedRows = 1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
    Visible = False
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'MS Sans Serif'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = clCream
    CellNode.ShowTree = False
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.ControlStyle = csClassic
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    EnhRowColMove = False
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -12
    FilterDropDown.Font.Name = 'MS Sans Serif'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -12
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.Borders = pbNoborder
    PrintSettings.Centered = False
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -12
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    Version = '2.2.3.0'
    WordWrap = False
    EditHint = False
    ShowFormula = False
    AutoRecalc = True
    AutoHeaders = False
    ErrorText = 'Error'
    ErrorDisplay = edFormula
    CellFormat = '%.2f'
    CellNameMode = nmRC
    ColWidths = (
      64
      64
      64)
    RowHeights = (
      21
      21
      21
      21
      29
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21)
  end
  object plot2: TAdvSpreadGrid
    Left = 590
    Top = 248
    Width = 294
    Height = 181
    Cursor = crDefault
    ColCount = 35
    DefaultRowHeight = 21
    DrawingStyle = gdsClassic
    FixedCols = 0
    RowCount = 300
    FixedRows = 0
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected]
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    Visible = False
    HoverRowCells = [hcNormal, hcSelected]
    ActiveCellFont.Charset = DEFAULT_CHARSET
    ActiveCellFont.Color = clWindowText
    ActiveCellFont.Height = -11
    ActiveCellFont.Name = 'MS Sans Serif'
    ActiveCellFont.Style = [fsBold]
    ActiveCellColor = clCream
    CellNode.ShowTree = False
    ControlLook.FixedGradientHoverFrom = clGray
    ControlLook.FixedGradientHoverTo = clWhite
    ControlLook.FixedGradientDownFrom = clGray
    ControlLook.FixedGradientDownTo = clSilver
    ControlLook.ControlStyle = csClassic
    ControlLook.DropDownHeader.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownHeader.Font.Color = clWindowText
    ControlLook.DropDownHeader.Font.Height = -11
    ControlLook.DropDownHeader.Font.Name = 'Tahoma'
    ControlLook.DropDownHeader.Font.Style = []
    ControlLook.DropDownHeader.Visible = True
    ControlLook.DropDownHeader.Buttons = <>
    ControlLook.DropDownFooter.Font.Charset = DEFAULT_CHARSET
    ControlLook.DropDownFooter.Font.Color = clWindowText
    ControlLook.DropDownFooter.Font.Height = -11
    ControlLook.DropDownFooter.Font.Name = 'Tahoma'
    ControlLook.DropDownFooter.Font.Style = []
    ControlLook.DropDownFooter.Visible = True
    ControlLook.DropDownFooter.Buttons = <>
    EnhRowColMove = False
    Filter = <>
    FilterDropDown.Font.Charset = DEFAULT_CHARSET
    FilterDropDown.Font.Color = clWindowText
    FilterDropDown.Font.Height = -12
    FilterDropDown.Font.Name = 'MS Sans Serif'
    FilterDropDown.Font.Style = []
    FilterDropDownClear = '(All)'
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'Tahoma'
    FixedFont.Style = []
    FloatFormat = '%.2f'
    PrintSettings.DateFormat = 'dd/mm/yyyy'
    PrintSettings.Font.Charset = DEFAULT_CHARSET
    PrintSettings.Font.Color = clWindowText
    PrintSettings.Font.Height = -11
    PrintSettings.Font.Name = 'MS Sans Serif'
    PrintSettings.Font.Style = []
    PrintSettings.FixedFont.Charset = DEFAULT_CHARSET
    PrintSettings.FixedFont.Color = clWindowText
    PrintSettings.FixedFont.Height = -12
    PrintSettings.FixedFont.Name = 'MS Sans Serif'
    PrintSettings.FixedFont.Style = []
    PrintSettings.HeaderFont.Charset = DEFAULT_CHARSET
    PrintSettings.HeaderFont.Color = clWindowText
    PrintSettings.HeaderFont.Height = -11
    PrintSettings.HeaderFont.Name = 'MS Sans Serif'
    PrintSettings.HeaderFont.Style = []
    PrintSettings.FooterFont.Charset = DEFAULT_CHARSET
    PrintSettings.FooterFont.Color = clWindowText
    PrintSettings.FooterFont.Height = -11
    PrintSettings.FooterFont.Name = 'MS Sans Serif'
    PrintSettings.FooterFont.Style = []
    PrintSettings.Borders = pbNoborder
    PrintSettings.Centered = False
    PrintSettings.PageNumSep = '/'
    ScrollWidth = 16
    SearchFooter.FindNextCaption = 'Find next'
    SearchFooter.FindPrevCaption = 'Find previous'
    SearchFooter.Font.Charset = DEFAULT_CHARSET
    SearchFooter.Font.Color = clWindowText
    SearchFooter.Font.Height = -12
    SearchFooter.Font.Name = 'MS Sans Serif'
    SearchFooter.Font.Style = []
    SearchFooter.HighLightCaption = 'Highlight'
    SearchFooter.HintClose = 'Close'
    SearchFooter.HintFindNext = 'Find next occurence'
    SearchFooter.HintFindPrev = 'Find previous occurence'
    SearchFooter.HintHighlight = 'Highlight occurences'
    SearchFooter.MatchCaseCaption = 'Match case'
    SelectionColor = clHighlight
    SelectionTextColor = clHighlightText
    Version = '2.2.3.0'
    WordWrap = False
    EditHint = False
    ShowFormula = False
    AutoRecalc = True
    AutoHeaders = False
    ErrorText = 'Error'
    ErrorDisplay = edFormula
    CellFormat = '%.2f'
    CellNameMode = nmRC
    ColWidths = (
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64
      64)
    RowHeights = (
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21
      21)
  end
  object PageControl1: TPageControl
    Left = 4
    Top = 4
    Width = 541
    Height = 621
    ActivePage = TabSheet1
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Lenghts'
      object PBox1: TPaintBox
        Left = 8
        Top = 132
        Width = 520
        Height = 461
        Visible = False
      end
      object Label3: TLabel
        Left = 416
        Top = 16
        Width = 32
        Height = 13
        Caption = 'Label3'
        Visible = False
      end
      object spaceCap: TcxTextEdit
        Left = 9
        Top = 108
        TabOrder = 0
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object Spacing: TcxLabel
        Left = 9
        Top = 92
        Caption = 'Caption'
      end
      object discap: TcxTextEdit
        Left = 9
        Top = 64
        TabOrder = 2
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object discap1: TcxLabel
        Left = 9
        Top = 48
        Caption = 'Distance'
      end
      object Dcap: TcxTextEdit
        Left = 9
        Top = 20
        TabOrder = 4
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object cxLabel1: TcxLabel
        Left = 9
        Top = 4
        Caption = 'Caption'
      end
      object BitBtn1: TBitBtn
        Tag = 1
        Left = 416
        Top = 80
        Width = 75
        Height = 25
        Hint = 'Copy graph to clipboard'
        Caption = 'Copy Chart'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 6
        OnClick = BitBtn1Click
      end
      object BitBtn3: TBitBtn
        Left = 416
        Top = 44
        Width = 75
        Height = 25
        Caption = 'Copy Data'
        TabOrder = 8
        OnClick = BitBtn3Click
      end
      object Y1: TcxLabel
        Left = 20
        Top = 244
        Caption = 'Y1ggggggggggggggggggggg'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taLeftJustify
        Properties.Alignment.Vert = taBottomJustify
        Properties.Angle = 90
        AnchorY = 478
      end
      object s1: TcxButton
        Left = 68
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 9
      end
      object s2: TcxButton
        Left = 98
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 10
      end
      object s3: TcxButton
        Left = 128
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 11
      end
      object s4: TcxButton
        Left = 158
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 13
      end
      object header1: TcxLabel
        Left = 112
        Top = 136
        Caption = 'Graph for dripline 123ggggggggggggggggggg'
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.LabelStyle = cxlsRaised
        AnchorX = 292
      end
      object x1: TcxLabel
        Left = 144
        Top = 568
        Caption = 'cxLabel2hhhhhhhggggggggggggggggg'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        AnchorX = 301
      end
      object s8: TcxButton
        Left = 278
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 15
      end
      object s5: TcxButton
        Left = 188
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 16
      end
      object s6: TcxButton
        Left = 218
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 17
      end
      object s7: TcxButton
        Left = 248
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 18
      end
      object s12: TcxButton
        Left = 398
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 19
      end
      object s9: TcxButton
        Left = 308
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 20
      end
      object s10: TcxButton
        Left = 338
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 21
      end
      object s11: TcxButton
        Left = 368
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 22
      end
      object s13: TcxButton
        Left = 428
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 23
      end
      object s14: TcxButton
        Left = 458
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 25
      end
      object s15: TcxButton
        Left = 488
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 24
      end
      object dchart: TRChart
        Left = 49
        Top = 184
        Width = 469
        Height = 354
        AvoidDuplicateMarks = False
        AllocSize = 1000
        AutoRedraw = True
        MarginRight = 20
        MarginTop = 20
        MarginBottom = 40
        MinDupMarkDist = 1
        RRim = 20
        TRim = 20
        BRim = 40
        BackGroundImg.IncludePath = False
        BackGroundImg.FillMode = bfStretch
        BackGroundImg.AreaMode = bamNone
        BackGroundImg.AreaColor = 14540253
        BackGroundImg.AreaLeft = -1.000000000000000000
        BackGroundImg.AreaRight = 1.000000000000000000
        BackGroundImg.AreaTop = 1.000000000000000000
        BackGroundImg.AreaBottom = -1.000000000000000000
        ClassDefault = 0
        GridStyle = gsNone
        Isometric = False
        JointLayers.L01xControlledBy = 1
        JointLayers.L01yControlledBy = 1
        JointLayers.L02xControlledBy = 2
        JointLayers.L02yControlledBy = 2
        CaptionPosX = 0
        CaptionPosY = -16
        CaptionAlignment = taRightJustify
        CaptionAnchorHoriz = cahChartRight
        CaptionAnchorVert = cavChartTop
        CrossHair1.Color = clBlack
        CrossHair1.Layer = 1
        CrossHair1.Mode = chOff
        CrossHair1.LineType = psSolid
        CrossHair1.LineWid = 1
        CrossHair2.Color = clBlack
        CrossHair2.Layer = 2
        CrossHair2.Mode = chOff
        CrossHair2.LineType = psSolid
        CrossHair2.LineWid = 1
        CrossHair3.Color = clBlack
        CrossHair3.Layer = 2
        CrossHair3.Mode = chOff
        CrossHair3.LineType = psSolid
        CrossHair3.LineWid = 1
        CrossHair4.Color = clBlack
        CrossHair4.Layer = 2
        CrossHair4.Mode = chOff
        CrossHair4.LineType = psSolid
        CrossHair4.LineWid = 1
        MouseAction = maNone
        MouseCursorFixed = True
        PanGridDx = 1.000000000000000000
        PanGridDy = 1.000000000000000000
        Scale1X.CaptionPosX = 0
        Scale1X.CaptionPosY = 22
        Scale1X.CaptionAlignment = taCenter
        Scale1X.CaptionAnchor = uaSclCenter
        Scale1X.ColorScale = clBlack
        Scale1X.DateFormat.TimeFormat = tfHHMMSS
        Scale1X.DateFormat.DateSeparator = '-'
        Scale1X.DateFormat.TimeSeparator = ':'
        Scale1X.DateFormat.YearLength = ylYYYY
        Scale1X.DateFormat.MonthName = True
        Scale1X.DateFormat.DateOrder = doDDMMYY
        Scale1X.DateFormat.DateForTime = dtOnePerDay
        Scale1X.DecPlaces = -2
        Scale1X.Font.Charset = DEFAULT_CHARSET
        Scale1X.Font.Color = clWindowText
        Scale1X.Font.Height = -11
        Scale1X.Font.Name = 'Tahoma'
        Scale1X.Font.Style = []
        Scale1X.Logarithmic = False
        Scale1X.LabelType = ftNum
        Scale1X.MinTicks = 3
        Scale1X.MinRange = 0.000000000100000000
        Scale1X.RangeHigh = 1.000000000000000000
        Scale1X.ShortTicks = True
        Scale1X.ScalePos = 0
        Scale1X.Visible = True
        Scale1X.ScaleLocation = slBottom
        Scale1Y.CaptionPosX = 0
        Scale1Y.CaptionPosY = -16
        Scale1Y.CaptionAlignment = taLeftJustify
        Scale1Y.CaptionAnchor = uaSclTopLft
        Scale1Y.ColorScale = clBlack
        Scale1Y.DateFormat.TimeFormat = tfHHMMSS
        Scale1Y.DateFormat.DateSeparator = '-'
        Scale1Y.DateFormat.TimeSeparator = ':'
        Scale1Y.DateFormat.YearLength = ylYYYY
        Scale1Y.DateFormat.MonthName = True
        Scale1Y.DateFormat.DateOrder = doDDMMYY
        Scale1Y.DateFormat.DateForTime = dtOnePerDay
        Scale1Y.DecPlaces = -2
        Scale1Y.Font.Charset = DEFAULT_CHARSET
        Scale1Y.Font.Color = clWindowText
        Scale1Y.Font.Height = -11
        Scale1Y.Font.Name = 'Tahoma'
        Scale1Y.Font.Style = []
        Scale1Y.Logarithmic = False
        Scale1Y.LabelType = ftNum
        Scale1Y.MinTicks = 3
        Scale1Y.MinRange = 0.000000000100000000
        Scale1Y.RangeHigh = 1.000000000000000000
        Scale1Y.ShortTicks = True
        Scale1Y.ScalePos = 0
        Scale1Y.Visible = True
        Scale1Y.ScaleLocation = slLeft
        Scale2X.CaptionPosX = 10
        Scale2X.CaptionPosY = 100
        Scale2X.CaptionAlignment = taCenter
        Scale2X.CaptionAnchor = uaSclCenter
        Scale2X.ColorScale = clMaroon
        Scale2X.DateFormat.TimeFormat = tfHHMMSS
        Scale2X.DateFormat.DateSeparator = '-'
        Scale2X.DateFormat.TimeSeparator = ':'
        Scale2X.DateFormat.YearLength = ylYYYY
        Scale2X.DateFormat.MonthName = True
        Scale2X.DateFormat.DateOrder = doDDMMYY
        Scale2X.DateFormat.DateForTime = dtOnePerDay
        Scale2X.DecPlaces = -2
        Scale2X.Font.Charset = DEFAULT_CHARSET
        Scale2X.Font.Color = clWindowText
        Scale2X.Font.Height = -11
        Scale2X.Font.Name = 'Tahoma'
        Scale2X.Font.Style = []
        Scale2X.Logarithmic = False
        Scale2X.LabelType = ftNum
        Scale2X.MinTicks = 3
        Scale2X.MinRange = 0.000000000100000000
        Scale2X.RangeHigh = 1.000000000000000000
        Scale2X.ShortTicks = True
        Scale2X.ScalePos = 0
        Scale2X.Visible = False
        Scale2X.ScaleLocation = slBottom
        Scale2Y.CaptionPosX = 10
        Scale2Y.CaptionPosY = 100
        Scale2Y.CaptionAlignment = taRightJustify
        Scale2Y.CaptionAnchor = uaSclTopLft
        Scale2Y.ColorScale = clMaroon
        Scale2Y.DateFormat.TimeFormat = tfHHMMSS
        Scale2Y.DateFormat.DateSeparator = '-'
        Scale2Y.DateFormat.TimeSeparator = ':'
        Scale2Y.DateFormat.YearLength = ylYYYY
        Scale2Y.DateFormat.MonthName = True
        Scale2Y.DateFormat.DateOrder = doDDMMYY
        Scale2Y.DateFormat.DateForTime = dtOnePerDay
        Scale2Y.DecPlaces = -2
        Scale2Y.Font.Charset = DEFAULT_CHARSET
        Scale2Y.Font.Color = clWindowText
        Scale2Y.Font.Height = -11
        Scale2Y.Font.Name = 'Tahoma'
        Scale2Y.Font.Style = []
        Scale2Y.Logarithmic = False
        Scale2Y.LabelType = ftNum
        Scale2Y.MinTicks = 3
        Scale2Y.MinRange = 0.000000000100000000
        Scale2Y.RangeHigh = 1.000000000000000000
        Scale2Y.ShortTicks = True
        Scale2Y.ScalePos = 0
        Scale2Y.Visible = False
        Scale2Y.ScaleLocation = slLeft
        ShadowStyle = ssFlying
        ShadowColor = clGrayText
        ShadowBakColor = clBtnFace
        TextFontStyle = []
        TextBkStyle = tbClear
        TextBkColor = clWhite
        TextAlignment = taCenter
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Losses'
      ImageIndex = 1
      object pbox2: TPaintBox
        Left = 8
        Top = 132
        Width = 520
        Height = 461
        Visible = False
      end
      object BitBtn4: TBitBtn
        Left = 402
        Top = 44
        Width = 75
        Height = 25
        Caption = 'Copy Data'
        TabOrder = 0
        OnClick = BitBtn4Click
      end
      object BitBtn2: TBitBtn
        Tag = 2
        Left = 402
        Top = 84
        Width = 75
        Height = 25
        Hint = 'Copy graph to clipboard'
        Caption = 'Copy Chart'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnClick = BitBtn1Click
      end
      object header2: TcxLabel
        Left = 112
        Top = 136
        Caption = 'Graph for dripline 123ggggggggggggggggggg'
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.LabelStyle = cxlsRaised
        AnchorX = 292
      end
      object y2: TcxLabel
        Left = 20
        Top = 244
        Caption = 'Y1ggggggggggggggggggggg'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        Properties.Alignment.Vert = taVCenter
        Properties.Angle = 90
        AnchorX = 32
        AnchorY = 361
      end
      object v1: TcxButton
        Left = 68
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 4
      end
      object v2: TcxButton
        Left = 98
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 5
      end
      object v3: TcxButton
        Left = 128
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 6
      end
      object v4: TcxButton
        Left = 158
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 7
      end
      object v5: TcxButton
        Left = 188
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 8
      end
      object v6: TcxButton
        Left = 218
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 9
      end
      object v7: TcxButton
        Left = 248
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 10
      end
      object v8: TcxButton
        Left = 278
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 11
      end
      object v9: TcxButton
        Left = 308
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 12
      end
      object v10: TcxButton
        Left = 338
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 13
      end
      object v11: TcxButton
        Left = 368
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 14
      end
      object v12: TcxButton
        Left = 398
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 15
      end
      object v13: TcxButton
        Left = 428
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 16
      end
      object v14: TcxButton
        Left = 458
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 17
      end
      object v15: TcxButton
        Left = 488
        Top = 544
        Width = 30
        Height = 21
        Caption = '25'
        Colors.Default = clGradientActiveCaption
        TabOrder = 18
      end
      object x2: TcxLabel
        Left = 144
        Top = 568
        Caption = 'cxLabel2hhhhhhhggggggggggggggggg'
        ParentFont = False
        Style.Font.Charset = ANSI_CHARSET
        Style.Font.Color = clMaroon
        Style.Font.Height = -16
        Style.Font.Name = 'Arial'
        Style.Font.Style = [fsBold]
        Style.IsFontAssigned = True
        Properties.Alignment.Horz = taCenter
        AnchorX = 301
      end
      object spacecap2: TcxTextEdit
        Left = 9
        Top = 108
        TabOrder = 20
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object cxLabel5: TcxLabel
        Left = 9
        Top = 92
        Caption = 'Caption'
      end
      object discap2: TcxTextEdit
        Left = 9
        Top = 64
        TabOrder = 22
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object cxLabel6: TcxLabel
        Left = 9
        Top = 48
        Caption = 'Distance'
      end
      object dcap2: TcxTextEdit
        Left = 9
        Top = 20
        TabOrder = 24
        Text = 'Dcap'
        OnKeyUp = DcapKeyUp
        Width = 361
      end
      object cxLabel7: TcxLabel
        Left = 9
        Top = 4
        Caption = 'Caption'
      end
      object mychart: TRChart
        Left = 49
        Top = 167
        Width = 469
        Height = 371
        AvoidDuplicateMarks = False
        AllocSize = 1000
        AutoRedraw = True
        MarginRight = 20
        MarginTop = 20
        MarginBottom = 40
        MinDupMarkDist = 1
        RRim = 20
        TRim = 20
        BRim = 40
        BackGroundImg.IncludePath = False
        BackGroundImg.FillMode = bfStretch
        BackGroundImg.AreaMode = bamNone
        BackGroundImg.AreaColor = 14540253
        BackGroundImg.AreaLeft = -1.000000000000000000
        BackGroundImg.AreaRight = 1.000000000000000000
        BackGroundImg.AreaTop = 1.000000000000000000
        BackGroundImg.AreaBottom = -1.000000000000000000
        ClassDefault = 0
        GridStyle = gsNone
        Isometric = False
        JointLayers.L01xControlledBy = 1
        JointLayers.L01yControlledBy = 1
        JointLayers.L02xControlledBy = 2
        JointLayers.L02yControlledBy = 2
        CaptionPosX = 0
        CaptionPosY = -16
        CaptionAlignment = taRightJustify
        CaptionAnchorHoriz = cahChartRight
        CaptionAnchorVert = cavChartTop
        CrossHair1.Color = clBlack
        CrossHair1.Layer = 1
        CrossHair1.Mode = chOff
        CrossHair1.LineType = psSolid
        CrossHair1.LineWid = 1
        CrossHair2.Color = clBlack
        CrossHair2.Layer = 2
        CrossHair2.Mode = chOff
        CrossHair2.LineType = psSolid
        CrossHair2.LineWid = 1
        CrossHair3.Color = clBlack
        CrossHair3.Layer = 2
        CrossHair3.Mode = chOff
        CrossHair3.LineType = psSolid
        CrossHair3.LineWid = 1
        CrossHair4.Color = clBlack
        CrossHair4.Layer = 2
        CrossHair4.Mode = chOff
        CrossHair4.LineType = psSolid
        CrossHair4.LineWid = 1
        MouseAction = maNone
        MouseCursorFixed = True
        PanGridDx = 1.000000000000000000
        PanGridDy = 1.000000000000000000
        Scale1X.CaptionPosX = 0
        Scale1X.CaptionPosY = 22
        Scale1X.CaptionAlignment = taCenter
        Scale1X.CaptionAnchor = uaSclCenter
        Scale1X.ColorScale = clBlack
        Scale1X.DateFormat.TimeFormat = tfHHMMSS
        Scale1X.DateFormat.DateSeparator = '-'
        Scale1X.DateFormat.TimeSeparator = ':'
        Scale1X.DateFormat.YearLength = ylYYYY
        Scale1X.DateFormat.MonthName = True
        Scale1X.DateFormat.DateOrder = doDDMMYY
        Scale1X.DateFormat.DateForTime = dtOnePerDay
        Scale1X.DecPlaces = -2
        Scale1X.Font.Charset = DEFAULT_CHARSET
        Scale1X.Font.Color = clWindowText
        Scale1X.Font.Height = -11
        Scale1X.Font.Name = 'Tahoma'
        Scale1X.Font.Style = []
        Scale1X.Logarithmic = False
        Scale1X.LabelType = ftNum
        Scale1X.MinTicks = 3
        Scale1X.MinRange = 0.000000000100000000
        Scale1X.RangeHigh = 1.000000000000000000
        Scale1X.ShortTicks = True
        Scale1X.ScalePos = 0
        Scale1X.Visible = True
        Scale1X.ScaleLocation = slBottom
        Scale1Y.CaptionPosX = 0
        Scale1Y.CaptionPosY = -16
        Scale1Y.CaptionAlignment = taLeftJustify
        Scale1Y.CaptionAnchor = uaSclTopLft
        Scale1Y.ColorScale = clBlack
        Scale1Y.DateFormat.TimeFormat = tfHHMMSS
        Scale1Y.DateFormat.DateSeparator = '-'
        Scale1Y.DateFormat.TimeSeparator = ':'
        Scale1Y.DateFormat.YearLength = ylYYYY
        Scale1Y.DateFormat.MonthName = True
        Scale1Y.DateFormat.DateOrder = doDDMMYY
        Scale1Y.DateFormat.DateForTime = dtOnePerDay
        Scale1Y.DecPlaces = -2
        Scale1Y.Font.Charset = DEFAULT_CHARSET
        Scale1Y.Font.Color = clWindowText
        Scale1Y.Font.Height = -11
        Scale1Y.Font.Name = 'Tahoma'
        Scale1Y.Font.Style = []
        Scale1Y.Logarithmic = False
        Scale1Y.LabelType = ftNum
        Scale1Y.MinTicks = 3
        Scale1Y.MinRange = 0.000000000100000000
        Scale1Y.RangeHigh = 1.000000000000000000
        Scale1Y.ShortTicks = True
        Scale1Y.ScalePos = 0
        Scale1Y.Visible = True
        Scale1Y.ScaleLocation = slLeft
        Scale2X.CaptionPosX = 10
        Scale2X.CaptionPosY = 100
        Scale2X.CaptionAlignment = taCenter
        Scale2X.CaptionAnchor = uaSclCenter
        Scale2X.ColorScale = clMaroon
        Scale2X.DateFormat.TimeFormat = tfHHMMSS
        Scale2X.DateFormat.DateSeparator = '-'
        Scale2X.DateFormat.TimeSeparator = ':'
        Scale2X.DateFormat.YearLength = ylYYYY
        Scale2X.DateFormat.MonthName = True
        Scale2X.DateFormat.DateOrder = doDDMMYY
        Scale2X.DateFormat.DateForTime = dtOnePerDay
        Scale2X.DecPlaces = -2
        Scale2X.Font.Charset = DEFAULT_CHARSET
        Scale2X.Font.Color = clWindowText
        Scale2X.Font.Height = -11
        Scale2X.Font.Name = 'Tahoma'
        Scale2X.Font.Style = []
        Scale2X.Logarithmic = False
        Scale2X.LabelType = ftNum
        Scale2X.MinTicks = 3
        Scale2X.MinRange = 0.000000000100000000
        Scale2X.RangeHigh = 1.000000000000000000
        Scale2X.ShortTicks = True
        Scale2X.ScalePos = 0
        Scale2X.Visible = False
        Scale2X.ScaleLocation = slBottom
        Scale2Y.CaptionPosX = 10
        Scale2Y.CaptionPosY = 100
        Scale2Y.CaptionAlignment = taRightJustify
        Scale2Y.CaptionAnchor = uaSclTopLft
        Scale2Y.ColorScale = clMaroon
        Scale2Y.DateFormat.TimeFormat = tfHHMMSS
        Scale2Y.DateFormat.DateSeparator = '-'
        Scale2Y.DateFormat.TimeSeparator = ':'
        Scale2Y.DateFormat.YearLength = ylYYYY
        Scale2Y.DateFormat.MonthName = True
        Scale2Y.DateFormat.DateOrder = doDDMMYY
        Scale2Y.DateFormat.DateForTime = dtOnePerDay
        Scale2Y.DecPlaces = -2
        Scale2Y.Font.Charset = DEFAULT_CHARSET
        Scale2Y.Font.Color = clWindowText
        Scale2Y.Font.Height = -11
        Scale2Y.Font.Name = 'Tahoma'
        Scale2Y.Font.Style = []
        Scale2Y.Logarithmic = False
        Scale2Y.LabelType = ftNum
        Scale2Y.MinTicks = 3
        Scale2Y.MinRange = 0.000000000100000000
        Scale2Y.RangeHigh = 1.000000000000000000
        Scale2Y.ShortTicks = True
        Scale2Y.ScalePos = 0
        Scale2Y.Visible = False
        Scale2Y.ScaleLocation = slLeft
        ShadowStyle = ssFlying
        ShadowColor = clGrayText
        ShadowBakColor = clBtnFace
        TextFontStyle = []
        TextBkStyle = tbClear
        TextBkColor = clWhite
        TextAlignment = taCenter
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Settings'
      ImageIndex = 2
      object Label1: TLabel
        Left = 36
        Top = 84
        Width = 121
        Height = 13
        Caption = 'Select a font for the plots.'
      end
      object Label2: TLabel
        Left = 36
        Top = 108
        Width = 64
        Height = 13
        Caption = 'Current font : '
      end
      object font1: TLabel
        Left = 116
        Top = 108
        Width = 24
        Height = 13
        Caption = 'font1'
      end
      object fbox: TListBox
        Left = 24
        Top = 132
        Width = 189
        Height = 197
        ItemHeight = 13
        TabOrder = 0
        OnClick = fboxClick
      end
      object Greek: TCheckBox
        Left = 188
        Top = 28
        Width = 97
        Height = 17
        Caption = 'Greek Text'
        TabOrder = 1
        OnClick = GreekClick
      end
    end
  end
end
