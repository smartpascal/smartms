unit Form175;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm175 = class(TW3Form)
  private
    {$I 'Form175:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm175 }

procedure TForm175.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm175.InitializeObject;
begin
  inherited;
  {$I 'Form175:impl'}
end;
 
procedure TForm175.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm175);
end.
