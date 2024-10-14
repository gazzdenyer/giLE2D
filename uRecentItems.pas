unit uRecentItems;

interface

uses
  Winapi.Windows, Messages, System.SysUtils, Variants, System.Classes, Forms,
  Menus, StdCtrls;

type
  TRecentItems = class(TPersistent)
  private
    FMaxItemsInList: integer;
    FRecentItemList: TStringList;
    function IsDuplicate(AItem: string): boolean;
  public
    property MaxItemsInList: integer read FMaxItemsInList write FMaxItemsInList;
    property RecentItemList: TStringList read FRecentItemList write FRecentItemList;

    constructor Create(AMaxItems: integer);

    destructor Destroy; override;

    procedure UpdateItemList(AItem: string; AMenu: TPopupMenu);
    procedure LoadItemList(AMenu: TPopupMenu);
  end;

implementation

uses umain;

{ TRecentItems }

constructor TRecentItems.Create(AMaxItems: integer);
begin
  FRecentItemList := TStringList.Create;

  if AMaxItems > 5 then
    FMaxItemsInList := AMaxItems
  else
    FMaxItemsInList := 5;
end;

destructor TRecentItems.Destroy;
begin
  FreeAndNil(FRecentItemList);
  inherited;
end;

function TRecentItems.IsDuplicate(AItem: string): boolean;
var
  cnt: Integer;
begin
  Result := False;
  for cnt := 0 to FRecentItemList.Count - 1 do
  begin
    if AItem = FRecentItemList[cnt] then
    begin
      Result := true;
      Break;
    end;
  end;
end;

procedure TRecentItems.LoadItemList(AMenu: TPopupMenu);
var
  tmpitem: TMenuItem;
  cnt: Integer;
  reclistfile: string;
begin
  FRecentItemList.Clear;

  reclistfile := ExtractFilePath(Application.ExeName) + 'recent.mnu';

  try
    if FileExists(reclistfile) then
      FRecentItemList.LoadFromFile(reclistfile)
    else
      FRecentItemList.SaveToFile(reclistfile);
  except
    on e:Exception do
    begin
      raise Exception.Create('Could not load recent items list! ' + e.Message);
      Exit;
    end;
  end;


  AMenu.Items.Clear;

  if FRecentItemList.Count = 0 then
    Exit;

  for cnt := 0 to FRecentItemList.Count - 1 do
  begin
    tmpitem := TMenuItem.Create(AMenu);
    tmpitem.Caption := FRecentItemList[cnt];
    tmpitem.OnClick := fmMain.RecentItemClick;
    AMenu.Items.Add(tmpitem);
  end;

end;

procedure TRecentItems.UpdateItemList(AItem: string; AMenu: TPopupMenu);
var
  tmpitem: TMenuItem;
  cnt: Integer;
begin
  if IsDuplicate(AItem) then
    Exit;

  if FRecentItemList.count = 0 then
  begin
    FRecentItemList.Add(AItem);
  end
  else
  begin
    FRecentItemList.Insert(0, AItem);

    if FRecentItemList.count > FMaxItemsInList then
    begin
      FRecentItemList.Delete(FMaxItemsInList);
    end;
  end;

  try
    FRecentItemList.SaveToFile(ExtractFilePath(Application.ExeName) + 'recent.mnu');
  except
    on e:Exception do
    begin
      raise Exception.Create('Could not save recent items list! ' + e.Message);
      Exit;
    end;
  end;

  AMenu.Items.Clear;
  for cnt := 0 to FRecentItemList.Count - 1 do
  begin
    tmpitem := TMenuItem.Create(AMenu);
    tmpitem.Caption := FRecentItemList[cnt];
    tmpitem.OnClick := fmMain.RecentItemClick;
    AMenu.Items.Add(tmpitem);
  end;

end;

end.
