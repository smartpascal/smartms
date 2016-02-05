unit Form161;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm161 = class(TW3Form)
  private
    {$I 'Form161:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm161 }

procedure TForm161.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm161.InitializeObject;
begin
  inherited;
  {$I 'Form161:impl'}
end;
 
procedure TForm161.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm161);
end.
