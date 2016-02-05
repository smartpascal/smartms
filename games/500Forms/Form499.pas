unit Form499;

interface

uses 
  System.Types, SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application;

type
  TForm499 = class(TW3Form)
  private
    {$I 'Form499:intf'}
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm499 }

procedure TForm499.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm499.InitializeObject;
begin
  inherited;
  {$I 'Form499:impl'}
end;
 
procedure TForm499.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm499);
end.
