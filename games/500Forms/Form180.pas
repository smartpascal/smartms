unit Form180;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm180 = class(TW3Form)
  private
    {$I 'Form180:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm180 }

procedure TForm180.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm180.InitializeObject;
begin
  inherited;
  {$I 'Form180:impl'}
end;
 
procedure TForm180.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm180);
end.
