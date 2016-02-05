unit Form467;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm467 = class(TW3Form)
  private
    {$I 'Form467:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm467 }

procedure TForm467.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm467.InitializeObject;
begin
  inherited;
  {$I 'Form467:impl'}
end;
 
procedure TForm467.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm467);
end.
