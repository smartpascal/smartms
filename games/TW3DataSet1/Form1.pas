unit Form1;

interface

uses
  System.Dataset,ECMA.JSON,
  //ECMA.Date,
  System.Diagnostics,
  System.Streams,
  System.Stream.Reader,
  System.Stream.Writer,
  System.NamePair,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application,
  SmartCL.Controls.Combobox;

type
  TDataSet = class(TW3DataSet)
  public
    function FieldByName(aName: string): TW3DatasetField;
  end;

  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    ProductsDS: TDataset;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TDataSet }
function TDataSet.FieldByName(aName: String): TW3DatasetField;
begin
  Result := Fields.FieldByName(aName);

  if not Assigned(Result) then
    WriteLn(Format('Field not found: %s', [aName]));
end;

{ TForm1 }

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}

var ds1 := '{"dhMagic":51966,"dhCount":15,"dhFieldDefs":{"ddMagic":3401235116,"ddDefs":[{"fdName":"productid","fdDatatype":4},{"fdName":"description","fdDatatype":4},{"fdName":"listprice","fdDatatype":3},{"fdName":"shipping","fdDatatype":3}]},"dhData":[{"productid":"9V-BATTERY-12PK","description":"12-pack of 9-volt batteries","listprice":20,"shipping":2},{"productid":"9V-BATTERY-4PK","description":"4-pack of 9-volt batteries","listprice":4.5,"shipping":1.5},{"productid":"CALCULATOR-BUSINESS","description":"Business calculator","listprice":10,"shipping":1},{"productid":"CASH-REGISTER","description":"Cash register with thermal printer","listprice":170,"shipping":10},{"productid":"FLASH-USB-16GB","description":"16GB USB flash drive","listprice":15,"shipping":0.5},{"productid":"FLASH-USB-32GB","description":"32GB USB flash drive","listprice":25,"shipping":0.5},{"productid":"FLASH-USB-8GB","description":"8GB USB flash drive","listprice":10,"shipping":0.5},{"productid":"LABEL-MAKER","description":"Label maker - plastic labels","listprice":35,"shipping":2},{"productid":"PEN-BP-12PK","description":"12-pack of ballpoint pens","listprice":12,"shipping":0.6},{"productid":"PHONE-HEADSET","description":"Hands-free phone headset","listprice":15,"shipping":2},{"productid":"PHONE-SYSTEM-4HS","description":"4-handset phone system with main base","listprice":120,"shipping":4},{"productid":"PROJECTOR-HD","description":"1080p HD Projector","listprice":850,"shipping":56},{"productid":"SCANNER-SF","description":"Sheet-feed paper scanner","listprice":150,"shipping":7},{"productid":"SHREDDER-SF-CC","description":"Sheet-feed, cross-cut shredder with bin","listprice":8,"shipping":10},{"productid":"USB-CARD-READER","description":"USB magnetic strip card reader","listprice":25,"shipping":2}]}';

ProductsDS := TDataset.Create;
ProductsDS.LoadFromString(ds1);
ProductsDS.CreateDataset;

ProductsDS.Active := true;

var ComboBox1: TW3ComboBox;

  ComboBox1 := TW3ComboBox.Create(Self);
  ComboBox1.Width := 200;
  ComboBox1.Top := 30;
  ComboBox1.Left := 30;
  ComboBox1.Height := 32;
  ComboBox1.Name := 'ComboBox1';
  ComboBox1.StyleClass := 'dropdown';
  ComboBox1.OnChanged := procedure(Sender: TObject)
  begin
    WriteLn( ComboBox1.Values[ComboBox1.SelectedIndex] );
  end;

  ComboBox1.BeginUpdate;
  ComboBox1.Clear;
  ComboBox1.Add('Select a product');
  {list Products content}
  ProductsDS.first;
  while not ProductsDS.EOF do
  begin
    ComboBox1.Add( ProductsDS.fields.fieldbyname('productid').asString );
    ProductsDS.Next;
  end;
  ComboBox1.EndUpdate;

end;

procedure TForm1.Resize;
begin
  inherited;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.