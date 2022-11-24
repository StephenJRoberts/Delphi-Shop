unit UDBStaff;

interface

uses
  UBOStaff;

type
  TDBStaff = class(TObject)
  private

  public
  constructor Create;
  class function Instance: TDBStaff;
  function DBOtainStaffDetails(StaffObj: TBOStaff):Boolean;
  end;

implementation

uses
  System.SysUtils, UDtMdlShopApp, Data.DB, Data.Win.ADODB;

var
  FInstance: TDBStaff;

{ TDBStaff }

constructor TDBStaff.Create;
begin
  if not Assigned(FInstance) then
    begin
      FInstance := inherited Create;
    end
  else
    raise Exception.Create(Format('Instance of %s already exists', [Self.ClassName]));
end;

function TDBStaff.DBOtainStaffDetails(StaffObj: TBOStaff): Boolean;
begin
  with DtMdlShopApp do
    begin
      StrdPrcShop.Close;
      StrdPrcShop.ProcedureName := 'StaffPROC';
      StrdPrcShop.Parameters.Clear;
      StrdPrcShop.Parameters.CreateParameter('PUSER_ID',ftString,pdInput,8,Trim(StaffObj.UserID));
      StrdPrcShop.Parameters.CreateParameter('PTITLE',ftString,pdOutput,4,'');
      StrdPrcShop.Parameters.CreateParameter('PFORENAME',ftString,pdOutput,25,'');
      StrdPrcShop.Parameters.CreateParameter('PSURNAME',ftString,pdOutput,25,'');
      StrdPrcShop.Parameters.CreateParameter('PPREF_FORENAME',ftString,pdOutput,25,'');
      StrdPrcShop.Parameters.CreateParameter('PROOM_NO',ftString,pdOutput,12,'');
      StrdPrcShop.Parameters.CreateParameter('PPOST_TITLE',ftString,pdOutput,25,'');
      StrdPrcShop.Parameters.CreateParameter('TEL_EXTN_NO',ftString,pdOutput,4,'');
      StrdPrcShop.Parameters.CreateParameter('PDIR_TEL_NO',ftString,pdOutput,15,'');
      StrdPrcShop.Parameters.CreateParameter('PEMAIL_ADDR',ftString,pdOutput,80,'');
      StrdPrcShop.Parameters.CreateParameter('PRETURN_CODE',ftString,pdOutput,1,'');
      StrdPrcShop.Parameters.CreateParameter('PABND_SQLCODE',ftInteger,pdOutput,4,0);
      StrdPrcShop.Parameters.CreateParameter('PABND_MESSAGE',ftString,pdOutput,100,'');
      StrdPrcShop.Prepared := True;
      try
        StrdPrcShop.ExecProc;
        //testOutput := StrdPrcShop.FieldByName('PABND_SQLCODE').AsInteger;
        if StrdPrcShop.Parameters.ParamByName('PABND_SQLCODE').Value = 0 then
          begin
            Result := True;
            StaffObj.FirstName := Trim(StrdPrcShop.Parameters.ParamByName('PFORENAME').Value);
            StaffObj.Surname := Trim(StrdPrcShop.Parameters.ParamByName('PSURNAME').Value);
          end
      except
        if DtBsShop.InTransaction then DtBsShop.RollbackTrans;
        raise Exception.Create('Exception raised in method TDBStaff.DBOtainStaffDetails');

      end;
    end;
end;

class function TDBStaff.Instance: TDBStaff;
begin
   if not Assigned(FInstance) then Self.Create;
   Result := FInstance;
end;

initialization

finalization
  FreeAndNil(FInstance);

end.

