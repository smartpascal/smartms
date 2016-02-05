unit Form432;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm432 = class(TW3Form)
  private
    {$I 'Form432:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm432 }

procedure TForm432.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm432.InitializeObject;
begin
  inherited;
  {$I 'Form432:impl'}
end;
 
procedure TForm432.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm432);
end.
