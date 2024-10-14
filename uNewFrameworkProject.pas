unit uNewFrameworkProject;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, AdvGlowButton, AdvAppStyler, AdvEdBtn,
  AdvDirectoryEdit, Vcl.StdCtrls, AdvEdit, Vcl.ExtCtrls, AdvPanel;

type
  TfmNewProject = class(TForm)
    pnlNewMap: TAdvPanel;
    txtFile: TAdvEdit;
    txtDir: TAdvDirectoryEdit;
    AdvFormStyler1: TAdvFormStyler;
    btnOK: TAdvGlowButton;
    btnCancel: TAdvGlowButton;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
