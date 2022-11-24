unit UBOShopList;

interface

uses
  System.Classes;

type
  TBOShopList = class(TObject)

  private
    FList: TStringList;
    procedure DestroyList;
    function ObtainShopsByDistNo(DaylistNum:Integer): Boolean;
  public
    property List: TStringList read FList write FList;
    constructor Create(DaylistNumber: Integer); virtual;
    destructor Destroy; override;
  end;

implementation

uses
  System.SysUtils, UDBShopList, UBOShop, StrUtils;

{ TBOShopList }

constructor TBOShopList.Create(DaylistNumber: Integer);
begin
  if List <> nil then
    begin
      DestroyList;
    end;
  List := TStringList.Create;
  ObtainShopsByDistNo(DaylistNumber);
end;

destructor TBOShopList.Destroy;
var
  I:Integer;
  TempObj:TObject;
begin
  for I := 0 to List.Count -1 do
    begin
      TempObj := List.Objects[I];
      FreeAndNil(TempObj);
    end;
    FreeAndNil(FList);
end;

procedure TBOShopList.DestroyList;
begin

end;

function TBOShopList.ObtainShopsByDistNo(DaylistNum: Integer): Boolean;
begin
  Result := TDBShopList.Instance.DBObtainShopsByDistNo(DaylistNum, Self);
end;

end.
