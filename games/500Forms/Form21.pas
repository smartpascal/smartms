unit Form21;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm21 = class(TW3Form)
  private
    {$I 'Form21:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm21 }

procedure TForm21.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm21.InitializeObject;
begin
  inherited;
  {$I 'Form21:impl'}
end;
 
procedure TForm21.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm21);
end.
