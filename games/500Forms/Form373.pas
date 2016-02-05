unit Form373;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm373 = class(TW3Form)
  private
    {$I 'Form373:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm373 }

procedure TForm373.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm373.InitializeObject;
begin
  inherited;
  {$I 'Form373:impl'}
end;
 
procedure TForm373.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm373);
end.
