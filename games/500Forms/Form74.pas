unit Form74;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm74 = class(TW3Form)
  private
    {$I 'Form74:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm74 }

procedure TForm74.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm74.InitializeObject;
begin
  inherited;
  {$I 'Form74:impl'}
end;
 
procedure TForm74.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm74);
end.
