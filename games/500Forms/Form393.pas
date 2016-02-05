unit Form393;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm393 = class(TW3Form)
  private
    {$I 'Form393:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm393 }

procedure TForm393.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm393.InitializeObject;
begin
  inherited;
  {$I 'Form393:impl'}
end;
 
procedure TForm393.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm393);
end.
