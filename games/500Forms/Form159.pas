unit Form159;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm159 = class(TW3Form)
  private
    {$I 'Form159:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm159 }

procedure TForm159.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm159.InitializeObject;
begin
  inherited;
  {$I 'Form159:impl'}
end;
 
procedure TForm159.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm159);
end.
