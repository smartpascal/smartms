unit Form311;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm311 = class(TW3Form)
  private
    {$I 'Form311:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm311 }

procedure TForm311.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm311.InitializeObject;
begin
  inherited;
  {$I 'Form311:impl'}
end;
 
procedure TForm311.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm311);
end.
