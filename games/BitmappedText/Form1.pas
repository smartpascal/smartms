unit Form1;

interface

uses
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms,
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Sprite3D,
  SmartCL.Time, SmartCL.BitmapFont, SmartCL.Controls;

const
  CHAR_SIZE = 16;
  CHARSET_FONT = ' !"#¤%&/{}=_-\[]0123456789:;(|)?*abcdefghijklmnopqrstuvwxyz';

type
  TForm1 = class(TW3form)
  private
    {$I 'Form1:intf'}
    FTimer: TW3Timer;
    FCounter: integer;
    FMyFont: TKromaskyBitmapFont;
    FCredits: TW3Image;
    FFontDone: Boolean;
    FChars: array of TW3Sprite;
    FReady: array of TW3Sprite;
    FScrolled:Float;
    FText: string;
    FCharIndex: integer;
    procedure HandleUpdate(Sender: TObject);
    procedure SetupChars;
  protected
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure FormActivated; override;
    procedure FormDeActivated; override;
  end;

implementation

function getXforChar(aChar: string): Integer;
var
  xpos: Integer;
begin
  xpos := pos(aChar, CHARSET_FONT);
  if xpos > 0 then
    Result := CHAR_SIZE * (xpos - 1)
  else
    Result := 0;
end;

procedure TForm1.HandleUpdate(Sender : TObject);
var
  x : Integer;
  mSprite : TW3Sprite;
begin
  Inc(FCounter);
  if  FMyFont.Ready and not FFontDone then
    begin  // Image for font is stored as text in FMyFont so fnt16x16.png is not required here.
      FFontDone := True;
      FCredits := FMyFont.DrawAndMake('by cipher-diaz');
      FCredits.InsertInto(Self.Handle);
      w3_Callback(Self.Resize, 10);
    end;

  if Length(FChars) > 0 then
    begin
      x := -1;
      repeat
        Inc(x);
        mSprite := FChars[x];
        mSprite.MoveX(-0.5); //Move it 0.5 px to left

        if mSprite.x <= (-CHAR_SIZE) then  //Not visible
          begin
            FChars.Delete(x, 1);  //Delete it from characters shown.
            FReady.Add(mSprite);  //Add it to new ones to be shown at the right edge
            Dec(x);
          end
        else
          mSprite.Update3d;  //Display the character.
      until x >= high(FChars);
    end;

  FScrolled += 0.5;
  if FScrolled >= CHAR_SIZE then  //Will take 32 updates before next letter selected.
                                  //Only show new letter when rest have moved one character position.
    begin
      FScrolled := 0.0;
      Inc(FCharIndex);
      if FCharIndex > Length(FText) then
        FCharIndex := 1; //Start again with the first letter

      if FReady.Length > 0 then
        begin
          mSprite := FReady[0]; //Always show the first in the queue.
          FReady.Delete(0, 1); //Delete the sprite that is about to be displayed.
          //Set the position of the background so that it shows the required letter.
          mSprite.handle.style['backgroundPosition'] :=
            '-' + IntToStr(getXforChar(FText[FCharIndex])) +'px 0px';
          mSprite.x := Width;  //Position it at the right edge
          mSprite.y := (Height div 2) - (CHAR_SIZE div 2); //Centre it vertically
          mSprite.Update3d;  //Display the new letter
          FChars.Add(mSprite); //Add the displayed letter to the array of letters to be displayed
                               //until they are beyond the left edge of the form.
        end;
    end;
end;

procedure TForm1.SetupChars;
var
  cnt: Integer;
  x: Integer;
  mChar: TW3Sprite;
begin
  if FChars.Length < 1 then  //Just do this on the first form activation
    begin  //Calculate the number of characters that fit across the form.
      cnt := Width div CHAR_SIZE;
      if (cnt * CHAR_SIZE) < Width then
        Inc(cnt);
      Inc(cnt);

      for x := 0 to cnt - 1 do
        begin
          mChar := TW3Sprite.Create(self);
          mChar.SetTransformFlags(CNT_USE_POS);
          mChar.Background.fromUrl('res/fnt16x16.png'); //Background is all of the characters.
          mChar.Width := CHAR_SIZE;
          mChar.Height := CHAR_SIZE;
          mChar.Transparent := True;
          mChar.Visible := true;
          FReady.Add(mChar); //Add it to the array of characters ready to be displayed at the far right.
        end;
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  StyleClass := '';
  FMyFont := TKromaskyBitmapFont.Create; //For the credit at the bottom of the form

  FText := 'Welcome to 1990* This is a nice retro demo coded in '
    + '¤Smart Mobile Studio¤ Brought to you by Optimale Systemer AS  '
    + '&&&&&&&&    ';
  FText := lowercase(FText);
  FCharIndex := 0;
  FTimer := TW3Timer.Create;
  FTimer.Delay := 1;
  FTimer.onTime := HandleUpdate;
  FTimer.Enabled := False;
end;

procedure TForm1.Resize;
begin
  inherited;
  if FCredits <> nil then
  begin
    FCredits.Top := Height - (FCredits.Height + 10);
    FCredits.Left := (Width div 2) - (FCredits.Width div 2);
  end;
end;

procedure TForm1.FormActivated;
begin
  inherited;
  SetupChars;
  FTimer.Enabled := True;
  w3_callback(Self.Resize, 100);
end;

procedure TForm1.FormDeActivated;
begin
  FTimer.enabled := False;
  inherited;
end;

initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);

end.
