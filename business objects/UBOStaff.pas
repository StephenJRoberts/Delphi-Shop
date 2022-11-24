unit UBOStaff;

interface

type
  TBOStaff = class(TObject)

  private
    FSurname: String;
    FFirstName:String;
    FUserID:String;
  public
    property UserID: String read FUserID write FUserID;
    property FirstName: String read FFirstName write FFirstName;
    property Surname: String read FSurname write FSurname;
    function ObtainStaffDetails: Boolean;
  end;

implementation

uses
  UDBStaff;

{ TBOStaff }

function TBOStaff.ObtainStaffDetails: Boolean;
begin
  Result := TDBStaff.Instance.DBOtainStaffDetails(Self);
end;

end.

