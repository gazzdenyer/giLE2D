unit uMain;

interface

uses
  mover, controlPosition,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Contnrs, pngimage, jpeg, AdvGlowButton, AdvOfficeImage, AdvPicture,
  AdvOfficeButtons, AdvGroupBox, AdvCombo, AdvEdit, AdvSmoothListBox, AdvOfficePager, AdvPanel, ImgList,
  AdvAppStyler, AdvOfficePagerStylers, ExtDlgs, uSpriteBlock, uCommonFuncs, AdvOfficeHint, AdvOfficeStatusBar,
  AdvOfficeStatusBarStylers, AdvScrollBox, shellapi, InspectorBar, InspLinks, CustomItemsContainer,
  AdvVerticalPolyList, GDIPImageItem, GDIPCustomItem,  GDIPImageTextItem, AdvSmoothSplashScreen, htmlhint,
  AdvToolBar, uSettings, uConfig, HTMListB, HTMLChkList,
  //AVLockS5,
  //Regist,
  uNewMap, uLayerDlg,
  Menus, AdvMenus, uBackgrounds, AdvToolBarStylers, uRecentItems;

type
  TfmMain = class(TForm)
    dlgOpenPic: TOpenPictureDialog;
    appStyler: TAdvAppStyler;
    pgrStyler: TAdvOfficePagerOfficeStyler;
    fmStyler: TAdvFormStyler;
    dlgSave: TSaveDialog;
    dlgOpenMap: TOpenDialog;
    pnlStyler: TAdvPanelStyler;
    ilBigButtons: TImageList;
    pnlToolbar: TAdvPanel;
    btnNew: TAdvGlowButton;
    btnOpen: TAdvGlowButton;
    btnSave: TAdvGlowButton;
    dlgColor: TColorDialog;
    sbMain: TAdvOfficeStatusBar;
    sbStyler: TAdvOfficeStatusBarOfficeStyler;
    pnlPager: TPanel;
    pgrSprites: TAdvOfficePager;
    pgSpriteList: TAdvOfficePage;
    pgProperties: TAdvOfficePage;
    pnlProperties: TAdvPanel;
    pnlForm: TPanel;
    AdvScrollBox1: TAdvScrollBox;
    pnlMapContainer: TPanel;
    pnlMap: TPanel;
    imgBackground: TImage;
    pbGrid: TPaintBox;
    ilTabs: TImageList;
    cbPhysType: TColComboInspectorEditLink;
    cbPhysicsShape: TColComboInspectorEditLink;
    ilInspector: TImageList;
    pnlInspector: TAdvPanel;
    btnExpand: TAdvGlowButton;
    btnCollapse: TAdvGlowButton;
    Inspector: TInspectorBar;
    ilDefaultCombo: TImageList;
    splash: TAdvSmoothSplashScreen;
    htmlhint: THTMLHint;
    btnSettings: TAdvGlowButton;
    sep1: TAdvToolBarSeparator;
    btnHelp: TAdvGlowButton;
    AdvToolBarSeparator1: TAdvToolBarSeparator;
    pnlDefaults: TAdvPanel;
    cbxDefaultItemType: TAdvComboBox;
    pnlSpriteName: TAdvPanel;
    tmrFileSave: TTimer;
    btnAbout: TAdvGlowButton;
    lblHelp: TLabel;
    pgLayers: TAdvOfficePage;
    pnlAllLayers: TAdvPanel;
    pgrSpritesSub: TAdvOfficePager;
    pgAvailableSpriteList: TAdvOfficePage;
    pgInUseSpriteList: TAdvOfficePage;
    lstManifest: TAdvVerticalPolyList;
    lstInUse: TAdvVerticalPolyList;
    chkAllLayers: TAdvOfficeCheckBox;
    lbLayers: THTMLCheckList;
    cbxLayer: TAdvComboBox;
    btnAddLayer: TAdvGlowButton;
    btnDeleteLayer: TAdvGlowButton;
    btnMoveLayerUp: TAdvGlowButton;
    btnMoveLayerDown: TAdvGlowButton;
    dlgExport: TSaveDialog;
    btnTEST: TAdvGlowButton;
    Panel1: TPanel;
    pnlSpriteTools: TAdvPanel;
    btnEditSprite: TAdvGlowButton;
    btnMediaFolder1: TAdvGlowButton;
    pnlFileName: TAdvPanel;
    chkShowBtnCaptions: TAdvOfficeCheckBox;
    tbMapTools: TAdvToolBar;
    btnBackground: TAdvGlowButton;
    btnDelSprite: TAdvGlowButton;
    btnRefreshSpriteList: TAdvGlowButton;
    btnSnap: TAdvGlowButton;
    btnGridColor: TAdvGlowButton;
    btnAutoSnap: TAdvGlowButton;
    btnClone: TAdvGlowButton;
    btnShowHideBG: TAdvGlowButton;
    btnBMPExport: TAdvGlowButton;
    btnMediaFolder: TAdvGlowButton;
    btnLaunchProject: TAdvGlowButton;
    AdvToolBarSeparator2: TAdvToolBarSeparator;
    AdvToolBarSeparator3: TAdvToolBarSeparator;
    AdvToolBarSeparator4: TAdvToolBarSeparator;
    AdvToolBarSeparator5: TAdvToolBarSeparator;
    tbStyler: TAdvToolBarOfficeStyler;
    btnNewFrameworkProject: TAdvGlowButton;
    mnuRecentItems: TPopupMenu;
    procedure FormCreate(Sender: TObject);
    procedure OnThumbListClick(Sender: TObject; Item: TCustomItem);
    procedure OnPolyClick(Sender: TObject; Item: TCustomItem);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure pbGridPaint(Sender: TObject);
    procedure btnOpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure txtFileIDChange(Sender: TObject);
    procedure cbShapeChange(Sender: TObject);
    procedure chkMapGeometryClick(Sender: TObject);
    procedure rbExplodableClick(Sender: TObject);
    procedure btnSnapClick(Sender: TObject);
    procedure btnGridColorClick(Sender: TObject);
    procedure btnBackgroundClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnDelSpriteClick(Sender: TObject);
    procedure btnRefreshSpriteListClick(Sender: TObject);
    procedure cbxDefaultItemTypeSelect(Sender: TObject);
    procedure pbGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure pbGridMouseLeave(Sender: TObject);
    procedure btnLaunchProjectClick(Sender: TObject);
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure cbPhysicsShapeSetProperties(Sender: TObject; R: TRect; Item: TInspectorItem);
    procedure cbPhysTypeSetProperties(Sender: TObject; R: TRect; Item: TInspectorItem);
    procedure InspectorEditStop(Sender: TObject; AInspectorPanel: TInspectorPanel;
      AInspectorItem: TInspectorItem);
    procedure pbGridClick(Sender: TObject);
    procedure AdvComboBox1Select(Sender: TObject);
    procedure btnSettingsClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure tmrFileSaveTimer(Sender: TObject);
    procedure btnAboutClick(Sender: TObject);
    procedure btnHelpClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure pgrSpritesSubChange(Sender: TObject);
    procedure chkAllLayersClick(Sender: TObject);
    procedure btnAddLayerClick(Sender: TObject);
    procedure btnDeleteLayerClick(Sender: TObject);
    procedure cbxLayerChange(Sender: TObject);
    procedure cbxLayerSelect(Sender: TObject);
    procedure btnTESTClick(Sender: TObject);
    procedure lbLayersCheckClick(Sender: TObject; Index: Integer);
    procedure btnMoveLayerUpClick(Sender: TObject);
    procedure btnMoveLayerDownClick(Sender: TObject);
    procedure btnBMPExportClick(Sender: TObject);
    procedure btnAutoSnapClick(Sender: TObject);
    procedure btnCloneClick(Sender: TObject);
    procedure btnMediaFolderClick(Sender: TObject);
    procedure btnEditSpriteClick(Sender: TObject);
    procedure AdvScrollBox1HScroll(Sender: TObject);
    procedure btnShowHideBGClick(Sender: TObject);
    procedure chkShowBtnCaptionsClick(Sender: TObject);
    procedure btnNewFrameworkProjectClick(Sender: TObject);
    procedure RecentItemClick(Sender: TObject);

  protected
    procedure WMDROPFILES (var Msg: TWMDropFiles); message WM_DROPFILES;

  private
    mover : TMover;
    recentitems: TRecentItems;
    // all this shit needs to be consolidated into at getdir structure rec (struct) !!!
    FmapFile, mapMediaPath, FExeName: string;

    FMapBackground1: TStringList;
    FGridLineColor: TColor;
    FSpriteType, FSpriteCount: integer;
    FCopyBuffer: TSpriteBlock;
    FSettings: TSettings;
    FLayerFile: string; // used to display layers... also persistent
    FAppRegStatus: string;
    FCurrentPolyItemDescription: string;

    FScroller: integer;
    FRepeater: integer;

    strRegistered: string;

//    FBGBitmap: TBitmap;

    procedure DrawGrid(ALineColor: TColor; AWidth: Integer);
    procedure AddSprite(nameID: integer; AFileName: string); overload;
    procedure AddSprite(ASprite: TSpriteBlock; AFileName: string; ACnt: integer); overload;
    procedure AddAssetToList(AFolder: string);
    procedure ViewCurrentUsedAssets(AFolder: string);
    procedure EditProperties(ASprite: TSpriteBlock;Sender: TObject; AInspectorItem: TInspectorItem = nil);
    procedure ClearMap(UpdateLayer: boolean = False);
    procedure AskToSave;
    procedure SaveMap(AAutoSave: boolean);
    procedure DisplayLayers(ALayers: TStringList);
    procedure DisplayAllLayers;
    procedure PopulateLayerControls;
    procedure LbMoveItemUp(AListBox: THTMLCheckList);
    procedure LbMoveItemDown(AListBox: THTMLCheckList);
    procedure ReIndexLayers;
    procedure ReIndexMapStringList(AFrom, ATo: integer);
    procedure ShowMapToolCaptions;

    procedure OpenMap(AOpenMap: string);

  public
    IsLoading: boolean;
    NeedSave: boolean;
    FMapStringList: TStringList; // holds the map file... makes it persistent
    FLayerStringList: TStringList;
    property GridLineColor: TColor read FGridLineColor write FGridLineColor;
    property MapBackground1: TStringList read FMapBackground1 write FMapBackground1;
    property MapFile: string read FmapFile;
    property LayerFile: string read FLayerFile;
    property Scroller: integer read FScroller;
    property Repeater: integer read FRepeater;

    function DoRegister(force:boolean): string;
  end;

var
  fmMain: TfmMain;
  //keydata: TKeyData;

implementation

{$WARN SYMBOL_PLATFORM OFF}

{$R *.dfm}

uses
  uImport, uAbout, uLayerDelete, uCrypt, stdActns, uNewFrameworkProject;

function TfmMain.DoRegister(force: boolean): string;
//var
  //F: TRegForm;
  //s: string;
begin
  {* Result := 'Registered';

  F := TRegForm.Create(nil); //Create the registration Form
  try
    F.GetRegStatus;
    if AVLock.IsLocal and (force or (keydata.Status = Moved) or (keydata.DaysLeft < 15)) then
    begin
      if F.ShowModal = mrOK then
      begin
        case keydata.Status of
          Unregistered: s:='TERMINATE';
          Moved: s:='Moved to another computer';
          Expired: s:='Expired';
          Registered:
            begin
              s := '';
              case keydata.KeyType of
                Trial: s := s+ 'Trial ' + inttostr(keydata.Days) + ' days - ' +
                  inttostr(keydata.DaysLeft) + ' days left.';

                Temporal: s:=s+'Temporal '+inttostr(keydata.Days)+' days - ' +
                  inttostr(keydata.DaysLeft)+' days left.';

                Permanent: s:=s+'Registered';
              end;
            end;
        end;
        Result := s;
      end;
    end;
  finally
    FreeAndNil(F);
  end; *}
end;

procedure TfmMain.FormCreate(Sender: TObject);
//  action: TCloseAction;
begin
//  action := caFree;

  {$IFDEF DEBUG}
  strRegistered := 'DEBUG 0.98.1 BETA';
  {$ELSE}
  strRegistered := 'RELEASE 0.98.1 BETA';
  {$ENDIF}

  //{$IFNDEF DEBUG}

  //strRegistered := DoRegister(False);
  //FAppRegStatus := strRegistered;

  //if (keydata.DaysLeft <> 0) then    // (strRegistered <> 'TERMINATE') or
  //begin
  //{$ENDIF}
    fmMain.Caption := 'giLE2D For AGK - ' + strRegistered;

    DragAcceptFiles(Handle, True);

    FMapStringList := TStringList.Create;
    FLayerStringList := TStringList.Create;
    FSettings := TSettings.Create;
    FMapBackground1 := TStringList.Create;
    FSettings.ReadFromIni(self);

    FGridLineColor := 4802889;
    pgrSprites.ActivePageIndex := 0;
    pgrSpritesSub.ActivePageIndex := 0;
    cbxDefaultItemType.SelectItem('1-Map Geometry');
    cbxLayer.SelectItem('1000-Default');
    FSpriteCount := 0;
    FSpriteType := 1; // default to map geometry
    sbMain.Panels[0].Text := 'Map Sprite Count: ' + inttostr(CountSprites(self));
    sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);
    FCurrentPolyItemDescription := '';
    ShowMapToolCaptions;
    chkShowBtnCaptions.Checked := FSettings.ShowButtonCaptions;

    try
      recentitems := TRecentItems.Create(FSettings.RecentItemsMax);
      recentitems.LoadItemList(mnuRecentItems);
    except
      on e:Exception do
      begin
        ShowMapMsg(self, STR_ERROR, e.Message, '', '', 'OK', '');
      end;
    end;

  //{$IFNDEF DEBUG}
  //end

  //else
  //application.Terminate;
  //{$ENDIF}
end;

procedure TfmMain.AddSprite(nameID: integer; AFileName: string);
var
  sprite: TSpriteBlock;
  lFile: string;
  lFileID: integer;
begin
  lFile := ExtractFileName(AFileName);
  lFileID := FSpriteCount; //strToInt(Copy(lFile, 1, ansipos('.', lFile) - 1));

  sprite := TSpriteBlock.Create(self);
  sprite.Parent := pnlMap;
  sprite.Cursor := crHandPoint;
  sprite.FileID := lFileID;
  sprite.FileName := ExtractFileName(AFileName);
  sprite.Picture.LoadFromFile(AFileName);

  sprite.Layer := GetLayerIDFromString(cbxLayer.Text);

  sprite.width := sprite.Picture.Width;
  sprite.height := sprite.Picture.height;
  sprite.Transparent := True;
  sprite.Name := 'block_' + inttostr(nameID);
  sprite.ShowHint := True;
  sprite.Hint := sprite.Name;
  sprite.FocusType := ftHot;
  sprite.MarginVert := 0;
  sprite.MarginHorz := 0;
  sprite.Margins.Bottom := 0;
  sprite.Margins.Left := 0;
  sprite.Margins.Right := 0;
  sprite.Margins.top := 0;
  sprite.ShowCaption := False;

  SetDefaultSpriteProperties(sprite, FSpriteType, FSettings);

  TGazzMap.CreateFileContents(self, FMapStringList, MapBackground1, FScroller, FRepeater);

  mover.PopulateProperties(sprite, Inspector);
  //EnablePropUI;

  mover.Add(sprite);

  // reset the mover
  //mover.Enabled := False;  ***** COMMENTED OUT CAUSING ACCESS VIOLATION ON MOVER RESET
  mover.Enabled := True;

  NeedSave := True;

end;

procedure TfmMain.AddAssetToList(AFolder: string);
var
  cnt: integer; // , typecnt
  lFileList: TStringList;
//  ival: Integer;
begin
  if AFolder = '' then
    AFolder := ExtractFilePath(Application.ExeName);

  sbMain.Panels[2].Text := 'Loading Available Sprite List...';
  sbMain.Panels[4].Progress.Position := 0;
  sbMain.Panels[4].Progress.min := 0;

  lFileList := TStringList.Create;

  try
    // this is kinda shite... fix it.
    LoadExistingFiles(AFolder, '*.png', False, lFileList);
    LoadExistingFiles(AFolder, '*.bmp', False, lFileList);
    LoadExistingFiles(AFolder, '*.jpg', False, lFileList);

    sbMain.Panels[4].Progress.max := lFileList.Count - 1;

    lstManifest.BeginUpdate;

    for cnt := 0 to lFileList.Count - 1 do
    begin

      with TImageItem(lstManifest.AddItem(TImageItem)) do
      begin
        Width := 240;
        Height := 90;

        ImageWidth := 48;
        ImageHeight := 48;

        Image.LoadFromFile(lFileList[cnt]);

        Caption := ExtractFileName(lFileList[cnt]) + ': (Size ' +
          inttostr(Image.Width) + 'x' + inttostr(Image.Height) + ')';
        CaptionLocation := tlTopCenter;
        CaptionSize := 8;
        //CaptionColor := clBlue;
        //CaptionFontStyle := [fsBold];

        Description := lFileList[cnt];
        DescriptionLocation := tlTopCenter;
        DescriptionSize := 7;
        DescriptionColor := clSilver;

        AspectRatio := true;

        OnItemDblClick := OnThumbListClick;
        OnItemClick := OnPolyClick;
      end;

      Application.ProcessMessages;
      sbMain.Panels[2].Text := lFileList[cnt] + '...';
      sbMain.Panels[4].Progress.Position := sbMain.Panels[4].Progress.Position + 1;
    end;

    lstManifest.EndUpdate;

    sbMain.Panels[2].Text := '';
    sbMain.Panels[4].Progress.Position := 0;

  finally
    FreeAndNil(lFileList);
  end;
end;

procedure TfmMain.AddSprite(ASprite: TSpriteBlock; AFileName: string; ACnt: integer);
begin

  ASprite.Left := ASprite.Xcoord;
  ASprite.Top := ASprite.Ycoord;
  ASprite.Height := ASprite.Ysize;
  ASprite.Width := ASprite.Xsize;
  ASprite.Transparent := True;
  Asprite.Name := 'block_' + inttostr(ACnt);
  ASprite.ShowHint := True;
  ASprite.Hint := Asprite.Name;
  ASprite.FocusType := ftHot;
  ASprite.MarginVert := 0;
  ASprite.MarginHorz := 0;
  ASprite.Margins.Bottom := 0;
  ASprite.Margins.Left := 0;
  ASprite.Margins.Right := 0;
  ASprite.Margins.top := 0;
  ASprite.ShowCaption := False;
  ASprite.FileName := ExtractFileName(AFileName);

  ASprite.Picture.LoadFromFile(AFileName);

  mover.Add(ASprite);

end;

procedure TfmMain.AdvComboBox1Select(Sender: TObject);
begin
  //
end;

procedure TfmMain.AdvScrollBox1HScroll(Sender: TObject);
begin
  pbGrid.Update;
end;

procedure TfmMain.btnAutoSnapClick(Sender: TObject);
begin
  mover.AutoSnap := btnAutoSnap.Down;
end;

procedure TfmMain.btnTESTClick(Sender: TObject);
var
  bg: TfmBackgrounds;
begin
  bg := TfmBackgrounds.Create(self);
  bg.init(mapMediaPath, MapBackground1, Scroller);
  bg.ShowModal;
  bg.Free;
// ShowMessage(inttostr(lblayers.itemindex));

// ShowMessage(EnDeCrypt('gazz@gazzbass.com'));
end;

procedure TfmMain.btnAboutClick(Sender: TObject);
var
  dlgAbout: TfmAbout;
begin
  dlgAbout := TfmAbout.Create(self);
  try
    dlgAbout.init(FAppRegStatus);
    dlgAbout.ShowModal;
  finally
    FreeAndNil(dlgabout);
  end;
end;

procedure TfmMain.btnSettingsClick(Sender: TObject);
var
  dlgSettings: TfmSettings;
begin
  dlgSettings := TfmSettings.Create(self);
  try
    dlgSettings.MyAppStyler := appStyler;
    dlgSettings.MyFormStyler := fmStyler;

    dlgSettings.Init(FSettings);

    dlgSettings.ShowModal;

    // set autosave immediately
    if FSettings.AutoSave then
    begin
      tmrFileSave.Interval := FSettings.AutoSaveTime * 60000; // minutes
      tmrFileSave.Enabled := True;
    end
    else
    begin
      tmrFileSave.Enabled := False;
    end;
  finally
    FreeAndNil(dlgSettings);
  end;
end;

procedure TfmMain.btnShowHideBGClick(Sender: TObject);
var
  idx: integer;
begin
  imgBackground.Visible := btnShowHideBG.Down;

  // fucking hassle to repaint all sprites !!!
  for idx := 0 to fmMain.ComponentCount - 1 do
  if fmMain.Components[idx] is TSpriteBlock then
  begin
    TSpriteBlock(fmMain.Components[idx]).Repaint;
  end;

end;

procedure TfmMain.chkAllLayersClick(Sender: TObject);
var
  cnt: Integer;
begin
  chkAllLayers.Enabled := (not chkAllLayers.Checked);

  // un-check everything in the layers list
  for cnt := 0 to lbLayers.Count - 1 do
  begin
    if lbLayers.Checked[cnt] then
      lbLayers.Checked[cnt] := False;
  end;

  // show the whole she-bang...
  DisplayAllLayers;
end;

procedure TfmMain.cbxDefaultItemTypeSelect(Sender: TObject);
begin
  FSpriteType := cbxDefaultItemType.ItemIndex;
end;

procedure TfmMain.cbxLayerChange(Sender: TObject);
begin
  if IsLoading then
   Exit;
end;

procedure TfmMain.cbxLayerSelect(Sender: TObject);
begin
  if IsLoading then
   Exit;
end;

procedure TfmMain.AskToSave;
begin
  if NeedSave = True then
  begin
    if ShowMapMsg(self, STR_SAVEMAP_TTL, STR_SAVEMAP, '', '', STR_YESSAVE, STR_NO) = 100 then
    begin
      SaveMap(False);
      NeedSave := False;
    end;
  end;
end;

procedure TfmMain.btnBackgroundClick(Sender: TObject);
var
  dlgbg: TfmBackgrounds;
  cnt: Integer;
begin
  dlgbg := TfmBackgrounds.Create(self);
  try
    dlgbg.init(mapMediaPath, MapBackground1, Scroller);
    if dlgbg.ShowModal = mrOK then
    begin
      if FScroller = 0 then
      begin
        MergeBackgrounds(includetrailingbackslash(mapMediaPath) + MapBackground1[0]);
      end
      else
      begin
        for cnt := 0 to 3 do
        begin
          MergeBackgrounds(includetrailingbackslash(mapMediaPath) + MapBackground1[cnt]);
        end;
      end;

      if FTmp <> nil then
      begin
        imgBackground.Picture.Graphic := FTmp;
        imgBackground.Update;
      end;

      NeedSave := True;
      fmMain.Update;

    end;
  finally
    FreeAndNil(dlgbg);
  end;

end;

procedure TfmMain.btnBMPExportClick(Sender: TObject);
var
  bmp: TBitmap;
  rendergrid: boolean;

begin
  rendergrid := True;

  if ShowMapMsg(self, STR_XTO_BMP, STR_INC_GRID, '', '', STR_YESGRID, STR_NOGRID) = 101 then
  begin
    rendergrid := False;
    pbGrid.Visible := False;
  end;

  if dlgExport.Execute then
  begin
    bmp := Control2Bitmap(pnlMap);
    try
     bmp.SaveToFile(dlgExport.FileName);
    finally
     FreeAndNil(bmp);
    end;
  end;

  if rendergrid = False then
    pbGrid.Visible := True;
end;

procedure TfmMain.btnCloneClick(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
  sel: boolean;
begin
  sel := False;

  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);
      if lSprite.Tag = 1 then
      begin
        sel := True;
        Break;
      end;
    end;
  end;

  if not sel then
  begin
    btnClone.Down := False;
    ShowMapMsg(self, STR_NOSPRITE_SEL, STR_CLONEMSG_SEL, '', '', 'OK', '');
    Exit;
  end;

  mover.Clone := btnClone.Down;

  if mover.Clone then
    pbGrid.Cursor := crDrag
  else
    pbGrid.Cursor := crCross;

end;

procedure TfmMain.btnCollapseClick(Sender: TObject);
var
  cnt: integer;
begin
  for cnt := 0 to Inspector.Panels.Count - 1 do
    Inspector.Panels[cnt].MultiPanelState := mpsClose;
end;

procedure TfmMain.btnAddLayerClick(Sender: TObject);
var
  layernum: integer;
  layerdlg: TfmLayerDlg;
begin
  layerdlg := TfmLayerDlg.Create(self);
  try
    if layerdlg.ShowModal = mrOK then
    begin
      layernum := LAYER_DEFAULT + lbLayers.Items.Count;
      lbLayers.Items.Add(inttostr(layernum) + '-' + layerdlg.txtLayerName.Text);
      cbxLayer.Items.Add(inttostr(layernum) + '-' + layerdlg.txtLayerName.Text);
      lblayers.Items.SaveToFile(FLayerFile);
    end;
  finally
    FreeAndNil(layerdlg);
  end;
end;

procedure TfmMain.btnDeleteLayerClick(Sender: TObject);
var
  layerDeletedlg: TfmLayerDelete;
  layerid: integer;
begin
//  DELETING LAYERS... warn the user that current sprites under this layer
//  can either be moved to another layer
//  or deleted. Give them the option of moving to another layer.

  if lblayers.ItemIndex < 0 then
  begin
    ShowMapMsg(self, STR_OOPS, STR_SELDELLAYER, '', '', 'OK', '');
    Exit;
  end;

  layerid := GetLayerIDFromString(lbLayers.items.strings[lblayers.itemindex]);

  if layerid = LAYER_DEFAULT then
  begin
    ShowMapMsg(self, STR_NOTALLOWED, STR_NODELDEFLAYER, '', '', 'OK', '');
    exit;
  end;

  layerDeletedlg := TfmLayerDelete.Create(self);
  try
    layerDeletedlg.Init(cbxLayer.Items, layerid);
    layerDeletedlg.lblLayerToDelete.Caption := lbLayers.items.strings[lblayers.itemindex];

    if layerDeletedlg.ShowModal = mrOK then
    begin

      case layerDeletedlg.rbMoveSpriteDeleteLayer.Checked of
        True: MoveSpritesFromToLayer(FMapStringList, layerid, layerDeletedlg.ToLayer);

        False: DeleteSpritesFromLayer(FMapStringList, layerid);
      end;

      cbxLayer.Items.Delete(lblayers.itemindex);
      lbLayers.Items.Delete(lblayers.itemindex);
      lblayers.Items.SaveToFile(FLayerFile);
    end;

  finally
    FreeAndNil(layerDeletedlg);
  end;

  DisplayAllLayers;

end;

procedure TfmMain.btnDelSpriteClick(Sender: TObject);
var
  idx: Integer;
  sprite: TSpriteBlock;
begin

  for idx := fmMain.ComponentCount - 1 downto 0 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      sprite := TSpriteBlock(fmMain.Components[idx]);
      try
        if sprite.Tag = 1 then
        begin
          if FSettings.WarnBeforeDelete then
          begin
            if ShowMapMsg(self, STR_DELSPRITE, STR_QDELSPRITE, STR_NOTE_DELSPRITE,
              '', STR_YESDELSPRITE, STR_NO) = 101 then
            Exit;
          end;

          if Assigned(sprite) then
            FreeAndNil(sprite);
          mover.SetNodesVisible(False);

          TGazzMap.CreateFileContents(self, FMapStringList, MapBackground1, FScroller, FRepeater);

          fmMain.RePaint;
          NeedSave := True;

          if pgrSprites.ActivePageIndex = 2 then
            ViewCurrentUsedAssets(mapMediaPath);

          Break;
        end;
      except
        on e:Exception do
          ShowMapMsg(self, STR_ERROR, e.Message, STR_OPCANCELLED, '', 'OK', '');
      end;
    end;
  end;
end;

procedure TfmMain.btnEditSpriteClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pwidechar(FCurrentPolyItemDescription), nil, nil, SW_SHOWNORMAL);
end;

procedure TfmMain.btnExpandClick(Sender: TObject);
var
  cnt: Integer;
begin
  for cnt := 0 to Inspector.Panels.Count - 1 do
    Inspector.Panels[cnt].MultiPanelState := mpsOpen;
end;

procedure TfmMain.btnGridColorClick(Sender: TObject);
var
  idx: Integer;
begin
  if dlgColor.Execute then
  begin
    FGridLineColor := integer(dlgColor.Color);
    pbGridPaint(nil);
    fmMain.RePaint;  // fuckin repaint shit
    for idx := 0 to fmMain.ComponentCount - 1 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        TSpriteBlock(fmMain.Components[idx]).Refresh;
      end;
    end;
  end;
end;

procedure TfmMain.btnHelpClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pwidechar(ExtractFilePath(Application.ExeName) + '\help\index.html'),
    nil, nil, SW_SHOWNORMAL) ;
end;

procedure TfmMain.btnLaunchProjectClick(Sender: TObject);
begin
  btnSaveClick(nil);
  ShellExecute(Handle, 'open', pwidechar(FExeName), nil, nil, SW_SHOWMAXIMIZED);
end;

procedure TfmMain.btnMediaFolderClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', pwidechar(mapMediaPath), nil, nil, SW_SHOWNORMAL);
end;

procedure TfmMain.btnMoveLayerDownClick(Sender: TObject);
var
  layerid: Integer;
begin
  layerid := GetLayerIDFromString(lbLayers.items.strings[lblayers.itemindex]);

  if layerid = LAYER_DEFAULT then
  begin
    ShowMapMsg(self, STR_NOTALLOWED, STR_NOMOVE_DEF_LAYER, STR_OPCANCELLED, '', 'OK', '');
    exit;
  end;

  LbMoveItemDown(lbLayers);
end;

procedure TfmMain.btnMoveLayerUpClick(Sender: TObject);
begin
  if lbLayers.ItemIndex = 1 then
  begin
    ShowMapMsg(self, STR_NOTALLOWED, STR_NOMOVE_BEFORE_DEFLAYER, STR_OPCANCELLED, '', 'OK', '');
    exit;
  end;

  LbMoveItemUp(lbLayers);
end;

procedure TfmMain.btnNewClick(Sender: TObject);
var
  dlgNew: TfmNewMap;
begin
  AskToSave;
  if not NeedSave then
  begin
    dlgNew := TfmNewMap.Create(self);
    try
      if dlgNew.ShowModal = mrOK then
      begin
        try
          FScroller := dlgNew.IsScroller;
          FRepeater := dlgNew.Repeater;
          FExeName := GetProjectEXE(dlgNew.MediaPath);
        except
          on e:Exception do
          begin
            ShowMapMsg(self, STR_ERROR , e.Message, STR_OPCANCELLED, '', 'OK', '');
            Exit;
          end;
        end;

        try
          LookForSourceFiles(dlgNew.MediaPath);
        except
          on e:Exception do
          begin
            ShowMapMsg(self, STR_ERROR, e.Message, STR_OPCANCELLED, '', 'OK', '');
            Exit;
          end;
        end;

        FmapFile := dlgNew.FilePath + '\' + dlgNew.FileName + '.txt';

        // clear MapBackground list
        MapBackground1.Clear;

        // create a layer file and assign fmMain.LayerFile property
        FLayerFile := CreateLayerFile(FmapFile);

        PopulateLayerControls;

        // should be a setval prop !!! FUCK !!!
        chkAllLayers.Checked := True;
        lblHelp.Visible := False;
        pnlForm.Visible := True;
        pnlPager.Visible := True;
        btnSave.Enabled := True;
        pgrSprites.Visible := True;

        ClearMap;

        if Assigned(mover) then
          FreeAndNil(mover);

        mover := TMover.Create(self);

//        pnlFileName.Text := 'Current File: ' + FmapFile;
        fmMain.Caption := '';
        fmMain.Caption := 'giLE2D For AGK - ' + strRegistered + ' - Current File: ' + FmapFile;
        mapMediaPath := dlgNew.MediaPath;
        AddAssetToList(dlgNew.MediaPath);
        NeedSave := True;
        FSpriteCount := 0;
        sbMain.Panels[0].Text := 'Map Sprite Count: ' + inttostr(CountSprites(self));
        sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);

        mover.AutoSnap := True;
        mover.Enabled := True;

//        if FSettings.AutoSave then
//          tmrFileSave.Enabled := True;
        FormResize(nil);

        // create the map file
        FMapStringList.SaveToFile(FmapFile);
      end;

      btnEditSprite.Enabled := False;

      if FScroller = 1 then
      begin
        pnlMapContainer.Width := 1150 * FRepeater;
        imgBackground.Stretch := True;
      end
      else
      begin
        pnlMapContainer.Width := 1150;
        imgBackground.Stretch := False;
      end;

    finally
      FreeAndNil(dlgNew);
    end;
  end;
end;

procedure TfmMain.btnNewFrameworkProjectClick(Sender: TObject);
var
  NewProjectDialog: TfmNewProject;
  targetDir: string;
  targetPath: string;
  AFromDir: string;
begin
  // First, get a path
  // then, move all scrollproto1 files to that path
  // then, rename the scrollproto1.agk project file to the project name

  NewProjectDialog := TfmNewProject.Create(Self);
  try
    if NewProjectDialog.ShowModal = mrOK then
    begin
      AFromDir := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'framework';

      if not DirectoryExists(AFromDir) then
      begin
        ShowMapMsg(self, STR_PROJECT_CREATE, STR_FRAMEWORKDIR_NOTEXISTS, STR_OPCANCELLED, '', 'OK', '');
        Exit;
      end;

      targetPath := NewProjectDialog.txtDir.Text;
      targetDir := NewProjectDialog.txtFile.Text;
      try
        MoveFrameworkToTarget(targetDir, AFromDir, IncludeTrailingBackslash(targetPath) + targetDir);
      except
        on e:Exception do
        begin
          ShowMapMsg(self, STR_PROJECT_CREATE, e.Message, STR_OPCANCELLED, '', 'OK', '');
          Exit;
        end;
      end;
    end;

  finally
    FreeAndNil(NewProjectDialog);
  end;

end;


procedure TfmMain.OpenMap(AOpenMap: string);
var
//  FList: TStringList;
  MyMap: TGazzMap;
  cnt: integer;
  sprite: TSpriteBlock;
  fFileName, fBackGround, fMediaPath: string;
  fdlgPath: string;
begin
  fdlgPath := ExtractFilePath(AOpenMap);
  fMediaPath := Copy(fdlgPath, 0, Length(fdlgPath) - 5);
  FLayerFile := GetLayerFile(AOpenMap);

  if not FileExists(FLayerFile) then
  begin
    ShowMapMsg(self, STR_ERROR, STR_NOFIND_MAPL, STR_OPCANCELLED, '', 'OK', '');
    Exit;
  end;

  try
    FExeName := GetProjectEXE(fMediaPath);
  except
    on e:Exception do
    begin
      ShowMapMsg(self, STR_ERROR, e.Message, STR_OPCANCELLED, '', 'OK', '');
      Exit;
    end;
  end;

  try
    LookForSourceFiles(fMediaPath);
  except
    on e:Exception do
    begin
      ShowMapMsg(self, STR_ERROR, e.Message, STR_OPCANCELLED, '', 'OK', '');
      Exit;
    end;
  end;

  try
    ClearMap;
   except
    on e:Exception do
    begin
      ShowMapMsg(self, STR_ERROR, e.Message, '', '', 'OK', '');
      Exit;
    end;
  end;

  if Assigned(mover) then
    FreeAndNil(mover);

  FSpriteCount := 0;

  sbMain.Panels[2].Text := 'Loading Sprites...';
  sbMain.Panels[4].Progress.Position := 0;
  sbMain.Panels[4].Progress.min := 0;

//    FList := TStringList.Create;
  MyMap := TGazzMap.Create;
  mover := TMover.Create(self);

  try
    Screen.Cursor := crHourGlass;
    try
      FMapStringList.Clear;
      FLayerStringList.Clear;

      MyMap.ReadFile(AOpenMap, FMapStringList);
      sbMain.Panels[4].Progress.max := FMapStringList.Count - 2;

      // if the map is empty, do not attempt any load
      if FMapStringList.Count >= 3 then
      begin
        // load background
        fBackGround := MyMap.MakeBGFileNameAndScroller(FMapStringList[0], FScroller, FRepeater, MapBackGround1);

        for cnt := 1 to FMapStringList.Count - 2 do // skip the background and EOF statement in the file
        begin
          sprite := TSpriteBlock.Create(self);
          sprite.Parent := pnlMap;
          sprite.Cursor := crHandPoint;
          sprite.CreateFromString(FMapStringList[cnt]);
          fFileName :=  ExtractFilePath(fMediaPath) + sprite.FileName;
            //inttostr(sprite.FileID) + sprite.FileExtension;
          AddSprite(sprite, fFileName, cnt);
          FSpriteCount := mover.MovableControls.Count; //FSpriteCount + 1;

          Application.ProcessMessages;
          sbMain.Panels[2].Text := fFileName + '...';
          sbMain.Panels[4].Progress.Position := sbMain.Panels[4].Progress.Position + 1;
        end;

        if FScroller = 0 then
        begin
          MergeBackgrounds(fMediaPath + MapBackground1[0]);
        end
        else
        begin
          for cnt := 0 to 3 do
          begin
            MergeBackgrounds(fMediaPath + MapBackground1[cnt]);
          end;
        end;

        if FTmp <> nil then
        begin
          imgBackground.Picture.Graphic := FTmp;
          imgBackground.Update;
        end;

      end;

    finally
      FreeAndNil(MyMap);
//        FreeAndNil(FList);
    end;

    FLayerStringList.Text := FMapStringList.Text; // assign text to the layer string list

    sbMain.Panels[4].Progress.Position := 0;

    mover.AutoSnap := True;
    mover.Enabled := True;

    AddAssetToList(fMediaPath);

    PopulateLayerControls;

    FmapFile := AOpenMap;
    mapMediaPath := fMediaPath;
//      pnlFileName.Text := 'Current File: ' + FmapFile;
    fmMain.Caption := '';
    fmMain.Caption := 'giLE2D For AGK - ' + strRegistered + ' - Current File: ' + FmapFile;
    sbMain.Panels[0].Text := 'Map Sprite Count: ' + inttostr(CountSprites(self));
    sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);
    sbMain.Panels[2].Text := '';

  finally
    Screen.Cursor := crDefault;
    Self.Repaint;
  end;

  // make UI visible after successful load
  lblHelp.Visible := False;
  pgrSprites.Visible := True;
  pnlForm.Visible := True;
  pnlPager.Visible := True;
  btnSave.Enabled := True;

  btnEditSprite.Enabled := False;

  // populate recent items menu
  recentitems.LoadItemList(mnuRecentItems);
  recentitems.UpdateItemList(FmapFile, mnuRecentItems);

  if FScroller = 1 then
  begin
    pnlMapContainer.Width := 1150 * FRepeater;
    imgBackground.Stretch := True;
  end
  else
  begin
    pnlMapContainer.Width := 1150;
    imgBackground.Stretch := False;
  end;

//    if FSettings.AutoSave then
//      tmrFileSave.Enabled := True;
  FormResize(nil);
end;


procedure TfmMain.btnOpenClick(Sender: TObject);
begin
  AskToSave;
  if dlgOpenMap.Execute then
  begin
    OpenMap(dlgOpenMap.FileName);
  end;
end;

procedure TfmMain.RecentItemClick(Sender: TObject);
var
  tmpitem: TMenuItem;
begin
  if Sender is TMenuItem then
  begin
    AskToSave;
    tmpitem := TMenuItem(Sender);
    OpenMap(tmpitem.Caption);
  end;
end;

procedure TfmMain.btnRefreshSpriteListClick(Sender: TObject);
var
  fdlgPath, fMediaPath: string;
begin
  fdlgPath := ExtractFilePath(FmapFile);
  fMediaPath := Copy(fdlgPath, 0, Length(fdlgPath) - 5);

  lstManifest.ClearItems;

  AddAssetToList(fMediaPath);
end;

procedure TfmMain.btnSaveClick(Sender: TObject);
begin
  sbMain.Panels[1].Text := 'Saving...';
  try
    if not chkAllLayers.Checked then
      chkAllLayersClick(nil);

    SaveMap(False);
  finally
    sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);
  end;
end;

procedure TfmMain.btnSnapClick(Sender: TObject);
var
  idx: Integer;
  ctrl: TSpriteBlock;
begin
  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      // snap ???
      ctrl := TSpriteBlock(fmMain.Components[idx]);
      if ctrl.Tag = 1 then
      begin
        ctrl.Left := Round(ctrl.Left/16)*16;
        ctrl.Top := Round(ctrl.Top/16)*16;
        Inspector.Panels[INS_PNL_COORDS].Items[2].IntValue := ctrl.Left;
        Inspector.Panels[INS_PNL_COORDS].Items[3].IntValue := ctrl.Top;
      end;
    end;
  end;
end;

procedure TfmMain.cbPhysicsShapeSetProperties(Sender: TObject; R: TRect; Item: TInspectorItem);
begin
  with cbPhysicsShape.ColumnComboBox do
  begin
    Columns.Clear;
    with Columns.Add do
    begin
      Width := 50;
      Font.Name := 'Tahoma';
    end;
    with Columns.Add do
    begin
      Width := 150;
      Font.Color := clBlue;
      Font.Style := [fsItalic];
      Font.Name := 'Tahoma';
    end;

    ComboItems.Clear;
    with ComboItems.Add.Strings do
    begin
      Add('0');
      Add('No Shape');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('1');
      Add('Circle');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('2');
      Add('Box');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('3');
      Add('Polygon');
    end;

    ItemIndex := Item.IntValue;
  end;
end;

procedure TfmMain.cbPhysTypeSetProperties(Sender: TObject; R: TRect; Item: TInspectorItem);
begin
  with cbPhysType.ColumnComboBox do
  begin
    Columns.Clear;
    with Columns.Add do
    begin
      Width := 50;
      Font.Name := 'Tahoma';
    end;
    with Columns.Add do
    begin
      Width := 150;
      Font.Color := clBlue;
      Font.Style := [fsItalic];
      Font.Name := 'Tahoma';
    end;

    ComboItems.Clear;
    with ComboItems.Add.Strings do
    begin
      Add('0');
      Add('Physics Off');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('1');
      Add('Static');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('2');
      Add('Dynamic');
    end;
    with ComboItems.Add.Strings do
    begin
      Add('3');
      Add('Kinematic');
    end;

    ItemIndex := Item.IntValue;
  end;
end;

procedure TfmMain.cbShapeChange(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  lSprite := nil;

  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);
      if lSprite.Tag = 1 then
        Break;
    end;
  end;

  if lSprite <> nil then
  begin
    if IsLoading = False then
      EditProperties(lSprite, Sender);
  end;
end;

procedure TfmMain.chkMapGeometryClick(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  lSprite := nil;

  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);
      if lSprite.Tag = 1 then
        Break;
    end;
  end;

  if lSprite <> nil then
  begin
    EditProperties(lSprite, Sender);

//    grbExploCollect.Enabled := not chkMapGeometry.Checked;
//    grbEnemy.Enabled := not chkMapGeometry.Checked;
  end;
end;

procedure TfmMain.chkShowBtnCaptionsClick(Sender: TObject);
begin
  FSettings.ShowButtonCaptions := chkShowBtnCaptions.Checked;

  ShowMapToolCaptions;
end;

procedure TfmMain.ClearMap(UpdateLayer: boolean = False);
var
  sprite: TSpriteBlock;
  idx: Integer;
begin

  try
    for idx := fmMain.ComponentCount - 1 downto 0 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        sprite := TSpriteBlock(fmMain.Components[idx]);
        try
          if Assigned(sprite) then
            FreeAndNil(sprite)
        except
          on e:Exception do
            ShowMapMsg(self, STR_ERR_CLEARMAP, e.Message, STR_OPCANCELLED, '', 'OK', '');
        end;
      end;
    end;

    if not UpdateLayer then
    begin
      lstManifest.ClearItems;
      MapBackground1.Clear;
      imgBackground.Picture := nil;
    end;

  except
    on e:Exception do
      raise Exception.Create('Could not clear map! ' + e.Message);
  end;
end;

procedure TfmMain.DisplayAllLayers;
var
  sprite: TSpriteBlock;
  cnt, bgcnt: Integer;
  fFileName: string;
begin
  ClearMap(True); // update layers

  if Assigned(mover) then
    FreeAndNil(mover);

  FSpriteCount := 0;

  FLayerStringList.Clear;
  FLayerStringList.Text := FMapStringList.Text;

//  imgBackground.Picture.LoadFromFile(includetrailingbackslash(mapMediaPath) +
//    MapBackGround1[0] + '.png');

  if FScroller = 0 then
  begin
    MergeBackgrounds(includetrailingbackslash(mapMediaPath) + MapBackGround1[0]);
  end
  else
  begin
    for bgcnt := 0 to 3 do
    begin
      MergeBackgrounds(includetrailingbackslash(mapMediaPath) + MapBackGround1[bgcnt]);
    end;
  end;

  mover := TMover.Create(self);
  Screen.Cursor := crHourGlass;
  try
    for cnt := 1 to FLayerStringList.Count - 2 do
    begin
      sprite := TSpriteBlock.Create(self);
      sprite.Parent := pnlMap;
      sprite.Cursor := crHandPoint;
      sprite.CreateFromString(FLayerStringList[cnt]);
      fFileName :=  ExtractFilePath(includetrailingbackslash(mapMediaPath)) + sprite.FileName;
      AddSprite(sprite, fFileName, cnt);
      FSpriteCount := mover.MovableControls.Count; // FSpriteCount + 1;
    end;
  finally
    Screen.Cursor := crDefault;
    Self.Repaint;
  end;

  mover.AutoSnap := True;
  mover.Enabled := True;
end;

procedure TfmMain.DisplayLayers(ALayers: TStringList);
var
  sprite: TSpriteBlock;
  cnt, layercnt, layerpos: Integer;
  fFileName, includelayer: string;
begin
  ClearMap(True); // update layers

  if Assigned(mover) then
    FreeAndNil(mover);

  FSpriteCount := 0;

  FLayerStringList.Clear;

  // go through FMapStringList and load all strings that are in ALayers
  // into FLayerStringList,

  for cnt := 1 to FMapStringList.Count - 1 do
  begin
    layerpos := ansipos('|', FMapStringList[cnt]);
    includelayer := Copy(FMapStringList[cnt], 0, layerpos - 1);
    for layercnt := 0 to ALayers.Count - 1 do
    begin
      if includelayer = ALayers[layercnt] then
        FLayerStringList.Add(FMapStringList[cnt]);
    end;
  end;

  // then use FLayerStringList to populate the scene

  mover := TMover.Create(self);
  Screen.Cursor := crHourGlass;
  try
    for cnt := 0 to FLayerStringList.Count - 1 do
    begin
      sprite := TSpriteBlock.Create(self);
      sprite.Parent := pnlMap;
      sprite.Cursor := crHandPoint;
      sprite.CreateFromString(FLayerStringList[cnt]);
      fFileName :=  ExtractFilePath(includetrailingbackslash(mapMediaPath)) + sprite.FileName;
      AddSprite(sprite, fFileName, cnt);
      FSpriteCount := mover.MovableControls.Count; // FSpriteCount + 1;
    end;
  finally
    Screen.Cursor := crDefault;
    Self.Repaint;
  end;

  mover.AutoSnap := True;
  mover.Enabled := True;

end;

procedure TfmMain.DrawGrid(ALineColor: TColor; AWidth: Integer);
var
  x, y: Integer;
  drawto_x: integer;
begin
  y := 16;
  x := 0;

  if FScroller = 1 then
  begin
    drawto_x := 1136 * FRepeater;
  end
  else
  begin
    drawto_x := 1136;
  end;

  pbGrid.Canvas.Pen.Color := ALineColor;
  pbGrid.Canvas.Pen.Width := 1;
  // draw a grid whose cells are 32x32
  while y < 640 do
  begin
    pbGrid.Canvas.MoveTo(0, y);
    pbGrid.Canvas.LineTo(imgBackground.Width, y);
    y := y + 32;
  end;

  while x < drawto_x do
  begin
    pbGrid.Canvas.MoveTo(x, imgBackground.Height);
    pbGrid.Canvas.LineTo(x, 0);
    x := x + 32;
  end;

end;


procedure TfmMain.EditProperties(ASprite: TSpriteBlock; Sender: TObject; AInspectorItem: TInspectorItem = nil);
begin

  case AInspectorItem.Tag of

    SPR_LAYER: ASprite.Layer := AInspectorItem.IntValue;
    SPR_INTTAG: ASprite.IntTag := AInspectorItem.IntValue;

    SPR_FILEID: ASprite.FileID := AInspectorItem.IntValue;

    SPR_ISMAPPGEO:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsMapGeometry := 0
        else
          ASprite.IsMapGeometry := 1;
      end;

    SPR_XCOORDS: ASprite.Xcoord := AInspectorItem.IntValue;
    SPR_YCOORDS: ASprite.Ycoord := AInspectorItem.IntValue;
    SPR_XSIZE: ASprite.Xsize := AInspectorItem.IntValue;
    SPR_YSIZE: ASprite.Ysize := AInspectorItem.IntValue;
    SPR_XOFFSET: ASprite.Xoffset := AInspectorItem.IntValue;
    SPR_YOFFSET: ASprite.Yoffset := AInspectorItem.IntValue;
    SPR_PHYTYPE: ASprite.physics := AInspectorItem.IntValue;
    SPR_PHYSHAPE: ASprite.shape := AInspectorItem.IntValue;

    SPR_EXPLODE:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsExplodable := 0
        else
          ASprite.IsExplodable := 1;
      end;

    SPR_COLLECT:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsCollectable := 0
        else
          ASprite.IsCollectable := 1;
      end;

    SPR_COLPOINTS: ASprite.PointsValue := AInspectorItem.IntValue;
    SPR_COLHEALTH: ASprite.ColHealthValue := AInspectorItem.IntValue;
    SPR_COLMONEY: ASprite.MoneyValue := AInspectorItem.IntValue;

    SPR_ISFRIEND:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsFriend := 0
        else
          ASprite.IsFriend := 1;
      end;

    SPR_ISENEMY:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsEnemy := 0
        else
          ASprite.IsEnemy := 1;
      end;

    SPR_FEHEALTH: ASprite.HealthValue := AInspectorItem.IntValue;

    SPR_ISMOVPLAT:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsMovingPlatform := 0
        else
          ASprite.IsMovingPlatform := 1;
      end;

    SPR_XFROM: ASprite.pXmoveFrom := AInspectorItem.IntValue;
    SPR_XTO: ASprite.pXmoveTo := AInspectorItem.IntValue;
    SPR_YFROM: ASprite.pYmoveFrom := AInspectorItem.IntValue;
    SPR_YTO: ASprite.pYmoveTo := AInspectorItem.IntValue;
    SPR_VELOCITY: ASprite.pVelocity := AInspectorItem.IntValue;

    SPR_ISSPRINT:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsSpringboard := 0
        else
          ASprite.IsSpringboard := 1;
      end;

    SPR_SFORCE: ASprite.SpringForce := AInspectorItem.IntValue;
    SPR_ISTELE:
      begin
        if AInspectorItem.BoolValue = False then
          ASprite.IsTeleporter := 0
        else
          ASprite.IsTeleporter := 1;
      end;

    SPR_TELEX: ASprite.TeleportX := AInspectorItem.IntValue;
    SPR_TELEY: ASprite.TeleportY := AInspectorItem.IntValue;

    SPR_PLAYERSTART: ASprite.PlayerStartMarker := AInspectorItem.IntValue;

  end;

  NeedSave := True;
end;

procedure TfmMain.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if key = 46 then
  begin
    btnDelSpriteClick(nil);
  end;
end;

procedure TfmMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  //"eat" da key presses
  //Key := #0;
end;

procedure TfmMain.FormResize(Sender: TObject);
begin
  pnlMapContainer.Left := (AdvScrollBox1.Width - pnlMapContainer.Width) div 2;
  if pnlMapContainer.Left < 2 then pnlMapContainer.Left := 2;

  pnlMapContainer.Top :=  (AdvScrollBox1.Height - pnlMapContainer.Height) div 2;
  if pnlMapContainer.Top < 2 then pnlMapContainer.Top := 2;
end;

procedure TfmMain.InspectorEditStop(Sender: TObject; AInspectorPanel: TInspectorPanel;
  AInspectorItem: TInspectorItem);
var
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  if IsLoading = False then
  begin
    lSprite := nil;

    for idx := 0 to fmMain.ComponentCount - 1 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        lSprite := TSpriteBlock(fmMain.Components[idx]);
        if lSprite.Tag = 1 then
          Break;
      end;
    end;

    if lSprite <> nil then
    begin
      EditProperties(lSprite, Sender, AInspectorItem);
    end;
  end;
end;

procedure TfmMain.lbLayersCheckClick(Sender: TObject; Index: Integer);
var
  layerlist: TStringList;
  cnt, chkcnt: integer;
begin
  // when we check an item in the layer list
  // we need to uncheck and enable the "display all layers" checkbox
  chkAllLayers.Checked := False;
  chkAllLayers.Enabled := True;

  chkcnt := 0;

  layerlist := TStringList.Create;
  try
    for cnt := 0 to lbLayers.Count - 1 do
    begin
      if lbLayers.Checked[cnt] = True then
      begin
        layerlist.Add(Copy(lbLayers.Items[cnt], 0, ansipos('-', lbLayers.Items[cnt]) - 1));
        chkcnt := chkcnt + 1;
      end;
    end;

    if chkcnt > 0 then
      DisplayLayers(layerlist)
    else
    begin
      chkAllLayers.Checked := True;
      chkAllLayers.Enabled := False;
      DisplayAllLayers;
    end;

  finally
    FreeAndNil(layerlist);
  end;
end;


procedure TfmMain.ReIndexLayers;
var
  cnt: Integer;
  lsuffix, selectedlayer: string;
begin
  selectedlayer := cbxLayer.Text;
  for cnt := 0 to lbLayers.Items.Count - 1 do
  begin
    lsuffix := Copy(lbLayers.Items[cnt], ansipos('-', lbLayers.Items[cnt]) + 1, maxint);
    lbLayers.Items[cnt] := inttostr(LAYER_DEFAULT + cnt) + '-' + lsuffix;
    cbxLayer.Items[cnt] := lbLayers.Items[cnt];
  end;
  lbLayers.Items.SaveToFile(FLayerFile);
  cbxLayer.SelectItem(selectedlayer);
end;

procedure TfmMain.ReIndexMapStringList(AFrom, ATo: integer);
var
  //cnt: integer;
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  // 1st pass - set AFrom sprites to 99999
  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);

      if lSprite.Layer = AFrom then
        lSprite.Layer := 99999;
    end;
  end;

  // 2nd pass - set ATo sprites to AFrom
  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);

      if lSprite.Layer = ATo then
        lSprite.Layer := AFrom;
    end;
  end;

  // 3rd pass - set 99999 sprites to ATo
  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);

      if lSprite.Layer = 99999 then
        lSprite.Layer := ATo;
    end;
  end;

  TGazzMap.CreateFileContents(self, FMapStringList, MapBackground1, FScroller, FRepeater);

end;

procedure TfmMain.LbMoveItemDown(AListBox: THTMLCheckList);
var
  CurrIndex, LastIndex: Integer;
  lFrom, lTo: integer;
begin
  with AListBox do
  begin
    CurrIndex := ItemIndex;
    LastIndex := Items.Count;
    if ItemIndex <> -1 then
    begin
      if CurrIndex + 1 < LastIndex then
      begin
        lFrom := strtoint(Copy(Items[ItemIndex], 0, ansipos('-', Items[ItemIndex]) - 1));
        lTo := strtoint(Copy(Items[CurrIndex + 1], 0, ansipos('-', Items[CurrIndex + 1]) - 1));

        Items.Move(ItemIndex, (CurrIndex + 1));
        ItemIndex := CurrIndex + 1;

        ReIndexMapStringList(lFrom, lTo);
      end;
      ReIndexLayers;
      NeedSave := True;
    end;
  end;
end;

procedure TfmMain.LbMoveItemUp(AListBox: THTMLCheckList);
var
  CurrIndex: Integer;
  lFrom, lTo: integer;
begin
  with AListBox do
  if ItemIndex > 0 then
  begin
    CurrIndex := ItemIndex;

    lFrom := strtoint(Copy(Items[ItemIndex], 0, ansipos('-', Items[ItemIndex]) - 1));
    lTo := strtoint(Copy(Items[CurrIndex - 1], 0, ansipos('-', Items[CurrIndex - 1]) - 1));

    Items.Move(ItemIndex, (CurrIndex - 1));
    ItemIndex := CurrIndex - 1;

    ReIndexMapStringList(lFrom, lTo);
  end;
  ReIndexLayers;
  NeedSave := True;
end;

procedure TfmMain.OnPolyClick(Sender: TObject; Item: TCustomItem);
begin
  FCurrentPolyItemDescription := TImageItem(Item).Description;
  btnEditSprite.Enabled := True;
end;

procedure TfmMain.OnThumbListClick(Sender: TObject; Item: TCustomItem);
var
  lFileName: string;
begin
  if mover.Clone then
  begin
    ShowMapMsg(self, STR_ERROR, STR_NEWOBJ_INCLONE, '', '', 'OK', '');
    Exit;
  end;

  if IsPowerOfTwo(TImageItem(Item).Image.Width) and
    IsPowerOfTwo(TImageItem(Item).Image.Height) then
  begin
    lFileName := TImageItem(Item).Description;
    AddSprite(FSpriteCount + 1, lFileName);
    FSpriteCount := mover.MovableControls.Count; // FSpriteCount + 1;
    sbMain.Panels[0].Text := 'Map Sprite Count: ' + inttostr(CountSprites(self));
    sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);
  end
  else
  begin
    ShowMapMsg(self, STR_ERROR, STR_NOTPOWEROF2, STR_OPCANCELLED, '', 'OK', '');
  end;
end;

procedure TfmMain.pbGridClick(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
  pt: TPoint;
begin
  lSprite := nil;

  if mover.Clone then
  begin
    for idx := 0 to fmMain.ComponentCount - 1 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        lSprite := TSpriteBlock(fmMain.Components[idx]);
        if lSprite.Tag = 1 then
          Break;
      end;
    end;

    if lSprite <> nil then
    begin
      try
        FCopyBuffer := TSpriteBlock.Create(self);
        FCopyBuffer.Copy(lSprite);
        FCopyBuffer.Parent := pnlMap;
        pt := Mouse.CursorPos;
        pt := pnlMap.ScreenToClient(pt);
        FCopyBuffer.Left := pt.X;
        FCopyBuffer.Top := pt.Y;
        FCopyBuffer.Xcoord := pt.X;
        FCopyBuffer.Ycoord := pt.Y;

        // increase the sprite count
        FSpriteCount := mover.MovableControls.Count; // FSpriteCount + 1;

        // assign the id
        FCopyBuffer.FileID := FSpriteCount;

        mover.Add(FCopyBuffer);

        // reset the mover
        mover.Enabled := False;
        mover.Enabled := True;

      except
        on e:Exception do
          ShowMapMsg(self, STR_ERROR, e.Message, '', '', 'OK', '');
      end;
    end;
  end;
end;

procedure TfmMain.pbGridMouseLeave(Sender: TObject);
begin
  sbMain.Panels[3].Text := '';
end;

procedure TfmMain.pbGridMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  sbMain.Panels[3].Text := 'Coords: ' + IntToStr(x) + ', ' + IntToStr(y);
end;

procedure TfmMain.pbGridPaint(Sender: TObject);
begin
  DrawGrid(FGridLineColor, 1);
end;

procedure TfmMain.pgrSpritesSubChange(Sender: TObject);
begin
  if IsLoading then
   Exit;

 if pgrSpritesSub.ActivePageIndex = 1 then
 begin
   lstInUse.ClearItems;
   ViewCurrentUsedAssets(mapMediaPath);
 end;
end;

procedure TfmMain.PopulateLayerControls;
begin
  lbLayers.Clear;
  cbxLayer.Clear;
  lbLayers.Items.LoadFromFile(FLayerFile);
  cbxLayer.Items.LoadFromFile(FLayerFile);
  cbxLayer.SelectItem('1000-Default');
end;

procedure TfmMain.rbExplodableClick(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  lSprite := nil;

  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      lSprite := TSpriteBlock(fmMain.Components[idx]);
      if lSprite.Tag = 1 then
        Break;
    end;
  end;

  if lSprite <> nil then
  begin
    EditProperties(TSpriteBlock(lSprite), Sender);
  end;
end;


procedure TfmMain.SaveMap(AAutoSave: boolean);
var
  LMap: TGazzMap;
  playercnt: integer;
begin

  playercnt := CheckPlayerMarker(self);

  // check for a player marker
  if playercnt <> 1 then
  begin
    if playercnt > 1 then
      ShowMapMsg(self, STR_PLYMARKER_ERR, STR_TOOMANY_PLY, STR_ONLYONEPLY, '', 'OK', '');

    if playercnt < 1 then
      ShowMapMsg(self, STR_PLYMARKER_ERR, STR_NOPLY, STR_ONEPLY, '', 'OK', '');

    Exit;
  end;

  // check that a background has been added
  if imgBackground.Picture = nil then
  begin
    ShowMapMsg(self, STR_BACKGRND_ERR, STR_NOBACK, STR_ONEBACK, '', 'OK', '');
    Exit;
  end;

  LMap := TGazzMap.Create;

  try
//    LMap.MapBackground := MapBackground;

    if FmapFile = '' then
    begin
      if dlgSave.Execute then
      begin
        LMap.WriteFile(self, dlgSave.FileName, MapBackground1, FScroller, FRepeater);
        NeedSave := False;
      end;
    end
    else
    begin
      if FileExists(FmapFile) then
      begin
        if not AAutoSave then
        begin
          if ShowMapMsg(self, STR_OVERWRITE, STR_OVERWRITEOK + FmapFile + '?', '', '',
            STR_YESOVERWRITE, STR_NO) = 101 then
          Exit;
        end;
      end;
      LMap.WriteFile(self, FmapFile, MapBackground1, FScroller, FRepeater);
      NeedSave := False;
    end;

  finally
    FreeAndNil(LMap);
  end;
//  pnlFileName.Text := 'Current File: ' + FmapFile;
  fmMain.Caption := '';
  fmMain.Caption := 'giLE2D For AGK - ' + strRegistered + ' - Current File: ' + FmapFile;
end;

procedure TfmMain.ShowMapToolCaptions;
var
  idx: Integer;
  btn: TAdvGlowButton;
begin
  for idx := 0 to fmMain.ComponentCount - 1 do
  begin
    if fmMain.Components[idx] is TAdvGlowButton then
    begin
      btn := TSpriteBlock(fmMain.Components[idx]);
      if btn.Parent.Name = 'tbMapTools' then
      begin
        btn.ShowCaption := FSettings.ShowButtonCaptions;
        if FSettings.ShowButtonCaptions then
          btn.Width := 88
        else
          btn.Width := 45;
      end;
    end;
  end;
end;

procedure TfmMain.tmrFileSaveTimer(Sender: TObject);
begin
  sbMain.Panels[1].Text := 'Saving...';
  try
    SaveMap(True);
  finally
    sbMain.Panels[1].Text := 'Media Files Count: ' + inttostr(lstManifest.ItemCount);
  end;
end;

procedure TfmMain.txtFileIDChange(Sender: TObject);
var
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  if IsLoading = False then
  begin
    lSprite := nil;

    for idx := 0 to fmMain.ComponentCount - 1 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        lSprite := TSpriteBlock(fmMain.Components[idx]);
        if lSprite.Tag = 1 then
          Break;
      end;
    end;

    if lSprite <> nil then
    begin
      EditProperties(lSprite, Sender);
    end;
  end;
end;

procedure TfmMain.ViewCurrentUsedAssets(AFolder: string);
var
  reflist: TStringList;
  idx: Integer;
  lSprite: TSpriteBlock;
begin
  sbMain.Panels[2].Text := 'Loading In Use Asset List...';
  sbMain.Panels[4].Progress.Position := 0;
  sbMain.Panels[4].Progress.min := 0;

  reflist := TStringList.Create;

  try
    lstInUse.BeginUpdate;

    for idx := 0 to fmMain.ComponentCount - 1 do
    begin
      if fmMain.Components[idx] is TSpriteBlock then
      begin
        lSprite := TSpriteBlock(fmMain.Components[idx]);

        // check to see if we already have this file in our used list
        if not SearchStringList(reflist, lSprite.FileName) then
        begin
          with TImageItem(lstInUse.AddItem(TImageItem)) do
          begin
            Width := 240;
            Height := 90;
            ImageWidth := 48;
            ImageHeight := 48;

            Image.LoadFromFile(IncludeTrailingBackslash(AFolder) + lSprite.FileName);
              //inttostr(lSprite.FileID) + lSprite.FileExtension);

            Caption := lSprite.FileName + ': (Size ' + //Inttostr(lSprite.FileID) + lSprite.FileExtension
              inttostr(Image.Width) + 'x' + inttostr(Image.Height) + ')';

            CaptionLocation := tlTopCenter;
            CaptionSize := 8;
            //CaptionColor := clBlue;
            CaptionFontStyle := [fsBold];

            Description := IncludeTrailingBackslash(AFolder) + lSprite.FileName
//              inttostr(lSprite.FileID) +
//              lSprite.FileExtension
              ;
            DescriptionLocation := tlTopCenter;
            DescriptionSize := 7;
            //DescriptionColor := clBlue;

            AspectRatio := true;

            OnItemDblClick := OnThumbListClick;
            OnItemClick := OnPolyClick;

            reflist.Add(lSprite.FileName);
          end;
          Application.ProcessMessages;
          sbMain.Panels[2].Text := IncludeTrailingBackslash(AFolder) + lSprite.FileName
//          inttostr(lSprite.FileID) + lSprite.FileExtension
          + '...';
          sbMain.Panels[4].Progress.Position := sbMain.Panels[4].Progress.Position + 1;
        end;
      end;
    end;

    lstInUse.EndUpdate;
    sbMain.Panels[2].Text := '';
    sbMain.Panels[4].Progress.Position := 0;

  finally
    FreeAndNil(reflist);
  end;
end;

procedure TfmMain.WMDROPFILES(var Msg: TWMDropFiles);
var
  i, amount: Integer;
  FileName: array[0..MAX_PATH] of Char;
  lFileList: TStringList;
  errstr: string;
  dlgImport: TfmImport;
begin
  inherited;

  if pnlForm.Visible = False then
  begin
    // ERROR! cannot drag files whe no project open!
    ShowMapMsg(self, STR_ERROR, STR_NOIMPORT, STR_NOPROJ_OPEN, '', 'OK', '');
    Exit;
  end;

  lFileList := TStringList.Create;
  try

    try
      Amount := DragQueryFile(Msg.Drop, $FFFFFFFF, FileName, MAX_PATH);
      for i := 0 to (Amount - 1) do
      begin
        DragQueryFile(Msg.Drop, i, FileName, MAX_PATH);
        // populate stringlist of the files
        lFileList.Add(FileName);
      end;

    finally
      DragFinish(Msg.Drop);
    end;
    // next, go through the list and import
    errstr := ImportAssets(mapMediaPath, lFileList, FSettings);

    // after the list is done, refresh the spritelist
    btnRefreshSpriteListClick(nil);

  finally
    FreeAndNil(lFileList);
  end;

  // if there have been errors, show them here in the uImport dialog
  if errstr <> '' then
  begin
    if ShowMapMsg(self, STR_ERROR, STR_IMPORT_ERR, '', '', STR_VIEWIMP_LOG, STR_NO) = 100 then
    begin
      dlgImport := TfmImport.Create(self);
      try
        dlgImport.MyFormStyler := fmStyler;
        dlgImport.ErrStr := errstr;
        dlgImport.Init;
        dlgImport.ShowModal;
      finally
        FreeAndNil(dlgImport);
      end;
    end;
  end;

end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AskToSave;
  ClearMap;

  FSettings.WriteToIni(self);

  FreeAndNil(FTmp);
  imgBackground.Picture.Graphic := nil;

  if Assigned(FSettings) then
    FreeAndNil(FSettings);

  if Assigned(FMapStringList) then
    FreeAndNil(FMapStringList);

  if Assigned(FLayerStringList) then
    FreeAndNil(FLayerStringList);

  if Assigned(FMapBackground1) then
    FreeAndNil(FMapBackground1);

  if Assigned(mover) then
      FreeAndNil(mover);

  if Assigned(recentitems) then
    FreeAndNil(recentitems);
end;

end.
