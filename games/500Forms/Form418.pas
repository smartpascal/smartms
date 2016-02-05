unit Form418;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm418 = class(TW3Form)
  private
    {$I 'Form418:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm418 }

procedure TForm418.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm418.InitializeObject;
begin
  inherited;
  {$I 'Form418:impl'}
end;
 
procedure TForm418.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm418);
end.
