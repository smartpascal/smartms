unit Form1;

{$R 'lib\aes.js'}

interface

uses 
  uCryptoJS,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Label,
  SmartCL.Controls.Button, SmartCL.Controls.EditBox;

type
  JOptions = class(JObject)
    class var mode := cryptoJS.mode.CBC;
    class var padding := cryptoJS.pad.Pkcs7;
  end;

type
  TForm1 = class(TW3Form)
    procedure btndecryptClick(Sender: TObject);
    procedure btnEncrptClick(Sender: TObject);
  private
    {$I 'Form1:intf'}
    op : JOptions;
    json: JCipherParams;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
  end;

implementation

{ TForm1 }

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

end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.