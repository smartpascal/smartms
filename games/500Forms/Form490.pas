unit Form490;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm490 = class(TW3Form)
  private
    {$I 'Form490:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm490 }

procedure TForm490.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm490.InitializeObject;
begin
  inherited;
  {$I 'Form490:impl'}
end;
 
procedure TForm490.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm490);
end.
