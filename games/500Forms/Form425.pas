unit Form425;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm425 = class(TW3Form)
  private
    {$I 'Form425:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm425 }

procedure TForm425.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm425.InitializeObject;
begin
  inherited;
  {$I 'Form425:impl'}
end;
 
procedure TForm425.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm425);
end.
