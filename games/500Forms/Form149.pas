unit Form149;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm149 = class(TW3Form)
  private
    {$I 'Form149:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm149 }

procedure TForm149.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm149.InitializeObject;
begin
  inherited;
  {$I 'Form149:impl'}
end;
 
procedure TForm149.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm149);
end.
