{$WARN SYMBOL_PLATFORM OFF}
unit uImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AdvStyleIF, AdvAppStyler, ExtCtrls, AdvPanel, StdCtrls, CustomItemsContainer, AdvVerticalPolyList,
  FileCtrl, FlCtrlEx;

type
  TfmImport = class(TForm)
    AdvPanel1: TAdvPanel;
    lblImportFrom: TLabel;
    btnOK: TButton;
    fmStyler: TAdvFormStyler;
    pnlStyler: TAdvPanelStyler;
    mmoErrors: TMemo;
    btnSave: TButton;
    dlgSave: TSaveDialog;
    procedure btnSaveClick(Sender: TObject);
  private
    FStyler: TAdvAppStyler;
    FMyFormStyler: TAdvFormStyler;
    FErrStr: string;

  public
    property MyAppStyler: TAdvAppStyler read FStyler write FStyler;
    property MyFormStyler: TAdvFormStyler read FMyFormStyler write FMyFormStyler;
    property ErrStr: string read FErrStr write FErrStr;
    procedure Init;
  end;

var
  fmImport: TfmImport;

implementation

{$R *.dfm}

procedure TfmImport.btnSaveClick(Sender: TObject);
begin
  if dlgSave.Execute then
    mmoErrors.Lines.SaveToFile(dlgSave.FileName);
end;

procedure TfmImport.Init;
begin
  fmStyler.Style := MyFormStyler.Style;
  mmoErrors.Text := ErrStr;
end;

end.
