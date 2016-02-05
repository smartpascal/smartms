unit Form195;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm195 = class(TW3Form)
  private
    {$I 'Form195:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm195 }

procedure TForm195.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm195.InitializeObject;
begin
  inherited;
  {$I 'Form195:impl'}
end;
 
procedure TForm195.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm195);
end.
