unit Form228;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm228 = class(TW3Form)
  private
    {$I 'Form228:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm228 }

procedure TForm228.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm228.InitializeObject;
begin
  inherited;
  {$I 'Form228:impl'}
end;
 
procedure TForm228.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm228);
end.
