unit Form231;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm231 = class(TW3Form)
  private
    {$I 'Form231:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm231 }

procedure TForm231.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm231.InitializeObject;
begin
  inherited;
  {$I 'Form231:impl'}
end;
 
procedure TForm231.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm231);
end.
