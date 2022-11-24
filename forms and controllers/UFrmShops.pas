unit UFrmShops;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UBOShop, UBOShopList,
  System.Generics.Collections, Vcl.Grids, Vcl.Menus, Vcl.WinXCtrls, Vcl.Buttons,
  Vcl.ToolWin, Vcl.ActnMan, Vcl.ActnCtrls, System.Actions, Vcl.ActnList,
  Vcl.PlatformDefaultStyleActnCtrls, Vcl.StdActns, Vcl.ExtActns, Vcl.ExtCtrls,
  System.Win.TaskbarCore, Vcl.Taskbar;

type
  TFrmShops = class(TForm)
    StringGrid1: TStringGrid;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    Search1: TMenuItem;
    Close1: TMenuItem;
    Options1: TMenuItem;
    SearchBox1: TSearchBox;
    Button1: TButton;
    BtnNewEntry: TButton;
    Button2: TButton;
    ActionManager1: TActionManager;
    ActionToolBar1: TActionToolBar;
    Panel1: TPanel;
    ActionReadOnly: TAction;
    IconButton1: TSpeedButton;
    IconButton2: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Close1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Search1Click(Sender: TObject);
    procedure BtnNewEntryClick(Sender: TObject);
    procedure BitBtnRefreshClick(Sender: TObject);
    procedure BtnDeleteClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SearchBox1Change(Sender: TObject);
  private
    { Private declarations }
    FShopObj : TBOShop;
    FShopList: TBOShopList;
    SearchShopList: TStringList;
    FCurrentShopObj:TBOShop;
    SearchString:String;
    procedure SetUpShopList;
    property CurrentShopObj: TBOShop read FCurrentShopObj write FCurrentShopObj;
    procedure AutoSizeGridColumns(Grid: TStringGrid);
    procedure CreateGridButtons(ACol, ARow: Integer);
    procedure BtnUpdateClick(Sender: TObject);
    procedure RowHeaders;
    procedure Search;
  public
    { Public declarations }
    property ShopObj: TBOShop read FShopObj write FShopObj;
    property ShopList: TBOShopList read FShopList write FShopList;
  end;

  var
    FrmShops: TFrmShops;

implementation

uses
  UFrmEditShop, StrUtils;
{$R *.dfm}

procedure TFrmShops.BitBtnRefreshClick(Sender: TObject);
var
  I:Integer;
  ButtonTemp:TBitBtn;
begin
for I := 0 to StringGrid1.ControlCount - 1 do
begin
  StringGrid1.Controls[0].Free;
end;

for I := 1 to StringGrid1.RowCount - 1 do
  begin
    StringGrid1.Rows[I].Clear;
    StringGrid1.RowCount := 1;
  end;

if SearchShopList.Count > 0 then
begin
  FreeAndNil(SearchShopList);
end;

if ShopList.List.Count > 0 then
begin
  FreeAndNil(FShopList);
end;

FreeAndNil(FShopObj);
SetUpShopList;
end;

procedure TFrmShops.BtnDeleteClick(Sender: TObject);
var
Button:TBitBtn;
DelResult:Boolean;
begin
Button := Sender as TBitBtn;
CurrentShopObj := ShopList.List.Objects[Button.Tag-1] as TBOShop;
DelResult := CurrentShopObj.DeleteShop;
if DelResult then
  begin
    MessageDlg('Entry has been Deleted.', mtInformation, [mbOK], 0);
  end
  else
  begin
    MessageDlg('Entry has failed to Delete.', mtInformation, [mbOK], 0);
  end;
BitBtnRefreshClick(Sender);
end;

procedure TFrmShops.BtnNewEntryClick(Sender: TObject);
begin
FrmEditShop.Create(Application);
FrmEditShop.ShowModal;
end;

procedure TFrmShops.BtnUpdateClick(Sender: TObject);
var
Button:TBitBtn;
begin
Button := Sender as TBitBtn;
CurrentShopObj := ShopList.List.Objects[Button.Tag-1] as TBOShop;
FrmEditShop.CreateEdit(Application, CurrentShopObj);
FrmEditShop.ShowModal;
end;

procedure TFrmShops.Button1Click(Sender: TObject);
begin
  SearchString := SearchBox1.Text;
end;

procedure TFrmShops.FormCreate(Sender: TObject);
begin
  if ShopList <> nil then
    begin
      FreeAndNil(FShopList);
    end;
  if ShopObj <> nil then
    begin
      FreeAndNil(FShopObj);
    end;
  ShopObj := TBOShop.Create;
  RowHeaders;
  SearchShopList := TStringList.Create;
  SetUpShopList;
end;

procedure TFrmShops.FormDestroy(Sender: TObject);
begin
  if FShopList <> nil then
    begin
      FreeAndNil(FShopList);
    end;
  if FShopObj <> nil then
    begin
      FreeAndNil(FShopObj);
    end;
end;

procedure TFrmShops.RowHeaders;
begin
  StringGrid1.Cells[0,0] := 'Shop ID';
  StringGrid1.Cells[1,0] := 'Shop Name';
  StringGrid1.Cells[2,0] := 'Address Line 1';
  StringGrid1.Cells[3,0] := 'Address Line 2';
  StringGrid1.Cells[4,0] := 'Address Line 3';
  StringGrid1.Cells[5,0] := 'Postcode';
  StringGrid1.Cells[6,0] := 'Edit';
  StringGrid1.Cells[7,0] := 'Delete';
end;

procedure TFrmShops.Search;
var
  I:Integer;
  TempStore:TBOShop;
begin
  SearchShopList.Free;
  SearchShopList := TStringList.Create;
  if SearchString <> '' then
  begin
    for I := 0 to ShopList.List.Count -1 do
    begin
      TempStore := ShopList.List.Objects[I] as TBOShop;
      if TempStore.HasString(SearchString) then SearchShopList.Add(TempStore.ShopID);
    end;
  end;
end;

procedure TFrmShops.Search1Click(Sender: TObject);
begin
  StringGrid1.Destroy;
end;

procedure TFrmShops.SearchBox1Change(Sender: TObject);
begin
  SearchString := SearchBox1.Text;
end;

procedure TFrmShops.SetUpShopList;
var
  I, Rows, a: Integer;
  TempShopObj: TBOShop;
  Button: TButton;
  R: TRect;
begin
  if ShopList <> nil then
    begin
      FreeAndNil(FShopList);
    end;
  ShopList := TBOShopList.Create(9);
  Search;

  if SearchShopList.Count = 0 then
    begin
    StringGrid1.RowCount := ShopList.List.Count +1;
    if ShopList.List.Count > 0 then
    begin
      for I := 0 to (ShopList.List.Count -1) do
        begin
          TempShopObj := ShopList.List.Objects[I] as TBOShop;
          StringGrid1.Cells[0,I+1] := TempShopObj.ShopID;
          StringGrid1.Cells[1,I+1] := TempShopObj.ShopName;
          StringGrid1.Cells[2,I+1] := TempShopObj.AddressLine1;
          StringGrid1.Cells[3,I+1] := TempShopObj.AddressLine2;
          StringGrid1.Cells[4,I+1] := TempShopObj.AddressLine3;
          StringGrid1.Cells[5,I+1] := TempShopObj.AddressPostcode;
        end;
      CurrentShopObj := ShopList.List.Objects[0] as TBOShop;
      AutoSizeGridColumns(StringGrid1);
      for I := 0 to (ShopList.List.Count -1) do
        begin
          CreateGridButtons(6,I+1);
        end;
    end;
  end
  else
  begin
    Rows := 0;
    StringGrid1.RowCount := SearchShopList.Count +1;
    begin
      for I := 0 to (ShopList.List.Count -1) do
        begin
          TempShopObj := ShopList.List.Objects[I] as TBOShop;
          for a := 0 to (SearchShopList.Count -1) do
          begin
            if ContainsText(SearchShopList[a],TempShopObj.ShopID) then
            begin
            StringGrid1.Cells[0,Rows+1] := TempShopObj.ShopID;
            StringGrid1.Cells[1,Rows+1] := TempShopObj.ShopName;
            StringGrid1.Cells[2,Rows+1] := TempShopObj.AddressLine1;
            StringGrid1.Cells[3,Rows+1] := TempShopObj.AddressLine2;
            StringGrid1.Cells[4,Rows+1] := TempShopObj.AddressLine3;
            StringGrid1.Cells[5,Rows+1] := TempShopObj.AddressPostcode;
            Inc(Rows);
            end;
          end;
        end;
      CurrentShopObj := ShopList.List.Objects[0] as TBOShop;
      AutoSizeGridColumns(StringGrid1);
      for I := 0 to (ShopList.List.Count -1) do
        begin
          CreateGridButtons(6,I+1);
        end;
    end;
  end;
end;

procedure TFrmShops.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
  var
  I:Integer;
  begin
if ARow = 0 then
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color := clGray;
      Canvas.FillRect(Rect);
      StringGrid1.Canvas.Font.Color := clWhite;
      Canvas.TextOut(Rect.Left+2,Rect.Top+2,Cells[ACol, ARow]);
    end;
end;

procedure TFrmShops.AutoSizeGridColumns(Grid: TStringGrid);
const
  MIN_COL_WIDTH = 30;
var
  Col, RowNum: Integer;
  ColWidth, CellWidth, TempColWidth: Integer;
  Row: Integer;
begin
  Grid.Canvas.Font.Assign(Grid.Font);
  for Col := 0 to Grid.ColCount - 2 do
  begin
    ColWidth := 0;
    for RowNum := 0 to Grid.RowCount do
      begin
        TempColWidth := Grid.Canvas.TextWidth(Grid.Cells[Col, RowNum]);
        if TempColWidth > ColWidth then
        begin
          ColWidth := TempColWidth;
        end;
      end;
    for Row := 0 to Grid.RowCount - 1 do
      begin
        CellWidth := Grid.Canvas.TextWidth(Grid.Cells[Col, Row]);
        if CellWidth > ColWidth then
          Grid.ColWidths[Col] := CellWidth + MIN_COL_WIDTH
        else
          Grid.ColWidths[Col] := ColWidth + MIN_COL_WIDTH + 10;
      end;
  end;
end;

procedure TFrmShops.Close1Click(Sender: TObject);
begin
  Close;
end;

procedure TFrmShops.CreateGridButtons(ACol, ARow: Integer);
var
  R: TRect;
  Button, ButtonDel, ButtonTemp: TBitBtn;
begin
  R := StringGrid1.CellRect(ACol, ARow);
  Inc(R.Right, StringGrid1.GridLineWidth);
  Inc(R.Bottom, StringGrid1.GridLineWidth);
  Button := TBitBtn.Create(StringGrid1);
  Button.BoundsRect := R;
  Button.Glyph := IconButton2.Glyph;
  Button.Tag := ARow;
  Button.ControlStyle := [csClickEvents];
  Button.OnClick := BtnUpdateClick;
  Button.Parent := StringGrid1;
  StringGrid1.Objects[Acol, Arow] := Button;
  OffsetRect(R, 0, StringGrid1.DefaultRowHeight + StringGrid1.GridLineWidth);

  R := StringGrid1.CellRect(ACol+1, ARow);
  Inc(R.Right, StringGrid1.GridLineWidth);
  Inc(R.Bottom, StringGrid1.GridLineWidth);
  ButtonDel := TBitBtn.Create(StringGrid1);
  ButtonDel.Width := 20;
  ButtonDel.Height := 20;
  ButtonDel.BoundsRect := R;
  ButtonDel.Glyph := IconButton1.Glyph;
  ButtonDel.Tag := ARow;
  ButtonDel.ControlStyle := [csClickEvents];
  ButtonDel.OnClick := BtnDeleteClick;
  ButtonDel.Parent := StringGrid1;
  StringGrid1.Objects[Acol+1, Arow] := ButtonDel;
  OffsetRect(R, 0, StringGrid1.DefaultRowHeight + StringGrid1.GridLineWidth);
end;

end.
