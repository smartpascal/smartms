unit Form274;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm274 = class(TW3Form)
  private
    {$I 'Form274:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm274 }

procedure TForm274.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm274.InitializeObject;
begin
  inherited;
  {$I 'Form274:impl'}
end;
 
procedure TForm274.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm274);
end.
