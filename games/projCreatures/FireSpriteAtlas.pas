unit FireSpriteAtlas;

interface

uses 
  W3C.Console, W3C.HTML5, W3C.DOM, ECMA.JSON;

type
  TFireSpriteAtlas = class
  private
    srcArray: variant;
    spriteSheetLocation: variant;
    SpriteSheet: JHTMLImageElement;
  protected
  public
    constructor Create(jsonArray: variant); virtual;
  published
    function createSprite(keyName: variant): variant;
    function createSpriteCanvas(keyName: variant): variant;
  end;

  function genFrameNames(b, a, c, d, f: variant): variant;

implementation

function this: Variant; external 'this' property;

{ TFireSpriteAtlas }

constructor TFireSpriteAtlas.Create(jsonArray: Variant);
begin
  //The jsonArray
  srcArray := jsonArray;
  //Get the location of the Image file from the passed in argument
  spriteSheetLocation := jsonArray.meta.image;
  //Create an Image to house the spriteSheet then load it in
	SpriteSheet := JHTMLImageElement(Document.createElement('img'));
	SpriteSheet.src := spriteSheetLocation;
end;

{ FireSpriteAtlas }
function TFireSpriteAtlas.createSprite(keyName: Variant): variant;
    procedure FireSprite(sourceSpriteSheet: Variant; sourceX: Variant; sourceY: Variant; sourceWidth: Variant; sourceHeight: Variant);
    begin
    		var srcImage := sourceSpriteSheet;
    		var srcX := sourceX;
    		var srcY := sourceY;
    		var srcWidth := sourceWidth;
    		var srcHeight := sourceHeight;
    		var scale := 1.0;

        this.draw := lambda(canvasContext, drawX, drawY: variant)
        	canvasContext.drawImage(srcImage, srcX, srcY, srcWidth, srcHeight, drawX, drawY, srcWidth*scale, srcHeight*scale);
        end;//endof draw


        this.setScale := lambda(newScale: float)
            begin
        			scale := newScale;
        			if(scale < 0.0) then begin
        				this.setScale(0.0);
        			end;
            end;
        		end;//endof setScale}

        this.getWidth := lambda():variant;
        			result := srcWidth * scale;
        		end;//endof getWidth

        this.getHeight := lambda(): variant
        			result := srcHeight * scale;
        		end;//endof getHeight

        this.getScale := lambda(): variant
        			result := scale;
        		end;//endof getScale
    end;

begin
	var foundSprite := false;

	for var i := 0 to srcArray.frames.length - 1 do begin
		if(srcArray.frames[i].filename = keyName) then begin
			var wantedSprite := srcArray.frames[i];
			  //result := new FireSprite(SpriteSheet, wantedSprite.frame.x, wantedSprite.frame.y, wantedSprite.frame.w, wantedSprite.frame.h);
        asm @result = new @FireSprite(@SpriteSheet, (@wantedSprite).frame.x, (@wantedSprite).frame.y, (@wantedSprite).frame.w, (@wantedSprite).frame.h); end;
			foundSprite := true;
			break;
		end;
	end;
	//returns an alert error if it cant find the sprite, comment out if you dont want it (it wont break anything if its gone)
	if (not foundSprite) then
		console.log("Error: Sprite "+keyName+" not found in " + spriteSheetLocation);
end;

function TFireSpriteAtlas.createSpriteCanvas(keyName: Variant): variant;
    function FireSpriteCanvas(sourceSpriteSheet: Variant; sourceX: Variant; sourceY: Variant; sourceWidth: Variant; sourceHeight: Variant): variant;
    begin
    	var imageCanvas : variant = document.createElement('canvas');
    	imageCanvas.width := sourceWidth;
    	imageCanvas.heigh := sourceHeight;
    	var imageContext := imageCanvas.getContext("2d");
    	imageContext.drawImage(sourceSpriteSheet, sourceX, sourceY, sourceWidth, sourceHeight, 0, 0, sourceWidth, sourceHeight);

    	result := imageCanvas;
    end;

begin
	var foundSprite := false;

	for var i := 0 to srcArray.frames.length - 1 do begin
		if(srcArray.frames[i].filename = keyName)then begin
			var wantedSprite := srcArray.frames[i];
			  //result := new FireSpriteCanvas(SpriteSheet, wantedSprite.frame.x, wantedSprite.frame.y, wantedSprite.frame.w, wantedSprite.frame.h);
        asm @result = new @FireSpriteCanvas(@SpriteSheet, (@wantedSprite).frame.x, (@wantedSprite).frame.y, (@wantedSprite).frame.w, (@wantedSprite).frame.h); end;
			foundSprite := true;
			break;
		end;
	end;
	//returns an alert error if it cant find the sprite, comment out if you dont want it (it wont break anything if its gone)
	if(not foundSprite) then
		console.log("Error: Sprite "+keyName+" not found in " + spriteSheetLocation);
end;

function genFrameNames(b, a, c, d, f: variant): variant;
  procedure pad(b: Variant; a: Variant; c: Variant; d: Variant);
  begin
  ASM
  	void 0 === @a && (@a = 0);
  	void 0 === @c && (@c = " ");
  	void 0 === @d && (@d = 3);
  	var f = 0;
  	if (@a + 1 >= (@b).length) {
  		switch (@d) {
  		case 1:
  			@b = Array(@a + 1 - (@b).length).join(@c) + @b;
  			break;
  		case 3:
  			@a = Math.ceil((f = @a - (@b).length) / 2);
  			@b = Array(f - @a + 1).join(@c) + @b + Array(@a + 1).join(@c);
  			break;
  		default:
  			@b += Array(@a + 1 - (@b).length).join(@c);
  		}
  	}
  	return @b;
  END;
  end;

begin
ASM
	void 0 === @d && (@d = "");
	var g = [],
	e = "";
	if (@a < @c) {
		for (; @a <= @c; @a++) {
			e = "number" === typeof @f ? @pad((@a).toString(), @f, "0", 1) : (@a).toString(),
			e = @b + e + @d,
			g.push(e);
		}
	} else {
		for (; @a >= @c; @a--) {
			e = "number" === typeof @f ? @pad((@a).toString(), @f, "0", 1) : (@a).toString(),
			e = @b + e + @d,
			g.push(e);
		}
	}
	@result = g;
END;
end;

end.
