unit Form413;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm413 = class(TW3Form)
  private
    {$I 'Form413:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm413 }

procedure TForm413.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm413.InitializeObject;
begin
  inherited;
  {$I 'Form413:impl'}
end;
 
procedure TForm413.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm413);
end.
