unit Form441;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm441 = class(TW3Form)
  private
    {$I 'Form441:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm441 }

procedure TForm441.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm441.InitializeObject;
begin
  inherited;
  {$I 'Form441:impl'}
end;
 
procedure TForm441.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm441);
end.
