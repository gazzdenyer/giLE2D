unit controlPosition;

interface
  uses Forms,IniFiles, Classes, Controls, SysUtils, AdvGlowButton, uSpriteBlock;

//  procedure ReadControlPlacement(const form : TForm);
//  procedure WriteControlPlacement(const form : TForm);

  procedure MoveToCoords(x, y: integer; const form : TForm);

implementation

uses uMain;

procedure MoveToCoords(x, y: integer; const form : TForm);
var
  idx: integer;
  btn: TSpriteBlock;
begin
  for idx := 0 to form.ComponentCount - 1 do
  begin
    if form.Components[idx] is TSpriteBlock then
    begin
      btn := TSpriteBlock(form.Components[idx]);
      // use tag to find active block
      if btn.Tag = 1 then
      begin
        btn.Left := x;
        btn.Top := y;
        btn.Tag := 0;
      end;
    end;
  end;
end;

//procedure ReadControlPlacement(const form : TForm);
//var
//  iniFile  : TIniFile;
//  idx : integer;
//  ctrl : TControl;
//  Left,Top,Width,Height: Integer;
//
//  procedure ReadControl(Ctrl: TControl);
//  begin
//    Top := iniFile.ReadInteger(ctrl.Name,'Top',ctrl.Top);
//    Left := iniFile.ReadInteger(ctrl.Name,'Left',ctrl.Left);
//    Width := iniFile.ReadInteger(ctrl.Name,'Width',ctrl.Width);
//    Height := iniFile.ReadInteger(ctrl.Name,'Height',ctrl.Height);
//    ctrl.SetBounds(Left,Top,Width,Height);
//  end;
//
//begin
//  iniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
//  try
//    ReadControl(form);
//    for idx := 0 to -1 + form.ComponentCount - 1 do
//    begin
//      if form.Components[idx] is TControl then
//        ReadControl(TControl(form.Components[idx]));
//    end;
//  finally
//    FreeAndNil(iniFile);
//  end;
//end; (*ReadControlPlacement*)
//
//
//procedure WriteControlPlacement(const form : TForm);
//var
//  iniFile  : TIniFile;
//  idx : integer;
//  ctrl : TControl;
//
//  procedure WriteControl(Ctrl: TControl);
//  begin
//    iniFile.WriteInteger(ctrl.Name,'Top',ctrl.Top);
//    iniFile.WriteInteger(ctrl.Name,'Left',ctrl.Left);
//    iniFile.WriteInteger(ctrl.Name,'Width',ctrl.Width);
//    iniFile.WriteInteger(ctrl.Name,'Height',ctrl.Height);
//  end;
//
//begin
//  iniFile := TIniFile.Create(ChangeFileExt(Application.ExeName,'.ini'));
//  try
//    WriteControl(form);
//    for idx := 0 to -1 + form.ComponentCount do
//    begin
//      if form.Components[idx] is TControl then
//        WriteControl(TControl(form.Components[idx]));
//    end;
//  finally
//    FreeAndNil(iniFile);
//  end;
//end; (*WriteControlPlacement*)


end.
