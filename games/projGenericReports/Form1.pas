unit Form1;

interface

uses 
  uBaseReport,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application,
  SmartCL.Controls.Combobox, SmartCL.Controls.Memo;

type
  TForm1 = class(TW3Form)
    procedure ComboBox1Changed(Sender: TObject);
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

procedure TForm1.ComboBox1Changed(Sender: TObject);
begin
  if ComboBox1.SelectedIndex >= 1 then
  begin
    var rpt:= TModelFactory.CreateModelFromID( ComboBox1.Items[ComboBox1.SelectedIndex] );
    div1.InnerHTML := rpt.BuildReport;
  end;
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  ComboBox1.BeginUpdate;
  ComboBox1.Clear;
  ComboBox1.Add('Select a report');
  ComboBox1.Add('devil_report');
  ComboBox1.Add('flowers_report');
  ComboBox1.Add('cards_report');
  ComboBox1.EndUpdate;
end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.