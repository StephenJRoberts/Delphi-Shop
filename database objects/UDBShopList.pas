unit UDBShopList;

interface

uses
 UBOShopList;

type
  TDBShopList = class(TObject)

  private

  public
    constructor Create;
    class function Instance : TDBShopList;
    function DBObtainShopsByDistNo(DaylistNo
     : Integer; ShopListObj : TBOShopList) : Boolean;
  end;

implementation

uses
  System.SysUtils, UDtMdlShopApp, Data.DB, Data.Win.ADODB, UBOShop;

var
  FInstance : TDBShopList;

{ TDBShopList }

constructor TDBShopList.Create;
begin
  if not Assigned(FInstance) then
    begin
      FInstance := inherited Create
    end
  else
    raise Exception.Create(Format('Instance of %s already exists', [Self.ClassName]));
end;

function TDBShopList.DBObtainShopsByDistNo(DaylistNo: Integer;
  ShopListObj: TBOShopList): Boolean;
var
  TempQry: TADOQuery;
  SQLString, TempShopID: String;
  TempShopObj: TBOShop;
begin
  try
    TempQry := TADOQuery.Create(Nil);
    TempQry.Connection := DtMdlShopApp.DtBsShop;
    TempQry.CursorType := ctStatic;
    TempQry.LockType := ltReadOnly;
    TempQry.Close;
    TempQry.Parameters.Clear;
    TempQry.SQL.Clear;
    //SQLString := 'SELECT AUN, AUN_NAME FROM T_AUN WHERE DLST_NO = ? AND AUN_TYPE = ? ORDER BY 2';
    SQLString := 'SELECT * FROM shopstable ORDER BY 2';
    //SQLString := 'SELECT AUN, AUN_NAME FROM T_AUN WHERE DLST_NO = :DLST_NO AND AUN_TYPE = :AUN_TYPE ORDER BY 2';
    TempQry.SQL.Add(SQLString);
    //TempQry.Parameters.CreateParameter('DLST_NO', ftInteger, pdInput, 0,DaylistNo);
    //TempQry.Parameters.CreateParameter('AUN_TYPE', ftString, pdInput, 1,'T');
    //TempQry.Parameters.ParamValues['DLST_NO'] := DaylistNo;
    //TempQry.Parameters.ParamValues['AUN_TYPE'] := 'T';
    try
      dtMdlShopApp.DtBsShop.BeginTrans;
      TempQry.Open;
      dtMdlShopApp.DtBsShop.CommitTrans;
      if TempQry.RecordCount = 0 then
        begin
          Result := True;
        end
      else
        begin
          Result := False;
        end;
      TempQry.First;
      while not TempQry.Eof do
        begin
          TempShopObj := TBOShop.Create;
          TempShopObj.ShopName := Trim(TempQry.FieldByName('StoreName').AsString);
          TempShopObj.AddressLine1 := Trim(TempQry.FieldByName('ADDRESS_L1').AsString);
          TempShopObj.AddressLine2 := Trim(TempQry.FieldByName('ADDRESS_L2').AsString);
          TempShopObj.AddressLine3 := Trim(TempQry.FieldByName('ADDRESS_L3').AsString);
          TempShopObj.AddressPostcode := Trim(TempQry.FieldByName('ADDRESS_POSTCODE').AsString);
          TempShopObj.ShopID := TempQry.FieldByName('STORE_ID').AsString;
          TempShopID := TempShopObj.ShopID;
          ShopListObj.List.AddObject(Trim(TempShopID), TempShopObj);
          TempQry.Next;
        end;
    except
      Result := False;
      if dtMdlShopApp.DtBsShop.InTransaction then dtMdlShopApp.DtBsShop.RollbackTrans;
      raise Exception.Create('Exception raised in method TDBShopList.DBObtainShopsByDistNo');
    end;
  finally
    if TempQry <> nil then
      begin
        FreeAndNil(TempQry);
      end;
  end;
end;

class function TDBShopList.Instance: TDBShopList;
begin
  if not Assigned(FInstance) then Self.Create;
  Result := FInstance;
end;

initialization

finalization
  FreeAndNil(FInstance);

end.
