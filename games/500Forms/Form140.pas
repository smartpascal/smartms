unit Form140;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm140 = class(TW3Form)
  private
    {$I 'Form140:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm140 }

procedure TForm140.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm140.InitializeObject;
begin
  inherited;
  {$I 'Form140:impl'}
end;
 
procedure TForm140.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm140);
end.
