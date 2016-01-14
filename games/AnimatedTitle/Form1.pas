unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Sprite3D, SmartCL.Time;

type
  TTitle= class(tw3sprite)
  private
    mDown:  Boolean;
  protected
    procedure InitializeObject; override;
  public
    procedure UpdateBehavior(const TimeId: integer); override;
  end;

type
  TForm1 = class(TW3Form)
  private
    {$I 'Form1:intf'}
    FTitle: TTitle;
    FTimer: TW3Timer;
    FCounter: integer;
  protected
    procedure FinalizeObject; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure HandleUpdate(Sender: TObject);
  end;

implementation

{ TTitle}

procedure TTitle.InitializeObject
begin
  inherited;
  SetTransformFlags(CNT_USE_POS or CNT_USE_ROTY);
  Width := 422;
  Height := 57;
  mDown := True;
  Update3d;
  Transparent := True;
  Background.fromURL('res/parallax.png');
end;

procedure TTitle.UpdateBehavior(const TimeId: integer);
begin
  if (TimeId mod 3) = 0 then
  begin
    case mDown of
    True:
      begin
        if Y < 20 then
          MoveY(0.5)
        else
          mDown := False;
      end;
    False:
      begin
        if Y > 10 then
          MoveY(-0.5)
        else
          mDown := True;
      end;
    end;
    Update3d;
  end
  else
  begin
    RotateY(-1);
    Update3d;
  end;
end;

{ TForm1}

procedure TForm1.HandleUpdate(Sender: TObject);
begin
  Inc(FCounter);
  FTitle.UpdateBehavior(FCounter);
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  StyleClass := '';
  FTitle := TTitle.Create(self);
  FTimer := TW3Timer.Create;
  FTimer.Delay := 1;
  FTimer.onTime := HandleUpdate;
  FTimer.Enabled := True;
end;

procedure TForm1.FinalizeObject;
begin
  FTitle.Free;
  inherited;
end;

procedure TForm1.Resize;
var
  dx : integer;
begin
  inherited;
  dx := (Width div 2) - (FTitle.Width div 2);
  FTitle.SetBounds(dx, 10, FTitle.Width, FTitle.Height);
end;

 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.