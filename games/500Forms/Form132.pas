unit Form132;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm132 = class(TW3Form)
  private
    {$I 'Form132:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm132 }

procedure TForm132.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm132.InitializeObject;
begin
  inherited;
  {$I 'Form132:impl'}
end;
 
procedure TForm132.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm132);
end.
