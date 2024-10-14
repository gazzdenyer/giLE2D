unit uLayerDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AdvEdit, AdvGlowButton, AdvAppStyler, ExtCtrls, AdvPanel;

type
  TfmLayerDlg = class(TForm)
    pnlLayer: TAdvPanel;
    AdvFormStyler1: TAdvFormStyler;
    AdvGlowButton1: TAdvGlowButton;
    AdvGlowButton2: TAdvGlowButton;
    txtLayerName: TAdvEdit;
    procedure btnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fmLayerDlg: TfmLayerDlg;

implementation

{$R *.dfm}

uses uCommonFuncs, uMain;

procedure TfmLayerDlg.btnOKClick(Sender: TObject);
begin
  if txtLayerName.Text = '' then
  begin
    ShowMapMsg(self, STR_ERROR, STR_PICK_LNAME, '', '', 'OK', '');
    Exit;
  end;

  ModalResult := mrOK;
end;

end.
