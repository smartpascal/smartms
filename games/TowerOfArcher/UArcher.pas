unit UArcher;

interface

uses 
  W3Time,
  USpawner, UGameVariables, UTextures, UScalingInfo;

type TArcher = class(TObject)
  public
    X, Y : float;
    XVol, YVol : float; // The predicted x and y velocities of shots
    CanShoot : boolean;
    constructor Create(newX, newY : float);
    procedure UpdateInformation(origX, origY, currX, currY : float); virtual;
    procedure Fire(); virtual;
    function ArrowSpawnPoint() : array [0 .. 1] of float;
    function Angle() : float;
    function Power() : float;
    procedure PauseTimer();
    procedure ResumeTimer();
  private
    Timer : TW3EventRepeater; // Timer for shots
    DelayHolder : integer;
    function HandleTimer(sender : TObject) : boolean;
end;

implementation

constructor TArcher.Create(newX, newY : float);
begin
  X := newX;
  Y := newY;
  XVol := 0;
  YVol := 0;
  CanShoot := true;
end;

procedure TArcher.UpdateInformation(origX, origY, currX, currY : float);
begin
  // Work out the x and y velocities
  XVol := (origX - currX) / (PIXELTOPOWERRATIO * (1 / Scale));
  YVol := (origY - currY) / (PIXELTOPOWERRATIO * (1 / Scale));
end;

procedure TArcher.Fire();
begin
  if CanShoot then
    begin
      SpawnArrow(XVol, YVol, ArrowSpawnPoint()[0], ArrowSpawnPoint()[1]);

      XVol := 0;
      YVol := 0;

      // Make the player unable to shoot and start the timer again
      CanShoot := false;
      Timer := TW3EventRepeater.Create(HandleTimer, TimeBetweenShots);
    end;
end;

function TArcher.ArrowSpawnPoint() : array [0 .. 1] of float;
var
  xPoint, yPoint : float;
begin
  // Get the x and y points using trigonometry
  xPoint := X + ArcherTexture.Handle.width / 2 + Cos(Angle()) * BowTexture.Handle.width;
  yPoint := Y + ArcherTexture.Handle.height / 3 + Sin(Angle()) * BowTexture.Handle.width;

  exit([xPoint, yPoint]);
end;

function TArcher.Angle() : float;
begin
  // Return the angle
  exit(ArcTan2(YVol, XVol));
end;

function TArcher.Power() : float;
var
  retVal : float;
begin
  // Return nothing if the archer cannot shoot
  if not CanShoot then
    begin
      exit(0);
    end;

  // Get the power
  retVal := Sqrt(Sqr(XVol) + Sqr(YVol));

  // Return max power if above max power, otherwise return the calculated power
  if retVal > MaxPower then
    begin
      exit(MaxPower);
    end
  else
    begin
      exit(retVal);
    end;
end;

procedure TArcher.PauseTimer();
begin
  // Store the delay then destroy the timer
  DelayHolder := Timer.Delay;
  Timer.Destroy();
end;

procedure TArcher.ResumeTimer();
begin
  // Recreate the timer then reset the delay holder
  Timer := TW3EventRepeater.Create(HandleTimer, DelayHolder);
  DelayHolder := 0;
end;

function TArcher.HandleTimer(sender : TObject) : boolean;
begin
  CanShoot := true;
  TW3EventRepeater(sender).Free();
  exit(true);
end;

end.
