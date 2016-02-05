unit Form259;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm259 = class(TW3Form)
  private
    {$I 'Form259:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm259 }

procedure TForm259.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm259.InitializeObject;
begin
  inherited;
  {$I 'Form259:impl'}
end;
 
procedure TForm259.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm259);
end.
