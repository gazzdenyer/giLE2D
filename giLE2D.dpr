program giLE2D;

uses
  Forms,
  uMain in 'uMain.pas' {fmMain},
  mover in 'mover.pas',
  controlPosition in 'controlPosition.pas',
  uNewMap in 'uNewMap.pas' {fmNewMap},
  uSpriteBlock in 'uSpriteBlock.pas',
  uCommonFuncs in 'uCommonFuncs.pas',
  uSettings in 'uSettings.pas' {fmSettings},
  uConfig in 'uConfig.pas',
  uImport in 'uImport.pas' {fmImport},
  uAbout in 'uAbout.pas' {fmAbout},
  uLayerObj in 'uLayerObj.pas',
  uLayerDlg in 'uLayerDlg.pas' {fmLayerDlg},
  uLayerDelete in 'uLayerDelete.pas' {fmLayerDelete},
  uCrypt in 'uCrypt.pas',
  uBackgrounds in 'uBackgrounds.pas' {fmBackgrounds},
  uNewFrameworkProject in 'uNewFrameworkProject.pas' {fmNewProject},
  uRecentItems in 'uRecentItems.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'giLE2D For AGK';

  Application.CreateForm(TfmMain, fmMain);
  Application.Run;
end.
