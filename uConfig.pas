unit uConfig;

interface

uses Controls, Classes, Windows, Forms, StdCtrls, ExtCtrls, IniFiles,
  SysUtils, AdvStyleIF;

type
  TAllowedFileTypes = (aftUnknown, aftPNG, aftBMP, aftJPG);

  TSettings = class(Tpersistent)
  private
    FAllowedFiles: TStringList;
    FAllowNonPowerOf2: boolean;
    FWarnBeforeDelete: boolean;
    FAutoSave: boolean;
    FAutoSaveTime: integer;
    FStyle: integer;
    FNewSpriteX: integer;
    FNewSpriteY: integer;
    Fmg_physics: integer;
    Fmg_shape: integer;
    Fcs_shape: integer;
    Fcs_points_value: integer;
    Fcs_colhealth_value: integer;
    Fcs_money_value: integer;
    Fes_health_value: integer;
    Ffs_health_value: integer;
    Fsb_springforce: integer;
    Ftp_Xto: integer;
    Ftp_Yto: integer;
    FShowButtonCaptions: boolean;
    FRecentItemsMax: integer;

  public
    property AllowedFiles: TStringList read FAllowedFiles write FAllowedFiles;
    property AllowNonPowerOf2: boolean read FAllowNonPowerOf2 write FAllowNonPowerOf2;
    property WarnBeforeDelete: boolean read FWarnBeforeDelete write FWarnBeforeDelete;
    property AutoSave: boolean read FAutoSave write FAutoSave;
    property AutoSaveTime: integer read FAutoSaveTime write FAutoSaveTime;
    property Style: integer read FStyle write FStyle;
    property NewSpriteX: integer read FNewSpriteX write FNewSpriteX;
    property NewSpriteY: integer read FNewSpriteY write FNewSpriteY;

    property ShowButtonCaptions: boolean read FShowButtonCaptions write FShowButtonCaptions;

    // map geometry sprite creation defaults
    property mg_physics: integer read Fmg_physics write Fmg_physics;
    property mg_shape: integer read Fmg_shape write Fmg_shape;

    // collectable sprite creation defaults
    property cs_shape: integer read Fcs_shape write Fcs_shape;
    property cs_points_value: integer read Fcs_points_value write Fcs_points_value;
    property cs_colhealth_value: integer read Fcs_colhealth_value write Fcs_colhealth_value;
    property cs_money_value: integer read Fcs_money_value write Fcs_money_value;

    // enemy sprite defaults
    property es_health_value: integer read Fes_health_value write Fes_health_value;

    // friendly sprite defaults
    property fs_health_value: integer read Ffs_health_value write Ffs_health_value;

    // moving platform sprite defaults

    // springboard sprite defaults
    property sb_springforce: integer read Fsb_springforce write Fsb_springforce;

    // teleporter sprite defaults
    property tp_Xto: integer read Ftp_Xto write Ftp_Xto;
    property tp_Yto: integer read Ftp_Yto write Ftp_Yto;

    // recent opened items
    property RecentItemsMax: integer read FRecentItemsMax write FRecentItemsMax;

    constructor Create;
    destructor Destroy; override;

    procedure ReadFromIni(Sender: TForm);
    procedure WriteToIni(Sender: TForm);
    function AllowedFileTypesToStr(AExt: string): TAllowedFileTypes;
  end;


implementation
{$WARN SYMBOL_PLATFORM OFF}

uses uMain;

function TSettings.AllowedFileTypesToStr(AExt: string): TAllowedFileTypes;
begin
  // aftUnknown, aftPNG, aftBMP, aftJPG
  Result := aftUnknown;

  if UpperCase(AExt) = UpperCase('.png') then
    Result := aftPNG;

  if UpperCase(AExt) = UpperCase('.bmp') then
    Result := aftBMP;

  if UpperCase(AExt) = UpperCase('.jpg') then
    Result := aftJPG;
end;

constructor TSettings.Create;
begin
  FAllowedFiles := TStringList.Create;
  FAllowedFiles.Delimiter := '|';
  FAllowedFiles.StrictDelimiter := True;
end;

destructor TSettings.Destroy;
begin
  FreeAndNil(FAllowedFiles);
  inherited;
end;

procedure TSettings.ReadFromIni(Sender: TForm);
var
  MyIni: TIniFile;
  lPath: string;
begin
  lPath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  MyIni := TIniFile.Create(lPath + 'config.cfg');
  try
    Sender.Top := MyIni.ReadInteger('MainForm', 'Top', 0);
    Sender.Left := MyIni.ReadInteger('MainForm', 'Left', 0);
    TfmMain(Sender).appStyler.Style := TTMSStyle(MyIni.ReadInteger('MainForm', 'Style', 0));
    TfmMain(Sender).fmStyler.Style := TTMSStyle(MyIni.ReadInteger('MainForm', 'Style', 0));
    TfmMain(Sender).GridLineColor := MyIni.ReadInteger('Grid', 'LineColor', 4802889);

    FShowButtonCaptions := MyIni.ReadBool('MainForm', 'ShowButtonCaptions', False);

    FAllowedFiles.DelimitedText := MyIni.ReadString('Import', 'AllowedTypes', '');
    FAllowNonPowerOf2 := MyIni.ReadBool('Import', 'AllowNonPower', False);

    FWarnBeforeDelete := MyIni.ReadBool('Warnings', 'WarnDelete', False);

    FAutoSave := MyIni.ReadBool('AutoSave', 'AutoSave', False);
    FAutoSaveTime := MyIni.ReadInteger('AutoSave', 'AutoSaveTime', 5);

    FNewSpriteX := MyIni.ReadInteger('Sprites', 'NewSpriteX', 20);
    FNewSpriteY := MyIni.ReadInteger('Sprites', 'NewSpriteY', 20);

    Fcs_shape := MyIni.ReadInteger('SpriteDefaults', 'CSSHAPE', 3);
    Fcs_points_value := MyIni.ReadInteger('SpriteDefaults', 'CSPOINTSVAL', 25);
    Fcs_colhealth_value := MyIni.ReadInteger('SpriteDefaults', 'CSHEALTHVAL', 25);
    Fcs_money_value := MyIni.ReadInteger('SpriteDefaults', 'CSMONEYVAL', 10);

    Fes_health_value := MyIni.ReadInteger('SpriteDefaults', 'ESHEALTHVAL', 2);

    Ffs_health_value := MyIni.ReadInteger('SpriteDefaults', 'FSHEALTHVAL', 50);

    Fsb_springforce := MyIni.ReadInteger('SpriteDefaults', 'SBFORCE', 75);

    Ftp_Xto := MyIni.ReadInteger('SpriteDefaults', 'TPXTO', 568);
    Ftp_Yto := MyIni.ReadInteger('SpriteDefaults', 'TPYTO', 320);

    FRecentItemsMax := MyIni.ReadInteger('RecentItemsMax', 'MAX', 5);

  finally
    FreeAndNil(MyIni);
  end;
end;

procedure TSettings.WriteToIni(Sender: TForm);
var
  MyIni: TIniFile;
  lPath: string;
begin
  lPath := IncludeTrailingBackSlash(ExtractFilePath(Application.ExeName));
  MyIni := TIniFile.Create(lPath + 'config.cfg');
  try
    MyIni.WriteInteger('MainForm', 'Top', Sender.Top);
    MyIni.WriteInteger('MainForm', 'Left', Sender.Left);
    MyIni.WriteInteger('MainForm', 'Style', ord(TfmMain(Sender).appStyler.Style));
    MyIni.WriteBool('MainForm', 'ShowButtonCaptions', FShowButtonCaptions);
    MyIni.WriteInteger('Grid', 'LineColor', TfmMain(Sender).GridLineColor);

    MyIni.WriteString('Import', 'AllowedTypes', FAllowedFiles.DelimitedText);
    MyIni.WriteBool('Import', 'AllowNonPower', FAllowNonPowerOf2);

    MyIni.WriteBool('Warnings', 'WarnDelete', FWarnBeforeDelete);

    MyIni.WriteBool('AutoSave', 'AutoSave', FAutoSave);
    MyIni.WriteInteger('AutoSave', 'AutoSaveTime', FAutoSaveTime);

    MyIni.WriteInteger('Sprites', 'NewSpriteX', FNewSpriteX);
    MyIni.WriteInteger('Sprites', 'NewSpriteY', FNewSpriteY);

    MyIni.WriteInteger('SpriteDefaults', 'CSSHAPE', Fcs_shape);
    MyIni.WriteInteger('SpriteDefaults', 'CSPOINTSVAL', Fcs_points_value);
    MyIni.WriteInteger('SpriteDefaults', 'CSHEALTHVAL', Fcs_colhealth_value);
    MyIni.WriteInteger('SpriteDefaults', 'CSMONEYVAL', Fcs_money_value);

    MyIni.WriteInteger('SpriteDefaults', 'ESHEALTHVAL', Fes_health_value);

    MyIni.WriteInteger('SpriteDefaults', 'FSHEALTHVAL', Ffs_health_value);

    MyIni.WriteInteger('SpriteDefaults', 'SBFORCE', Fsb_springforce);

    MyIni.WriteInteger('SpriteDefaults', 'TPXTO', Ftp_Xto);
    MyIni.WriteInteger('SpriteDefaults', 'TPYTO', Ftp_Yto);

    MyIni.WriteInteger('RecentItemsMax', 'MAX', FRecentItemsMax);

  finally
    FreeAndNil(MyIni);
  end;
end;

end.
