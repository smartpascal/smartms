unit Form173;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm173 = class(TW3Form)
  private
    {$I 'Form173:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm173 }

procedure TForm173.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm173.InitializeObject;
begin
  inherited;
  {$I 'Form173:impl'}
end;
 
procedure TForm173.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm173);
end.
