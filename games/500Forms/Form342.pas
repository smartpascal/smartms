unit Form342;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm342 = class(TW3Form)
  private
    {$I 'Form342:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm342 }

procedure TForm342.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm342.InitializeObject;
begin
  inherited;
  {$I 'Form342:impl'}
end;
 
procedure TForm342.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm342);
end.
