unit UFrmStaff;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UBOStaff;

type
  TFrmStaff = class(TForm)
    LblUserId: TLabel;
    EdtUserID: TEdit;
    LblResult: TLabel;
    BtnUserID: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BtnUserIDClick(Sender: TObject);
  private
    { Private declarations }
    FStaffObj : TBOStaff;
  public
    { Public declarations }
    property StaffObj: TBOStaff read FStaffObj write FStaffObj;
  end;

var
  FrmStaff: TFrmStaff;

implementation

{$R *.dfm}

procedure TFrmStaff.BtnUserIDClick(Sender: TObject);
begin
  LblResult.Caption := EmptyStr;
  StaffObj.UserID := Trim(EdtUserID.Text);
  StaffObj.ObtainStaffDetails;
  LblResult.Caption := StaffObj.FirstName + ' ' + StaffObj.Surname;
end;

procedure TFrmStaff.FormCreate(Sender: TObject);
begin
  EdtUserID.Clear;
  LblResult.Caption := EmptyStr;
  if StaffObj <> nil then
    begin
      FreeAndNil(FStaffObj);
    end;
  StaffObj := TBOStaff.Create;
end;

procedure TFrmStaff.FormDestroy(Sender: TObject);
begin
  if FStaffObj <> nil then
    begin
    FreeAndNil(FStaffObj);
    end;
end;

end.
