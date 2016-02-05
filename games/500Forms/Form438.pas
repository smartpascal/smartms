unit Form438;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm438 = class(TW3Form)
  private
    {$I 'Form438:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm438 }

procedure TForm438.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm438.InitializeObject;
begin
  inherited;
  {$I 'Form438:impl'}
end;
 
procedure TForm438.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm438);
end.
