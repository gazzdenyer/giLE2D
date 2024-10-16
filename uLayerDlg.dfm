object fmLayerDlg: TfmLayerDlg
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Layer'
  ClientHeight = 143
  ClientWidth = 397
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object pnlLayer: TAdvPanel
    Left = 0
    Top = 0
    Width = 397
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Color = 16645114
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    UseDockManager = True
    Version = '2.1.2.0'
    BorderColor = 16765615
    Caption.Color = 16575452
    Caption.ColorTo = 16571329
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clBlack
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = 16643051
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = 13542013
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 7485192
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 16575452
    StatusBar.ColorTo = 16571329
    StatusBar.GradientDirection = gdVertical
    Styler = fmMain.pnlStyler
    ExplicitWidth = 804
    FullHeight = 200
    object txtLayerName: TAdvEdit
      Left = 32
      Top = 30
      Width = 301
      Height = 21
      EmptyTextStyle = []
      LabelCaption = 'Layer Name'
      LabelPosition = lpTopLeft
      LabelTransparent = True
      LabelFont.Charset = DEFAULT_CHARSET
      LabelFont.Color = clWindowText
      LabelFont.Height = -11
      LabelFont.Name = 'Tahoma'
      LabelFont.Style = []
      Lookup.Separator = ';'
      Color = clWindow
      TabOrder = 0
      Visible = True
      Version = '3.0.1.0'
    end
  end
  object AdvGlowButton1: TAdvGlowButton
    Left = 232
    Top = 96
    Width = 71
    Height = 31
    Caption = 'OK'
    Font.Charset = ANSI_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageIndex = 6
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    Spacing = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    OnClick = btnOKClick
    Appearance.BorderColor = 13542013
    Appearance.BorderColorHot = 16504504
    Appearance.BorderColorDown = 13542013
    Appearance.BorderColorChecked = clHighlight
    Appearance.Color = 16575452
    Appearance.ColorTo = 16571329
    Appearance.ColorChecked = 16645114
    Appearance.ColorCheckedTo = 16643051
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16575452
    Appearance.ColorDownTo = 16571329
    Appearance.ColorHot = 16645114
    Appearance.ColorHotTo = 16643051
    Appearance.ColorMirror = 16571329
    Appearance.ColorMirrorTo = 16571329
    Appearance.ColorMirrorHot = 16643051
    Appearance.ColorMirrorHotTo = 16645114
    Appearance.ColorMirrorDown = 16571329
    Appearance.ColorMirrorDownTo = 16575452
    Appearance.ColorMirrorChecked = 16575452
    Appearance.ColorMirrorCheckedTo = 16575452
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
    Appearance.GradientHot = ggVertical
    Appearance.GradientMirrorHot = ggVertical
    Appearance.GradientDown = ggVertical
    Appearance.GradientMirrorDown = ggVertical
    Appearance.GradientChecked = ggVertical
  end
  object AdvGlowButton2: TAdvGlowButton
    Left = 309
    Top = 96
    Width = 71
    Height = 31
    Caption = 'Cancel'
    Font.Charset = ANSI_CHARSET
    Font.Color = 7485192
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ImageIndex = 6
    ModalResult = 2
    NotesFont.Charset = DEFAULT_CHARSET
    NotesFont.Color = clWindowText
    NotesFont.Height = -11
    NotesFont.Name = 'Tahoma'
    NotesFont.Style = []
    ParentFont = False
    Spacing = 1
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
    Appearance.BorderColor = 13542013
    Appearance.BorderColorHot = 16504504
    Appearance.BorderColorDown = 13542013
    Appearance.BorderColorChecked = clHighlight
    Appearance.Color = 16575452
    Appearance.ColorTo = 16571329
    Appearance.ColorChecked = 16645114
    Appearance.ColorCheckedTo = 16643051
    Appearance.ColorDisabled = 15921906
    Appearance.ColorDisabledTo = 15921906
    Appearance.ColorDown = 16575452
    Appearance.ColorDownTo = 16571329
    Appearance.ColorHot = 16645114
    Appearance.ColorHotTo = 16643051
    Appearance.ColorMirror = 16571329
    Appearance.ColorMirrorTo = 16571329
    Appearance.ColorMirrorHot = 16643051
    Appearance.ColorMirrorHotTo = 16645114
    Appearance.ColorMirrorDown = 16571329
    Appearance.ColorMirrorDownTo = 16575452
    Appearance.ColorMirrorChecked = 16575452
    Appearance.ColorMirrorCheckedTo = 16575452
    Appearance.ColorMirrorDisabled = 11974326
    Appearance.ColorMirrorDisabledTo = 15921906
    Appearance.GradientHot = ggVertical
    Appearance.GradientMirrorHot = ggVertical
    Appearance.GradientDown = ggVertical
    Appearance.GradientMirrorDown = ggVertical
    Appearance.GradientChecked = ggVertical
  end
  object AdvFormStyler1: TAdvFormStyler
    Style = tsWindows7
    AppStyle = fmMain.appStyler
    Left = 122
    Top = 98
  end
end
