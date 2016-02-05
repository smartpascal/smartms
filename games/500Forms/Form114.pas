unit Form114;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm114 = class(TW3Form)
  private
    {$I 'Form114:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm114 }

procedure TForm114.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm114.InitializeObject;
begin
  inherited;
  {$I 'Form114:impl'}
end;
 
procedure TForm114.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm114);
end.
