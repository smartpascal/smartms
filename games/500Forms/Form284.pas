unit Form284;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm284 = class(TW3Form)
  private
    {$I 'Form284:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm284 }

procedure TForm284.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm284.InitializeObject;
begin
  inherited;
  {$I 'Form284:impl'}
end;
 
procedure TForm284.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm284);
end.
