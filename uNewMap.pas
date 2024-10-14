unit uNewMap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, AdvOfficeButtons, AdvGroupBox, AdvEdBtn, AdvDirectoryEdit, AdvAppStyler,
  AdvGlowButton, ExtCtrls, AdvPanel, Mask, AdvSpin, System.UITypes;

type
  TfmNewMap = class(TForm)
    AdvFormStyler1: TAdvFormStyler;
    btnOK: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
    pnlNewMap: TAdvPanel;
    txtFile: TAdvEdit;
    txtDir: TAdvDirectoryEdit;
    grbMapType: TAdvGroupBox;
    chkNonScrolling: TAdvOfficeRadioButton;
    chkScrolling: TAdvOfficeRadioButton;
    txtRepeater: TAdvSpinEdit;
    procedure btnOKClick(Sender: TObject);
    procedure chkScrollingClick(Sender: TObject);
    procedure chkNonScrollingClick(Sender: TObject);
    procedure txtRepeaterChange(Sender: TObject);
  private
    FFileName: string;
    FFilePath: string;

    FMediaPath: string;
    FIsScroller: integer;
    FRepeater: integer;

    function ValidateData: string;
  public

    property FilePath: string read FFilePath write FFilePath;
    property FileName: string read FFileName write FFileName;
    property MediaPath: string read FMediaPath write FMediaPath;
    property IsScroller: integer read FIsScroller write FIsScroller;
    property Repeater: integer read FRepeater write FRepeater;
  end;

var
  fmNewMap: TfmNewMap;

implementation

{$WARN SYMBOL_PLATFORM OFF}

{$R *.dfm}

uses uMain, uCommonFuncs;

procedure TfmNewMap.btnOKClick(Sender: TObject);
var
  errstr: string;
  mymapfile: string;
begin
  errstr := ValidateData;

  if Length(errstr) = 0 then
  begin
    FFilePath := IncludeTrailingBackslash(txtDir.Text) + 'maps';
    FFileName := txtFile.Text;
    FMediaPath := txtDir.Text;

    if not DirectoryExists(FFilePath) then
    begin
      if MessageDlg('Directory ' + FFilePath + ' does not exist. Create it?',
        mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        if ForceDirectories(FFilePath) = False then
        begin
          MessageDlg('Could not create directory ' + FFilePath +
          '! Please choose another directory.', mtError, [mbOK], 0);
          Exit;
        end;
      end
      else
        Exit;
    end;

    mymapfile := IncludeTrailingBackslash(FFilePath) + FFileName + '.txt';

    if FileExists(mymapfile) then  // mantis 10
    begin
      ShowMapMsg(self, STR_ERROR, mymapfile + ' already exists!',
        STR_OPCANCELLED, STR_MAPNAMEERR, 'OK', '');

      Exit;
    end;

    ModalResult := mrOK;
  end
  else
  begin
    MessageDlg(errstr, mtWarning, [mbOK], 0);
    Exit;
  end;
end;

procedure TfmNewMap.chkNonScrollingClick(Sender: TObject);
begin
  txtRepeater.Enabled := chkScrolling.Checked;
  FIsScroller := 0;
end;

procedure TfmNewMap.chkScrollingClick(Sender: TObject);
begin
  txtRepeater.Enabled := chkScrolling.Checked;
  FIsScroller := 1;
end;

procedure TfmNewMap.txtRepeaterChange(Sender: TObject);
begin
  FRepeater := txtRepeater.Value;
end;

function TfmNewMap.ValidateData: string;
begin
  Result := '';

  if Length(txtDir.Text) = 0 then
    Result := Result + 'Please specify the path to your AGK project!' + #13#10;

  if Length(txtFile.Text) = 0 then
    Result := Result + 'Please specify a filename for your map!' + #13#10;
end;

end.
