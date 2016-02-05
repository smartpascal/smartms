unit Form43;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm43 = class(TW3Form)
  private
    {$I 'Form43:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm43 }

procedure TForm43.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm43.InitializeObject;
begin
  inherited;
  {$I 'Form43:impl'}
end;
 
procedure TForm43.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm43);
end.
