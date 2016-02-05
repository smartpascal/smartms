unit Form381;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm381 = class(TW3Form)
  private
    {$I 'Form381:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm381 }

procedure TForm381.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm381.InitializeObject;
begin
  inherited;
  {$I 'Form381:impl'}
end;
 
procedure TForm381.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm381);
end.
