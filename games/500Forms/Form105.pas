unit Form105;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm105 = class(TW3Form)
  private
    {$I 'Form105:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm105 }

procedure TForm105.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm105.InitializeObject;
begin
  inherited;
  {$I 'Form105:impl'}
end;
 
procedure TForm105.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm105);
end.
