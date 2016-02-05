unit Form462;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm462 = class(TW3Form)
  private
    {$I 'Form462:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm462 }

procedure TForm462.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm462.InitializeObject;
begin
  inherited;
  {$I 'Form462:impl'}
end;
 
procedure TForm462.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm462);
end.
