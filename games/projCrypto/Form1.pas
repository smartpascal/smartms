unit Form1;

//{$R 'lib\aes.js'}
//{$R 'https://cdnjs.cloudflare.com/ajax/libs/crypto-js/3.1.2/rollups/aes.js'}

interface

uses 
  uCryptoJS,
  W3C.TypedArray,  W3C.Cryptography, System.Diagnostics,
  SynCrossPlatformCrypto, 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Controls.Button, SmartCL.Controls.EditBox, SmartCL.Controls.Combobox;

type
  JOptions = class(JObject)
    class var mode := cryptoJS.mode.CBC;
    class var padding := cryptoJS.pad.Pkcs7;
  end;

type
  TForm1 = class(TW3Form)
    procedure GenerateUUID1Click(Sender: TObject);
    procedure GenerateUUID2Click(Sender: TObject);
    procedure ComboBox1Changed(Sender: TObject);
    procedure W3Button1Click(Sender: TObject);
    procedure btndecryptClick(Sender: TObject);
    procedure btnEncrptClick(Sender: TObject);
  private
    {$I 'Form1:intf'}
    op : JOptions;
    json: JCipherParams;
    _keySizeInBits: integer;
    procedure genPassphrase;
  protected

    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

function GenerateUUID:string;
// The procedure to generate a version 4 UUID is as follows:
// 1. Generate 16 random bytes (=128 bits)
// 2. Adjust certain bits according to RFC 4122 section 4.4 as follows:
//   a. set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
//   b. set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
// 3. Convert the adjusted bytes to 32 hexadecimal digits
// 4. Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
// 5. Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
var
  d0, d1, d2, d3: integer;
begin
  d0 := Integer(Now + PerformanceTimer.Now) + Trunc(Random * $ffffffff);
  d1 := d0 + Trunc(Random * $ffffffff);
  d2 := d1 + Trunc(Random * $ffffffff);
  d3 := d2 + Trunc(Random * $ffffffff);
  d1 := (d1 and $ff0fffff) or $00400000;
  d2 := (d2 and $ffffff3f) or $00000080;
  Result := IntToHex(d0 and $ff, 2) + IntToHex((d0 shr 8) and $ff, 2) +
    IntToHex((d0 shr 16) and $ff, 2) + IntToHex((d0 shr 24) and $ff, 2) + '-' +
    IntToHex(d1 and $ff, 2) + IntToHex((d1 shr 8) and $ff, 2) + '-' +
    IntToHex((d1 shr 16) and $ff, 2) + IntToHex((d1 shr 24) and $ff, 2) + '-' +
    IntToHex(d2 and $ff, 2) + IntToHex((d2 shr 8) and $ff, 2) + '-' +
    IntToHex((d2 shr 16) and $ff, 2) + IntToHex((d2 shr 24) and $ff, 2) +
    IntToHex(d3 and $ff, 2) + IntToHex((d3 shr 8) and $ff, 2) +
    IntToHex((d3 shr 16) and $ff, 2) + IntToHex((d3 shr 24) and $ff, 2);
end;


function GenerateUUIDNew: string;
// The procedure to generate a version 4 UUID is as follows:
// 1. Generate 16 random bytes (=128 bits)
// 2. Adjust certain bits according to RFC 4122 section 4.4 as follows:
//   a. set the four most significant bits of the 7th byte to 0100'B, so the high nibble is '4'
//   b. set the two most significant bits of the 9th byte to 10'B, so the high nibble will be one of '8', '9', 'A', or 'B'.
// 3. Convert the adjusted bytes to 32 hexadecimal digits
// 4. Add four hyphen '-' characters to obtain blocks of 8, 4, 4, 4 and 12 hex digits
// 5. Output the resulting 36-character string "XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX"
var
  data: JUint8Array;
begin
  data := JUint8Array.Create(16);
  JCrypto.getRandomValues(data);
  data[6] := (data[6] and $0f) or $40;
  data[8] := (data[8] and $3f) or $80;
  Result := IntToHex(data[0], 2) + IntToHex(data[1], 2) +
    IntToHex(data[2], 2) + IntToHex(data[3], 2) + '-' +
    IntToHex(data[4], 2) + IntToHex(data[5], 2) + '-' +
    IntToHex(data[6], 2) + IntToHex(data[7], 2) + '-' +
    IntToHex(data[8], 2) + IntToHex(data[9], 2) + '-' +
    IntToHex(data[10], 2) + IntToHex(data[11], 2) +
    IntToHex(data[12], 2) + IntToHex(data[13], 2) +
    IntToHex(data[14], 2) + IntToHex(data[15], 2);
end;


procedure TForm1.btnEncrptClick(Sender: TObject);
begin
/*** encrypt */
  json := CryptoJS.AES.encrypt(edit1.text, "Secret Passphrase", op);
  edit2.Text := json.ciphertext.toString(CryptoJS.enc.Base64);

end;

procedure TForm1.btndecryptClick(Sender: TObject);
begin
/*** decrypt */
  var decrypt := CryptoJS.AES.decrypt(json, "Secret Passphrase", op);
  edit3.Text := decrypt.toString(CryptoJS.enc.Utf8);

end;


function parseInt(s: string; radix: integer = 0): integer;external;

function troncaNum(c, a: variant): variant;
begin
	var b := c.toString();
	result := b.substring(0, a)
end;

function getHash(c, e: variant): variant;
begin
	var d : variant;
	var b = parseInt(e);
	if (b = 128) then
  begin
		d := SHA256(c);
		var a = 128 / 4;
		d := troncaNum(d, a)
	end else
  begin
		if (b = 192) then begin
			d := SHA256(c);
			var a = 192 / 4;
			d := troncaNum(d, a)
		end else
    begin
			if (b = 256) then begin
				d := SHA256(c)
			end;
		end;
	end;
	result := d;
end;

function randomPassphrase(c: variant): variant;
begin
  try
		var d = (RandomInt(10000));
		var b = getHash(d, c);
		result := b
  except
    on E : Exception do
   	  result := -1
  end;
end;

procedure TForm1.W3Button1Click(Sender: TObject);
begin
  genPassphrase;
end;

procedure TForm1.GenerateUUID2Click(Sender: TObject);
begin
  EditUI2.Text := GenerateUUIDNew;
end;

procedure TForm1.GenerateUUID1Click(Sender: TObject);
begin
  EditUI1.Text := GenerateUUID;
end;

procedure TForm1.genPassphrase;
begin
  _keySizeInBits := StrToInt( ComboBox1.Items[ComboBox1.SelectedIndex] ); //192;
	var a = randomPassphrase(_keySizeInBits);
  keysize.Text := a;
end;

procedure TForm1.ComboBox1Changed(Sender: TObject);
begin
  WriteLn(ComboBox1.Items[ComboBox1.SelectedIndex]);
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  // this is a good place to initialize components
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  op := new JOptions;

ComboBox1.Add('128');
ComboBox1.Add('192');
ComboBox1.Add('256');

end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.