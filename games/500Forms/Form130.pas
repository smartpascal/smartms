unit Form130;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm130 = class(TW3Form)
  private
    {$I 'Form130:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm130 }

procedure TForm130.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm130.InitializeObject;
begin
  inherited;
  {$I 'Form130:impl'}
end;
 
procedure TForm130.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm130);
end.
