unit Form325;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm325 = class(TW3Form)
  private
    {$I 'Form325:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm325 }

procedure TForm325.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm325.InitializeObject;
begin
  inherited;
  {$I 'Form325:impl'}
end;
 
procedure TForm325.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm325);
end.
