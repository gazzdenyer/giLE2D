unit uSpriteBlock;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Grids, AdvObj, BaseGrid, AdvGrid, AdvGlowButton, Dialogs,
  Forms, uConfig;

type
  TSpriteBlock = class(TAdvGlowButton)
  private
    FFileID: Integer;
    FXcoord: integer;
    Fphysics: integer;
    FYcoord: integer;
    FXsize: integer;
    FYsize: integer;
    FXoffset: integer;
    FYoffset: integer;
    FIsCollectable: integer;
    Fshape: integer;
    FIsExplodable: integer;
    FPointsValue: integer;
    FIsEnemy: integer;
    FIsMapGeometry: integer;
    FHealthValue: integer;
    FIsFriend: integer;
    FIsMovingPlatform: integer;
    FpXmoveFrom: integer;
    FpYmoveFrom: integer;
    FpXmoveTo: integer;
    FpYmoveTo: integer;
    FpVelocity: integer;
    FColHealthValue: integer;
    FMoneyValue: integer;
    FIsSpringboard: integer;
    FSpringForce: integer;
    FIsTeleporter: integer;
    FTeleportX: integer;
    FTeleportY: integer;
    FPlayerStartMarker: integer;
    FFileName: string;
    FLayer: integer;
    FIntTag: integer;

  public
    procedure Copy(Source: TPersistent);

    // TODO - add this when loading or saving a file !!!
    property FileName: string read FFileName write FFileName;

  published
    property Layer: integer read FLayer write FLayer;

    property FileID: integer read FFileID write FFileID;
    property Xcoord: integer read FXcoord write FXcoord;
    property Ycoord: integer read FYcoord write FYcoord;
    property Xsize: integer read FXsize write FXsize;
    property Ysize: integer read FYsize write FYsize;
    property Xoffset: integer read FXoffset write FXoffset;
    property Yoffset: integer read FYoffset write FYoffset;
    property physics: integer read Fphysics write Fphysics;

    // The shape to use for this sprite, 0=no shape, 1=circle, 2=box, 3=polygon
    property shape: integer read Fshape write Fshape;

    property IsMapGeometry: integer read FIsMapGeometry write FIsMapGeometry;
    property IsExplodable: integer read FIsExplodable write FIsExplodable;
    property IsCollectable: integer read FIsCollectable write FIsCollectable;
    property PointsValue: integer read FPointsValue write FPointsValue;
    property ColHealthValue: integer read FColHealthValue write FColHealthValue;
    property MoneyValue: integer read FMoneyValue write FMoneyValue;
    property IsEnemy: integer read FIsEnemy write FIsEnemy;
    property IsFriend: integer read FIsFriend write FIsFriend;
    property HealthValue: integer read FHealthValue write FHealthValue;

    property IsMovingPlatform: integer read FIsMovingPlatform write FIsMovingPlatform;
    property pXmoveFrom: integer read FpXmoveFrom write FpXmoveFrom;
    property pXmoveTo: integer read FpXmoveTo write FpXmoveTo;
    property pYmoveFrom: integer read FpYmoveFrom write FpYmoveFrom;
    property pYmoveTo: integer read FpYmoveTo write FpYmoveTo;
    property pVelocity: integer read FpVelocity write FpVelocity;

    property IsSpringboard: integer read FIsSpringboard write FIsSpringboard;
    property SpringForce: integer read FSpringForce write FSpringForce;

    property IsTeleporter: integer read FIsTeleporter write FIsTeleporter;
    property TeleportX: integer read FTeleportX write FTeleportX;
    property TeleportY: integer read FTeleportY write FTeleportY;

    property PlayerStartMarker: integer read FPlayerStartMarker write FPlayerStartMarker;

    property IntTag: integer read FIntTag write FIntTag;

    function CreateFromString(AString: string): TSpriteBlock;
  end;


  TGazzMap = class(TPersistent)
  private
//    FMapBackground: integer;

  public
//    property MapBackground: integer read FMapBackground write FMapBackground;
    class procedure CreateFileContents(AForm: TForm; AParamList, AMapBG: TStringList;
      AIsScroller, ARepeater: integer);

    class function MakeParamLine(ASprite: TSpriteBlock): string;
    procedure WriteFile(AForm: TForm; AFileName: string; AMapBG: TStringList;
      AScroller, ARepeater: integer);//; AMapList: TStringList);
    procedure ReadFile(AFileName: string; AParamList: TStringList);

    function MakeBGFileNameAndScroller(AFileID: string; var AScroller: integer;
      var ARepeater: integer; AMapBGList: TStringList): string;

  end;

  const
    ST_None = 0;
    ST_Map_Geometry = 1;
    ST_Collectable_Item = 2;
    ST_Scenery_Block = 3;
    ST_Enemy_Entity = 4;
    ST_Friendly_Entity = 5;
    ST_Moving_Platform = 6;
    ST_Springboard = 7;
    ST_Teleporter = 8;
    ST_PlayerStart = 9;
    ST_IntTag = 10;

  procedure SetDefaultSpriteProperties(ASprite: TSpriteBlock; AType: integer; ASettings: TSettings);

implementation

uses uCommonFuncs;

procedure SetDefaultSpriteProperties(ASprite: TSpriteBlock; AType: integer; ASettings: TSettings);
begin
  // TODO: These values will change when I implement custom map and sprite sizes

  ASprite.Xcoord := ASettings.NewSpriteX;
  ASprite.Ycoord := ASettings.NewSpriteY;
  ASprite.Top := ASprite.Xcoord;
  ASprite.Left := ASprite.Ycoord;
  ASprite.IntTag := 0;

  case AType of
    ST_None: // default generic sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 1;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsCollectable := 0;
        ASprite.IsEnemy := 0;
      end;

    ST_Map_Geometry: // default map geometry sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 1;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 1;
        ASprite.IsCollectable := 0;
        ASprite.IsEnemy := 0;
      end;

    ST_Collectable_Item: // default collectable sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := 32;
        ASprite.Ysize := 32;
        ASprite.width := 32;
        ASprite.height := 32;
        ASprite.physics := 0;
        ASprite.shape := ASettings.cs_shape; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 1;
        ASprite.PointsValue := ASettings.cs_points_value;
        ASprite.IsEnemy := 0;
        ASprite.ColHealthValue := ASettings.cs_colhealth_value;
        ASprite.MoneyValue := ASettings.cs_money_value;
      end;

    ST_Scenery_Block: // default scenery sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 0;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsEnemy := 0;
      end;

    ST_Enemy_Entity: // default Enemy sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 1;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsEnemy := 1;
        ASprite.HealthValue := ASettings.es_health_value; // take 2 healthpoints off player by default
      end;

    ST_Friendly_Entity: // default Friend sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 1;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsFriend := 1;
        ASprite.HealthValue := ASettings.fs_health_value; // Friends have 50 healthpoints by default
      end;

    ST_Moving_Platform: // moving platform sprite
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := ASprite.Width;
        ASprite.Ysize := ASprite.Height;
        ASprite.physics := 3;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsEnemy := 0;
        // default the moving platform with an up-down motion of differential 100
        ASprite.IsMovingPlatform := 1;
        ASprite.pXmoveFrom := 0;
        ASprite.pXmoveTo := 0;
        ASprite.pYmoveFrom := Asprite.Top;
        ASprite.pYmoveTo := Asprite.Top - 100;
        ASprite.pVelocity := 40;
      end;

    ST_Springboard: // springboard
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := 64;
        ASprite.Ysize := 64;
        ASprite.width := 64;
        ASprite.height := 64;
        ASprite.physics := 1;
        ASprite.shape := 3; // needs to be a poly - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsSpringboard := 1;
        ASprite.SpringForce := ASettings.sb_springforce;  // default spring force
      end;

    ST_Teleporter:
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := 64;
        ASprite.Ysize := 64;
        ASprite.width := 64;
        ASprite.height := 64;
        ASprite.physics := 0;
        ASprite.shape := 2; // defaults to box collider - see TSpriteBlock.shape property
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.IsTeleporter := 1;
        ASprite.TeleportX := ASettings.tp_Xto;
        ASprite.TeleportY := ASettings.tp_Yto;
      end;

    ST_PlayerStart:
      begin
        ASprite.Xoffset := 0;
        ASprite.Yoffset := 0;
        ASprite.Xsize := 64;
        ASprite.Ysize := 64;
        ASprite.width := 64;
        ASprite.height := 64;
        ASprite.physics := 0;
        ASprite.shape := 0;
        ASprite.IsMapGeometry := 0;
        ASprite.IsCollectable := 0;
        ASprite.PlayerStartMarker := 1;
      end;
  end;
end;


{ TGazzMap }

class procedure TGazzMap.CreateFileContents(AForm: TForm; AParamList, AMapBG: TStringList;
  AIsScroller, ARepeater: integer);
var
//  c, r: integer;
  idx: integer;
  lsprite: TSpriteBlock;
  sParamLine: string;
begin
  AParamList.Clear;

  if AIsScroller = 0 then
  begin
    AParamList.Add('0|99999|' + AMapBG[0] + '|' + AMapBG[0] + '|0|0|0|0|' +
      inttostr(AIsScroller) + '|' + inttostr(ARepeater) + '|0|0|0');
  end
  else
  begin
    AParamList.Add('0|99999|' + AMapBG[0] + '|' + AMapBG[0] + '|' + AMapBG[1] + '|' +
      AMapBG[2] + '|' + AMapBG[3] + '|0' +
      '|' + inttostr(AIsScroller) + '|' + inttostr(ARepeater) + '|0|0|0');
  end;

  for idx := 0 to AForm.ComponentCount - 1 do //fmMain.ControlCount do
  begin
    if AForm.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(AForm.Components[idx]);
      sParamLine := MakeParamLine(lsprite);
      AParamList.Add(sParamLine);
    end;
  end;

  AParamList.Add('EOF');
end;

function TGazzMap.MakeBGFileNameAndScroller(AFileID: string; var AScroller: integer;
  var ARepeater: integer; AMapBGList: TStringList): string;
var
  FList: TStringList;
  //FFile: string;
begin
  FList := TStringList.Create;

  try
    FList.Delimiter := '|';
    FList.StrictDelimiter := True;
    FList.DelimitedText := AFileID;

    AMapBGList.Clear;

    AMapBGList.Add(Flist[2]);
    AMapBGList.Add(Flist[4]);
    AMapBGList.Add(Flist[5]);
    AMapBGList.Add(Flist[6]);


    AScroller := strtoint(FList[8]);
    ARepeater := strtoint(FList[9]);

    Result := AMapBGList[0];

  finally
    FreeAndNil(FList);
  end;

end;

class function TGazzMap.MakeParamLine(ASprite: TSpriteBlock): string;
begin
  if ASprite.IsMapGeometry = 1 then
  begin
    ASprite.IsExplodable := 0;
    ASprite.IsCollectable := 0;
    ASprite.PointsValue := 0;
    ASprite.IsEnemy := 0;
    ASprite.IsFriend := 0;
    ASprite.HealthValue := 0;
  end;

  ASprite.Xcoord := ASprite.Left;
  ASprite.Ycoord := ASprite.Top;

  Result :=
    inttostr(ASprite.Layer) + '|' +

    inttostr(ASprite.FileID) + '|' +
    ASprite.FileName + '|' +  //FileExtension;
    inttostr(ASprite.Xcoord) + '|' +
    inttostr(ASprite.Ycoord) + '|' +
    inttostr(ASprite.Xsize) + '|' +
    inttostr(ASprite.Ysize) + '|' +
    inttostr(ASprite.Xoffset) + '|' +
    inttostr(ASprite.Yoffset) + '|' +
    inttostr(ASprite.physics) + '|' +
    inttostr(ASprite.shape) + '|' +
    inttostr(ASprite.IsMapGeometry) + '|' +
    inttostr(ASprite.IsExplodable) + '|' +
    inttostr(ASprite.IsCollectable) + '|' +
    inttostr(ASprite.PointsValue) + '|' +
    inttostr(ASprite.IsEnemy) + '|' +
    inttostr(ASprite.IsFriend) + '|' +
    inttostr(ASprite.HealthValue) + '|' +
    inttostr(ASprite.IsMovingPlatform) + '|' +
    inttostr(ASprite.pXmoveFrom) + '|' +
    inttostr(ASprite.pXmoveTo) + '|' +
    inttostr(ASprite.pYmoveFrom) + '|' +
    inttostr(ASprite.pYmoveTo) + '|' +
    inttostr(ASprite.pVelocity) + '|' +
    inttostr(ASprite.ColHealthValue) + '|' +
    inttostr(ASprite.MoneyValue) + '|' +
    inttostr(ASprite.IsSpringboard) + '|' +
    inttostr(ASprite.SpringForce) + '|' +
    inttostr(ASprite.IsTeleporter) + '|' +
    inttostr(ASprite.TeleportX) + '|' +
    inttostr(ASprite.TeleportY) + '|' +
    inttostr(ASprite.PlayerStartMarker) + '|' +
    inttostr(ASprite.IntTag);
end;

procedure TGazzMap.ReadFile(AFileName: string; AParamList: TStringList);
begin
  AParamList.LoadFromFile(AFileName);

end;

procedure TGazzMap.WriteFile(AForm: TForm; AFileName: string; AMapBG: TStringList;
  AScroller, ARepeater: integer);//; AMapList: TStringList);
var
  AList: TStringList;
begin
  AList := TStringList.Create;
  try
    CreateFileContents(AForm, AList, AMapBG, AScroller, ARepeater);
    AList.Sorted := True;
    AList.SaveToFile(AFileName);  //  + '.txt'
  finally
    FreeAndNil(AList);
  end;
//  AMapList.Clear;
//  CreateFileContents(AForm, AMapList);
//  AMapList.SaveToFile(AFileName);  //  + '.txt'
end;

{ TSpriteBlock }

procedure TSpriteBlock.Copy(Source: TPersistent);
begin
  if (Source is TSpriteBlock) then   // TAdvCustomGlowButton
  begin
    Cursor := crHandPoint;
    Picture.Assign((Source as TSpriteBlock).Picture);
    Transparent := (Source as TSpriteBlock).Transparent;
    Visible := (Source as TSpriteBlock).Visible;
    Width := (Source as TSpriteBlock).Width;
    Height := (Source as TSpriteBlock).Height;
    Left := (Source as TSpriteBlock).Left;
    Top := (Source as TSpriteBlock).Top;

    Layer := (Source as TSpriteBlock).Layer;

    FileName  := (Source as TSpriteBlock).FileName;
    FileID := (Source as TSpriteBlock).FileID;
    Xsize := (Source as TSpriteBlock).Xsize;
    Ysize := (Source as TSpriteBlock).Ysize;
    Xoffset := (Source as TSpriteBlock).Xoffset;
    Yoffset := (Source as TSpriteBlock).Yoffset;
    physics := (Source as TSpriteBlock).physics;
    shape := (Source as TSpriteBlock).shape;

    IsMapGeometry := (Source as TSpriteBlock).IsMapGeometry;
    IsExplodable := (Source as TSpriteBlock).IsExplodable;
    IsCollectable := (Source as TSpriteBlock).IsCollectable;
    PointsValue := (Source as TSpriteBlock).PointsValue;
    ColHealthValue := (Source as TSpriteBlock).ColHealthValue;
    MoneyValue := (Source as TSpriteBlock).MoneyValue;
    IsEnemy := (Source as TSpriteBlock).IsEnemy;
    IsFriend := (Source as TSpriteBlock).IsFriend;
    HealthValue := (Source as TSpriteBlock).HealthValue;

    IsMovingPlatform := (Source as TSpriteBlock).IsMovingPlatform;
    pXmoveFrom := (Source as TSpriteBlock).pXmoveFrom;
    pXmoveTo := (Source as TSpriteBlock).pXmoveTo;
    pYmoveFrom := (Source as TSpriteBlock).pYmoveFrom;
    pYmoveTo := (Source as TSpriteBlock).pYmoveTo;
    pVelocity := (Source as TSpriteBlock).pVelocity;

    IsSpringboard := (Source as TSpriteBlock).IsSpringboard;
    SpringForce := (Source as TSpriteBlock).SpringForce;

    IsTeleporter := (Source as TSpriteBlock).IsTeleporter;
    TeleportX := (Source as TSpriteBlock).TeleportX;
    TeleportY := (Source as TSpriteBlock).TeleportY;

    PlayerStartMarker := (Source as TSpriteBlock).PlayerStartMarker;
  end;
end;

function TSpriteBlock.CreateFromString(AString: string): TSpriteBlock;
var
  AParams: TstringList;
begin
  AParams := TStringList.Create;

  try
    AParams.Delimiter := '|';
    AParams.StrictDelimiter := True;
    AParams.DelimitedText := AString;

    FLayer := strtoint(Aparams[0]);
    // change the index values !!!
    FFileID := strtoint(Aparams[1]);
    FFileName := Aparams[2];
    FXcoord := strtoint(Aparams[3]);
    FYcoord := strtoint(Aparams[4]);
    FXsize := strtoint(Aparams[5]);
    FYsize := strtoint(Aparams[6]);
    FXoffset := strtoint(Aparams[7]);
    FYoffset := strtoint(Aparams[8]);
    Fphysics := strtoint(Aparams[9]);
    Fshape := strtoint(Aparams[10]);
    FIsMapGeometry := strtoint(Aparams[11]);
    FIsExplodable := strtoint(Aparams[12]);
    FIsCollectable := strtoint(Aparams[13]);
    FPointsValue := strtoint(Aparams[14]);
    FIsEnemy := strtoint(Aparams[15]);
    FIsFriend := strtoint(Aparams[16]);
    FHealthValue := strtoint(Aparams[17]);
    FIsMovingPlatform := strtoint(Aparams[18]);
    FpXmoveFrom := strtoint(Aparams[19]);
    FpXmoveTo := strtoint(Aparams[20]);
    FpYmoveFrom := strtoint(Aparams[21]);
    FpYmoveTo := strtoint(Aparams[22]);
    FpVelocity := strtoint(Aparams[23]);
    FColHealthValue := strtoint(Aparams[24]);
    FMoneyValue := strtoint(Aparams[25]);
    FIsSpringboard := strtoint(Aparams[26]);
    FSpringForce := strtoint(Aparams[27]);
    FIsTeleporter := strtoint(Aparams[28]);
    FTeleportX := strtoint(Aparams[29]);
    FTeleportY := strtoint(Aparams[30]);
    FPlayerStartMarker := strtoint(Aparams[31]);
    FIntTag := strtoint(Aparams[32]);

    Result := Self;

  finally
    FreeAndNil(AParams);
  end;
end;


end.
