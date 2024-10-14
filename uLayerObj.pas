unit uLayerObj;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs, contnrs;

type
  TMapLayer = class(TPersistent)
  private
    Flayer_id: integer;
    Flayer_name: string;

  public
    property layer_id: integer read Flayer_id write Flayer_id;
    property layer_name: string read Flayer_name write Flayer_name;
  end;

  TMapLayer_List = class(TObjectList)
  private

  protected
    function GetItem(Index: Integer): TMapLayer;
    procedure SetItem(Index: Integer; AObject: TMapLayer);
  public
    property Items[Index: Integer]: TMapLayer read GetItem write SetItem; default;
  end;



implementation

{ TMapLayer_List }

function TMapLayer_List.GetItem(Index: Integer): TMapLayer;
begin
  Result := TMapLayer(inherited Items[Index]);
end;

procedure TMapLayer_List.SetItem(Index: Integer; AObject: TMapLayer);
begin
  inherited Items[Index] := AObject;
end;

end.
