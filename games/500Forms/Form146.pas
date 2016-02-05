unit Form146;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm146 = class(TW3Form)
  private
    {$I 'Form146:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm146 }

procedure TForm146.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm146.InitializeObject;
begin
  inherited;
  {$I 'Form146:impl'}
end;
 
procedure TForm146.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm146);
end.
