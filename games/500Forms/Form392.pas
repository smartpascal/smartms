unit Form392;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm392 = class(TW3Form)
  private
    {$I 'Form392:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm392 }

procedure TForm392.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm392.InitializeObject;
begin
  inherited;
  {$I 'Form392:impl'}
end;
 
procedure TForm392.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm392);
end.
