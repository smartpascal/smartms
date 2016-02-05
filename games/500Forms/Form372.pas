unit Form372;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm372 = class(TW3Form)
  private
    {$I 'Form372:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm372 }

procedure TForm372.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm372.InitializeObject;
begin
  inherited;
  {$I 'Form372:impl'}
end;
 
procedure TForm372.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm372);
end.
