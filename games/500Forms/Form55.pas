unit Form55;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm55 = class(TW3Form)
  private
    {$I 'Form55:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm55 }

procedure TForm55.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm55.InitializeObject;
begin
  inherited;
  {$I 'Form55:impl'}
end;
 
procedure TForm55.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm55);
end.
