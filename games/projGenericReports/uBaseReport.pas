unit uBaseReport;

interface

uses W3C.Console;

type

TBaseReport = class(TObject)
  published
    function BuildReport: string; virtual;
  end;

  TModelClass = class of TBaseReport;

  TModelFactory = class
  public
    class function CreateModelFromID(const AID: string): TBaseReport;
    class function FindModelClassForId(const AID: string): TModelClass;
    class function GetModelClassID(AModelClass: TModelClass): string;
    class procedure RegisterModelClass(const AID: string;
      AModelClass: TModelClass);
  end;

implementation

uses uReportA, uReportB, uReportC;

{ TModelFactory }

type
  TModelClassRegistration = record
    ID: string;
    ModelClass: TModelClass;
  end;

var
  RegisteredModelClasses: array of TModelClassRegistration;

class function TModelFactory.CreateModelFromID(const AID: string): TBaseReport;
var
  ModelClass: TModelClass;
begin
  ModelClass :=  FindModelClassForId(AID);
  if ModelClass <> nil then
    Result := ModelClass.Create
  else
    Result := nil;
end;

class function TModelFactory.FindModelClassForId(
  const AID: string): TModelClass;
var
  i, Len: integer;
begin
  Result := nil;
  Len := Length(RegisteredModelClasses);
  for i := 0 to Len - 1 do
    if RegisteredModelClasses[i].ID = AID then begin
      Result := RegisteredModelClasses[i].ModelClass;
      break;
    end;
end;

class function TModelFactory.GetModelClassID(AModelClass: TModelClass): string;
var
  i, Len: integer;
begin
  Result := '';
  Len := Length(RegisteredModelClasses);
  for i := 0 to Len - 1 do
    if RegisteredModelClasses[i].ModelClass = AModelClass then begin
      Result := RegisteredModelClasses[i].ID;
      break;
    end;
end;

class procedure TModelFactory.RegisterModelClass(const AID: string;
  AModelClass: TModelClass);
var
  i, Len: integer;
begin
  Assert(AModelClass <> nil);
  Len := Length(RegisteredModelClasses);
  for i := 0 to Len - 1 do
    if (RegisteredModelClasses[i].ID = AID)
      and (RegisteredModelClasses[i].ModelClass = AModelClass)
    then begin
      Assert(FALSE);
      exit;
    end;
  RegisteredModelClasses.SetLength(Len+1);
  
  RegisteredModelClasses[Len].ID := AID;
  RegisteredModelClasses[Len].ModelClass := AModelClass;
end;

function TBaseReport.BuildReport: string;
begin
  Result := 'master report';
end;

initialization
  var rec :TModelClassRegistration;
  rec.ID := 'devil_report';
  rec.ModelClass := TReportA;
  RegisteredModelClasses.Add(rec);
  rec.ID:= 'flowers_report';
  rec.ModelClass := TReportB;
  RegisteredModelClasses.Add(rec);
  rec.ID := 'cards_report';
  rec.ModelClass := TReportC;
  RegisteredModelClasses.Add(rec);
end.
