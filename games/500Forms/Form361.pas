unit Form361;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm361 = class(TW3Form)
  private
    {$I 'Form361:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm361 }

procedure TForm361.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm361.InitializeObject;
begin
  inherited;
  {$I 'Form361:impl'}
end;
 
procedure TForm361.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm361);
end.
