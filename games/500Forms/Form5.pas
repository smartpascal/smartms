unit Form5;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm5 = class(TW3Form)
  private
    {$I 'Form5:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm5 }

procedure TForm5.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm5.InitializeObject;
begin
  inherited;
  {$I 'Form5:impl'}
end;
 
procedure TForm5.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm5);
end.
