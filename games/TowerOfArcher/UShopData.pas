unit UShopData;

interface

uses 
  UArcher, UGameVariables, UPlayerData, UTextures;

var
  PurchaseMessage : string;

// Purchase event handlers for shop items
procedure AddArcher();
procedure IncreaseDamage();
procedure IncreaseRange();
procedure DecreaseReload();
procedure IncreaseIce();

implementation

procedure AddArcher();
begin
  if Length(Player.ExtraArchers) = 0 then
    begin
      // Create the first extra archer for the player
      Player.ExtraArchers[0] := TArcher.Create(Player.X - ArcherTexture.Handle.width - 30, Player.Y + 20);
    end
  else
    begin
      // Get the y change compared to the last archer
      var yChange := 20;
      if Length(Player.ExtraArchers) mod 2 = 0 then
        begin
          // If there are an off amount of archers the next archer is above the previous
          yChange *= -1;
        end;

      // Get the y and x position
      var xPos := Player.ExtraArchers[High(Player.ExtraArchers)].X - ArcherTexture.Handle.width - 30;
      var yPos := Player.ExtraArchers[High(Player.ExtraArchers)].Y + yChange;

      // Create the new archer
      Player.ExtraArchers[Length(Player.ExtraArchers)] := TArcher.Create(xPos, yPos);
    end;
end;

procedure IncreaseDamage();
begin
  ArrowDamage += 10;
end;

procedure IncreaseRange();
begin
  MaxPower += 2;
end;

procedure DecreaseReload();
begin
  TimeBetweenShots -= 200;
end;

procedure IncreaseIce();
begin
  ArrowsFreeze := true;
  ArrowFreezeDuration += 500;
end;

end.
