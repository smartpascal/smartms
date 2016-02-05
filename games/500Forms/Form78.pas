unit Form78;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm78 = class(TW3Form)
  private
    {$I 'Form78:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm78 }

procedure TForm78.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm78.InitializeObject;
begin
  inherited;
  {$I 'Form78:impl'}
end;
 
procedure TForm78.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm78);
end.
