unit Form290;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm290 = class(TW3Form)
  private
    {$I 'Form290:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm290 }

procedure TForm290.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm290.InitializeObject;
begin
  inherited;
  {$I 'Form290:impl'}
end;
 
procedure TForm290.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm290);
end.
