unit Form305;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm305 = class(TW3Form)
  private
    {$I 'Form305:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm305 }

procedure TForm305.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm305.InitializeObject;
begin
  inherited;
  {$I 'Form305:impl'}
end;
 
procedure TForm305.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm305);
end.
