unit uSettings;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvPanel, ExtCtrls, AdvStyleIF, AdvAppStyler, AdvCombo,
  AdvGroupBox, AdvOfficeButtons, uConfig, uCommonFuncs, Mask, AdvSpin, AdvOfficePager, AdvOfficePagerStylers,
  AdvGlowButton;

type
  TfmSettings = class(TForm)
    pnlStyler: TAdvPanelStyler;
    fmStyler: TAdvFormStyler;
    pgrSettings: TAdvOfficePager;
    pgApplication: TAdvOfficePage;
    pgSprites: TAdvOfficePage;
    pgStyler: TAdvOfficePagerOfficeStyler;
    pnlMain: TAdvPanel;
    grbImport: TAdvGroupBox;
    lblAllowedTypes: TLabel;
    chkPNG: TAdvOfficeCheckBox;
    chkBMP: TAdvOfficeCheckBox;
    chkJPG: TAdvOfficeCheckBox;
    chkPowerOf2: TAdvOfficeCheckBox;
    AdvGroupBox1: TAdvGroupBox;
    cbxStyle: TAdvComboBox;
    AdvGroupBox2: TAdvGroupBox;
    chkDeleting: TAdvOfficeCheckBox;
    chkAutoSave: TAdvOfficeCheckBox;
    seAutoSave: TAdvSpinEdit;
    AdvGroupBox3: TAdvGroupBox;
    lblDefaultSpriteCoords: TLabel;
    Label1: TLabel;
    txtXCoords: TAdvSpinEdit;
    txtYCoords: TAdvSpinEdit;
    btnOK: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
    Label2: TLabel;
    grbColSprites: TAdvGroupBox;
    cbxCSShape: TAdvComboBox;
    txtCSPoints: TAdvSpinEdit;
    txtCSHealth: TAdvSpinEdit;
    txtCSMoney: TAdvSpinEdit;
    grbEnemyFriend: TAdvGroupBox;
    txtEFHealthDrain: TAdvSpinEdit;
    txtEFHealthValue: TAdvSpinEdit;
    grbSpringBoard: TAdvGroupBox;
    txtSBSpringForce: TAdvSpinEdit;
    grbTeleport: TAdvGroupBox;
    txtTPXto: TAdvSpinEdit;
    txtTPYto: TAdvSpinEdit;
    procedure ComboBox1Select(Sender: TObject);
    procedure chkPNGClick(Sender: TObject);
    procedure chkPowerOf2Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure chkDeletingClick(Sender: TObject);
    procedure chkAutoSaveClick(Sender: TObject);
    procedure seAutoSaveChange(Sender: TObject);
    procedure txtXCoordsChange(Sender: TObject);
    procedure txtYCoordsChange(Sender: TObject);
    procedure cbxCSShapeSelect(Sender: TObject);
    procedure txtCSPointsChange(Sender: TObject);
    procedure txtCSHealthChange(Sender: TObject);
    procedure txtCSMoneyChange(Sender: TObject);
    procedure txtEFHealthDrainChange(Sender: TObject);
    procedure txtEFHealthValueChange(Sender: TObject);
    procedure txtSBSpringForceChange(Sender: TObject);
    procedure txtTPXtoChange(Sender: TObject);
    procedure txtTPYtoChange(Sender: TObject);
  private
    FStyler: TAdvAppStyler;
    FMyFormStyler: TAdvFormStyler;
    //FFileStr: string;
    FSettings: TSettings;
    function MakeAllowedFilesStr: string;
  public
    property MyAppStyler: TAdvAppStyler read FStyler write FStyler;
    property MyFormStyler: TAdvFormStyler read FMyFormStyler write FMyFormStyler;

    procedure Init(ASettings: TSettings);
  end;

var
  fmSettings: TfmSettings;

implementation

{$R *.dfm}

uses uMain;

procedure TfmSettings.Init(ASettings: TSettings);
var
  cnt: integer;
begin
  FSettings := ASettings;

  for cnt := 0 to FSettings.AllowedFiles.Count - 1 do
  begin
    if FSettings.AllowedFiles[cnt] = '.png' then
      chkPNG.Checked := True;
    if FSettings.AllowedFiles[cnt] = '.bmp' then
      chkBMP.Checked := True;
    if FSettings.AllowedFiles[cnt] = '.jpg' then
      chkJPG.Checked := True;
  end;

  chkPowerOf2.Checked := FSettings.AllowNonPowerOf2;
  chkDeleting.Checked := FSettings.WarnBeforeDelete;

  FSettings.AllowedFiles.DelimitedText := MakeAllowedFilesStr;
  seAutoSave.Enabled := FSettings.AutoSave;
  chkAutoSave.Checked := FSettings.AutoSave;

  cbxStyle.ItemIndex := ord(fmMain.appStyler.Style);

  fmStyler.Style := fmMain.appStyler.Style;
  pgStyler.Style := TOfficePagerStyle(ord(cbxStyle.ItemIndex));

  txtXCoords.Value := FSettings.NewSpriteX;
  txtYCoords.Value := FSettings.NewSpriteY;

  cbxCSShape.ItemIndex := FSettings.cs_shape;
  txtCSPoints.Value := FSettings.cs_points_value;
  txtCSHealth.Value := FSettings.cs_colhealth_value;
  txtCSMoney.Value := FSettings.cs_money_value;

  txtEFHealthDrain.Value := FSettings.es_health_value;
  txtEFHealthValue.Value := FSettings.fs_health_value;

  txtSBSpringForce.Value := FSettings.sb_springforce;

  txtTPXto.Value := FSettings.tp_Xto;
  txtTPYto.Value := FSettings.tp_Yto;
end;

function TfmSettings.MakeAllowedFilesStr: string;
var
  typelist: TStringList;
  cnt: Integer;
begin
  // rough and ready ... ugh
  Result := '';

  typelist := TStringList.Create;

  try
    if chkPNG.Checked then typelist.Add('.png');
    if chkBMP.Checked then typelist.Add('.bmp');
    if chkJPG.Checked then typelist.Add('.jpg');

    if typelist.Count > 1 then
    begin
      for cnt := 0 to typelist.Count - 1 do
        Result := Result + typelist[cnt] + '|';

      Result := Copy(Result, 1, Length(Result) - 1);
    end
    else
    begin
      if typelist.Count = 1 then
        Result := typelist[0]
      else
        Result := '';
    end;

  finally
    FreeAndNil(typelist);
  end;

end;

procedure TfmSettings.seAutoSaveChange(Sender: TObject);
begin
  FSettings.AutoSaveTime := seAutoSave.Value;
end;

procedure TfmSettings.txtCSHealthChange(Sender: TObject);
begin
  FSettings.cs_colhealth_value := txtCSHealth.Value;
end;

procedure TfmSettings.txtCSMoneyChange(Sender: TObject);
begin
  FSettings.cs_money_value := txtCSMoney.Value;
end;

procedure TfmSettings.txtCSPointsChange(Sender: TObject);
begin
  FSettings.cs_points_value := txtCSPoints.Value;
end;

procedure TfmSettings.txtEFHealthDrainChange(Sender: TObject);
begin
  FSettings.es_health_value := txtEFHealthDrain.Value;
end;

procedure TfmSettings.txtEFHealthValueChange(Sender: TObject);
begin
  FSettings.fs_health_value := txtEFHealthValue.Value;
end;

procedure TfmSettings.txtSBSpringForceChange(Sender: TObject);
begin
  FSettings.sb_springforce := txtSBSpringForce.Value;
end;

procedure TfmSettings.txtTPXtoChange(Sender: TObject);
begin
  FSettings.tp_Xto := txtTPXto.Value;
end;

procedure TfmSettings.txtTPYtoChange(Sender: TObject);
begin
  FSettings.tp_Yto := txtTPYto.Value;
end;

procedure TfmSettings.txtXCoordsChange(Sender: TObject);
begin
  FSettings.NewSpriteX := txtXCoords.Value;
end;

procedure TfmSettings.txtYCoordsChange(Sender: TObject);
begin
  FSettings.NewSpriteY := txtYCoords.Value;
end;

procedure TfmSettings.btnOKClick(Sender: TObject);
begin
  if FSettings.AllowedFiles.Text = '' then
  begin
    ShowMapMsg(self, STR_ERROR, STR_NOIMP_CHOOSE, STR_NEEDPICK_IMPTYPE, '', 'OK', '');
    Exit;
  end;

  ModalResult := mrOK;

end;

procedure TfmSettings.cbxCSShapeSelect(Sender: TObject);
begin
  FSettings.cs_shape := cbxCSShape.ItemIndex;
end;

procedure TfmSettings.chkAutoSaveClick(Sender: TObject);
begin
  FSettings.AutoSave := chkAutoSave.Checked;
  seAutoSave.Enabled := chkAutoSave.Checked;
end;

procedure TfmSettings.chkDeletingClick(Sender: TObject);
begin
  FSettings.WarnBeforeDelete := chkDeleting.Checked;
end;

procedure TfmSettings.chkPNGClick(Sender: TObject);
begin
  FSettings.AllowedFiles.DelimitedText := MakeAllowedFilesStr;
end;

procedure TfmSettings.chkPowerOf2Click(Sender: TObject);
begin
  FSettings.AllowNonPowerOf2 := chkPowerOf2.Checked;
end;

procedure TfmSettings.ComboBox1Select(Sender: TObject);
var
  AStyle: TTMSStyle;
begin
  AStyle := MyAppStyler.Style;

  case cbxStyle.ItemIndex of
    0: AStyle := tsOffice2003Blue;
    1: Astyle := tsOffice2003Silver;
    2: AStyle := tsOffice2003Olive;
    3: Astyle := tsOffice2003Classic;
    4: AStyle := tsOffice2007Luna;
    5: AStyle := tsOffice2007Obsidian;
    6: AStyle := tsWindowsXP;
    7: AStyle := tsWhidbey;
    8: AStyle := tsCustom;
    9: AStyle := tsOffice2007Silver;
    10: AStyle := tsWindowsVista;
    11: AStyle := tsWindows7;
    12: AStyle := tsTerminal;
    13: AStyle := tsOffice2010Blue;
    14: AStyle := tsOffice2010Silver;
    15: AStyle := tsOffice2010Black;
  end;

  MyAppStyler.Style := AStyle;
  MyFormStyler.Style := AStyle;
  fmStyler.Style := AStyle;
  pgStyler.Style  := TOfficePagerStyle(ord(AStyle));
end;

end.
