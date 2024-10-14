unit uBackgrounds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvSmoothListBox, AdvAppStyler, AdvPanel, ExtCtrls, ExtDlgs,
  AdvGlowButton, PngImage, Jpeg, Menus, AdvMenus, ShellAPI;

type
  TfmBackgrounds = class(TForm)
    pnlBackMain: TAdvPanel;
    fmStyler: TAdvFormStyler;
    lstBackgrounds: TAdvSmoothListBox;
    pnlPreview: TPanel;
    dlgPic: TOpenPictureDialog;
    btnOK: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
    imgPreview: TImage;
    mnuEdit: TAdvPopupMenu;
    EditBackdrop1: TMenuItem;
    procedure lstBackgroundsItemClick(Sender: TObject; itemindex: Integer);
    procedure lstBackgroundsItemDblClick(Sender: TObject; itemindex: Integer);
    procedure btnOKClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure lstBackgroundsItemHint(Sender: TObject; itemindex: Integer; var hint: string);
    procedure EditBackdrop1Click(Sender: TObject);
  private
    FMediaPath: string;
    FBGList: TStringList;
    FScroller: integer;
    procedure EnableItems;
  public
    procedure init(AMediaPath: string; ABGList: TStringList; AScroller: integer);
  end;

var
  fmBackgrounds: TfmBackgrounds;

implementation

{$R *.dfm}

uses uMain, uCommonFuncs;

procedure TfmBackgrounds.btnOKClick(Sender: TObject);
var
  cnt: integer;
begin
  FBGList.Clear;

  if FScroller = 0 then
  begin
    FBGList.Add(ExtractFileName(lstBackgrounds.Items[0].Caption));
  end
  else
  begin
    for cnt := 0 to 3 do
      FBGList.Add(ExtractFileName(lstBackgrounds.Items[cnt].Caption));
  end;

  ModalResult := mrOK;
end;

procedure TfmBackgrounds.EditBackdrop1Click(Sender: TObject);
begin
  if lstBackgrounds.SelectedItemIndex <> -1 then
    ShellExecute(Handle, 'open', pwidechar(lstBackgrounds.Items[lstBackgrounds.SelectedItemIndex].Caption),
      nil, nil, SW_SHOWNORMAL)
  else
    ShowMapMsg(self, STR_ERROR, 'Please select a backdrop to edit!', '', '', 'OK', '');
end;

procedure TfmBackgrounds.EnableItems;
var
  cnt: Integer;
begin
  if FBGList.Count > 0 then
  begin

    if FScroller = 0 then
    begin
      lstBackgrounds.Items[0].Enabled := True;
      lstBackgrounds.Items[1].Enabled := False;
      lstBackgrounds.Items[2].Enabled := False;
      lstBackgrounds.Items[3].Enabled := False;
    end
    else
    begin
      lstBackgrounds.Items[0].Enabled := True;
      lstBackgrounds.Items[1].Enabled := True;
      lstBackgrounds.Items[2].Enabled := True;
      lstBackgrounds.Items[3].Enabled := True;
    end;

    if FScroller = 0 then
    begin
      lstBackgrounds.Items[0].Caption := FMediaPath + FBGList[0];
      MergeBackgrounds(lstBackgrounds.Items[0].Caption);
    end
    else
    begin
      for cnt := 0 to 3 do
      begin
        lstBackgrounds.Items[cnt].Caption := FMediaPath + FBGList[cnt];
        MergeBackgrounds(lstBackgrounds.Items[cnt].Caption);
      end;
    end;

    if FTmp <> nil then
    begin
      imgPreview.Picture.Graphic := FTmp;
      imgPreview.Update;
    end;

  end;
end;

procedure TfmBackgrounds.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(FTmp);
  imgPreview.Picture.Graphic := nil;
end;

procedure TfmBackgrounds.FormCreate(Sender: TObject);
begin
  FreeAndNil(FTmp);
  imgPreview.Picture.Graphic := nil;
end;

procedure TfmBackgrounds.init(AMediaPath: string; ABGList: TStringList; AScroller: integer);
begin
  fmStyler.Style := fmMain.fmStyler.Style;
  FMediaPath := AMediaPath;
  FBGList := ABGList;
  FScroller := AScroller;

  EnableItems;

end;

procedure TfmBackgrounds.lstBackgroundsItemClick(Sender: TObject; itemindex: Integer);
begin
  //imgPreview.Picture.LoadFromFile(lstBackgrounds.Items[itemindex].Caption);
end;

procedure TfmBackgrounds.lstBackgroundsItemDblClick(Sender: TObject; itemindex: Integer);
var
  cnt: Integer;
begin
  dlgPic.InitialDir := FMediaPath;

  if dlgPic.Execute then
  begin
    if ExtractFileExt(dlgpic.FileName) <> '.png' then
    begin
      ShowMapMsg(self, STR_ERROR, STR_PNGONLY_BG +
        STR_OPCANCELLED, '', '', 'OK', '');
      Exit;
    end;

    lstBackgrounds.Items[itemindex].Caption := dlgPic.FileName;

    FreeAndNil(FTmp);
    imgPreview.Picture.Graphic := nil;

    if FScroller = 0 then
    begin
      MergeBackgrounds(lstBackgrounds.Items[0].Caption);
    end
    else
    begin
      for cnt := 0 to 3 do
      begin
        MergeBackgrounds(lstBackgrounds.Items[cnt].Caption);
      end;
    end;

    if FTmp <> nil then
    begin
      imgPreview.Picture.Graphic := FTmp;
      imgPreview.Update;
    end;

  end;
end;

procedure TfmBackgrounds.lstBackgroundsItemHint(Sender: TObject; itemindex: Integer; var hint: string);
begin
  hint := '<B>' + lstBackgrounds.Items[itemindex].Caption + '</B><hr><BR>' +
    'Double-Click to change, or right-click to edit<BR>';
end;

end.
