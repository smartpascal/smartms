unit Form254;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm254 = class(TW3Form)
  private
    {$I 'Form254:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm254 }

procedure TForm254.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm254.InitializeObject;
begin
  inherited;
  {$I 'Form254:impl'}
end;
 
procedure TForm254.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm254);
end.
