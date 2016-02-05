unit Form321;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm321 = class(TW3Form)
  private
    {$I 'Form321:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm321 }

procedure TForm321.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm321.InitializeObject;
begin
  inherited;
  {$I 'Form321:impl'}
end;
 
procedure TForm321.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm321);
end.
