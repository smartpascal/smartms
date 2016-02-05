unit Form255;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm255 = class(TW3Form)
  private
    {$I 'Form255:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm255 }

procedure TForm255.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm255.InitializeObject;
begin
  inherited;
  {$I 'Form255:impl'}
end;
 
procedure TForm255.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm255);
end.
