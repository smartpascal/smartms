unit Form364;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm364 = class(TW3Form)
  private
    {$I 'Form364:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm364 }

procedure TForm364.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm364.InitializeObject;
begin
  inherited;
  {$I 'Form364:impl'}
end;
 
procedure TForm364.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm364);
end.
