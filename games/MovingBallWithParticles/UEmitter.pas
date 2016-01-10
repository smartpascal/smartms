unit UEmitter;
{
    Copyright (c) 2014 George Wright

    Licensed under the Apache License, Version 2.0 (the "License"); you may not
    use this file except in compliance with the License, as described at
    http://www.apache.org/licenses/ and http://www.pp4s.co.uk/licenses/
}

interface

uses
  SmartCL.System, SmartCL.Graphics, UParticle, UColourShifter;

type TParticleEmitter = class(TObject)
  Particles : array of TParticle; // Contains all the particles and their data
  EmitterX : float; // The starting X of all particles, the X origin point
  EmitterY : float; // The starting Y of all particles, the Y origin point
  LeftToSpawn : float; // Particles waiting to be spawned
  CurrentCol : array [0 .. 2] of integer;
  ColourToEdit : integer;
  IncrementCol : boolean;
  ColourShifter : TColourShifter; // The colour changer
  constructor Create(newx, newy : float);
  procedure Update(updateX, updateY : float; howManyToSpawn : float = 1); // Updates all the particles and makes any new ones
  procedure DrawStars(Canvas : TW3Canvas); // Draws all the stars
  function GenerateNewParticle : TParticle; // Will generate a new particle
end;

implementation

constructor TParticleEmitter.Create(newx, newy : float);
begin
  EmitterX := newx;
  EmitterY := newy;
  LeftToSpawn := 0;
  ColourShifter := TColourShifter.Create(0, 0, 0);
end;

procedure TParticleEmitter.Update(updateX, updateY : float; howManyToSpawn : float = 1);
begin
  // Set the x and y
  EmitterX := updateX;
  EmitterY := updateY;
  // Iterate over the particles
  for var i := 0 to High(Particles) do
    begin
      // Update the particle
      Particles[i].Update();
      // If the particle is meant to be dead kill it
      if (Particles[i].TTL <= 0) then
        begin
          // Respawn the particle
          Particles[i] := GenerateNewParticle();
          LeftToSpawn -= 1;
        end;
      end;

  LeftToSpawn += howManyToSpawn;

  for var i := 0 to trunc(LeftToSpawn) do
    begin
      // Generate a new particle
      Particles[High(Particles) + 1] := GenerateNewParticle();
      // Store that a particle was created
      LeftToSpawn -= 1
    end;
end;

procedure TParticleEmitter.DrawStars(Canvas: TW3Canvas);
begin
  // Iterate over each particle
  for var i := 0 to High(Particles) do
    // Draw the particle
    Particles[i].Draw(Canvas);
end;

function TParticleEmitter.GenerateNewParticle() : TParticle;
var
  pX, pY, pXvol, pYvol, pAngle, pSpin, pSize : float;
  pColour : array [0..2] of integer;
  pTTL : integer;
  returnP : TParticle;
begin
  // Set the new particle's X and Y
  pX := EmitterX;
  pY := EmitterY;
  // Set the new particle's x-velocity and y-velocity
  pXvol := randomint(10) - 5;
  pYvol := randomint(4) - 2;
  // Set the new particle's angle and spin
  pAngle := randomint(360);
  pSpin := randomint(60)- 30;
  // Set the new particle's colour
  pColour := ColourShifter.Colour;
  // Shift the colour
  ColourShifter.ShiftColour();
  // Set the new particle's size
  pSize := randomint(200) / 100;
  // Set the new particle's TTL
  pTTL := randomint(5) + 25;
   // Create the new particle
   returnP := TParticle.Create(pX, pY, pXvol, pYvol, pAngle, pSpin, pSize, pColour, pTTL);
  // Return the new particle
  exit(returnP);
end;

end.