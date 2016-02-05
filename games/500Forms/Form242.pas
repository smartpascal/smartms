unit Form242;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm242 = class(TW3Form)
  private
    {$I 'Form242:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm242 }

procedure TForm242.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm242.InitializeObject;
begin
  inherited;
  {$I 'Form242:impl'}
end;
 
procedure TForm242.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm242);
end.
