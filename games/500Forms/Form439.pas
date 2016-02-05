unit Form439;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm439 = class(TW3Form)
  private
    {$I 'Form439:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm439 }

procedure TForm439.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm439.InitializeObject;
begin
  inherited;
  {$I 'Form439:impl'}
end;
 
procedure TForm439.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm439);
end.
