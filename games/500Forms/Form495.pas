unit Form495;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm495 = class(TW3Form)
  private
    {$I 'Form495:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm495 }

procedure TForm495.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm495.InitializeObject;
begin
  inherited;
  {$I 'Form495:impl'}
end;
 
procedure TForm495.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm495);
end.
