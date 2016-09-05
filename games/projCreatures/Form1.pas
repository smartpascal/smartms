{ ╔═════════════════════════════╗
  ║  _______  _______  _______  ║
  ║ (  ____ \(       )(  ____ \ ║
  ║ | (    \/| () () || (    \/ ║
  ║ | (_____ | || || || (_____  ║
  ║ (_____  )| |(_)| |(_____  ) ║
  ║       ) || |   | |      ) | ║
  ║ /\____) || )   ( |/\____) | ║
  ║ \_______)|/     \|\_______) ║
  ║Sea creatures by: warleyalex ║
  ╚═════════════════════════════╝ }

unit Form1;

interface

uses 
  FireSpriteAtlas, MainView,
  W3C.Console, W3C.HTML5, W3C.DOM, ECMA.JSON,
  SmartCL.Forms, SmartCL.Application, uMDButton;

type
  TForm1 = class(TW3Form)

  private
    {$I 'Form1:intf'}
    FParticles: TMainView;
    procedure StartStop(Sender: TObject);
  protected
    procedure HandleBackButtonClicked(Sender: TObject); 
    procedure FormActivated; override;
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
    procedure Resize; override;
  end;

implementation

(*================== TForm1 ==========================*)
{ TForm1 }
procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  FParticles := TMainView.Create(Self);
  FParticles.Width:= 800;
  FParticles.Height:= 600;
  FParticles.OnClick := StartStop;
end;

procedure TForm1.FinalizeObject;
begin
  FParticles.Free;
  inherited;
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.FormActivated;
begin
  inherited FormActivated;
  FParticles.Start;
end;

procedure TForm1.HandleBackButtonClicked(Sender: TObject);
begin
  FParticles.Stop;
end;

procedure TForm1.StartStop(Sender: TObject);
begin
  FParticles.Toggle;
end;

procedure TForm1.Resize;
//var DeltaY: Integer;
begin
  inherited;
/*  if Assigned(FParticles) then
  begin
    DeltaY := btn1.Top + btn1.Height + 10;
    FParticles.SetBounds(10, DeltaY, Width - 20, Height - (10 + DeltaY));
  end;*/
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);

end.