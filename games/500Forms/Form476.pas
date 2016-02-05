unit Form476;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm476 = class(TW3Form)
  private
    {$I 'Form476:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm476 }

procedure TForm476.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm476.InitializeObject;
begin
  inherited;
  {$I 'Form476:impl'}
end;
 
procedure TForm476.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm476);
end.
