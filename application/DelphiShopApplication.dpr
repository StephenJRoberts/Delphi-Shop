program DelphiShopApplication;

uses
  Vcl.Forms,
  UFrmMain in '..\forms and controllers\UFrmMain.pas' {FrmMain},
  UBOStaff in '..\business objects\UBOStaff.pas',
  UDBStaff in '..\database objects\UDBStaff.pas',
  UDtMdlShopApp in '..\database objects\UDtMdlShopApp.pas' {DtMdlShopApp: TDataModule},
  UFrmStaff in '..\forms and controllers\UFrmStaff.pas' {FrmStaff},
  UFrmShops in '..\forms and controllers\UFrmShops.pas' {FrmShops},
  UBOShop in '..\business objects\UBOShop.pas',
  UDBShop in '..\database objects\UDBShop.pas',
  UBOShopList in '..\business objects\UBOShopList.pas',
  UDBShopList in '..\database objects\UDBShopList.pas',
  UFrmEditShop in '..\forms and controllers\UFrmEditShop.pas' {FrmEditShop};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDtMdlShopApp, DtMdlShopApp);
  Application.CreateForm(TFrmStaff, FrmStaff);
  Application.CreateForm(TFrmShops, FrmShops);
  Application.CreateForm(TFrmEditShop, FrmEditShop);
  Application.Run;
end.
