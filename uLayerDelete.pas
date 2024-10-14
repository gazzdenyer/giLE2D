unit uLayerDelete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, AdvPanel, AdvOfficeButtons, AdvCombo, AdvGroupBox;

type
  TfmLayerDelete = class(TForm)
    AdvPanel1: TAdvPanel;
    btnOK: TButton;
    btnCancel: TButton;
    rbMoveSpriteDeleteLayer: TAdvOfficeRadioButton;
    rbDeleteLayerAndSprites: TAdvOfficeRadioButton;
    Label1: TLabel;
    lblLayerToDelete: TLabel;
    grbMoveSprites: TAdvGroupBox;
    cbxLayer: TAdvComboBox;
    procedure btnOKClick(Sender: TObject);
    procedure cbxLayerSelect(Sender: TObject);
    procedure rbMoveSpriteDeleteLayerClick(Sender: TObject);
  private
    FLayerID: integer;
    FToLayer: integer;
  public
    property ToLayer: integer read FToLayer;
    procedure Init(AComboboxItems: TStrings; ALayerID: integer);
  end;


implementation

{$R *.dfm}

uses uCommonFuncs;

{ TfmLayerDelete }

procedure TfmLayerDelete.btnOKClick(Sender: TObject);
var
  domodalok: integer;
begin
  domodalok := 0;

  if rbMoveSpriteDeleteLayer.Checked then
  begin
    if cbxLayer.Text = '' then
    begin
      ShowMapMsg(self, STR_OOPS, STR_MOVE_SPRITE_TO, '', '', 'OK', '');
      Exit;
    end
    else
      domodalok := domodalok + 1;
  end;

  if rbDeleteLayerAndSprites.Checked then
  begin
    if ShowMapMsg(self, STR_DEL_LAYERSP, STR_DEL_LAYER_SURE, STR_DELLAYER_WARN, '',
      STR_YES_DEL_LAYERSP, STR_NO) = 100 then
      domodalok := domodalok + 1
    else
      Exit;
  end;

  if domodalok > 0 then
    ModalResult := mrOK
  else
    ModalResult := mrCancel;

end;

procedure TfmLayerDelete.cbxLayerSelect(Sender: TObject);
var
  selstr: string;
begin
  selstr := cbxLayer.Text;
  FToLayer := GetLayerIDFromString(cbxLayer.Text);
  if FLayerID = FToLayer then
  begin
    // cant move to same layer !!!
    FToLayer := -1;
    ShowMapMsg(self, STR_NOTALLOWED, STR_SPR_TODELLAYER,
      '', '', 'OK', '');
    cbxLayer.SelectItem(selstr);
    Exit;
  end;
end;

procedure TfmLayerDelete.Init(AComboboxItems: TStrings; ALayerID: integer);
begin
  FLayerID := ALayerID;
  FToLayer := -1;
  cbxLayer.Clear;
  cbxLayer.Items.Assign(AComboboxItems);
end;

procedure TfmLayerDelete.rbMoveSpriteDeleteLayerClick(Sender: TObject);
begin
  cbxLayer.Enabled := rbMoveSpriteDeleteLayer.Checked;
end;

end.
