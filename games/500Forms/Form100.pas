unit Form100;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm100 = class(TW3Form)
  private
    {$I 'Form100:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm100 }

procedure TForm100.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm100.InitializeObject;
begin
  inherited;
  {$I 'Form100:impl'}
end;
 
procedure TForm100.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm100);
end.
