unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Button,
  SmartCL.Controls.Label, SmartCL.Controls.Memo, SmartCL.Inet, SmartCL.Layout;

type
  TForm1=class(TW3form)
  private
    {$I 'Form1:intf'}
    FLayout: TLayout;
    FHttp: TW3HttpRequest;
    procedure Download(url: string);
    procedure HandleDataReady(Sender: TW3HttpRequest);
    procedure HandleReadyStateChange(Sender: TW3HttpRequest);
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  FLayout := Layout.Client(Layout{1}.Margins(20).Spacing(10), [
    Layout{2}.Top(btnGetInetTxt),
    Layout{3}.Top(btnGetResNotHere),
    Layout{4}.Top(lblResult),
    Layout{5}.Top(memoResult),
    Layout{6}.Top(lblLog),
    Layout{7}.Top(memoLog)
  ]);
  btnGetInetTxt.OnClick := procedure (Sender: TObject)
    begin
      Download('res/inet.txt');
    end;
  btnGetResNotHere.OnClick := procedure (Sender: TObject)
    begin
      Download('http://ec2-54-194-211-233.eu-west-1.compute.amazonaws.com:8080/root/Member?select=*');
    end;
 end;

procedure TForm1.Download(url: string);
begin
  memoLog.Text := '';
  memoResult.Text := '';
  FHttp := TW3HttpRequest.Create;
  FHttp.OnDataReady := HandleDataReady;
  FHttp.OnReadyStateChange := HandleReadyStateChange;
  FHttp.Get(url);
end;

procedure TForm1.HandleDataReady(Sender: TW3HttpRequest);
begin
  memoResult.Text := FHttp.ResponseText;
end;

procedure TForm1.HandleReadyStateChange(Sender: TW3HttpRequest);
begin
  if Sender.ReadyState = 4 then
    memoLog.Text := memoLog.Text + 'ReadyState: 4   ' + 'Status: ' + Sender.Status.ToString;
end;

procedure TForm1.Resize;
begin
  inherited;
  FLayout.Resize(Self);
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);

end.