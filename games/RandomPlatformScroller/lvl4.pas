unit lvl4;

interface

uses
  w3system, UE, UCreates, KeyCodeToKeyName, UGlobalsNoUserTypes;

procedure Initialize();

implementation

procedure Initialize();
begin
	clearvars();
	text('Use ' + CodeToKeyName(FallKey) + ' to fall through the platform', 'blue', 10, 230);
  text('or the button called "Fall" in the bottom right corner.', 'blue', 10, 250);
	indoor(10, 100);
	outdoor(100, 400);
	fixplats(10, 100 + ue.height,ue.width + 10, 10);
	fixplats(10, 90, ue.width + 10, 10);
	fixplats(10, 100, 10, ue.height);
	fixplats(10 + ue.width, 100, 10, ue.height);
	fixplats(10, 400 + ue.height, 100 + ue.width, 10);
	sidescrollsize(500, 600);
	percentofrands(0);
	startlvl();
end;

end.