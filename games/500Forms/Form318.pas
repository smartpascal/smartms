unit Form318;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm318 = class(TW3Form)
  private
    {$I 'Form318:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm318 }

procedure TForm318.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm318.InitializeObject;
begin
  inherited;
  {$I 'Form318:impl'}
end;
 
procedure TForm318.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm318);
end.
