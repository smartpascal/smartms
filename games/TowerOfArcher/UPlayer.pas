unit UPlayer;

interface

uses 
  UArcher;

type TPlayer = class(TArcher)
  public
    ExtraArchers : array of TArcher;
    procedure UpdateInformation(origX, origY, currX, currY : float); override;
    procedure Fire(); override;
    procedure UpdateY(newPos : float);
end;

implementation

procedure TPlayer.UpdateInformation(origX, origY, currX, currY : float);
begin
  inherited(origX, origY, currX, currY);

  // Update information for the extra archers
  for var i := 0 to High(ExtraArchers) do
    begin
      ExtraArchers[i].UpdateInformation(origX, origY, currX, currY);

      // Set the archer's ability to shoot to that of the player
      if not ExtraArchers[i].CanShoot = CanShoot then
        begin
          ExtraArchers[i].CanShoot := CanShoot;
        end;
    end;
end;

procedure TPlayer.Fire();
begin
  // Make extra archers also fire if the player can
  if CanShoot then
    begin
      for var i := 0 to High(ExtraArchers) do
        begin
          ExtraArchers[i].Fire();
        end;
    end;

  // Then fire the player
  inherited();
end;

procedure TPlayer.UpdateY(newPos : float);
var
  posChange : float;
begin
  // Get the change in y position
  posChange := Y - newPos;

  // Update the player's and extra archer's y position
  Y -= posChange;
  for var i := 0 to High(ExtraArchers) do
    begin
      ExtraArchers[i].Y -= posChange;
    end;
end;

end.
