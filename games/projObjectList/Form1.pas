unit Form1;

interface

uses 
  uClients,
  uWebCore, W3C.Console,
  SmartCL.System, SmartCL.Graphics, SmartCL.Components, SmartCL.Forms, 
  SmartCL.Fonts, SmartCL.Borders, SmartCL.Application,
  SmartCL.Controls.EditBox, SmartCL.Controls.Button, SmartCL.Controls.Panel,
  SmartCL.Controls.Label;

type
  TForm1 = class(TW3Form)
    procedure W3Button1Click(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDelClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnLastClick(Sender: TObject);
    procedure btnNextClick(Sender: TObject);
    procedure btnPriorClick(Sender: TObject);
    procedure btnFirstClick(Sender: TObject);
  private
    {$I 'Form1:intf'}
     Client: TClient;
     ListClients : TListClient;
  protected
    procedure InitializeForm; override;
    procedure InitializeObject; override;
    procedure Resize; override;
    procedure updateControls();
  end;

implementation

{ TForm1 }

procedure TForm1.updateControls;
begin
  btnNext.enabled   := ListClients.isNextBtnEnabled;
  btnPrior.enabled  := ListClients.isPriorBtnEnabled;

  Client := ListClients.CurrentRecord as TClient;

  edit1.Text := IntToStr(Client.Id);
  edit2.Text := Client.Nome;
  edit3.Text := Client.CNPJ;

  if (not ListClients.isNextBtnEnabled and not ListClients.isPriorBtnEnabled) then
  begin
    edit1.Text := '';
    edit2.Text := '';
    edit3.Text := '';
  end;


end;

procedure TForm1.btnFirstClick(Sender: TObject);
begin
  //WriteLn('First record');
  Client := ListClients.FirstRecord as TClient;
  updateControls;
end;

procedure TForm1.btnPriorClick(Sender: TObject);
begin
  //WriteLn('Previous record');
  Client := ListClients.PriorRecord as TClient;
  updateControls;
end;

procedure TForm1.btnNextClick(Sender: TObject);
begin
  //WriteLn('Next record');
  Client:= ListClients.NextRecord as TClient;
  updateControls;
end;

procedure TForm1.btnLastClick(Sender: TObject);
begin
  //WriteLn('Last record');
  Client:= ListClients.LastRecord as TClient;
  updateControls;
end;

procedure TForm1.btnAddClick(Sender: TObject);
begin
  //WriteLn('Insert record');
  //updateControls;
    edit1.Text := IntToStr(ListClients.NewRecord);
    edit2.Text := '';
    edit3.Text := '';
end;

procedure TForm1.btnDelClick(Sender: TObject);
begin
  //WriteLn('Delete record');
  ListClients.RemoveCurrentRecord;
  updateControls;
end;

procedure TForm1.btnEditClick(Sender: TObject);
begin
  //WriteLn('Edit record');
end;

procedure TForm1.btnConfirmClick(Sender: TObject);
begin
  //WriteLn('Confirm Edit record');
  Client := TClient.Create;
  Client.ID        := StrToInt(edit1.Text);
  Client.Nome      := edit2.Text;
  Client.CNPJ      := edit3.Text;
  Client.Atividade :=  Servicos;
  ListClients.Adicionar(Client);

  updateControls;
end;

procedure TForm1.btnCancelClick(Sender: TObject);
begin
  //WriteLn('Cancel Edit record');
  btnFirstClick(Self); // ignore editing
end;

procedure TForm1.btnRefreshClick(Sender: TObject);
begin
  //WriteLn('Refresh Edit record');
end;

procedure TForm1.W3Button1Click(Sender: TObject);
begin
  //WriteLn(ListClients.FirstRecord);

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
    // Instantiating Client List
  ListClients := TListClient.Create;
  //By now we're able to handle our list, including, removing and counting. Let's start with Add.

for var k := 0 to 9 do begin
    Client := TClient.Create;
    Client.ID        := k;//StrToInt(edit1.Text);
    Client.Nome      := 'warleyalex'+IntToStr(k);//edit2.Text;
    Client.CNPJ      := '12345'+IntToStr(k);//edit3.Text;
    Client.Atividade :=  Comercio;
    ListClients.Adicionar(Client);
end;
    //console.log(ListClients);
    btnFirstClick(Self); // display the 1st object
end;
 
procedure TForm1.Resize;
begin
  inherited;
end;
 
initialization
  Forms.RegisterForm({$I %FILE%}, TForm1);
end.