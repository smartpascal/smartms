unit Form251;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm251 = class(TW3Form)
  private
    {$I 'Form251:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm251 }

procedure TForm251.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm251.InitializeObject;
begin
  inherited;
  {$I 'Form251:impl'}
end;
 
procedure TForm251.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm251);
end.
