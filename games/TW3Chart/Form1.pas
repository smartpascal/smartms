unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Chart, SmartCL.Controls.ToolBar,
  SmartCL.Controls.ToolButton;

type
  TForm1 = class(TW3Form)
    procedure W3ToolButton2Click(Sender: TObject);
    procedure W3ToolButton1Click(Sender: TObject);
  private
    {$I 'Form1:intf'}
  protected
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.W3ToolButton1Click(Sender: TObject);
begin
  W3Chart1[0].Visible := true;
  W3Chart1[1].Visible := false;
 end;

procedure TForm1.W3ToolButton2Click(Sender: TObject);
begin
  W3Chart1[1].Visible := true;
  W3Chart1[0].Visible := false;
end;

procedure TForm1.InitializeObject;
var
  bars: TBarSeries;
begin
  inherited;
  {$I 'Form1:impl'}
handle.ReadyExecute( procedure ()
    begin
      W3Chart1.Title.Text := 'Percentage of Sessions on PPS (Sept 2014)';
      W3Chart1.Legend.Position := lpBottom;
      bars := TBarSeries.Create;
      W3Chart1.AddSeries(bars); //The first series to be added is W3Chart1[0] (or W3Chart1.Item[0])
      W3Chart1[0].Data.Values := [17, 9, 6, 5, 4, 3, 3, 2, 2, 2];   //or W3Chart1.Item[0].Data.Values
      W3Chart1[0].Data.Labels := ['UK', 'US','Germany', 'India', 'Brazil', 'Indonesia',
                                  'Russia', 'Netherlands', 'Italy', 'France'];
      W3Chart1[0].Data.Values.Reverse;
      W3Chart1[0].Data.Labels.Reverse;

      W3Chart1.AddSeries(TPieSeries.Create);
      W3Chart1[1].Data.Values := [52, 20, 20, 5, 2];
      W3Chart1[1].Data.Labels := ['Europe', 'Americas', 'Asia', 'Africa', 'Oceania'];
      W3Chart1[0].Visible := false;
      W3Chart1[1].Visible := false;
    end);

end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
