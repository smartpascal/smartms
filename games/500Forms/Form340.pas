unit Form340;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm340 = class(TW3Form)
  private
    {$I 'Form340:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm340 }

procedure TForm340.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm340.InitializeObject;
begin
  inherited;
  {$I 'Form340:impl'}
end;
 
procedure TForm340.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm340);
end.
