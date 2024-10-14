object fmLayerDelete: TfmLayerDelete
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Delete Layer'
  ClientHeight = 246
  ClientWidth = 449
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
  object AdvPanel1: TAdvPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 187
    Align = alTop
    BevelOuter = bvNone
    Color = 13616833
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
    Caption.Color = 12105910
    Caption.ColorTo = 10526878
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = clWhite
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = 12958644
    ColorMirror = 12958644
    ColorMirrorTo = 15527141
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = clWhite
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 10592158
    StatusBar.ColorTo = 5459275
    StatusBar.GradientDirection = gdVertical
    FullHeight = 200
    object Label1: TLabel
      Left = 32
      Top = 14
      Width = 132
      Height = 13
      Caption = 'Options For Deleting Layer:'
    end
    object lblLayerToDelete: TLabel
      Left = 170
      Top = 14
      Width = 87
      Height = 13
      Caption = 'LAYER TO DELETE'
    end
    object rbMoveSpriteDeleteLayer: TAdvOfficeRadioButton
      Left = 32
      Top = 46
      Width = 247
      Height = 20
      TabOrder = 0
      TabStop = True
      OnClick = rbMoveSpriteDeleteLayerClick
      Alignment = taLeftJustify
      Caption = 'Move Sprites To A New Layer Before Deleting'
      Checked = True
      ReturnIsTab = False
      Version = '1.3.5.1'
    end
    object rbDeleteLayerAndSprites: TAdvOfficeRadioButton
      Left = 32
      Top = 150
      Width = 239
      Height = 20
      TabOrder = 1
      OnClick = rbMoveSpriteDeleteLayerClick
      Alignment = taLeftJustify
      Caption = 'Just Delete The Layer And Associated Sprites'
      ReturnIsTab = False
      Version = '1.3.5.1'
    end
    object grbMoveSprites: TAdvGroupBox
      Left = 32
      Top = 72
      Width = 391
      Height = 61
      TabOrder = 2
      object cbxLayer: TAdvComboBox
        Left = 11
        Top = 22
        Width = 242
        Height = 22
        Hint = 
          '<B>Create Sprite In Layer</B><hr><BR>Select a layer for sprites ' +
          'to be created in<BR>'
        Color = clWindow
        Version = '1.4.3.0'
        Visible = True
        Style = csDropDownList
        DropDownCount = 12
        DropWidth = 0
        Enabled = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = 7485192
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = -1
        Items.Strings = (
          '1000-Default')
        LabelCaption = 'Move Sprites To:'
        LabelPosition = lpTopLeft
        LabelTransparent = True
        LabelFont.Charset = DEFAULT_CHARSET
        LabelFont.Color = clWindowText
        LabelFont.Height = -11
        LabelFont.Name = 'Tahoma'
        LabelFont.Style = []
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 0
        OnSelect = cbxLayerSelect
      end
    end
  end
  object btnOK: TButton
    Left = 279
    Top = 206
    Width = 75
    Height = 25
    Caption = 'OK'
    TabOrder = 1
    OnClick = btnOKClick
  end
  object btnCancel: TButton
    Left = 360
    Top = 206
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 2
  end
end
