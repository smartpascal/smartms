unit Form61;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm61 = class(TW3Form)
  private
    {$I 'Form61:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm61 }

procedure TForm61.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm61.InitializeObject;
begin
  inherited;
  {$I 'Form61:impl'}
end;
 
procedure TForm61.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm61);
end.
