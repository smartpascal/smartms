unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, SmartCL.Fonts,
  SmartCL.Borders, SmartCL.Application, SmartCL.Grid, SmartCL.Grid.Columns;

type
  TStock = record
    StockCode : string;
    Price : float;
    StockLevel : integer;
  end;

  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    const MAX_ITEMS = 3;
    Items : array[1 .. 3] of TStock;
    TextCol :  TW3TextColumn;
    CurrencyCol, LevelCol : TW3NumberColumn;
    RowCaptions : array[1 .. 3] of string := ['Stock Code', 'Price', 'Stock Level'];
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
   end;

implementation

procedure TForm1.InitializeForm;
begin
  inherited;
  Items[1].StockCode := 'ABC123';
  Items[1].Price := 56.28;
  Items[1].StockLevel := 5;

  Items[2].StockCode := 'ABD138';
  Items[2].Price := 6.35;
  Items[2].StockLevel := 50;

  Items[3].StockCode := 'ABE107';
  Items[3].Price := 1.08;
  Items[3].StockLevel := 200;


  TextCol := TW3TextColumn.Create(W3Grid1 as IW3ColumnsControl);
  TextCol.Header.Caption := RowCaptions[1];
  (TextCol.Header as TW3CustomControl).Font.Weight := 'bold';
  TextCol.Width := 100;
  W3Grid1.Columns.Add(TextCol);

  CurrencyCol := TW3NumberColumn.Create(W3Grid1 as IW3ColumnsControl);
  CurrencyCol.Header.Caption := RowCaptions[2];
  (CurrencyCol.Header as TW3CustomControl).Font.Weight := 'bold';
  CurrencyCol.Width := 80;
  TW3NumberColumn(CurrencyCol).TextBefore := '£'; //Use Notepad to save the HTML as UTF8
  W3Grid1.Columns.Add(CurrencyCol);

  LevelCol := TW3NumberColumn.Create(W3Grid1 as IW3ColumnsControl);
  LevelCol.Header.Caption := RowCaptions[3];
  (LevelCol.Header as TW3CustomControl).Font.Weight := 'bold';
  LevelCol.Width := 100;
  TW3NumberColumn(LevelCol).Precision := 0;
  W3Grid1.Columns.Add(LevelCol);

  W3Grid1.AddRow(MAX_ITEMS);
  for var i := 0 to MAX_ITEMS - 1 do
    begin
      W3Grid1.Cell[0, i].Value := Items[(i+1)].StockCode;
      W3Grid1.Cell[1, i].Value := Items[(i+1)].Price;
      W3Grid1.Cell[2, i].Value := Items[(i+1)].StockLevel;
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
