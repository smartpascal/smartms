unit Form391;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm391 = class(TW3Form)
  private
    {$I 'Form391:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm391 }

procedure TForm391.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm391.InitializeObject;
begin
  inherited;
  {$I 'Form391:impl'}
end;
 
procedure TForm391.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm391);
end.
