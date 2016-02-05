unit Form91;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm91 = class(TW3Form)
  private
    {$I 'Form91:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm91 }

procedure TForm91.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm91.InitializeObject;
begin
  inherited;
  {$I 'Form91:impl'}
end;
 
procedure TForm91.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm91);
end.
