unit UDBShop;

interface

uses
  UBOShop;

type
  TDBShop = class(TObject)
  private
  public
  constructor Create;
  class function Instance: TDBShop;
  function DBOtainShopDetails(ShopObj: TBOShop):Boolean;
  function DBUpdateDetails(ShopObj: TBOShop):Boolean;
  function NewDetails(ShopObj: TBOShop):Boolean;
  function DeleteShop(ShopObj:TBOShop):Boolean;
  end;

implementation

uses
  System.SysUtils, UDtMdlShopApp, Data.DB, Data.Win.ADODB;

var
  FInstance: TDBShop;

{ TDBShop }

constructor TDBShop.Create;
begin
  if not Assigned(FInstance) then
    begin
      FInstance := inherited Create;
    end
  else
    raise Exception.Create(Format('Instance of %s already exists', [Self.ClassName]));
end;

function TDBShop.DBOtainShopDetails(ShopObj: TBOShop): Boolean;
begin
  with DtMdlShopApp do
    begin
      StrdPrcShop.Close;
      StrdPrcShop.ProcedureName := 'STOREPROC';
      StrdPrcShop.Parameters.Clear;
      StrdPrcShop.Parameters.CreateParameter('PSTORE_ID',ftString,pdInput,8,Trim(ShopObj.ShopID));
      StrdPrcShop.Parameters.CreateParameter('PSTORENAME',ftString,pdOutput,25,'');

      StrdPrcShop.Parameters.CreateParameter('PADDRESS_L1',ftString,pdOutput,50,'');
      StrdPrcShop.Parameters.CreateParameter('PADDRESS_L2',ftString,pdOutput,50,'');
      StrdPrcShop.Parameters.CreateParameter('PADDRESS_L3',ftString,pdOutput,50,'');
      StrdPrcShop.Parameters.CreateParameter('PADDRESS_POSTCODE',ftString,pdOutput,50,'');

      StrdPrcShop.Parameters.CreateParameter('PRETURN_CODE',ftString,pdOutput,1,'');
      StrdPrcShop.Parameters.CreateParameter('PABND_SQLCODE',ftInteger,pdOutput,4,0);
      StrdPrcShop.Parameters.CreateParameter('PABND_MESSAGE',ftString,pdOutput,100,'');
      StrdPrcShop.Prepared := True;
      try
        StrdPrcShop.ExecProc;
        if StrdPrcShop.Parameters.ParamByName('PABND_SQLCODE').Value = 0 then
          begin
            Result := True;
            ShopObj.ShopName := Trim(StrdPrcShop.Parameters.ParamByName('PSTORENAME').Value);
          end
      except
        if DtBsShop.InTransaction then DtBsShop.RollbackTrans;
        raise Exception.Create('Exception raised in method TDBStaff.DBOtainStaffDetails');
      end;
    end;
end;

class function TDBShop.Instance: TDBShop;
begin
  if not Assigned(FInstance) then Self.Create;
  Result := FInstance;
end;

function TDBShop.NewDetails(ShopObj: TBOShop): Boolean;
var
  TempQry: TADOQuery;
  SQLString: String;
begin
  try
    Result := True;
    TempQry := TADOQuery.Create(Nil);
    TempQry.Connection := DtMdlShopApp.DtBsShop;
    TempQry.CursorType := ctStatic;
    TempQry.LockType := ltReadOnly;
    TempQry.Close;
    TempQry.Parameters.Clear;
    TempQry.SQL.Clear;
    SQLString := 'INSERT INTO shopstable (STORE_ID,STORENAME,ADDRESS_L1,ADDRESS_L2,ADDRESS_L3,ADDRESS_POSTCODE) VALUES (:STORE_ID,:STORENAME,:ADDRESS_L1,:ADDRESS_L2,:ADDRESS_L3,:ADDRESS_POSTCODE)';
    TempQry.SQL.Add(SQLString);
    TempQry.Parameters.ParamValues['STORE_ID'] := (ShopObj.ShopName[1] + ShopObj.ShopName[2] + ShopObj.ShopName[3] + IntToStr(Random(100))).ToUpper;
    TempQry.Parameters.ParamValues['STORENAME'] := ShopObj.ShopName;
    TempQry.Parameters.ParamValues['ADDRESS_L1'] := ShopObj.AddressLine1;
    TempQry.Parameters.ParamValues['ADDRESS_L2'] := ShopObj.AddressLine2;
    TempQry.Parameters.ParamValues['ADDRESS_L3'] := ShopObj.AddressLine3;
    TempQry.Parameters.ParamValues['ADDRESS_POSTCODE'] := ShopObj.AddressPostCode;
    try
      DtMdlShopApp.DtBsShop.BeginTrans;
      TempQry.ExecSQL;
      DtMdlShopApp.DtBsShop.CommitTrans;
    except
      Result := false;
      if DtMdlShopApp.DtBsShop.InTransaction then DtMdlShopApp.DtBsShop.RollbackTrans;
      raise Exception.Create('Exception raised in method TDBShop.DBUpdateShop');
    end;
  finally
    if TempQry <> nil then
      begin
        FreeAndNil(TempQry);
      end;
  end;
end;

function TDBShop.DBUpdateDetails(ShopObj: TBOShop): Boolean;
var
  TempQry: TADOQuery;
  SQLString: String;
begin
  try
    Result := True;
    TempQry := TADOQuery.Create(Nil);
    TempQry.Connection := DtMdlShopApp.DtBsShop;
    TempQry.CursorType := ctStatic;
    TempQry.LockType := ltReadOnly;
    TempQry.Close;
    TempQry.Parameters.Clear;
    TempQry.SQL.Clear;
    SQLString := 'UPDATE shopstable Set STORENAME = :STORENAME , ADDRESS_L1 = :ADDRESS_L1 , ADDRESS_L2 = :ADDRESS_L2 , ADDRESS_L3 = :ADDRESS_L3 , ADDRESS_POSTCODE = :ADDRESS_POSTCODE WHERE STORE_ID = :STORE_ID';
    TempQry.SQL.Add(SQLString);
    TempQry.Parameters.ParamValues['STORE_ID'] := ShopObj.ShopID;
    TempQry.Parameters.ParamValues['STORENAME'] := ShopObj.ShopName;
    TempQry.Parameters.ParamValues['ADDRESS_L1'] := ShopObj.AddressLine1;
    TempQry.Parameters.ParamValues['ADDRESS_L2'] := ShopObj.AddressLine2;
    TempQry.Parameters.ParamValues['ADDRESS_L3'] := ShopObj.AddressLine3;
    TempQry.Parameters.ParamValues['ADDRESS_POSTCODE'] := ShopObj.AddressPostCode;
    try
      DtMdlShopApp.DtBsShop.BeginTrans;
      TempQry.ExecSQL;
      DtMdlShopApp.DtBsShop.CommitTrans;
    except
      Result := false;
      if DtMdlShopApp.DtBsShop.InTransaction then DtMdlShopApp.DtBsShop.RollbackTrans;
      raise Exception.Create('Exception raised in method TDBShop.DBUpdateShop');
    end;
  finally
    if TempQry <> nil then
      begin
        FreeAndNil(TempQry);
      end;
  end;
end;

function TDBShop.DeleteShop(ShopObj: TBOShop): Boolean;
var
  TempQry: TADOQuery;
  SQLString: String;
begin
  try
    Result := True;
    TempQry := TADOQuery.Create(Nil);
    TempQry.Connection := DtMdlShopApp.DtBsShop;
    TempQry.CursorType := ctStatic;
    TempQry.LockType := ltReadOnly;
    TempQry.Close;
    TempQry.Parameters.Clear;
    TempQry.SQL.Clear;
    SQLString := 'DELETE FROm shopstable WHERE STORE_ID = :STORE_ID';
    TempQry.SQL.Add(SQLString);
    TempQry.Parameters.ParamValues['STORE_ID'] := ShopObj.ShopID;
    try
      DtMdlShopApp.DtBsShop.BeginTrans;
      TempQry.ExecSQL;
      DtMdlShopApp.DtBsShop.CommitTrans;
    except
      Result := false;
      if DtMdlShopApp.DtBsShop.InTransaction then DtMdlShopApp.DtBsShop.RollbackTrans;
      raise Exception.Create('Exception raised in method TDBShop.DBUpdateShop');
    end;
  finally
    if TempQry <> nil then
      begin
        FreeAndNil(TempQry);
      end;
  end;
end;

initialization

finalization
  FreeAndNil(FInstance);

end.
