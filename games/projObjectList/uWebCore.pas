unit uWebCore;

interface

uses
  SmartCL.System, //System.Types,
  W3C.Console, W3C.HTML5, W3C.DOM, W3C.CSS;



type
 EException = class external 'Exception'
    public
       constructor Create(const Msg: String);
       property Message: String;
       property Name: String;
       property StackTrace: String;
    end;

type
  EError = class external 'Error' (Eexception)
  public
    constructor Create(const message: String);
    property message: String;
    property name: String;
    property stack: String;
  end;



type
 TNotifyEvent = procedure (Sender: TObject) of object;

 TAbstractList = class
    private
       FUpdateCount: Integer;
       FUpdated: Boolean;
       FOnChanged: TNotifyEvent;
    protected
       property UpdateCount: Integer read FUpdateCount;
       procedure HandleChanges; virtual;
       procedure DoChanged; virtual;
       //procedure Load(AReader: TReader); override;
    public
       property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
       procedure BeginUpdate;
       procedure EndUpdate;
    end;

 TObjectsArray = array of TObject;

 TObjectSortCompare = function (L,R: TObject): Integer of object;

 TObjectList = class(TAbstractList)
    private
       FselectedIndex: Integer;
       FDestroying: Boolean;
       FOwnsObjects: Boolean=True;
       FCount: Integer;
       FObjects: TObjectsArray;
       FSorted: Boolean;
       procedure FreeObjects;
       function AddObject(NewObject: TObject): Integer;
       procedure InsertObject(InsertPos: Integer; NewObject: TObject);
       procedure DeleteObject(DeletePos: Integer; FreeOwnedObject: Boolean=True);
       procedure SetSorted(Value: Boolean);
       procedure SortObjects(L, R: Integer);
    protected
       procedure HandleChanges; override;
       procedure CheckIndex(Index: Integer);
       procedure SetCount(Value: Integer);
       function GetObject(Index: Integer): TObject; virtual;
       procedure SetObject(Index: Integer; AObject: TObject); virtual;
       function SortCompare(L,R: TObject): Integer; overload; virtual;
       function SortCompare(L: TObject; const R: String): Integer; overload; virtual;
    public
       constructor Create; overload;
       constructor Create(AOwnsObjects: Boolean); overload;
       destructor Destroy; override;
       property selectedIndex: Integer read FselectedIndex write FselectedIndex;
       property OwnsObjects: Boolean read FOwnsObjects;
       property Count: Integer read FCount write SetCount;
       property Objects[Index: Integer]: TObject read GetObject write SetObject; default;
       property Sorted: Boolean read FSorted write SetSorted;
       procedure Clear;
       function Add(AObject: TObject): Integer;
       procedure Delete(Index: Integer; FreeOwnedObject: Boolean=True);
       function Remove(AObject: TObject; FreeOwnedObject: Boolean=True): Integer;
       procedure Sort;
       function Find(const Value: String; NearestMatch: Boolean=False): Integer;
       function IndexOf(AObject: TObject): Integer;
       procedure Insert(Index: Integer; AObject: TObject);
       function First: TObject;
       function Prior(AObject: TObject; Wrap: Boolean=False): TObject;
       function Next(AObject: TObject; Wrap: Boolean=False): TObject;
       function Last: TObject;
       procedure Queue(AObject: TObject);
       function Dequeue: TObject;
       procedure Requeue(AObject: TObject);
       procedure Push(AObject: TObject);
       function Pop: TObject;
       procedure Exchange(Source: Integer; Dest: Integer);
       procedure Move(Source: Integer; Dest: Integer);
       procedure AddObjects(AList: TObjectList);
    end;


implementation

Const
   { Comparison results (for finding/sorting }
   CMP_LESS = -1;
   CMP_EQUAL = 0;
   CMP_GREATER = 1;

{ TAbstractList }

procedure TAbstractList.HandleChanges;
begin
   if Assigned(FOnChanged) then
      FOnChanged(Self);
end;

procedure TAbstractList.DoChanged;
begin
   if (FUpdateCount=0) then
      HandleChanges
   else
      FUpdated:=True;
end;


/*
procedure TAbstractList.DoChanged;
begin
   if (FUpdateCount=0) then
      begin
      if Assigned(FOnChanged) then
         FOnChanged(Self);
      end
   else
      FUpdated:=True;
end;
*/

/*
procedure TAbstractList.BeginUpdate;
begin
   Inc(FUpdateCount);
end;

procedure TAbstractList.EndUpdate;
begin
   if (FUpdateCount > 0) then
      begin
      Dec(FUpdateCount);
      if (FUpdateCount=0) and FUpdated then
         begin
         FUpdated:=False;
         DoChanged;
         end;
      end;
end;
*/

procedure TAbstractList.BeginUpdate;
begin
   Inc(FUpdateCount);
end;

procedure TAbstractList.EndUpdate;
begin
   if (FUpdateCount > 0) then
      begin
      Dec(FUpdateCount);
      if (FUpdateCount=0) and FUpdated then
         begin
         FUpdated:=False;
         HandleChanges;
         end;
      end;
end;

//-----------------------------------------------------
{ TObjectList }

{ TObjectList }

constructor TObjectList.Create;
begin
   inherited Create;
end;

constructor TObjectList.Create(AOwnsObjects: Boolean);
begin
   inherited Create;
   FOwnsObjects:=AOwnsObjects;
end;

destructor TObjectList.Destroy;
begin
   FDestroying:=True;
   FreeObjects;
   inherited Destroy;
end;

procedure TObjectList.FreeObjects;
var
   TempObject: TObject;
begin
   try
      while (FCount > 0) do
         begin
         TempObject:=FObjects[FCount-1];
         FObjects[FCount-1]:=nil;
         Dec(FCount);
         if FOwnsObjects then
            TempObject.Free;
         end;
   finally
      //SetLength(FObjects,0);
      FObjects.SetLength(0);
      FCount:=0;
   end;
end;

procedure TObjectList.HandleChanges;
begin
   if FSorted then
      Sort;
   inherited HandleChanges;
end;

procedure TObjectList.Clear;
begin
   SetCount(0);
end;

procedure TObjectList.SetCount(Value: Integer);
var
   I: Integer;
begin
   if (Value <> FCount) then
      begin
      if (Value < FCount) then
         begin
         if FOwnsObjects then
            begin
            for I:=FCount-1 downto Value do
               begin
               FObjects[I].Free;
               FObjects[I]:=nil;
               end;
            end;
         //SetLength(FObjects,Value);
         FObjects.SetLength(Value);
         end
      else if (Value > FCount) then
         begin
         //SetLength(FObjects,Value);
         FObjects.SetLength(Value);
         for I:=FCount to Value-1 do
            FObjects[I]:=nil;
         end;
      FCount:=Value;
      DoChanged;
      end;
end;

function TObjectList.AddObject(NewObject: TObject): Integer;
begin
   Result:=FCount;
   Inc(FCount);
   //SetLength(FObjects,FCount);
   FObjects.SetLength(FCount);
   FObjects[FCount-1]:=NewObject;
   DoChanged;
end;

procedure TObjectList.InsertObject(InsertPos: Integer; NewObject: TObject);
  function Insert(a, b, c: variant): variant;
  begin
    ASM
     if (@a instanceof Array)
        return Array.prototype.splice.apply(@b, [@c, 0].concat(@a));
     else
        return (@b).splice(@c, 0, @a);
    END;
  end;

begin
   { This is done to initialize the array !! }
   //SetLength(FObjects,FCount);
   FObjects.SetLength(FCount);
   Insert(NewObject,Variant(FObjects),InsertPos);
   Inc(FCount);
   DoChanged;
end;

procedure TObjectList.DeleteObject(DeletePos: Integer; FreeOwnedObject: Boolean=True);
  function Delete(a, b, c: variant): Variant;
  begin
   /*if (c) then
      result:= a.splice(b, c)
   else
      result:= a.splice(b);
   */
   result := if (c = true) then a.splice(b, c) else a.splice(b);
  end;

var
   TempObject: TObject;
begin
   TempObject:=FObjects[DeletePos];
   try
      if FOwnsObjects and FreeOwnedObject then
         TempObject.Free;
      Delete(Variant(FObjects),DeletePos,1);
   finally
      Dec(FCount);
      DoChanged;
   end;
end;

procedure TObjectList.CheckIndex(Index: Integer);
begin
   if (Index < 0) or (Index >= FCount) then
      //raise Exception.Create(Translate('ERR_LIST_BOUNDS',[IntToStr(Index)]));
      raise exception.create('List index '+IntToStr(Index)+' out of bounds');
end;

function TObjectList.GetObject(Index: Integer): TObject;
begin
   CheckIndex(Index);
   Result:=FObjects[Index];
end;

procedure TObjectList.SetObject(Index: Integer; AObject: TObject);
begin
   CheckIndex(Index);
   if (AObject <> FObjects[Index]) then
      begin
      FObjects[Index]:=AObject;
      DoChanged;
      end;
end;

function TObjectList.IndexOf(AObject: TObject): Integer;
var
   I: Integer;
begin
   Result:=-1;
   for I:=0 to FCount-1 do
      begin
      if (FObjects[I]=AObject) then
         begin
         Result:=I;
         Break;
         end;
      end;
end;

function TObjectList.Add(AObject: TObject): Integer;
begin
   Result:=AddObject(AObject);
end;

procedure TObjectList.Insert(Index: Integer; AObject: TObject);
begin
   if (Index < 0) or (FCount=0) then
      Index:=0
   else if (Index > FCount) then
      Index:=(FCount-1);
   InsertObject(Index,AObject);
end;

procedure TObjectList.Delete(Index: Integer; FreeOwnedObject: Boolean=True);
begin
  // if (not FDestroying) then
  //    begin
  //    CheckIndex(Index);
      DeleteObject(Index,FreeOwnedObject);
 //     end;
end;

function TObjectList.Remove(AObject: TObject; FreeOwnedObject: Boolean=True): Integer;
begin
   if FDestroying then
      Result:=-1
   else
      begin
      Result:=IndexOf(AObject);
      if (Result <> -1) then
         DeleteObject(Result,FreeOwnedObject);
      end;
end;

function TObjectList.First: TObject;
begin
   Result:=nil;
   if (FCount > 0) then
      Result:=FObjects[0];
end;

function TObjectList.Prior(AObject: TObject; Wrap: Boolean=False): TObject;
var
   I: Integer;
begin
   Result:=nil;
   I:=IndexOf(AObject);
   if (I <> -1) then
      begin
      if (I > 0) then
         Result:=FObjects[I-1]
      else if Wrap and (FCount > 0) then
         Result:=FObjects[FCount-1];
      end;
end;

function TObjectList.Next(AObject: TObject; Wrap: Boolean=False): TObject;
var
   I: Integer;
begin
   Result:=nil;
   I:=IndexOf(AObject);
   if (I <> -1) then
      begin
      if (I < (FCount-1)) then
         Result:=FObjects[I+1]
      else if Wrap and (FCount > 0) then
         Result:=FObjects[0];
      end;
end;

function TObjectList.Last: TObject;
begin
   Result:=nil;
   if (FCount > 0) then
      Result:=FObjects[FCount-1];
end;

procedure TObjectList.Queue(AObject: TObject);
begin
   AddObject(AObject);
end;

function TObjectList.Dequeue: TObject;
begin
   Result:=First;
   if Assigned(Result) then
      DeleteObject(0,False);
end;

procedure TObjectList.Requeue(AObject: TObject);
begin
   InsertObject(0,AObject);
end;

procedure TObjectList.Push(AObject: TObject);
begin
   AddObject(AObject);
end;

function TObjectList.Pop: TObject;
begin
   Result:=Last;
   if Assigned(Result) then
      DeleteObject((FCount-1),False);
end;

procedure TObjectList.Exchange(Source: Integer; Dest: Integer);
var
   TempObject: TObject;
begin
   CheckIndex(Source);
   CheckIndex(Dest);
   TempObject:=FObjects[Source];
   FObjects[Source]:=FObjects[Dest];
   FObjects[Dest]:=TempObject;
   DoChanged;
end;

procedure TObjectList.Move(Source: Integer; Dest: Integer);
var
   TempObject: TObject;
begin
   CheckIndex(Source);
   if (Dest <> Source) then
      begin
      TempObject:=FObjects[Source];
      Delete(Source,False);
      Insert(Dest,TempObject);
      DoChanged;
      end;
end;

procedure TObjectList.AddObjects(AList: TObjectList);
var
   I: Integer;
begin
   BeginUpdate;
   try
      AList.BeginUpdate;
      try
         for I:=0 to AList.Count-1 do
            Add(AList[I]);
         for I:=AList.Count-1 downto 0 do
            AList.Delete(I,False);
      finally
         AList.EndUpdate;
      end;
   finally
      EndUpdate;
   end;
end;

procedure TObjectList.SetSorted(Value: Boolean);
begin
   if (Value <> FSorted) then
      begin
      FSorted := Value;
      if FSorted = true then
         Sort;
      end;
end;

function TObjectList.SortCompare(L,R: TObject): Integer;
begin
   Result:=CMP_LESS;
end;

function TObjectList.SortCompare(L: TObject; const R: String): Integer;
begin
   Result:=CMP_LESS;
end;

procedure TObjectList.SortObjects(L, R: Integer);
var
   I: Integer;
   J: Integer;
   TempCompareObject: TObject;
   TempObject: TObject;
begin

   repeat
      I:=L;
      J:=R;
      TempCompareObject:=FObjects[(L+R) shr 1];
      repeat
         while (SortCompare(FObjects[I],TempCompareObject)=CMP_LESS) do
            Inc(I);
         while (SortCompare(FObjects[J],TempCompareObject)=CMP_GREATER) do
            Dec(J);
         if (I <= J) then
            begin
            if (I <> J) then
               begin
               TempObject:=FObjects[I];
               FObjects[I]:=FObjects[J];
               FObjects[J]:=TempObject;
               end;
            Inc(I);
            Dec(J);
            end;
      until (I > J);
      if (L < J) then
         SortObjects(L,J);
      L:=I;
   until (I >= R);

end;

procedure TObjectList.Sort;
begin
   if (FCount > 1) then
      SortObjects(0,FCount-1);
end;

function TObjectList.Find(const Value: String; NearestMatch: Boolean=False): Integer;
var
   I: Integer;
   J: Integer;
   TempResult: Integer;
begin
   Result:=-1;
   if (not FSorted) then
      //raise Exception.Create(Translate('ERR_LIST_SORT'));
      raise Exception.Create('ERR_LIST_SORT');
   if (FCount > 0) then
      begin
      TempResult:=CMP_LESS;
      I:=0;
      J:=(FCount-1);
      while (I <= J) do
         begin
         Result:=((I+J) div 2);
         TempResult:=SortCompare(FObjects[Result],Value);
         case TempResult of
            CMP_LESS:
               I:=(Result+1);
            CMP_GREATER:
               J:=(Result-1);
            CMP_EQUAL:
               Break;
            end;
         end;
      if (TempResult <> CMP_EQUAL) and (not NearestMatch) then
         Result:=-1;
      end;
end;

end.
