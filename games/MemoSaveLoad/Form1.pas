unit Form1;

interface

uses 
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application, SmartCL.Controls.Memo,
  SmartCL.Storage, SmartCL.Controls.Button;

type
  TForm1 = class(TW3Form)
    procedure btnSaveClick(Sender: TObject);
  private
    {$I 'Form1:intf'}
    FStorage: TW3LocalStorage;
    memoText := 'Type here and press the save button when finished.';
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
  end;

implementation

procedure TForm1.btnSaveClick(Sender: TObject);
begin
  FStorage.setKeyStr('MemoStr', W3Memo1.text);
end;

procedure TForm1.InitializeForm;
begin
  inherited;
  FStorage := TW3LocalStorage.Create;
  FStorage.Open('MemoDemo');
  W3Memo1.Text := memoText;
  var s := FStorage.getKeyStr('MemoStr', 'error');
  if s = 'error' then
    begin
      FStorage.setKeyStr('MemoStr', memoText);
    end
  else
    begin
      W3Memo1.Text := s;
    end;
end;

procedure TForm1.InitializeObject;
begin
  inherited;
  {$I 'Form1:impl'}
  W3Memo1.ScrollH := soNone;
  W3Memo1.ScrollV := soAuto;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.
