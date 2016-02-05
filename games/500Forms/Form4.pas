unit Form4;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm4 = class(TW3Form)
  private
    {$I 'Form4:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm4 }

procedure TForm4.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm4.InitializeObject;
begin
  inherited;
  {$I 'Form4:impl'}
end;
 
procedure TForm4.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm4);
end.
