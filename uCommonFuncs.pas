unit uCommonFuncs;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Forms, uSpriteBlock, TaskDialog, TaskDialogEx, GDIPicture, uConfig,
  CustomItemsContainer, AdvVerticalPolyList, Dialogs, ExtCtrls, shlobj;

function IsPowerOfTwo(AInt: integer): boolean;
procedure LoadExistingFiles(const PathName, FileName: string;
  const InDir: boolean; AList: TStringList);
function CountSprites(AForm: TForm): integer;
function GetParentDirectory(path: string): string;
function GetProjectEXE(APath: string): string;
procedure LookForSourceFiles(APath: string);
function CheckPlayerMarker(AForm: TForm): integer;

function ShowMapMsg(Sender: TForm; ATitle, AInstruction, AContent,
  AFooter, ABtnCaption1, ABtnCaption2: string): integer;

function ImportAssets(AMediaFolder: string; AFileList: TStringList; ASettings: TSettings): string;
function SearchStringList(AList: TStringList; str1: string): boolean;
function GetFileExtension(AFileName, AMediaFolder: string): string;

// returns layer file name to populate fmMain.LayerFile property ... TODO
function CreateLayerFile(AMapFile: string): string;
function GetLayerFile(AMapFile: string): string;
function GetLayerIDFromString(ALayer: string): integer;
procedure MoveSpritesFromToLayer(AMapStringList: TStringList; AFrom, ATo: integer);
procedure DeleteSpritesFromLayer(AMapStringList: TStringList; ALayer: integer);

// Export general methods
function Control2Bitmap(Control_: TWinControl): TBitmap;

// Image manipulation methods
procedure MergeBackgrounds(AFileName: string);
procedure CombineImage(const ATopLeftPos: TPoint; const AImgFileName: string);

// my documents folder
function GetMyDocuments: string;

// move framework to user project
procedure MoveFrameworkToTarget(AProjectName, AFrom, ATo: string);

var
  FTmp: TBitmap;

const
  // bunch of constants for readability
  INS_PNL_COORDS = 0;
  SPR_LAYER = 30;
  SPR_INTTAG = 31;
  SPR_FILEID = 0;
  SPR_ISMAPPGEO = 1;
  SPR_XCOORDS = 2;
  SPR_YCOORDS = 3;
  SPR_XSIZE = 4;
  SPR_YSIZE = 5;
  SPR_XOFFSET = 6;
  SPR_YOFFSET = 7;
  SPR_PHYTYPE = 8;
  SPR_PHYSHAPE = 9;

  INS_PNL_EXPL = 1;
  SPR_EXPLODE = 10;
  SPR_COLLECT = 11;
  SPR_COLPOINTS = 12;
  SPR_COLHEALTH = 13;
  SPR_COLMONEY = 14;

  INS_PNL_FE = 2;
  SPR_ISFRIEND = 15;
  SPR_ISENEMY = 16;
  SPR_FEHEALTH = 17;

  INS_PNL_MP = 3;
  SPR_ISMOVPLAT = 18;
  SPR_XFROM = 19;
  SPR_XTO = 20;
  SPR_YFROM = 21;
  SPR_YTO = 22;
  SPR_VELOCITY = 23;

  INS_PNL_SPTELE = 4;
  SPR_ISSPRINT = 24;
  SPR_SFORCE = 25;
  SPR_ISTELE = 26;
  SPR_TELEX = 27;
  SPR_TELEY = 28;

  INS_PNL_PLAYER = 5;
  SPR_PLAYERSTART = 29;

  LAYER_PLAYERSTART = 9999;
  LAYER_DEFAULT = 1000;

  DEMO_SPRITE_LIMIT = 20;

  // so, to refer to Inspector.Panels[0].Items[8], (physics type) we would do
  // Inspector.Panels[INS_PNL_COORDS].Items[SPR_PHYTYPE]

resourcestring
  STR_ERROR = 'Error';
  STR_PROJECT_CREATE = 'Could not create a new AGK framework project!';
  STR_FRAMEWORKDIR_NOTEXISTS = 'The giLE2d frameork directory could not be found or is not installed!';
  STR_CLONEMSG_SEL = 'Please select a map object before switching to clone mode!';
  STR_OPCANCELLED = 'Operation Cancelled!';
  STR_NEWOBJ_INCLONE = 'Cannot add a new object while in clone mode!';
  STR_NOTPOWEROF2 = 'Image height/width not a power of 2';
  STR_NOSPRITE_SEL = 'No Sprite Selected';
  STR_SAVEMAP = 'Do you want to save this map first?';
  STR_SAVEMAP_TTL = 'Save Map';
  STR_YESSAVE = 'Yes, Save this map';
  STR_NO = 'No, not now';
  STR_YESOVERWRITE = 'Yes, overwrite current file';
  STR_PLYMARKER_ERR = 'Player Marker Error';
  STR_TOOMANY_PLY = 'Too many player markers!';
  STR_ONLYONEPLY = 'Only one player is allowed on your map!';
  STR_NOPLY = 'No player markers!';
  STR_ONEPLY = 'At least one player must be present on your map!';
  STR_BACKGRND_ERR = 'Map Background Error';
  STR_NOBACK = 'No background has been chosen!';
  STR_ONEBACK = 'A background (PNG) must be chosen before you can save your map!';
  STR_NOTALLOWED = 'Not Allowed';
  STR_SPR_TODELLAYER = 'You cannot move sprites to the layer that is to be deleted!';
  STR_NOMOVE_DEF_LAYER = 'You cannot move the default layer!';
  STR_NOMOVE_BEFORE_DEFLAYER = 'This layer cannot be before the default layer!';
  STR_OOPS = 'OOPS!';
  STR_SELDELLAYER = 'Please select a layer to delete!';
  STR_NODELDEFLAYER = 'You cannot delete the default layer!';
  STR_DELSPRITE = 'Delete Sprite';
  STR_QDELSPRITE = 'Are you sure you want to delete this sprite?';
  STR_NOTE_DELSPRITE = 'NOTE: You can turn this dialog off in Settings.';
  STR_YESDELSPRITE = 'Yes, delete this sprite';
  STR_PNGONLY_BG = 'Only PNG files allowed for backgrounds!';
  STR_XTO_BMP = 'Export To Bitmap';
  STR_INC_GRID = 'Do you want to render the grid lines as well?';
  STR_YESGRID = 'Yes, render the grid';
  STR_NOGRID = 'No, don''t render the grid';
  STR_NOFIND_MAPL = 'Cannot find map layer file!';
  STR_ERR_CLEARMAP = 'Error - Clear Map';
  STR_OVERWRITE = 'Overwrite';
  STR_OVERWRITEOK = 'OK to overwrite ';
  STR_NOIMPORT = 'Cannot Import Files!';
  STR_NOPROJ_OPEN = 'There is no project open!';
  STR_IMPORT_ERR = 'There were errors during import. Would you like to view the log?';
  STR_VIEWIMP_LOG = 'YES, view the import log';
  STR_MAPNAMEERR = 'Please choose another map name.';
  STR_NOIMP_CHOOSE = 'No import file types chosen';
  STR_NEEDPICK_IMPTYPE = 'You need to pick at least one file type for import (PNG preferred)';
  STR_PICK_LNAME = 'Please supply a layer name!';
  STR_MOVE_SPRITE_TO = 'Please choose a layer to move sprites to!';
  STR_DEL_LAYERSP = 'Delete Layer And Sprites';
  STR_DEL_LAYER_SURE = 'Are you sure you want to delete this layer?';
  STR_DELLAYER_WARN = 'NOTE: ALL ASSOCIATED SPRITES WILL BE DELETED! CANNOT BE UNDONE!.';
  STR_YES_DEL_LAYERSP = 'Yes, delete this layer and all associated sprites';

implementation
{$WARN SYMBOL_PLATFORM OFF}


function IsPowerOfTwo(AInt: integer): boolean;
begin
  Result := (AInt and (AInt - 1)) = 0;
end;


procedure LoadExistingFiles(const PathName, FileName: string;
  const InDir: boolean; AList: TStringList);
var
  Rec: TSearchRec;
  Path: string;
begin
  Path := IncludeTrailingBackslash(PathName);
  if FindFirst(Path + FileName, faAnyFile - faDirectory, Rec) = 0 then
  try
    repeat
      AList.Add(Path + Rec.Name)
    until FindNext(Rec) <> 0;

  finally
    FindClose(Rec);
  end;

  if not InDir then
    Exit;

  if FindFirst(Path + FileName, faDirectory, Rec) = 0 then   //  '*.png'
  try
    repeat
      if ((Rec.Attr and faDirectory) <> 0) and (Rec.Name <> '.') and (Rec.Name <> '..') then
        LoadExistingFiles(Path + Rec.Name, FileName, True, AList);
    until FindNext(Rec) <> 0;

  finally
    FindClose(Rec);
  end;
end;

function CountSprites(AForm: TForm): integer;
var
  idx: Integer;
begin
  Result := 0;

  for idx := AForm.ComponentCount - 1 downto 0 do
  begin
    if AForm.Components[idx] is TSpriteBlock then
    begin
      Result := Result + 1;
    end;
  end;
end;

function GetParentDirectory(path: string): string;
begin
  result := ExpandFileName(path + '\..')
end;

function GetProjectEXE(APath: string): string;
var
  lPath: string;
  lFile: TStringList;
begin
  lFile := TStringList.Create;
  try
    lPath := GetParentDirectory(APath);
    LoadExistingFiles(lPath, '*.exe', False, lFile);

    if lFile.Count = 1 then
    begin
      result := lfile[0];
    end
    else
    begin
      result := '';
      raise Exception.Create('An AGK project does not seem to exist in this folder structure!');
    end;

  finally
    FreeAndNil(lFile);
  end;
end;

procedure LookForSourceFiles(APath: string);
var
  lPath: string;
  lFile: TStringList;
begin
  lFile := TStringList.Create;
  try
    lPath := GetParentDirectory(APath);
    LoadExistingFiles(lPath, '*.agc', False, lFile);

    if lFile.Count < 0 then
    begin
      raise Exception.Create('Could not find any AGK source code in this folder structure!');
    end;

  finally
    FreeAndNil(lFile);
  end;
end;

function ShowMapMsg(Sender: TForm; ATitle, AInstruction, AContent,
  AFooter, ABtnCaption1, ABtnCaption2: string): integer;
var
  dlg: TAdvTaskDialogEx;
begin
  dlg := TAdvTaskDialogEx.Create(Sender);
  try
    dlg.Title := ATitle;
    dlg.Icon := tiQuestion;
    dlg.Instruction := AInstruction;
    dlg.Content := AContent;
    dlg.Footer := AFooter;

    dlg.CustomButtons.Clear;
    dlg.CustomButtons.Add(ABtnCaption1);

    if ABtnCaption2 <> '' then
      dlg.CustomButtons.Add(ABtnCaption2);

    dlg.DefaultButton := 100;
    dlg.Options := [doCommandLinks, doAllowDialogCancel];

    Result := dlg.Execute;
  finally
    FreeAndNil(dlg);
  end;
end;

function CheckPlayerMarker(AForm: TForm): integer;
var
  idx: Integer;
  lsprite: TSpriteBlock;
begin
  Result := 0;

  for idx := AForm.ComponentCount - 1 downto 0 do
  begin
    if AForm.Components[idx] is TSpriteBlock then
    begin
      lsprite := TSpriteBlock(AForm.Components[idx]);
      if lsprite.PlayerStartMarker = 1 then
        Result := Result + 1;
    end;
  end;

end;

function ImportAssets(AMediaFolder: string; AFileList: TStringList; ASettings: TSettings): string;
var
  cnt: integer; //   , ival
  img: TGDIPPicture;
begin
  Result := '';
  img := TGDIPPicture.Create;
  try

    for cnt := 0 to AFileList.Count - 1 do

    begin

      // if the file is not valid, FAIL
      if ASettings.AllowedFileTypesToStr(ExtractFileExt(AFileList[cnt])) = aftUnknown then
      begin
        Result := Result + 'Error: ' + AFileList[cnt] + ' is not a valid file.' + #13#10;
      end
      else
      begin
        // load the file into a TGDIPImage
        img.LoadFromFile(AFileList[cnt]);
        // IF the file is not power of 2, FAIL
        if (IsPowerOfTwo(img.Width) =  False) or (IsPowerOfTwo(img.Height) = False) then
        begin
          Result := Result + 'Error: ' + AFileList[cnt] + ' width/height NOT a power of 2.' + #13#10;
        end
        else
        begin
          // if the file name is not a number, FAIL
//          if TryStrToInt(Copy(ExtractFileName(AFileList[cnt]), 1,
//            ansipos('.', ExtractFileName(AFileList[cnt])) - 1), ival) = False then
//          begin
//            Result := Result + 'Error: ' + AFileList[cnt] + ' filename is NOT an integer.' + #13#10;
//          end
//          else
//          begin
          // Check if file exists, of it does, FAIL
          if FileExists(IncludeTrailingBackslash(AMediaFolder) + ExtractFileName(AFileList[cnt])) then
          begin
            Result := Result + 'Error: ' + AFileList[cnt] +
              ' already exists... NOT importing this file.' + #13#10;
          end
          else
          begin
            // passed all tests, save it to the project media folder
            img.SaveToFile(IncludeTrailingBackslash(AMediaFolder) + ExtractFileName(AFileList[cnt]));
          end;
//          end;
        end;
      end;

    end;

  finally
    FreeAndNil(img);
  end;
end;

function SearchStringList(AList: TStringList; str1: string): boolean;
var
  cnt: Integer;
begin
  Result := False;

  for cnt := 0 to AList.Count - 1 do
  begin
    if AnsiCompareText(AList[cnt], str1) = 0 then
      Result := True;
  end;
end;

function GetFileExtension(AFileName, AMediaFolder: string): string;
begin
  Result := ''; // TODO: Should have recorded the filename in the map file !!!
end;

// returns layer file name to populate fmMain.LayerFile property ... TODO
function CreateLayerFile(AMapFile: string): string;
var
  lFile: TStringList;
  lFileName: string;
begin
  lFile := TStringList.Create;
  try
    lFile.Add('1000-Default');

    lFileName := Copy(AMapFile, 1, ansipos('.', AMapFile) - 1) + '_layers.txt';

    lFile.SaveToFile(lFileName);
  finally
    FreeAndNil(lFile);
  end;

  Result := lFileName;
end;

function GetLayerFile(AMapFile: string): string;
begin
  Result := Copy(AMapFile, 1, ansipos('.', AMapFile) - 1) + '_layers.txt';
end;

function GetLayerIDFromString(ALayer: string): integer;
var
  layernum: string;
begin
  layernum := Copy(ALayer, 0, ansipos('-', ALayer) - 1);
  Result := strtoint(layernum);
end;

procedure MoveSpritesFromToLayer(AMapStringList: TStringList; AFrom, ATo: integer);
var
  cnt, lFrom: integer;
  map_part: string;
begin
  // go through each string in the maplist
  // replace AFrom with ATo
  for cnt := 1 to AMapStringList.Count - 2 do   // skip map background and EOF string
  begin
    lFrom := strtoint(Copy(AMapStringList[cnt], 0, ansipos('|', AMapStringList[cnt]) - 1));
    map_part := Copy(AMapStringList[cnt], ansipos('|', AMapStringList[cnt]), maxint);

    if lFrom = AFrom then
      AMapStringList[cnt] := inttostr(ATo) + map_part;
  end;
end;

procedure DeleteSpritesFromLayer(AMapStringList: TStringList; ALayer: integer);
var
  cnt, lLayer: integer;
begin
  // go through each string in the maplist
  // remove the line with sprites from ALayer
  for cnt := AMapStringList.Count - 2 downto 1 do
  begin
    lLayer := strtoint(Copy(AMapStringList[cnt], 0, ansipos('|', AMapStringList[cnt]) - 1));
    if lLayer = ALayer then
      AMapStringList.Delete(cnt);
  end;
end;

function Control2Bitmap(Control_: TWinControl): TBitmap;
begin
  Result := TBitmap.Create;
  with Result do
  begin
    Height := Control_.Height;
    Width := Control_.Width;
    Canvas.Handle := CreateDC(nil, nil, nil, nil);
    Canvas.Lock;
    Control_.PaintTo(Canvas.Handle, 0, 0);
    Canvas.Unlock;
    DeleteDC(Canvas.Handle);
  end;
end;


procedure MergeBackgrounds(AFileName: string);
var
  vPos: TPoint;
begin
  // ask for position of the source picture
  vPos.X := 0;
  vPos.Y := 0;
  CombineImage(vPos, AFileName);
end;


procedure CombineImage(const ATopLeftPos: TPoint; const AImgFileName: string);
var
  vPic: TPicture;
  vSrc: TGraphic;
  vMinWidth : Integer;
  vMinHeight: Integer;
begin
  // check if the given file does exist or not, raise exception when not.
  if not FileExists(AImgFileName) then
    Exit;
    //raise Exception.Create('The supplied image file does not exists');

  vPic := TPicture.Create; // init our simple class factory
  try
    // load the image file name to our class factory. Let it decide actual
    // graphic class to instantiate for the image.
    vPic.LoadFromFile(AImgFileName);
    vSrc := vPic.Graphic;

    if FTmp = nil then
      FTmp := TBitmap.Create;

    // make sure the dimension of our temp bitmap accomodates the dimension
    // of the source when placed at the designated position.
    vMinWidth  := ATopLeftPos.X + vSrc.Width;
    vMinHeight := ATopLeftPos.Y + vSrc.Height;

    if FTmp.Width < vMinWidth then
      FTmp.Width := vMinWidth;

    if FTmp.Height < vMinHeight then
      FTmp.Height := vMinHeight;

    FTmp.Canvas.Draw(ATopLeftPos.X, ATopLeftPos.Y, vSrc);

  finally
    vPic.Free;
  end;
end;

function GetMyDocuments: string;
var
  r: Bool;
  path: array[0..Max_Path] of Char;
begin
  r := ShGetSpecialFolderPath(0, path, CSIDL_Personal, False) ;
  if not r then
    raise Exception.Create('Could not find MyDocuments folder location.') ;

  Result := Path;
end;

procedure MoveFrameworkToTarget(AProjectName, AFrom, ATo: string);
var
  myFileList: TStringList;
  cnt: Integer;
  fromfile, destfile: string;
begin
  myFileList := TStringList.Create;
  try

    if not DirectoryExists(ATo) then
    begin
      try
        CreateDir(ATo);
        CreateDir(ATo + '\media');
        CreateDir(ATo + '\media\maps');
      except
        on e:Exception do
        begin
          raise Exception.Create('Cannot create project folder: ' + e.ClassName + ': ' + e.message);
        end;
      end;
    end;

    try

      LoadExistingFiles(AFrom, '*.*', False, myFileList);

      for cnt := 0 to myFileList.Count - 1 do
      begin
        fromfile := myFileList[cnt];
        destfile := IncludeTrailingBackslash(ATo) + ExtractFileName(myFileList[cnt]);

        CopyFile(pwidechar(fromfile), pwidechar(destfile), true);

        if UpperCase(ExtractFileName(destfile)) = 'FRAMEWORK.AGK' then
          RenameFile(destfile, IncludeTrailingBackslash(ExtractFilePath(destfile)) + AProjectName + '.agk');

        if UpperCase(ExtractFileName(destfile)) = 'FRAMEWORK.EXE' then
          RenameFile(destfile, IncludeTrailingBackslash(ExtractFilePath(destfile)) + AProjectName + '.exe');
      end;

      myFileList.Clear;

      LoadExistingFiles(AFrom + '\media', '*.*', False, myFileList);

      for cnt := 0 to myFileList.Count - 1 do
      begin
        destfile := IncludeTrailingBackslash(ATo) + 'media\' + ExtractFileName(myFileList[cnt]);
        CopyFile(pwidechar(myFileList[cnt]), pwidechar(destfile), true); //IncludeTrailingBackslash(AFrom) + 'media' +
      end;

     except
      on e:Exception do
      begin
        raise Exception.Create('Cannot copy files! : ' + e.ClassName + ': ' + e.message);
      end;
    end;

  finally
    FreeAndNil(myFileList);
  end;
end;

end.
