unit Form300;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm300 = class(TW3Form)
  private
    {$I 'Form300:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm300 }

procedure TForm300.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm300.InitializeObject;
begin
  inherited;
  {$I 'Form300:impl'}
end;
 
procedure TForm300.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm300);
end.
