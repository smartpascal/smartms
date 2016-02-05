unit Form56;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm56 = class(TW3Form)
  private
    {$I 'Form56:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm56 }

procedure TForm56.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm56.InitializeObject;
begin
  inherited;
  {$I 'Form56:impl'}
end;
 
procedure TForm56.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm56);
end.
