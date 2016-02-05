unit Form429;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm429 = class(TW3Form)
  private
    {$I 'Form429:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm429 }

procedure TForm429.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm429.InitializeObject;
begin
  inherited;
  {$I 'Form429:impl'}
end;
 
procedure TForm429.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm429);
end.
