unit Form1;

interface

uses 
   SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Layout,
  SmartCL.Controls.EditBox, SmartCL.Controls.Button, System.Colors,
  SmartCL.Controls.Elements;

type
  TForm1 = class(TW3Form)
procedure sClick(Sender: TObject);
    procedure edtNameChanged(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
  private
    {$I 'Form1:intf'}
    FLayout: TLayout;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

procedure TForm1.btnClearClick(Sender: TObject);
begin
  lblOutput.Caption := '';
  edtName.Text := '';
end;

procedure TForm1.edtNameChanged(Sender: TObject);
begin
  lblOutput.caption := 'Hello, ' + edtName.text + '!';
end;

procedure TForm1.sClick(Sender: TObject);
begin

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
  lblOutput.Caption := '';
  lblTitle.Font.Size := 18;
  lblOutput.Font.Color := clRed;

FLayout := Layout.Client(Layout{1}.Margins(20).Spacing(5), [
    Layout{2}.Top(lblTitle),
    Layout{3}.Top(btnClear),
    Layout{4}.Top(lblForename),
    Layout{5}.Top(edtName),
    Layout{6}.Top(lblOutput)
  ]);
end;
 
procedure TForm1.Resize;
begin
  inherited;
  if ClientHeight > ClientWidth then begin
      FLayout.Resize(Self);
      s.Handle.style.setProperty('display', 'none');
  end else
  begin
      s.Handle.style.setProperty('width', '100%');
      s.Handle.style.setProperty('height', '100%');
      s.Handle.style.setProperty('position', 'fixed');
      s.Handle.style.setProperty('top', '0px');
      s.Handle.style.setProperty('left', '0px');
      s.Handle.style.setProperty('background-color', 'white');
      s.Handle.style.setProperty('background-image', 'url("res/playportrait.png")');
      s.Handle.style.setProperty('background-repeat', 'no-repeat');
      s.Handle.style.setProperty('background-position', 'center center');
      s.Handle.style.setProperty('display', 'block');
 end;

end;

 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.