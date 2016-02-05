unit Form99;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm99 = class(TW3Form)
  private
    {$I 'Form99:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm99 }

procedure TForm99.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm99.InitializeObject;
begin
  inherited;
  {$I 'Form99:impl'}
end;
 
procedure TForm99.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm99);
end.
