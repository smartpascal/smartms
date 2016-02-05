unit Form279;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm279 = class(TW3Form)
  private
    {$I 'Form279:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm279 }

procedure TForm279.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm279.InitializeObject;
begin
  inherited;
  {$I 'Form279:impl'}
end;
 
procedure TForm279.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm279);
end.
