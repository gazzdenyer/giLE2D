unit uAbout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, AdvGlowButton, AdvAppStyler, AdvOfficePager, AdvOfficePagerStylers,
  ComCtrls, Menus;

type
  TfmAbout = class(TForm)
    Image1: TImage;
    AdvGlowButton1: TAdvGlowButton;
    fmStyler: TAdvFormStyler;
    lblRegistered: TLabel;
    AdvOfficePager1: TAdvOfficePager;
    AdvOfficePager11: TAdvOfficePage;
    AdvOfficePager12: TAdvOfficePage;
    AdvOfficePager13: TAdvOfficePage;
    AdvOfficePagerOfficeStyler1: TAdvOfficePagerOfficeStyler;
    Memo1: TMemo;
    RichEdit1: TRichEdit;
    PopupMenu1: TPopupMenu;
    Print1: TMenuItem;
    PrintDialog1: TPrintDialog;
    Memo2: TMemo;
    procedure AdvGlowButton1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Print1Click(Sender: TObject);
  private
    { Private declarations }
  public
    procedure init(ARegStatus: string);
  end;

var
  fmAbout: TfmAbout;

implementation

{$R *.dfm}

procedure TfmAbout.AdvGlowButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfmAbout.FormCreate(Sender: TObject);
begin
  Image1.Picture.LoadFromFile('foxlogo.png');
  RichEdit1.Lines.LoadFromFile('EULAgiLE2D.rtf');
end;

procedure TfmAbout.init(ARegStatus: string);
begin
  lblRegistered.Caption := ARegStatus;
end;

procedure TfmAbout.Print1Click(Sender: TObject);
begin
  if PrintDialog1.Execute then
    RichEdit1.Print('EULA');
end;

end.
