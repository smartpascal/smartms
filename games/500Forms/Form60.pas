unit Form60;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm60 = class(TW3Form)
  private
    {$I 'Form60:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm60 }

procedure TForm60.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm60.InitializeObject;
begin
  inherited;
  {$I 'Form60:impl'}
end;
 
procedure TForm60.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm60);
end.
