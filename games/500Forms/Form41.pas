unit Form41;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm41 = class(TW3Form)
  private
    {$I 'Form41:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm41 }

procedure TForm41.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm41.InitializeObject;
begin
  inherited;
  {$I 'Form41:impl'}
end;
 
procedure TForm41.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm41);
end.
