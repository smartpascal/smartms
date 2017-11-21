unit uPersistent;

interface

uses 
  W3C.Console,
  SmartCL.System, System.Types;

type

EPersistent = Class(EW3Exception);

IPersistent = Interface
  function  objToString:String;
  procedure objFromString(const aData:String);
  procedure objReset;
end;

TPersistent = Class(TObject,IPersistent)
private
  (* Implements:: IPersistent *)
  function  objToString:String;
  Procedure objFromString(const aData:String);
  procedure objReset;
protected
  Procedure AssignTo(const aTarget:TPersistent);virtual;
public
  Procedure Assign(const aSource:TPersistent);virtual;
End;

TNamedValuePair = Record
  PropertyFieldName:   String;
  PropertyFieldValue:  Variant;
  GetterFieldValue: Variant;
End;
TNamedValuePairArray = Array of TNamedValuePair;

TPersistentHelper = Class helper for TPersistent
public
  class function  getRTTIProperties(var aPairs:TNamedValuePairArray):Integer;
  class procedure setRTTIProperties(const aPairs:TNamedValuePairArray);
end;

implementation

resourcestring
CNT_ERR_TPERSISTENT_READ  = 'Persistent read error [%s]';
CNT_ERR_TPERSISTENT_WRITE = 'Persistent write error [%s]';

//#############################################################################
// TPersistentHelper
//#############################################################################

class procedure TPersistentHelper.setRTTIProperties
      (const aPairs:TNamedValuePairArray);
var
  mRTTI:  Array of TRTTIRawAttribute;
  mAttrib:  TRTTIRawAttribute;
  mTypeId:  TRTTITypeInfo;
  x,y:  Integer;
Begin
  if aPairs.length>0 then
  begin
    for y:=aPairs.low to aPairs.high do
    Begin
      mTypeId:=TypeOf(self.classtype);
      mRTTI:=RTTIRawAttributes;
      if mRtti.length>0 then
      Begin
        for x:=mRtti.low to mRtti.high do
        begin
          mAttrib:=mRtti[x];
          //if  (mAttrib.T = mTypeId) and (mAttrib.A is RTTIPropertyAttribute) then
          if  (variant(mAttrib).T.ID = variant(mTypeId).ID) and (mAttrib.A is RTTIPropertyAttribute) then
          begin
            var prop := RTTIPropertyAttribute(mAttrib.A);
            if prop.name = aPairs[y].PropertyFieldName then
            prop.setter(variant(self),aPairs[y].PropertyFieldValue);
            //prop.setter(variant(self),aPairs[y].PropertyFieldValue);
            //prop.setter(variant(self),aPairs[y].PropertyFieldValue);
          end;
        end;
      end;
    end;
  end;
end;

class function TPersistentHelper.getRTTIProperties
         (var aPairs:TNamedValuePairArray):Integer;
var
  mRTTI:  Array of TRTTIRawAttribute;
  mAttrib:  TRTTIRawAttribute;
  mTypeId:  TRTTITypeInfo;
  x:  Integer;
  mPair: TNamedValuePair;
Begin
  aPairs.clear;
  result:=-1;

  mTypeId:=TypeOf(self.classtype);

  mRTTI:=RTTIRawAttributes;
  if mRtti.Length>0 then
  begin
    for x:=mRtti.Low to mRtti.High do
    begin
      mAttrib:=mRtti[x];
      //if  (mAttrib.T = mTypeId) and (mAttrib.A is RTTIPropertyAttribute) then
      if  (variant(mAttrib).T.ID = variant(mTypeId).ID) and (mAttrib.A is RTTIPropertyAttribute) then
      begin
        var prop := RTTIPropertyAttribute(mAttrib.A);
        mPair.PropertyFieldName:=prop.name;
        mPair.PropertyFieldValue:=prop.Typ.Name; //Prop.Getter(Variant(self));
        mPair.GetterFieldValue :=prop.Getter(Variant(Self));
        aPairs.add(mPair);
      end;
    end;
    result:=aPairs.length;
  end;
end;

//#############################################################################
// TPersistent
//#############################################################################

procedure TPersistent.objReset;
var
  mData:  TNamedValuePairArray;
  x:  Integer;
Begin
  if getRTTIProperties(mData)>0 then
  begin
    for x:=mData.low to mData.high do
    mData[x].PropertyFieldValue:=undefined;
    setRTTIProperties(mData);
  end;
end;

function TPersistent.objToString:String;
var
  mData:  TNamedValuePairArray;
  mCount: Integer;
  x:  Integer;
Begin
  mCount:=getRTTIProperties(mData);
  if mCount>0 then
  begin
    try
      asm
        @Result = JSON.stringify(@mData);
        console.log(@mData);
      end;

    finally
      mData.clear;
    end;
  end
end;

Procedure TPersistent.objFromString(const aData:String);
var
  mData:  TNamedValuePairArray;
Begin
  if length(aData)>0 then
  Begin
    asm
      @mData = JSON.parse(@aData);
      console.log(@aData);
    end;

    if mData.length>0 then
    Begin
      setRTTIProperties(mData);
      mData.clear;
    end;
  end else
  objReset;
end;

Procedure TPersistent.Assign(const aSource:TPersistent);
Begin
  if aSource<>NIL then
  Begin
    try
      objFromString(aSource.objToString);
    except
      on e: exception do
      Raise EPersistent.CreateFmt(CNT_ERR_TPERSISTENT_READ,[e.message]);
    end;
  end;
end;

procedure TPersistent.AssignTo(const aTarget: TPersistent);
begin
  if aTarget<>NIL then
  begin
    try
      aTarget.objFromString(objToString);
    except
      on e: exception do
      Raise EPersistent.CreateFmt(CNT_ERR_TPERSISTENT_WRITE,[e.message]);
    end;
  end;
end;

end.