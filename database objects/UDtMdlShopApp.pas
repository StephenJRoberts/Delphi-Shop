unit UDtMdlShopApp;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDtMdlShopApp = class(TDataModule)
    DtBsShop: TADOConnection;
    StrdPrcShop: TADOStoredProc;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtMdlShopApp: TDtMdlShopApp;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDtMdlShopApp.DataModuleCreate(Sender: TObject);
begin
  if Assigned(DtBsShop) then
  begin
    if DtBsShop.InTransaction then
    begin
      DtBsShop.CommitTrans;
    end;
    if DtBsShop.Connected then DtBsShop.Close;
  end;
  DtBsShop.Connected := false;
  DtBsShop.Close;
  if not(DtBsShop.Connected) then
  begin
  //DtBsShop.ConnectionString := 'DSN=CAPS;APNA=EHRB;CVNL=YES';
  //DtBsShop.ConnectionString:='Provider=Microsoft.Jet.OLEDB.4.0;Data Source=TestShop.mdb;Persist Security Info=False';
  DtBsShop.ConnectionString := 'DRIVER={MySQL ODBC 8.0 ANSI Driver}; SERVER=localhost; PORT=3306; DATABASE=shoptable; UID=testUser ; PASSWORD=password;OPTION=3;';
    try
      DtBsShop.Open;
    except
      on exp: exception do
      begin
        exp.Message := 'ADOConnect(): could not open database connection.' + exp.Message;
        raise;
      end;
    end;
  end;
end;

end.
