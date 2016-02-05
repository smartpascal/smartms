unit Form272;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm272 = class(TW3Form)
  private
    {$I 'Form272:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm272 }

procedure TForm272.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm272.InitializeObject;
begin
  inherited;
  {$I 'Form272:impl'}
end;
 
procedure TForm272.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm272);
end.
