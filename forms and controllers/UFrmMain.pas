unit UFrmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Menus, Vcl.CheckLst;

type
  TFrmMain = class(TForm)
    BtnStaff: TButton;
    BtnShops: TButton;
    procedure BtnStaffClick(Sender: TObject);
    procedure BtnShopsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses
  UFrmStaff, UFrmShops;

{$R *.dfm}

procedure TFrmMain.BtnShopsClick(Sender: TObject);
begin
FrmShops.FormCreate(Sender);
//FrmShops.Create(Application);
FrmShops.ShowModal;
end;

procedure TFrmMain.BtnStaffClick(Sender: TObject);
begin
FrmStaff.FormCreate(Sender);
FrmStaff.ShowModal;
end;

end.
