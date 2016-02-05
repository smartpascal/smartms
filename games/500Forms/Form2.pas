unit Form2;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm2 = class(TW3Form)
  private
    {$I 'Form2:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm2 }

procedure TForm2.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm2.InitializeObject;
begin
  inherited;
  {$I 'Form2:impl'}
end;
 
procedure TForm2.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm2);
end.
