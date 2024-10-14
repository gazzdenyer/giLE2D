unit mover;

interface

uses TypInfo, Contnrs, Controls, Classes, Windows, Forms, StdCtrls,
  ExtCtrls, Graphics, SysUtils, AdvGlowButton, uSpriteBlock,
  InspectorBar, dialogs, System.Types;

type
  TMethodArray = array of TMethod;

  TMover = class(TComponent)
  private
    FInReposition : boolean;
    FNodePositioning: Boolean;
    oldPos: TPoint;
    FNodes: TObjectList;
    FCurrentNodeControl: TWinControl;

    OnClickMethods : TMethodArray;
    MouseDownMethods : TMethodArray;
    MouseMoveMethods : TMethodArray;
    MouseUpMethods : TMethodArray;
    KeyDownMethods : TMethodArray;

    FMovableControls : TComponentList;
    FEnabled: boolean;
    FAutoSnap: boolean;
    FClone: boolean;
    function GetMovableControls: TComponentList;
    procedure SetEnabled(const Value: boolean);


    procedure CreateNodes;
//    procedure SetNodesVisible(Visible: Boolean);
    procedure PositionNodes(AroundControl: TWinControl);

    procedure NodeMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure NodeMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure NodeMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);


  public
    procedure Add(Control : TControl); //);   TSpriteBlock

    property MovableControls : TComponentList read GetMovableControls;
    property Enabled : boolean read FEnabled write SetEnabled;
    property InReposition : boolean read FInReposition;

    property AutoSnap: boolean read FAutoSnap write FAutoSnap;
    property Clone: boolean read FClone write FClone;

    procedure SetNodesVisible(Visible: Boolean);

    procedure PopulateProperties(ASprite: TSpriteBlock; AInspector: TInspectorBar = nil);

    constructor Create(AOwner : TComponent); override;
    destructor Destroy; override;
  published // must be published so that RTTI know about them
    procedure ControlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure ControlMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

implementation

uses uMain, uCommonFuncs;


constructor TMover.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);

  FEnabled := false;
  FInReposition := false;

  FNodes := TObjectList.Create(False);
  CreateNodes;
end;

destructor TMover.Destroy;
begin
  if Assigned(FMovableControls) then FMovableControls.Free;

  FNodes.Free;

  inherited;
end; (*Destroy*)

procedure TMover.ControlKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//var
//  idx: Integer;
//  lSprite: TSpriteBlock;
begin
//  for idx := 0 to fmMain.ComponentCount - 1 do
//  begin
//    if fmMain.Components[idx] is TSpriteBlock then
//    begin
//      lSprite := TSpriteBlock(fmMain.Components[idx]);
//      if lSprite.Tag = 1 then
//        Break;
//    end;
//  end;
//  if inReposition then
//  begin
//    //if (Enabled) AND (Sender is TSpriteBlock) then
//      ShowMessage('SPRITE');
//  end;
end;

procedure TMover.ControlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  idx: Integer;
begin
  // reset all TWinControl Tags
  for idx := 0 to fmMain.ComponentCount - 1 do  //     ControlCount
  begin
    if fmMain.Components[idx] is TSpriteBlock then
    begin
      TSpriteBlock(fmMain.Components[idx]).Tag := 0;
    end;
  end;

  if (Enabled) AND (Sender is TSpriteBlock) then
  begin
    FInReposition:=True;
    SetCapture(TWinControl(Sender).Handle);
    GetCursorPos(oldPos);
    PositionNodes(TWinControl(Sender));
    TWinControl(sender).Tag := 1;
  end;
end;

procedure TMover.ControlMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  minWidth = 20;
  minHeight = 20;
var
  newPos: TPoint;
  //frmPoint : TPoint;
begin
  if inReposition then
  begin
    with TSpriteBlock(Sender) do    //    TWinControl
    begin
      GetCursorPos(newPos);

//      if ssShift in Shift then
//      begin //resize
//        Screen.Cursor := crSizeNWSE;
//        frmPoint := ScreenToClient(Mouse.CursorPos);
//        if frmPoint.X > minWidth then Width := frmPoint.X;
//        if frmPoint.Y > minHeight then Height := frmPoint.Y;
//      end
//      else //move
//      begin
        Screen.Cursor := crSize;
        Left := Left - oldPos.X + newPos.X;
        Top := Top - oldPos.Y + newPos.Y;
        oldPos := newPos;

        PopulateProperties(TSpriteBlock(Sender), fmMain.Inspector);
//      end;
    end;
    fmMain.pbGrid.Update; //Repaint;
    PositionNodes(TWinControl(Sender));
    fmMain.NeedSave := True;
  end;
end;

procedure TMover.ControlMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if inReposition then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;

    // snap
    if AutoSnap then
    begin
      TSpriteBlock(sender).Left := Round(TSpriteBlock(sender).Left/16)*16;
      TSpriteBlock(sender).Top := Round(TSpriteBlock(sender).Top/16)*16;

      fmMain.Inspector.Panels[INS_PNL_COORDS].Items[2].IntValue := TSpriteBlock(sender).Left;
      fmMain.Inspector.Panels[INS_PNL_COORDS].Items[3].IntValue := TSpriteBlock(sender).Top;
    end;

    TGazzMap.CreateFileContents(fmMain, fmMain.FMapStringList, fmMain.MapBackground1,
      fmMain.Scroller, fmMain.Repeater);

    PositionNodes(TSpriteBlock(Sender));

    FInReposition := False;
  end;

end;

procedure TMover.CreateNodes;
var
  Node: Integer;
  Panel: TPanel;
begin
  for Node := 0 to 7 do
  begin
    Panel := TPanel.Create(self);
    with Panel do
    begin
      BevelOuter := bvNone;
      Color := clRed;
      Name := 'Node' + IntToStr(Node);
      Width := 6;
      Height := 6;
      Parent := nil;
      Visible := false;
      FNodes.Add(Panel);
//      case Node of
//        0,4: Cursor := crSizeNWSE;
//        1,5: Cursor := crSizeNS;
//        2,6: Cursor := crSizeNESW;
//        3,7: Cursor := crSizeWE;
//      end;
      OnMouseDown := NodeMouseDown;
      OnMouseMove := NodeMouseMove;
      OnMouseUp := NodeMouseUp;
    end;
  end;
end;

function TMover.GetMovableControls: TComponentList;
begin
  if FMovableControls = nil then
  begin
    FMovableControls := TComponentList.Create(false);
  end;
  result := FMovableControls;
end; (*GetMovableControls*)

procedure TMover.NodeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EXIT; // resize doesnt make sense when sprites are already correct size

  if (Enabled) AND (Sender is TWinControl) then
  begin
    FNodePositioning:=True;
    SetCapture(TWinControl(Sender).Handle);
    GetCursorPos(oldPos);
  end;
end;

procedure TMover.NodeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
const
  minWidth = 20;
  minHeight = 20;
var
  newPos: TPoint;
  frmPoint : TPoint;
  OldRect: TRect;
  AdjL,AdjR,AdjT,AdjB: Boolean;
begin
  EXIT; // resize doesnt make sense when sprites are already correct size

  if FNodePositioning then
  begin
    begin
      with TWinControl(Sender) do
      begin
      GetCursorPos(newPos);

      with FCurrentNodeControl do
      begin //resize
        Screen.Cursor := crSizeNWSE;
        frmPoint := FCurrentNodeControl.Parent.ScreenToClient(Mouse.CursorPos);
        OldRect := FCurrentNodeControl.BoundsRect;
        AdjL := False;
        AdjR := False;
        AdjT := False;
        AdjB := False;
        case FNodes.IndexOf(TWinControl(Sender)) of
          0: begin
               AdjL := True;
               AdjT := True;
             end;
          1: begin
               AdjT := True;
             end;
          2: begin
               AdjR := True;
               AdjT := True;
             end;
          3: begin
               AdjR := True;
             end;
          4: begin
               AdjR := True;
               AdjB := True;
             end;
          5: begin
               AdjB := True;
             end;
          6: begin
               AdjL := True;
               AdjB := True;
             end;
          7: begin
               AdjL := True;
             end;
        end;

        if AdjL then
          OldRect.Left := frmPoint.X;
        if AdjR then
          OldRect.Right := frmPoint.X;
        if AdjT then
          OldRect.Top := frmPoint.Y;
        if AdjB then
          OldRect.Bottom := frmPoint.Y;

        SetBounds(OldRect.Left,OldRect.Top,OldRect.Right - OldRect.Left,OldRect.Bottom - OldRect.Top);
      end;
      //move node
      Left := Left - oldPos.X + newPos.X;
      Top := Top - oldPos.Y + newPos.Y;
      oldPos := newPos;
      end;
    end;
    PositionNodes(FCurrentNodeControl);
  end;
end;

procedure TMover.NodeMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  EXIT; // resize doesnt make sense when sprites are already correct size

  if FNodePositioning then
  begin
    Screen.Cursor := crDefault;
    ReleaseCapture;
    FNodePositioning := False;
  end;
end;

procedure TMover.PopulateProperties(ASprite: TSpriteBlock; AInspector: TInspectorBar = nil);
begin

  fmMain.IsLoading := True;

  fmMain.pnlSpriteName.Text := 'Sprite Name: ' + ASprite.Name; //  + ', File: ' + ASprite.FileName

  try

    AInspector.Panels[INS_PNL_COORDS].Items[0].IntValue := ASprite.FileID;
    AInspector.Panels[INS_PNL_COORDS].Items[1].BoolValue := ASprite.IsMapGeometry = 1;
    AInspector.Panels[INS_PNL_COORDS].Items[2].IntValue := ASprite.Xcoord;
    AInspector.Panels[INS_PNL_COORDS].Items[3].IntValue := ASprite.Ycoord;
    AInspector.Panels[INS_PNL_COORDS].Items[4].IntValue := ASprite.Xsize;
    AInspector.Panels[INS_PNL_COORDS].Items[5].IntValue := ASprite.Ysize;
    AInspector.Panels[INS_PNL_COORDS].Items[6].IntValue := ASprite.Xoffset;
    AInspector.Panels[INS_PNL_COORDS].Items[7].IntValue := ASprite.Yoffset;
    AInspector.Panels[INS_PNL_COORDS].Items[8].IntValue := ASprite.physics;
    AInspector.Panels[INS_PNL_COORDS].Items[9].IntValue := ASprite.shape;
    AInspector.Panels[INS_PNL_COORDS].Items[10].IntValue := ASprite.Layer;
    AInspector.Panels[INS_PNL_COORDS].Items[11].IntValue := ASprite.IntTag;

    AInspector.Panels[INS_PNL_EXPL].Items[0].BoolValue :=  ASprite.IsExplodable = 1;
    AInspector.Panels[INS_PNL_EXPL].Items[1].BoolValue := ASprite.IsCollectable = 1;
    AInspector.Panels[INS_PNL_EXPL].Items[2].IntValue := ASprite.PointsValue;
    AInspector.Panels[INS_PNL_EXPL].Items[3].IntValue := ASprite.ColHealthValue;
    AInspector.Panels[INS_PNL_EXPL].Items[4].IntValue := ASprite.MoneyValue;

    AInspector.Panels[INS_PNL_FE].Items[0].BoolValue := ASprite.IsFriend = 1;
    AInspector.Panels[INS_PNL_FE].Items[1].BoolValue := ASprite.IsEnemy = 1;
    AInspector.Panels[INS_PNL_FE].Items[2].IntValue := ASprite.HealthValue;

    AInspector.Panels[INS_PNL_MP].Items[0].BoolValue := ASprite.IsMovingPlatform = 1;
    AInspector.Panels[INS_PNL_MP].Items[1].IntValue := ASprite.pXmoveFrom;
    AInspector.Panels[INS_PNL_MP].Items[2].IntValue := ASprite.pXmoveTo;
    AInspector.Panels[INS_PNL_MP].Items[3].IntValue := ASprite.pYmoveFrom;
    AInspector.Panels[INS_PNL_MP].Items[4].IntValue := ASprite.pYmoveTo;
    AInspector.Panels[INS_PNL_MP].Items[5].IntValue := ASprite.pVelocity;

    AInspector.Panels[INS_PNL_SPTELE].Items[0].BoolValue := ASprite.IsSpringboard = 1;
    AInspector.Panels[INS_PNL_SPTELE].Items[1].IntValue := ASprite.SpringForce;
    AInspector.Panels[INS_PNL_SPTELE].Items[2].BoolValue := ASprite.IsTeleporter = 1;
    AInspector.Panels[INS_PNL_SPTELE].Items[3].IntValue := ASprite.TeleportX;
    AInspector.Panels[INS_PNL_SPTELE].Items[4].IntValue := ASprite.TeleportY;

    AInspector.Panels[INS_PNL_PLAYER].Items[0].BoolValue := ASprite.PlayerStartMarker = 1;;
  finally
    fmMain.IsLoading := False;
  end;

end;

procedure TMover.PositionNodes(AroundControl: TWinControl);
var
  Node,T,L,CT,CL,FR,FB,FT,FL: Integer;
  TopLeft: TPoint;
begin
  FCurrentNodeControl := nil;
  for Node := 0 to 7 do
  begin
    with AroundControl do
    begin
      CL := (Width div 2) + Left -2;
      CT := (Height div 2) + Top -2;
      FR := Left + Width - 2;
      FB := Top + Height - 2;
      FT := Top - 2;
      FL := Left - 2;
      case Node of
        0: begin
             T := FT;
             L := FL;
           end;
        1: begin
             T := FT;
             L := CL;
           end;
        2: begin
             T := FT;
             L := FR;
           end;
        3: begin
             T := CT;
             L := FR;
           end;
        4: begin
             T := FB;
             L := FR;
           end;
        5: begin
             T := FB;
             L := CL;
           end;
        6: begin
             T := FB;
             L := FL;
           end;
        7: begin
             T := CT;
             L := FL;
           end;
        else
          T := 0;
          L := 0;
      end;
      TopLeft := Parent.ClientToScreen(Point(L,T));
    end;
    with TPanel(FNodes[Node]) do
    begin
      Parent := AroundControl.Parent;
      TopLeft := Parent.ScreenToClient(TopLeft);
      Top := TopLeft.Y;
      Left := TopLeft.X;
      Color := clAqua;
    end;
  end;
  FCurrentNodeControl := AroundControl;
  SetNodesVisible(True);
end;

procedure TMover.Add(Control: TControl);//);    TSpriteBlock
begin
  MovableControls.Add(Control);
end;

procedure TMover.SetEnabled(const Value: boolean);
var
  idx : integer;
  oldMethod : TMethod;
  newMethod : TMethod;
  nilMethod : TMethod;
  ctrl : TControl;
begin
  // ***** COMMENTED OUT CAUSING ACCESS VIOLATION ON MOVER RESET
  //if value = FEnabled then Exit;

  FEnabled := Value;


  if Enabled then
  begin
    OnClickMethods := nil; //clear;
    MouseDownMethods := nil;
    MouseMoveMethods := nil;
    MouseUpMethods := nil;
    KeyDownMethods := nil;

    nilMethod.Data := nil;
    nilMethod.Code := nil;

    SetLength(OnClickMethods,MovableControls.Count);
    SetLength(MouseDownMethods,MovableControls.Count);
    SetLength(MouseMoveMethods,MovableControls.Count);
    SetLength(MouseUpMethods,MovableControls.Count);
    SetLength(KeyDownMethods, MovableControls.Count);

    //swap mouse related event handlers
    for idx := 0 to -1 + MovableControls.Count do
    begin
      ctrl := TControl(MovableControls[idx]);

      oldMethod := GetMethodProp(ctrl, 'OnClick');
      OnClickMethods[idx].Code := oldMethod.Code;
      OnClickMethods[idx].Data := oldMethod.Data;
      SetMethodProp(ctrl, 'OnClick', nilMethod);

      oldMethod := GetMethodProp(ctrl, 'OnMouseDown');
      MouseDownMethods[idx].Code := oldMethod.Code;
      MouseDownMethods[idx].Data := oldMethod.Data;
      newMethod.Code := self.MethodAddress('ControlMouseDown');
      newMethod.Data := Pointer(self);
      SetMethodProp(ctrl, 'OnMouseDown', newMethod);

      oldMethod := GetMethodProp(ctrl, 'OnMouseMove');
      MouseMoveMethods[idx].Code := oldMethod.Code;
      MouseMoveMethods[idx].Data := oldMethod.Data;
      newMethod.Code := self.MethodAddress('ControlMouseMove');
      newMethod.Data := Pointer(self);
      SetMethodProp(ctrl, 'OnMouseMove', newMethod);

      oldMethod := GetMethodProp(ctrl, 'OnMouseUp');
      MouseUpMethods[idx].Code := oldMethod.Code;
      MouseUpMethods[idx].Data := oldMethod.Data;
      newMethod.Code := self.MethodAddress('ControlMouseUp');
      newMethod.Data := Pointer(self);
      SetMethodProp(ctrl, 'OnMouseUp', newMethod);

      oldMethod := GetMethodProp(ctrl, 'OnKeyDown');
      KeyDownMethods[idx].Code := oldMethod.Code;
      KeyDownMethods[idx].Data := oldMethod.Data;
      newMethod.Code := self.MethodAddress('ControlKeyDown');
      newMethod.Data := Pointer(self);
      SetMethodProp(ctrl, 'OnKeyDown', newMethod);

    end;
  end
  else //disabled
  begin
    //restore default Mouse related event handler
    for idx := 0 to -1 + MovableControls.Count do
    begin
      ctrl := TControl(MovableControls[idx]);

      oldMethod.Code := OnClickMethods[idx].Code;
      oldMethod.Data := OnClickMethods[idx].Data;
      SetMethodProp(ctrl, 'OnClick', oldMethod);

      oldMethod.Code := MouseDownMethods[idx].Code;
      oldMethod.Data := MouseDownMethods[idx].Data;
      SetMethodProp(ctrl, 'OnMouseDown', oldMethod);

      oldMethod.Code := MouseMoveMethods[idx].Code;
      oldMethod.Data := MouseMoveMethods[idx].Data;
      SetMethodProp(ctrl, 'OnMouseMove', oldMethod);

      oldMethod.Code := MouseUpMethods[idx].Code;
      oldMethod.Data := MouseUpMethods[idx].Data;
      SetMethodProp(ctrl, 'OnMouseUp', oldMethod);

      oldMethod.Code := KeyDownMethods[idx].Code;
      oldMethod.Data := KeyDownMethods[idx].Data;
      SetMethodProp(ctrl, 'OnKeyDown', oldMethod);
    end;
  end;

end; (*SetEnabled*)

procedure TMover.SetNodesVisible(Visible: Boolean);
var
  Node: Integer;
begin
  for Node := 0 to 7 do
  begin
    TPanel(FNodes.Items[Node]).Visible := Visible;
    TPanel(FNodes.Items[Node]).Color := clAqua;
  end;
end; (*SetNodesVisible*)

end.

