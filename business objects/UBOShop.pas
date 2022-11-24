unit UBOShop;

interface

type
  TBOShop = class(TObject)

  private
    FShopID:String;
    FShopName:String;
    FAddressLine1:String;
    FAddressLine2:String;
    FAddressLine3:String;
    FAddressPostCode:String;
  public
    property ShopID: String read FShopID write FShopID;
    property ShopName: String read FShopName write FShopName;
    property AddressLine1: String read FAddressLine1 write FAddressLine1;
    property AddressLine2: String read FAddressLine2 write FAddressLine2;
    property AddressLine3: String read FAddressLine3 write FAddressLine3;
    property AddressPostCode: String read FAddressPostCode write FAddressPostCode;
    function ObtainShopDetails: Boolean;
    function NewDetails: Boolean;
    function UpdateDetails:Boolean;
    function DeleteShop:Boolean;
    function HasString(SearchString:String):Boolean;
  end;

implementation

uses
  UDBShop;

{ TBOShop }

function TBOShop.ObtainShopDetails: Boolean;
begin
  Result := TDBShop.Instance.DBOtainShopDetails(Self);
end;

function TBOShop.UpdateDetails: Boolean;
begin
  Result := TDBShop.Instance.DBUpdateDetails(Self);
end;

function TBOShop.DeleteShop: Boolean;
begin
  Result := TDBShop.Instance.DeleteShop(Self);
end;

function TBOShop.HasString(SearchString: String): Boolean;
begin
//
end;

function TBOShop.NewDetails: Boolean;
begin
  Result := TDBShop.Instance.NewDetails(Self);
end;

end.
