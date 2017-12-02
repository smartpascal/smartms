unit uClients;

interface

uses 
  uWebCore, SmartCL.System;

type
  TAtividade = (Comercio, Servicos, Industria);

Type
  TClient = class
  private
    { private declarations }
    FCNPJ: String;
    FID: Integer;
    FNome: String;
    FRamo: TAtividade;
  protected
    { protected declarations }
  published
    { published declarations }
    property ID: Integer read FID write FID;
    property Nome: String read FNome write FNome;
    property CNPJ: String read FCNPJ write FCNPJ;
    property Atividade: TAtividade read FRamo write FRamo;
  end;

{Note that here we've done reference the two classes necessary to make the Example }
Type

  TListClient = class
    private
      { private declarations }
      FListClients : TObjectList;
    protected
      { protected declarations }
    public
      { public declarations }
      constructor Create;
      procedure Adicionar(pCliente: TClient);
      procedure RemoveCurrentRecord;
      function Count: Integer;
      function NewRecord: Integer;
    published
      { published declarations }
      function FirstRecord: TObject;
      function LastRecord: TObject;
      function NextRecord: TObject;
      function PriorRecord: TObject;
      function isPriorBtnEnabled: boolean;
      function isNextBtnEnabled: boolean;
      function CurrentRecord: TObject;
    end;

implementation

constructor TListClient.Create;
begin
  inherited Create;
  FListClients := TObjectList.Create;
end;

function TListClient.Count: Integer;
begin
  Result := FListClients.Count;
end;

function TListClient.NewRecord: Integer;
begin
  FListClients.selectedIndex := FListClients.Count;
  Result := FListClients.selectedIndex;
end;

function TListClient.CurrentRecord: TObject;
begin
  result := ( FListClients.Objects[FListClients.selectedIndex] );
end;

procedure TListClient.Adicionar(pCliente: TClient);
begin
  FListClients.Add(pCliente);
end;

procedure TListClient.RemoveCurrentRecord;
begin
  if (FListClients.selectedIndex < FListClients.Count - 1)  then begin
    if (FListClients.selectedIndex = 0) then
      FListClients.remove( FListClients.First )
    else
      FListClients.Delete(FListClients.selectedIndex);
  end;

  if (FListClients.selectedIndex > 0) then begin
      if FListClients.selectedIndex = FListClients.Count-1 then begin
        FListClients.remove( FListClients.Last ); //FListClients.remove( FListClients.Pop );
        FListClients.selectedIndex := FListClients.selectedIndex-1;
      end;
  end;

end;

function TListClient.FirstRecord: TObject;
begin
  FListClients.selectedIndex := 0;
  result := ( FListClients.First )
end;

function TListClient.PriorRecord: TObject;
begin
	if (FListClients.selectedIndex > 0) then begin
		FListClients.selectedIndex := FListClients.selectedIndex - 1;
    result := ( FListClients.Objects[FListClients.selectedIndex] );
	end;
end;

function TListClient.NextRecord: TObject;
begin
	if (FListClients.selectedIndex < FListClients.count-1) then begin
		FListClients.selectedIndex := FListClients.selectedIndex + 1;
    result := ( FListClients.Objects[FListClients.selectedIndex] );
	end;
end;

function TListClient.LastRecord: TObject;
begin
  FListClients.selectedIndex := FListClients.count-1;
  result := ( FListClients.Last );
end;

function TListClient.isNextBtnEnabled: boolean;
begin
  result := not((FListClients.count = 0) or (FListClients.selectedIndex = FListClients.count-1)); // disable btn "UP" if true
end;

function TListClient.isPriorBtnEnabled: boolean;
begin
  result := not((FListClients.count = 0) or (FListClients.selectedIndex = 0)); // disable btn "DOWN" if true
end;

end.
