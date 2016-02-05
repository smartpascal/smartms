unit Form288;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm288 = class(TW3Form)
  private
    {$I 'Form288:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm288 }

procedure TForm288.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm288.InitializeObject;
begin
  inherited;
  {$I 'Form288:impl'}
end;
 
procedure TForm288.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm288);
end.
