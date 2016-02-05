unit Form316;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm316 = class(TW3Form)
  private
    {$I 'Form316:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm316 }

procedure TForm316.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm316.InitializeObject;
begin
  inherited;
  {$I 'Form316:impl'}
end;
 
procedure TForm316.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm316);
end.
