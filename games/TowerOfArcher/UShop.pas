unit UShop;

interface

uses 
  W3Image, W3Graphics,
  UShopItem, UShopData;

type TShop = class(TObject)
  public
    Items : array [0 .. 4] of TShopItem;
    Loaded : boolean;
    constructor Create();
    procedure ResetItems();
    procedure Draw(canvas : TW3Canvas);
    procedure CheckClicked(xPos, yPos : integer);
  private
    ContentLoaded : array [0 .. 4] of boolean;
    procedure CheckLoadedContent();
end;

var
  Shop : TShop;

implementation

constructor TShop.Create();
var
  textures : array [0 .. 4] of TW3Image;
begin
  Loaded := false;
  ContentLoaded := [ false, false, false, false, false ];

  // Load textures
  textures[0] := TW3Image.Create(nil);
  textures[0].LoadFromURL("res\ArcherThumbnail.png");
  textures[1] := TW3Image.Create(nil);
  textures[1].LoadFromURL("res\DamageThumbnail.png");
  textures[2] := TW3Image.Create(nil);
  textures[2].LoadFromURL("res\IceThumbnail.png");
  textures[3] := TW3Image.Create(nil);
  textures[3].LoadFromURL("res\RangeThumbnail.png");
  textures[4] := TW3Image.Create(nil);
  textures[4].LoadFromURL("res\SpeedThumbnail.png");

  // Apply to OnLoad event
  textures[0].OnLoad :=  procedure(o : TObject) begin ContentLoaded[0] := true;  CheckLoadedContent(); end;
  textures[1].OnLoad :=  procedure(o : TObject) begin ContentLoaded[1] := true;  CheckLoadedContent(); end;
  textures[2].OnLoad :=  procedure(o : TObject) begin ContentLoaded[2] := true;  CheckLoadedContent(); end;
  textures[3].OnLoad :=  procedure(o : TObject) begin ContentLoaded[3] := true;  CheckLoadedContent(); end;
  textures[4].OnLoad :=  procedure(o : TObject) begin ContentLoaded[4] := true;  CheckLoadedContent(); end;

  // Create each shop item
  Items[0] := TShopItem.Create(150, 20, 5, 1000, 1.3, "Extra Archers", textures[0], AddArcher);
  Items[1] := TShopItem.Create(150, 80, -1, 100, 1.3, "Increase Damage", textures[1], IncreaseDamage);
  Items[2] := TShopItem.Create(150, 140, 5, 700, 1.6, "Freeze", textures[2], IncreaseIce);
  Items[3] := TShopItem.Create(150, 200, 10, 100, 1.2, "Increase Max Power", textures[3], IncreaseRange);
  Items[4] := TShopItem.Create(150, 260, 8, 300, 1.4, "Decrease Reload Speed", textures[4], DecreaseReload);
end;

procedure TShop.ResetItems();
begin
  for var i := 0 to 4 do
    begin
      Items[i].Reset();
    end;
end;

procedure TShop.Draw(canvas : TW3Canvas);
begin
  for var i := 0 to 4 do
    begin
      Items[i].Draw(canvas);
    end;

  // Draw the message
  canvas.FillStyle := "rgb(110, 0, 0)";
  canvas.Font := "24pt verdana";
  canvas.TextAlign := "center";
  canvas.TextBaseLine := "top";
  canvas.FillTextF(PurchaseMessage, 150 + SHOP_WIDTH / 2, 320, SHOP_WIDTH * 2);
end;

procedure TShop.CheckClicked(xPos, yPos : integer);
begin
  for var i := 0 to High(Items) do
    begin
      // Purchase the item if it was clicked
      if Items[i].IsInButton(xPos, yPos) then
        begin
          Items[i].Purchase();
          break;
        end;
    end;
end;

procedure TShop.CheckLoadedContent();
begin
  // Check each content is loaded
  for var i := 0 to High(ContentLoaded) do
    begin
      if not ContentLoaded[i] then
        begin
          exit
        end;
    end;

  // If they are all loaded state all content is loaded
  Loaded := true;
end;

end.
