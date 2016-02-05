unit Form183;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm183 = class(TW3Form)
  private
    {$I 'Form183:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm183 }

procedure TForm183.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm183.InitializeObject;
begin
  inherited;
  {$I 'Form183:impl'}
end;
 
procedure TForm183.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm183);
end.
