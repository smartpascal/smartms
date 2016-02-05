unit Form388;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm388 = class(TW3Form)
  private
    {$I 'Form388:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm388 }

procedure TForm388.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm388.InitializeObject;
begin
  inherited;
  {$I 'Form388:impl'}
end;
 
procedure TForm388.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm388);
end.
