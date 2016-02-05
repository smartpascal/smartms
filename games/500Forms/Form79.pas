unit Form79;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm79 = class(TW3Form)
  private
    {$I 'Form79:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm79 }

procedure TForm79.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm79.InitializeObject;
begin
  inherited;
  {$I 'Form79:impl'}
end;
 
procedure TForm79.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm79);
end.
