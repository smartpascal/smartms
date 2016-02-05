unit Form366;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm366 = class(TW3Form)
  private
    {$I 'Form366:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm366 }

procedure TForm366.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm366.InitializeObject;
begin
  inherited;
  {$I 'Form366:impl'}
end;
 
procedure TForm366.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm366);
end.
