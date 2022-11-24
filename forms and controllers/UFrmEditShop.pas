unit UFrmEditShop;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UBOShop;

type
  TFrmEditShop = class(TForm)
    LblShopName: TLabel;
    LblAddrLn1: TLabel;
    LblAddrLn2: TLabel;
    LblAddrLn3: TLabel;
    LblAddrPostcode: TLabel;
    BtnUpdate: TButton;
    EdtShopName: TEdit;
    EdtAddrLn1: TEdit;
    EdtAddrLn2: TEdit;
    EdtAddrLn3: TEdit;
    EdtAddrPostcode: TEdit;
    procedure BtnUpdateClick(Sender: TObject);
    procedure EdtAddrPostcodeChange(Sender: TObject);
  private
    { Private declarations }
    FShopObject:  TBOShop;
    FEditType:String;
    function ValidateData:Boolean;
    function ValidatePostCode(Postcode:String):Boolean;
  public
    { Public declarations }
    property ShopObject: TBOShop read FShopObject write FShopObject;
    constructor Create(AOwner: TComponent);
    constructor CreateEdit(AOwner: TComponent;
          const ShopObj: TBOShop);
  end;

var
  FrmEditShop: TFrmEditShop;

implementation

uses
  System.UITypes;

{$R *.dfm}

procedure TFrmEditShop.BtnUpdateClick(Sender: TObject);
begin
if ValidateData then
  begin
    ShopObject.ShopName := EdtShopName.Text;
    ShopObject.AddressLine1 := EdtAddrLn1.Text;
    ShopObject.AddressLine2 := EdtAddrLn2.Text;
    ShopObject.AddressLine3 := EdtAddrLn3.Text;
    ShopObject.AddressPostCode := EdtAddrPostcode.Text;
    if FEditType = 'New' then
    begin
      if ShopObject.NewDetails then
      begin
        MessageDlg('Entry has been inputed.', mtInformation, [mbOK], 0);
        Close;
      end
    else
      begin
        MessageDlg('Entry has failed to inputed.', mtInformation, [mbOK], 0);
      end;
    end
    else
    begin
      if ShopObject.UpdateDetails then
      begin
        MessageDlg('Entry has been updated.', mtInformation, [mbOK], 0);
        Close;
      end
    else
      begin
        MessageDlg('Entry has failed to update.', mtInformation, [mbOK], 0);
      end;
    end;

  end
else
  begin
    MessageDlg('Data Validation Error.', mtError, [mbOK], 0);
  end;
end;

constructor TFrmEditShop.CreateEdit(AOwner: TComponent; const ShopObj: TBOShop);
begin
  FEditType := 'Edit';
  ShopObject := ShopObj;
  EdtShopName.Text := ShopObject.ShopName;
  EdtAddrLn1.Text := ShopObject.AddressLine1;
  EdtAddrLn2.Text := ShopObject.AddressLine2;
  EdtAddrLn3.Text := ShopObject.AddressLine3;
  EdtAddrPostcode.Text := ShopObject.AddressPostCode;
  BtnUpdate.Caption := 'Update';
end;

procedure TFrmEditShop.EdtAddrPostcodeChange(Sender: TObject);
var
curLocation:Integer;
begin
curLocation := EdtAddrPostcode.SelStart;
EdtAddrPostcode.Text := UpperCase(EdtAddrPostcode.Text);
EdtAddrPostcode.SelStart := curLocation;
end;

constructor TFrmEditShop.Create(AOwner: TComponent);
begin
  FEditType := 'New';
  ShopObject := TBOShop.Create;
  BtnUpdate.Caption := 'Insert';
end;

function TFrmEditShop.ValidateData: Boolean;
var
  IsDataValid:Boolean;
begin
  IsDataValid := ValidatePostCode(EdtAddrPostcode.Text);
  Result := IsDataValid;
end;

function TFrmEditShop.ValidatePostCode(Postcode:String): Boolean;
begin
  Result := False;
  if (Postcode = EmptyStr) then Exit;
  if Length(Postcode) = 0 then Exit;


end;

end.
