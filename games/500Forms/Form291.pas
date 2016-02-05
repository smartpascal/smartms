unit Form291;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm291 = class(TW3Form)
  private
    {$I 'Form291:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm291 }

procedure TForm291.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm291.InitializeObject;
begin
  inherited;
  {$I 'Form291:impl'}
end;
 
procedure TForm291.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm291);
end.
