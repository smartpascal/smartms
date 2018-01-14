unit uWebCore;
{*************************************************************************
*
*      Elevate Web Builder Core Unit
*
*      Copyright 2011-2015  Elevate Software, Inc.
*      All rights reserved.
*
*************************************************************************}
interface

uses
  System.Types, W3C.Console, W3C.HTML5, W3C.DOM, W3C.CSS;

type
  { +-------------------------------------------------------------------+
    ¦ DO NOT MODIFY THESE DECLARATIONS, THEY ARE SYSTEM DECLARATIONS    ¦
    ¦ REQUIRED BY THE COMPILER !!!!!!                                   ¦
    +-------------------------------------------------------------------+ }
  /* TClass = class of TObject; */
  TObjectList = class;
  TPersistent = class;
  TComponent = class;
  TCollection = class;
  TCollectionItem = class;
  TDataValues = class;

  { +-------------------------------------------------------------------+
    ¦ Only used for method assignment during loading with variants, not ¦
    ¦ REQUIRED BY THE COMPILER !!!!!!                                   ¦
    +-------------------------------------------------------------------+ }

  { +---------------------------------------------------+
    ¦ accurate for casting methods that return a result ¦
    +---------------------------------------------------+ }
  TMethod = procedure of object;
  DateTime = Integer; //????

type
  TObject_ = class external 'TObject'
  public
    constructor Create; //virtual;
    destructor Destroy; //virtual;
    class procedure Free;
    class function ClassType: TClass;
    class function ClassName: string;
    class function ClassParent: TClass;
    class function PropertyCount: Integer;
    class function PropertyName(AIndex: Integer): string;
    class function PropertyType(const AName: string): Integer;
    class function GetProperty(const AName: string): Variant;
    class procedure SetProperty(const AName: string; Value: Variant);
    class function GetMethod(const AName: string): Variant;
    class procedure SetInstance(const AName: string; Value: TObject;
      ARoot: Boolean = False);
  end;

const
  { +----------------------------------------------------------+
    ¦ Run-time type information constants - DO NOT MODIFY !!!  ¦
    +----------------------------------------------------------+ }
  TYPE_INFO_UNKNOWN = 0;
  TYPE_INFO_BOOLEAN = 1;
  TYPE_INFO_CHAR = 2;
  TYPE_INFO_CLASS = 3;
  TYPE_INFO_CLASSREF = 4;
  TYPE_INFO_DATETIME = 5;
  TYPE_INFO_DOUBLE = 6;
  TYPE_INFO_ENUM = 7;
  TYPE_INFO_INTEGER = 8;
  TYPE_INFO_METHOD = 9;
  TYPE_INFO_STRING = 10;

  TYPE_PROPTYPE_VARIABLE = 0;
  TYPE_PROPTYPE_METHOD = 1;

  { +-----------------------------------------+
    ¦ Persistent loading JSON property names  ¦
    +-----------------------------------------+ }
  PERSISTENT_LOAD_CLASSNAME = 'ClassName';
  PERSISTENT_LOAD_NAME = 'Name';
  PERSISTENT_LOAD_PROPERTIES = 'Properties';
  PERSISTENT_LOAD_COMPONENTS = 'Components';
  PERSISTENT_LOAD_COUNT = 'Count';
  PERSISTENT_LOAD_ITEMS = 'Items';
  PERSISTENT_LOAD_STRINGS = 'Strings';

  { +-----------------------------------------+
    ¦ Parsed tokens                           ¦
    +-----------------------------------------+ }
  tkTerm = #0;
  tkSymbol = #1;
  tkString = #2;
  tkInteger = #3;
  tkFloat = #4;

  { +-----------------------------------------+
    ¦ Component message codes                 ¦
    +-----------------------------------------+ }
  cmInsertComp = 1;
  cmCompNameChanged = 2;
  cmRemoveComp = 3;

  cmUser = 1000;

  { +-----------------------------------------+
    ¦ Character constants                     ¦
    +-----------------------------------------+ }
  LF = #10;
  CR = #13;
  CRLF = #13 + #10;
  SPACE = #32;
  EQ = '=';
  TAB = #9;
  BACKSPACE = #8;
  DOUBLE_QUOTE = #34;
  SINGLE_QUOTE = #39;
  SLASH = '/';
  BACKSLASH = '\';
  COLON = ':';
  AMPERSAND = '&';
  QUESTION = '?';
  LEFT_PAREN = '(';
  RIGHT_PAREN = ')';
  LEFT_BRACKET = '[';
  RIGHT_BRACKET = ']';
  LEFT_BRACE = '{';
  RIGHT_BRACE = '}';
  LEFT_ARROW = '<';
  RIGHT_ARROW = '>';
  SEMICOLON = ';';
  COMMA = ',';
  EXP_LOWER = 'e';
  EXP_UPPER = 'E';
  PERIOD = '.';
  MINUS = '-';

  HEX_PREFIX = '0x';
  NULL_VALUE = 'null';

  BOOL_TRUE = 'True';
  BOOL_FALSE = 'False';
  JSON_UNICODE = 'u';
  JSON_BACKSPACE = 'b';
  JSON_TAB = 't';
  JSON_CR = 'r';
  JSON_LF = 'f';
  JSON_CRLF = 'n';

  HTML_LT = 'lt';
  HTML_GT = 'gt';
  HTML_AMP = 'amp';
  HTML_QUOT = 'quot';
  HTML_APOS = 'apos';
  ESCAPE_UNICODE = 'u';

  { +-----------------------------------------+
    ¦ Integer constants                       ¦
    +-----------------------------------------+ }
  LOW_INT = -2147483648;
  HIGH_INT = 2147483647;

  LOW_UINT = 0;
  HIGH_UINT = 4294967295;

  { +-----------------------------------------+
    ¦ Comparison results (for finding/sorting ¦
    +-----------------------------------------+ }
  CMP_LESS = -1;
  CMP_EQUAL = 0;
  CMP_GREATER = 1;

  { +-----------------------------------------+
    ¦ Bitmap constants                        ¦
    +-----------------------------------------+ }
  BITS_PER_WORD = 32;

  { +-----------------------------------------+
    ¦ Formatting constants                    ¦
    +-----------------------------------------+ }
  MONTHS_PER_YEAR = 12;
  DAYS_PER_WEEK = 7;

  HOURS_PER_DAY = 24;
  MINS_PER_HOUR = 60;
  SECS_PER_MINUTE = 60;
  MSECS_PER_SECOND = 1000;

  AMPM_HOURS = 12;

  YEAR_FORMAT_CHAR = 'y';
  MONTH_FORMAT_CHAR = 'M';
  DAY_FORMAT_CHAR = 'd';

  FULL_YEAR_FORMAT = 'yyyy';
  PART_YEAR_FORMAT = 'yy';
  FULL_MONTH_FORMAT = 'MM';
  PART_MONTH_FORMAT = 'M';
  FULL_DAY_FORMAT = 'dd';
  PART_DAY_FORMAT = 'd';

  HOUR12_FORMAT_CHAR = 'h';
  HOUR24_FORMAT_CHAR = 'H';
  MIN_FORMAT_CHAR = 'm';
  SEC_FORMAT_CHAR = 's';
  AMPM_FORMAT_CHAR = 't';

  FULL_HOUR12_FORMAT = 'hh';
  PART_HOUR12_FORMAT = 'h';
  FULL_HOUR24_FORMAT = 'HH';
  PART_HOUR24_FORMAT = 'H';
  FULL_MIN_FORMAT = 'mm';
  PART_MIN_FORMAT = 'm';
  FULL_SEC_FORMAT = 'ss';
  PART_SEC_FORMAT = 's';
  FULL_AMPM_FORMAT = 'tt';

function CreateArray: variant; external '[]' property;

type
  { +--------------------------------------------+
    ¦ TParser                                    ¦
    +--------------------------------------------+ }
  TParser = class
  private
    FText: string;
    FTextLength: Integer;
    FPos: Integer;
    FLastPos: Integer;
    FStart: Integer;
    FEnd: Integer;
    FEscaped: Boolean;
    FToken: Char;
    FTokenString: string;
    FFullNumbers: Boolean;
    FPropertyNameType: Char;
    procedure IncPos;
    procedure SkipBlanks;
    function GetTokenPortion(EndPos: Integer): string;
    function GetTokenLiteral: string;
    procedure ParseString;
    procedure ParseDigits;
    function ParseChar(Value: Char): Boolean;
    procedure ParseNumber;
    procedure ParseAlphaChars;
    procedure ParseSymbol;
  public
    property PropertyNameType: Char read FPropertyNameType;
    property Token: Char read FToken;
    property TokenString: string read FTokenString;
    property TokenLiteral: string read GetTokenLiteral;
    procedure Initialize(const TextToParse: string;
      FullNumbers: Boolean = True;
      APropertyNameType: Char = tkString);
    procedure NextToken;
    function CheckToken(Value: Char): Boolean;
    function CheckString(const Value: string): Boolean;
    function CheckSymbol(const Value: string): Boolean;
    procedure ExpectedError(const Value: string);
    procedure ErrorIfNotToken(Value: Char);
    procedure ErrorIfNotString(const Value: string);
    procedure ErrorIfNotSymbol(const Value: string);
    function SkipToken(Value: Char): Boolean;
    function SkipString(const Value: string): Boolean;
    function SkipSymbol(const Value: string): Boolean;
    procedure ErrorIfNotSkipToken(Value: Char);
    procedure ErrorIfNotSkipString(const Value: string);
    procedure ErrorIfNotSkipSymbol(const Value: string);
    function SkipObject: Boolean;
    function SkipArray: Boolean;
    procedure SkipProperty;
    procedure SkipPropertyValue;
    function GetString: string;
    function GetInteger: Integer;
    function GetBoolean: Boolean;
    function GetFloat: Double;
  end;

  TCharArray = array of Char;

  TStringBuilder = class
  private
    FMemory: TCharArray;
    FLength: Integer;
    procedure SetLength(Value: Integer);
    function GetChar(Index: Integer): Char;
    procedure SetChar(Index: Integer; Value: Char);
  public
    constructor Create(const Value: string); virtual;
    property Length: Integer read FLength write SetLength;
    property Chars[Index: Integer]: Char read GetChar write SetChar; default;
    function GetString(Index: Integer; Count: Integer): string;
    procedure Append(const Value: variant); overload;
    procedure Append(Value: Char); overload;
    procedure Insert(Position: Integer; Value: Char); overload;
    procedure Insert(Position: Integer; const Value: variant); overload;
    procedure Remove(Position: Integer; Count: Integer);
    function ToString: string;
  end;

  TDateTimeFormat = (dtfRaw, dtfISO8601);

  TWriterState = class(TObject)
  private
    FPropertyCount: Integer;
    FIndent: Integer;
  public
    constructor Create(APropertyCount: Integer;
      AIndent: Integer); virtual;
    property PropertyCount: Integer read FPropertyCount;
    property Indent: Integer read FIndent;
  end;

  TWriter = class
  private
    FOutput: string;
    FDateTimeFormat: TDateTimeFormat = dtfRaw;
    FIndentSpaces: Integer = 3;
    FLineFeeds: Boolean;
    FCompressed: Boolean;
    FPropertyCount: Integer;
    FIndent: Integer;
    FNewLine: Boolean;
    FStack: TObjectList;
    procedure Append(const Value: string);
  public
    constructor Create(ADateTimeFormat: TDateTimeFormat = dtfRaw;
      AIndentSpaces: Integer = 3;
      AIncludeLineFeeds: Boolean = True;
      ACompressWhitespace: Boolean = False); virtual;
    destructor Destroy; override;
    property Output: string read FOutput;
    procedure Initialize;
    procedure Whitespace;
    procedure Separator;
    procedure IncIndent;
    procedure DecIndent;
    procedure NewLine;
    procedure BeginNewLine;
    procedure CancelNewLine;
    procedure Literal(const Value: string);
    procedure BeginObject;
    procedure EndObject;
    procedure PropertyName(const Name: string);
    procedure NullProperty(const Name: string);
    procedure NullValue;
    procedure ObjectProperty(const Name: string);
    procedure StringProperty(const Name: string;
      const Value: string);
    procedure StringValue(const Value: string);
    procedure DateTimeProperty(const Name: string;
      Value: DateTime);
    procedure DateTimeValue(Value: DateTime);
    procedure IntegerProperty(const Name: string;
      Value: Integer);
    procedure IntegerValue(Value: Integer);
    procedure BooleanProperty(const Name: string;
      Value: Boolean);
    procedure BooleanValue(Value: Boolean);
    procedure FloatProperty(const Name: string;
      Value: Double);
    procedure FloatValue(Value: Double);
    procedure BeginArray(HasElements: Boolean);
    procedure EndArray(HasElements: Boolean);
  end;

  TFixup = class
  private
    FRootComponent: TComponent;
    FInstance: TPersistent;
    FPropertyName: string;
    FComponentName: string;
  public
    constructor Create(ARootComponent: TComponent;
      AInstance: TPersistent;
      APropertyName: string;
      AComponentName: string); virtual;
    property RootComponent: TComponent read FRootComponent;
    property Instance: TPersistent read FInstance;
    property PropertyName: string read FPropertyName;
    property ComponentName: string read FComponentName;
  end;

  TFixups = class
  private
    FList: TObjectList;
    function GetCount: Integer;
    function GetFixup(Index: Integer): TFixup;
  public
    constructor Create; virtual; //override;
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property Fixup[Index: Integer]: TFixup read GetFixup; default;
    procedure Add(ARootComponent: TComponent;
      AInstance: TPersistent;
      const APropertyName: string;
      const AComponentName: string);
  end;

  TReader = class
  private
    FParser: TParser;
    FDateTimeFormat: TDateTimeFormat = dtfRaw;
    FCompressedProperties: Boolean;
    FRootComponent: TComponent;
    FGlobalComponent: TComponent;
    FLevel: Integer;
    FFixups: TFixups;
  protected
    procedure AddFixup(AInstance: TPersistent;
      const APropertyName: string;
      const AComponentName: string); virtual;
    procedure ApplyFixups; virtual;
  public
    constructor Create(ADateTimeFormat: TDateTimeFormat = dtfRaw); virtual;
    destructor Destroy; override;
    property RootComponent: TComponent read FRootComponent
      write FRootComponent;
    property GlobalComponent: TComponent read FGlobalComponent
      write FGlobalComponent;
    property Level: Integer read FLevel;
    procedure Initialize(const Value: string;
      ACompressedProperties: Boolean = False); virtual;
    function IsObject: Boolean;
    procedure BeginObject;
    function GetPropertyName: string;
    procedure SkipPropertyName;
    procedure SkipPropertySeparator;
    procedure SkipProperty;
    procedure SkipPropertyValue;
    function IsNull: Boolean;
    function IsString: Boolean;
    function IsBoolean: Boolean;
    function ReadString: string;
    function ReadDateTime: DateTime;
    function ReadInteger: Integer;
    function ReadBoolean: Boolean;
    function ReadFloat: Double;
    function MoreProperties: Boolean;
    function EndOfObject: Boolean;
    procedure EndObject;
    function IsArray: Boolean;
    procedure BeginArray;
    function MoreArrayElements: Boolean;
    function EndOfArray: Boolean;
    procedure EndArray;
    procedure SkipArrayElement;
  end;

  TPersistent = class
  private
    FLoading: Boolean;
  protected
    property Loading: Boolean read FLoading;
    procedure BeforeLoad; virtual;
    procedure AfterLoad; virtual;
    procedure LoadError(E: Exception); virtual;
    function LoadProperty(AReader: TReader): Boolean; virtual;
    procedure LoadProperties(AReader: TReader); virtual;
    procedure LoadObject(AReader: TReader); virtual;
    function LoadArrayElement(AReader: TReader): Boolean; virtual;
    procedure LoadArrayElements(AReader: TReader); virtual;
    procedure LoadArray(AReader: TReader); virtual;
    procedure BeforeSave; virtual;
    procedure AfterSave; virtual;
    procedure SaveError(E: Exception); virtual;
    procedure SaveProperty(AWriter: TWriter; const AName: string); virtual;
    procedure SaveProperties(AWriter: TWriter); virtual;
    procedure SaveArrayElement(AWriter: TWriter); virtual;
    procedure SaveArrayElements(AWriter: TWriter); virtual;
    procedure Load(AReader: TReader); virtual;
    procedure Save(AWriter: TWriter); virtual;
    procedure Assign(APersistent: TPersistent); virtual;

    function PropertyCount: Integer;
    function PropertyName(AIndex: Integer): string;
    procedure SetProperty(const AName: string; Value: Variant);
    function PropertyType(const AName: string): Integer;
    function GetProperty(const AName: string): TObject; overload;
    function GetProperty(const AName: Boolean): Boolean; overload;
    function GetMethod(const AName: string): Variant;
    procedure SetInstance(const AName: string; Value: TObject;
      ARoot: Boolean = False);
  public

  end;

  TNotifyEvent = procedure(Sender: TObject) of object;

  TComponentName = string;

  TComponent = class(TPersistent)
  private
    FOwner: TComponent;
    FName: TComponentName;
    FData: TObject;
    FTag: Integer;
    FInitializing: Boolean;
    FDestroying: Boolean;
    FComponents: TObjectList;
    FNotifications: TObjectList;
    FNotifying: Boolean;
    FRegistering: Boolean;
    FUnRegistering: Boolean;
    procedure SetDestroying;
    function GetIsInitializing: Boolean;
    function GetIsLoading: Boolean;
    procedure SetName(const Value: TComponentName);
  protected
    property Initializing: Boolean read FInitializing;
    property IsInitializing: Boolean read GetIsInitializing;
    property IsLoading: Boolean read GetIsLoading;
    procedure CheckOwnerClass(AOwnerClass: TClass);
    procedure Initialize;
    procedure InitializeProperties; virtual;
    procedure BeforeInitialize; virtual;
    procedure AfterInitialize; virtual;
    procedure NameChanged; virtual;
    procedure AddComponent(Component: TComponent);
    procedure RemoveComponent(Component: TComponent);
    function GetComponentCount: Integer;
    function GetComponent(Value: Integer): TComponent;
    function Notification(Sender: TComponent; ID: Integer; Data: TObject):
      Boolean; virtual;
    procedure Notify(ID: Integer; Data: TObject = nil); virtual;
    function LoadProperty(AReader: TReader): Boolean; override;
  public
    constructor Create(AOwner: TComponent); virtual;
    destructor Destroy; override;
    property ComponentCount: Integer read GetComponentCount;
    property Component[Index: Integer]: TComponent read GetComponent;
    property Data: TObject read FData write FData;
    property Destroying: Boolean read FDestroying;
    property Owner: TComponent read FOwner;
    property Tag: Integer read FTag write FTag default 0;
    //description 'Specifies an integer value to associate with the component';
    procedure &Register(Component: TComponent);
    procedure UnRegister(Component: TComponent);
    function FindComponent(const Value: string; Recurse: Boolean = False):
      TComponent;
  published
    property Name: TComponentName read FName write SetName;
    //description 'Specifies the name of the component';
  end;

  TComponentClass = class of TComponent;

  TAbstractList = class(TPersistent)
  private
    FUpdateCount: Integer;
    FUpdated: Boolean;
    FOnChanged: TNotifyEvent;
  protected
    property UpdateCount: Integer read FUpdateCount;
    procedure HandleChanges; virtual;
    procedure DoChanged; virtual;
    procedure Load(AReader: TReader); override;
  public
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    procedure BeginUpdate;
    procedure EndUpdate;
  end;

  TObjectsArray = array of TObject;

  TObjectSortCompare = function(L, R: TObject): Integer of object;

  TObjectList = class(TAbstractList)
  private
    FselectedIndex: Integer;
    FDestroying: Boolean;
    FOwnsObjects: Boolean = True;
    FCount: Integer;
    FObjects: TObjectsArray;
    FSorted: Boolean;
    procedure FreeObjects;
    function AddObject(NewObject: TObject): Integer;
    procedure InsertObject(InsertPos: Integer; NewObject: TObject);
    procedure DeleteObject(DeletePos: Integer; FreeOwnedObject: Boolean = True);
    procedure SetSorted(Value: Boolean);
    procedure SortObjects(L, R: Integer);
  protected
    procedure HandleChanges; override;
    procedure CheckIndex(Index: Integer);
    procedure SetCount(Value: Integer);
    function GetObject(Index: Integer): TObject; virtual;
    procedure SetObject(Index: Integer; AObject: TObject); virtual;
    function SortCompare(L, R: TObject): Integer; overload; virtual;
    function SortCompare(L: TObject; const R: string): Integer; overload;
      virtual;
  public
    constructor Create; overload; virtual; //override;
    constructor Create(AOwnsObjects: Boolean); overload;
    destructor Destroy; override;
    property selectedIndex: Integer read FselectedIndex write FselectedIndex;
    property OwnsObjects: Boolean read FOwnsObjects;
    property Count: Integer read FCount write SetCount;
    property Objects[Index: Integer]: TObject read GetObject write SetObject;
      default;
    property Sorted: Boolean read FSorted write SetSorted;
    procedure Clear;
    function Add(AObject: TObject): Integer;
    procedure Delete(Index: Integer; FreeOwnedObject: Boolean = True);
    function Remove(AObject: TObject; FreeOwnedObject: Boolean = True): Integer;
    procedure Sort;
    function Find(const Value: string; NearestMatch: Boolean = False): Integer;
    function IndexOf(AObject: TObject): Integer;
    procedure Insert(Index: Integer; AObject: TObject);
    function First: TObject;
    function Prior(AObject: TObject; Wrap: Boolean = False): TObject;
    function Next(AObject: TObject; Wrap: Boolean = False): TObject;
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

  TCollectionItemName = string;

  TCollectionItem = class(TPersistent)
  private
    FCollection: TCollection;
    FID: Integer;
    FName: TCollectionItemName;
    FIndex: Integer;
    procedure SetName(const Value: TCollectionItemName);
    procedure SetIndex(Value: Integer);
  protected
    procedure InvalidCollectionError; virtual;
    procedure Initialize; virtual;
    procedure ValidateName(const Value: TCollectionItemName); virtual;
    procedure UpdateID(Value: Integer);
    procedure UpdateName(const Value: TCollectionItemName);
    procedure UpdateIndex(Value: Integer);
  public
    constructor Create(ACollection: TCollection); virtual;
    property Collection: TCollection read FCollection;
    property ID: Integer read FID;
    property Name: TCollectionItemName read FName write SetName;
    property Index: Integer read FIndex write SetIndex;
  end;

  TCollectionItemClass = class of TCollectionItem;

  TCollection = class(TPersistent)
  private
    FItemClass: TCollectionItemClass;
    FItems: TObjectList;
    FNextID: Integer = 1;
    FOnChanged: TNotifyEvent;
    function GetCount: Integer;
    function GetItem(AIndex: Integer): TCollectionItem; overload;
    function GetItem_(const AName: string): TCollectionItem; overload;
    function GetUpdateCount: Integer;
    procedure UpdateIndexes;
  protected
    property UpdateCount: Integer read GetUpdateCount;
    procedure BeforeLoad; override;
    function LoadProperty(AReader: TReader): Boolean; override;
    function LoadArrayElement(AReader: TReader): Boolean; override;
    procedure Save(AWriter: TWriter); override;
    procedure ItemsChanged(Sender: TObject);
    function CreateItem: TCollectionItem; virtual;
    procedure DoChanging; virtual;
    procedure DoChanged; virtual;
  public
    constructor Create(AItemClass: TCollectionItemClass);
    destructor Destroy; override;
    property Count: Integer read GetCount;
    property ItemClass: TCollectionItemClass read FItemClass;
    property Items[AIndex: Integer]: TCollectionItem read GetItem;
    property Items_[const AName: string]: TCollectionItem read GetItem_; 
    property OnChanged: TNotifyEvent read FOnChanged write FOnChanged;
    procedure BeginUpdate; virtual;
    procedure EndUpdate; virtual;
    function FindItemByID(AID: Integer): TCollectionItem;
    function IndexOf(AItem: TCollectionItem): Integer; overload;
    function IndexOf(const AName: string): Integer; overload;
    procedure Clear; virtual;
    function Add: TCollectionItem;
    function Insert(AIndex: Integer): TCollectionItem;
    procedure Delete(AIndex: Integer);
    procedure Move(Source: Integer; Dest: Integer);
    function GetNames: array of string;
  end;

  TStringsArray = array of string;

  TStrings = class(TAbstractList)
  private
    FNameValueSeparator: Char = EQ;
    FLineSeparator: string = CRLF;
    function GetName(Index: Integer): string;
    function GetValue(const Name: string): string;
    procedure SetValue(const Name, Value: string);
    function GetValueFromIndex(Index: Integer): string;
    procedure SetValueFromIndex(Index: Integer; const Value: string);
  protected
    procedure BeforeLoad; override;
    function LoadProperty(AReader: TReader): Boolean; override;
    function LoadArrayElement(AReader: TReader): Boolean; override;
    procedure Save(AWriter: TWriter); override;
    procedure CheckIndex(Index: Integer);
    function GetCount: Integer; virtual; abstract;
    procedure SetCount(Value: Integer); virtual; abstract;
    function AddString(const Value: string): Integer; virtual; abstract;
    procedure InsertString(Index: Integer; const Value: string); virtual;
      abstract;
    procedure DeleteString(Index: Integer); virtual; abstract;
    procedure DeleteAllStrings; virtual; abstract;
    function GetString(Index: Integer): string; virtual; abstract;
    procedure SetString(Index: Integer; const Value: string); virtual;
    function GetText: string; virtual;
    procedure SetText(const Value: string); virtual;
    function ExtractName(const Value: string): string;
    function ExtractValue(const Value: string): string;
  public
    property Count: Integer read GetCount write SetCount;
    property Strings[Index: Integer]: string read GetString write SetString;
    default;
    property LineSeparator: string read FLineSeparator write FLineSeparator;
    property NameValueSeparator: Char read FNameValueSeparator write
      FNameValueSeparator;
    property Names[Index: Integer]: string read GetName;
    property Values[const Name: string]: string read GetValue write SetValue;
    property ValueFromIndex[Index: Integer]: string read GetValueFromIndex write
    SetValueFromIndex;
    property Text: string read GetText write SetText;
    procedure Assign(Value: TStrings); reintroduce;
    function Add(const Value: string): Integer;
    procedure Clear;
    function IndexOf(const Value: string; StartIndex: Integer = 0;
      PartialMatch: Boolean = False): Integer;
    function IndexOfName(const Name: string; StartIndex: Integer = 0;
      PartialMatch: Boolean = False): Integer;
    function IndexOfValue(const Value: string): Integer;
    procedure Insert(Index: Integer; const Value: string);
    procedure Delete(Index: Integer);
    function Remove(const Value: string): Integer;
  end;

  TStringList = class(TStrings)
  private
    FCount: Integer;
    FStrings: array of Variant; //TStringsArray; --> buggy warleyalex
    FSorted: Boolean;
    FSortCaseInsensitive: Boolean;
    FSortLocaleInsensitive: Boolean;
    procedure SetSorted(Value: Boolean);
    procedure SetSortCaseInsensitive(Value: Boolean);
    procedure SetSortLocaleInsensitive(Value: Boolean);
    function SortCompare(const L, R: string): Integer;
    procedure SortStrings(L, R: Integer);
  protected
    procedure HandleChanges; override;
    function GetCount: Integer; override;
    procedure SetCount(Value: Integer); override;
    function AddString(const Value: string): Integer; override;
    procedure InsertString(Index: Integer; const Value: string); override;
    procedure DeleteString(Index: Integer); override;
    procedure DeleteAllStrings; override;
    function GetString(Index: Integer): string; override;
    procedure SetString(Index: Integer; const Value: string); override;
    function GetText: string; override;
    procedure SetText(const Value: string); override;
  public
    property Sorted: Boolean read FSorted write SetSorted;
    property SortCaseInsensitive: Boolean read FSortCaseInsensitive
      write SetSortCaseInsensitive;
    property SortLocaleInsensitive: Boolean read FSortLocaleInsensitive
      write SetSortLocaleInsensitive;
    procedure Sort;
    function Find(const Value: string; NearestMatch: Boolean = False): Integer;
  end;

  TIntegerArray = array of Integer;
  TBooleanArray = array of Boolean;

  TSet = class
  private
    FLength: Integer;
    FValues: TBooleanArray;
    function GetCount: Integer;
    procedure SetLength(Value: Integer);
  protected
    //property Length: Integer read FLength;
    //property Values: TBooleanArray read FValues;
    procedure RangeError(Value: Integer);
    function GetMax: Integer;
  public
    //constructor Create(const AValues: TIntegerArray); virtual;
    constructor Create(AValues: TIntegerArray = []); virtual;
    destructor Destroy; override;
    function IsEmpty: Boolean;
    procedure Initialize(const AValues: TIntegerArray);
    function Add(Value: Integer): Boolean;
    function Remove(Value: Integer): Boolean;
    function Exists(Value: Integer): Boolean;
    procedure Assign(Value: TSet);
    procedure All(ACount: Integer);
    procedure Range(AStart, AEnd: Integer);
    procedure Union(Value: TSet);
    procedure &except(Value: TSet);
    procedure Intersect(Value: TSet);
    procedure Empty;
    function Copy: TSet;
    property Count: Integer read GetCount;
    property Max: Integer read GetMax;

  published
    property Length: Integer read FLength;
    property Values: TBooleanArray read FValues;

  end;

  TDataType = (dtUnknown, dtString, dtBoolean, dtInteger, dtFloat, dtDate,
    dtTime, dtDateTime, dtBlob);

  TDataValue = class
  private
    FValues: TDataValues;
    FIndex: Integer = -1;
    FNull: Boolean = True;
    FModified: Boolean;
  protected
    procedure CheckNotReadOnly;
    function GetName: string; virtual;
    function GetDataType: TDataType; virtual;
    function GetLength: Integer {TDataType}; virtual;
    function GetScale: Integer {TDataType}; virtual;
    function GetDateTimeFormat: TDateTimeFormat; virtual;
    function GetLocalizeDateTime: Boolean; virtual;
    function GetReadOnly: Boolean; virtual;
    procedure AssignValue(NewValue: TDataValue); virtual; abstract;
    procedure SetModified; virtual;
    procedure ResetModified; virtual;
    procedure Initialize; virtual;
    procedure NotifyChange; virtual;
    procedure SetValue; virtual;
    procedure ClearValue; virtual; abstract;
    function GetAsString: string; virtual; abstract;
    procedure SetAsString(const Value: string); virtual; abstract;
    function GetAsInteger: Integer; virtual; abstract;
    procedure SetAsInteger(Value: Integer); virtual; abstract;
    function GetAsBoolean: Boolean; virtual; abstract;
    procedure SetAsBoolean(Value: Boolean); virtual; abstract;
    function GetAsFloat: Double; virtual; abstract;
    procedure SetAsFloat(Value: Double); virtual; abstract;
    function GetAsDate: DateTime; virtual;
    procedure SetAsDate(Value: DateTime); virtual;
    function GetAsTime: DateTime; virtual;
    procedure SetAsTime(Value: DateTime); virtual;
    function GetAsDateTime: DateTime; virtual; abstract;
    procedure SetAsDateTime(Value: DateTime); virtual; abstract;

    property Values: TDataValues read FValues;
    property &Index: Integer read FIndex;
    property Name: string read GetName;
    property DataType: TDataType read GetDataType;
    property Length: Integer read GetLength;
    property Scale: Integer read GetScale;
    property DateTimeFormat: TDateTimeFormat read GetDateTimeFormat;
    property LocalizeDateTime: Boolean read GetLocalizeDateTime;
    property ReadOnly: Boolean read GetReadOnly;
  public
    constructor Create(AValues: TDataValues = nil;
      AIndex: Integer = -1); virtual;
    property Null: Boolean read FNull;
    property AsString: string read GetAsString write SetAsString;
    property AsBoolean: Boolean read GetAsBoolean write SetAsBoolean;
    property AsInteger: Integer read GetAsInteger write SetAsInteger;
    property AsFloat: Double read GetAsFloat write SetAsFloat;
    property AsDate: DateTime read GetAsDate write SetAsDate;
    property AsTime: DateTime read GetAsTime write SetAsTime;
    property AsDateTime: DateTime read GetAsDateTime write SetAsDateTime;
    property Modified: Boolean read FModified;
    procedure Assign(Value: TDataValue);
    procedure Clear;
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; virtual;
    function GetJSON: string;
  end;

  TStringValue = class(TDataValue)
  private
    FValue: string;
  protected
    procedure AssignValue(NewValue: TDataValue); override;
    procedure ClearValue; override;
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
    function GetAsBoolean: Boolean; override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsDate: DateTime; override;
    procedure SetAsDate(Value: DateTime); override;
    function GetAsTime: DateTime; override;
    procedure SetAsTime(Value: DateTime); override;
    function GetAsDateTime: DateTime; override;
    procedure SetAsDateTime(Value: DateTime); override;
  public
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; override;
  end;

  TBooleanValue = class(TDataValue)
  private
    FValue: Boolean;
  protected
    procedure AssignValue(NewValue: TDataValue); override;
    procedure ClearValue; override;
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
    function GetAsBoolean: Boolean; override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsDateTime: DateTime; override;
    procedure SetAsDateTime(Value: DateTime); override;
  public
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; override;
  end;

  TIntegerValue = class(TDataValue)
  private
    FValue: Integer;
  protected
    procedure AssignValue(NewValue: TDataValue); override;
    procedure ClearValue; override;
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
    function GetAsBoolean: Boolean; override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsDateTime: DateTime; override;
    procedure SetAsDateTime(Value: DateTime); override;
  public
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; override;
  end;

  TDateTimeValue = class(TDataValue)
  private
    FValue: DateTime;
  protected
    property Value: DateTime read FValue write FValue;
    procedure AssignValue(NewValue: TDataValue); override;
    procedure ClearValue; override;
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
    function GetAsBoolean: Boolean; override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsDateTime: DateTime; override;
    procedure SetAsDateTime(Value: DateTime); override;
  public
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; override;
  end;

  TDateValue = class(TDateTimeValue)
  protected
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
  end;

  TTimeValue = class(TDateTimeValue)
  protected
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
  end;

  TFloatValue = class(TDataValue)
  private
    FValue: Double;
  protected
    procedure AssignValue(NewValue: TDataValue); override;
    procedure ClearValue; override;
    function GetAsString: string; override;
    procedure SetAsString(const Value: string); override;
    function GetAsBoolean: Boolean; override;
    procedure SetAsBoolean(Value: Boolean); override;
    function GetAsInteger: Integer; override;
    procedure SetAsInteger(Value: Integer); override;
    function GetAsFloat: Double; override;
    procedure SetAsFloat(Value: Double); override;
    function GetAsDateTime: DateTime; override;
    procedure SetAsDateTime(Value: DateTime); override;
  public
    function Compare(Value: TDataValue;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; override;
  end;

  TBlobValue = class(TStringValue)
  end;

  TDataValues = class
  private
    FModified: Boolean;
    FID: Integer;
    FValues: TObjectList;
    FNotifyChanges: Boolean = True;
    function GetCount: Integer;
    function GetValue(Index: Integer): TDataValue;
  protected
    property NotifyChanges: Boolean read FNotifyChanges
      write FNotifyChanges;
    procedure SetID(Value: Integer); virtual;
    procedure SetCount(Value: Integer); virtual;
    function CreateValue(Index: Integer): TDataValue; virtual; abstract;
    function GetValueName(Index: Integer): string; virtual;
    function GetValueDataType(Index: Integer): TDataType; virtual;
    function GetValueLength(Index: Integer): Integer; virtual;
    function GetValueScale(Index: Integer): Integer; virtual;
    function GetValueDateTimeFormat(Index: Integer): TDateTimeFormat; virtual;
    function GetValueLocalizeDateTime(Index: Integer): Boolean; virtual;
    function GetValueReadOnly(Index: Integer): Boolean; virtual;
    procedure ValueChanged(Index: Integer); virtual;
    function NotifyModified: Boolean; virtual;
    procedure SetModified; virtual;
    procedure ResetModified; virtual;
  public
    constructor Create(AID: Integer; ACount: Integer); virtual;
    destructor Destroy; override;
    property ID: Integer read FID;
    property Modified: Boolean read FModified;
    property Count: Integer read GetCount;
    property Values[Index: Integer]: TDataValue read GetValue; default;
    procedure Assign(NewValues: TDataValues);
    procedure Initialize;
    function Compare(Value: TDataValues;
      CaseInsensitive: Boolean = False;
      LocaleInsensitive: Boolean = False): Integer; virtual;
    function GetJSON(ModifiedOnly: Boolean = False;
      IncludeID: Boolean = False;
      IDName: string = ''): string; virtual;
  end;

  TFormatSettings = class
  private
    FParser: TParser;
    FDateSeparator: Char = '/';
    FTimeSeparator: Char = ':';
    FShortDateFormat: string = 'M/d/yyyy';
    FShortDateFormatComps: TStringsArray;
    FTwoDigitYearCenturyWindow: Integer = 50;
    FShortTimeFormat: string = 'h:mm tt';
    FShortTimeFormatComps: TStringsArray;
    FTimeAMString: string = 'AM';
    FTimePMString: string = 'PM';
    FShortMonthNames: array of string;
    FLongMonthNames: array of string;
    FShortDayNames: array of string;
    FLongDayNames: array of string;
    FStartOfWeek: Integer = DAYS_PER_WEEK;
    FDecimalSeparator: Char = PERIOD;
    FTranslations: TStrings;
    procedure ComponentError(const Format: string;
      const Value: string);
    procedure ValidateShortDateComp(const Format: string;
      const Value: string);
    function GetShortDateFormatComp(Index: Integer): string;
    procedure SetShortDateFormat(const Value: string);
    procedure ValidateShortTimeComp(const Format: string;
      const Value: string);
    function GetShortTimeFormatComp(Index: Integer): string;
    procedure SetShortTimeFormat(const Value: string);
    procedure CheckMonth(Value: Integer);
    procedure CheckDay(Value: Integer);
    function GetShortMonthName(Month: Integer): string;
    procedure SetShortMonthName(Month: Integer; const Value: string);
    function GetLongMonthName(Month: Integer): string;
    procedure SetLongMonthName(Month: Integer; const Value: string);
    function GetShortDayName(Day: Integer): string;
    procedure SetShortDayName(Day: Integer; const Value: string);
    function GetLongDayName(Day: Integer): string;
    procedure SetLongDayName(Day: Integer; const Value: string);
    procedure SetStartOfWeek(Day: Integer);
    function GetDateName: string;
    function GetTimeName: string;
    procedure SetTranslations(Value: TStrings);
  protected
    procedure Error(const Format: string; const Msg: string); virtual;
    /*
      Member symbol is not visible from this scope // moved to the public scope
    procedure Initialize;
    function ParseShortDate(const Value: string;
      Format: Boolean = False): TStringsArray; virtual;
    function ParseShortTime(const Value: string;
      Format: Boolean = False): TStringsArray; virtual;
    */
      procedure SetupTranslations; virtual;
  public
    constructor Create; //override;
    destructor Destroy; override;
    procedure Initialize;
    function ParseShortDate(const Value: string;
      Format: Boolean = False): TStringsArray; virtual;

    function ParseShortTime(const Value: string;
      Format: Boolean = False): TStringsArray; virtual;

    property DateSeparator: Char read FDateSeparator write FDateSeparator;
    property TimeSeparator: Char read FTimeSeparator write FTimeSeparator;
    property ShortDateFormat: string read FShortDateFormat write
      SetShortDateFormat;
    property ShortDateFormatComp[Index: Integer]: string read
    GetShortDateFormatComp;
    property TwoDigitYearCenturyWindow: Integer read FTwoDigitYearCenturyWindow
      write FTwoDigitYearCenturyWindow;
    property ShortTimeFormat: string read FShortTimeFormat write
      SetShortTimeFormat;
    property ShortTimeFormatComp[Index: Integer]: string read
    GetShortTimeFormatComp;
    property TimeAMString: string read FTimeAMString write FTimeAMString;
    property TimePMString: string read FTimePMString write FTimePMString;
    property ShortMonthNames[Month: Integer]: string read GetShortMonthName
    write SetShortMonthName;
    property LongMonthNames[Month: Integer]: string read GetLongMonthName
    write SetLongMonthName;
    property ShortDayNames[Day: Integer]: string read GetShortDayName
    write SetShortDayName;
    property LongDayNames[Day: Integer]: string read GetLongDayName
    write SetLongDayName;
    property StartOfWeek: Integer read FStartOfWeek write SetStartOfWeek;
    property DecimalSeparator: Char read FDecimalSeparator write
      FDecimalSeparator;
    property Translations: TStrings read FTranslations write SetTranslations;
  end;

function InheritsFrom(AChildClass: TClass; AClass: TClass): Boolean; overload;
function InheritsFrom(AObject: TObject; AClass: TClass): Boolean; overload;

function Trunc(Value: Double): Integer;

function IsAlpha(Value: Char): Boolean;
function IsDigit(Value: Char): Boolean;

function IsBool(const Value: string): Boolean;
function IsInt(const Value: string): Boolean;
function IsFloat(const Value: string): Boolean;

function IsLeapYear(Value: Integer): Boolean;
function IsMonth(Value: Integer): Boolean;
function IsDay(Month: Integer; Value: Integer; LeapYear: Boolean = False):
  Boolean;
function IsHour(Value: Integer; AMPM: Boolean = False): Boolean;
function IsMinute(Value: Integer): Boolean;
function IsSecond(Value: Integer): Boolean;
function IsMSecond(Value: Integer): Boolean;

function IsDate(const Value: string): Boolean;
function IsTime(const Value: string): Boolean;
function IsDateTime(const Value: string): Boolean;

function StrToBool(const Value: string): Boolean;

function FloatToStr(Value: Double; Decimals: Integer = -1): string; overload;
function StrToFloat(const Value: string): Double;

function DateToStr(Value: DateTime; UTC: Boolean = False): string;
function StrToDate(const Value: string; UTC: Boolean = False): DateTime;

function TimeToStr(Value: DateTime; UTC: Boolean = False): string;
function StrToTime(const Value: string; UTC: Boolean = False): DateTime;

function DateTimeToStr(Value: DateTime; UTC: Boolean = False): string;
function StrToDateTime(const Value: string; UTC: Boolean = False): DateTime;

function DST(Value: DateTime; UTC: Boolean = False): Boolean;

function AddFS(const Value: string): string;
function RemoveFS(const Value: string): string;

function EscapeJSON(const Value: string): string;
function UnEscapeJSON(const Value: string): string;
function UnEscapeHTML(const Value: string): string;

function EscapeStr(const Value: string): string;
function UnEscapeStr(const Value: string): string;

function QuotedStr(const Value: string;
  QuoteChar: Char = SINGLE_QUOTE): string;

function StrReplace(const Value: string; const SearchValue: string;
  const ReplaceValue: string;
  ReplaceAll: Boolean = False;
  CaseInsensitive: Boolean = False): string;
/*function Trim(const Value: string): string; overload;*/
function Trim(const Value: string; TrimChar: Char): string; overload;
function Pad(const Value: string; PadLen: Integer;
  PadChar: Char = ' '): string;
function Format(const Value: string; Values: array of string): string;

function Translate(const ID: string): string; overload;
function Translate(const ID: string; const Values: array of string): string;
  overload;

function NumUnits(Value: Integer; UnitSize: Integer): Integer;

function DataTypeToStr(Value: TDataType): string;

procedure ConversionError(FromType: TDataType;
  ToType: TDataType);

{ +--------------------------------------------+
  ¦ Another utils global functions             ¦
  +--------------------------------------------+ }
function StrToDouble(n: string): Double;
function DoubleToStr(a: Double; b: Double = nil): string;
//function HourOf(a, b: variant): variant;
function HourOf(a: variant; b: Boolean = False): Integer;
function MinuteOf(a: variant; b: Boolean = False): Integer;
function SecondOf(a: variant; b: Boolean = False): Integer;
//function EncodeTime(a, b, c, d, e: variant): variant;
function EncodeTime(a, b, c, d: Integer; e: Boolean = False): Integer;
//function EncodeDateTime(a, b, c, d, e, f, g, h: variant): variant;
function EncodeDateTime(a, b, c, d, e, f, g: Integer; h: Boolean = False):
  Integer;
function YearOf(a: variant; b: Boolean = False): Integer;
function MonthOf(a: variant; b: Boolean = False): Integer;
function DayOf(a: variant; b: boolean = False): Integer;
function TimeZoneOffset(a: variant): variant;
//function encodedate(a, b, c, d: variant): variant;
function EncodeDate(a, b, c: Integer; d: Boolean = False): Integer;
function Max(a, b: variant): variant; overload;
function Min(a, b: variant): variant; overload;
function LocaleUpperCase(a: variant): variant;
function Pos(a, b: variant; c: variant = nil): variant;
function split(a: variant; b, c: variant = nil): variant;
function InsertArray(a, b, c: variant): variant;
function DeleteArray(a, b, c: variant): Variant;
function Join(a: variant; b: variant = false): Variant;
function DateTimeToISOstr(a: variant): variant;
function LookUpPropertyName(a: variant): variant;
function ISOStrToDatetime(a: variant): variant;
function CreateMethod(a: TComponent; b: Variant {TMethod}): Variant;
function ClassByName(a: variant): TClass; // probaby buggy
function LocaleCompareStr(L, R: variant): Variant;
function LocaleCompareText(L, R: variant): Variant;
function GetSet: TSet;
procedure PutSet(ASet: TSet);

var
  FormatSettings: TFormatSettings = nil;

implementation

var
  SetStack: TObjectList;
  GlobalFixups: TFixups;

function InheritsFrom(AChildClass: TClass; AClass: TClass): Boolean;
var
  TempClass: TClass;
begin
  if Assigned(AChildClass) then
  begin
    TempClass := AChildClass;
    while Assigned(TempClass) and (TempClass <> AClass) do
      TempClass := TempClass.ClassParent;
    Result := Assigned(TempClass);
  end
  else
    Result := False;
end;

function InheritsFrom(AObject: TObject; AClass: TClass): Boolean;
begin
  if Assigned(AObject) then
    Result := InheritsFrom(AObject.ClassType, AClass)
  else
    Result := False;
end;

function Trunc(Value: Double): Integer;
begin
  if (Value < 0) then
    Result := Ceil(Value)
  else
    Result := Floor(Value);
end;

function IsAlpha(Value: Char): Boolean;
begin
  Result := ((Value >= 'A') and (Value <= 'Z')) or
    ((Value >= 'a') and (Value <= 'z'));
end;

function IsDigit(Value: Char): Boolean;
begin
  Result := (Value >= '0') and (Value <= '9');
end;

function IsBool(const Value: string): Boolean;
begin
  Result := False;
  try
    StrToBool(Value);
    Result := True;
  except
  end;
end;

function IsInt(const Value: string): Boolean;
begin
  Result := False;
  try
    StrToInt(Value);
    Result := True;
  except
  end;
end;

function IsFloat(const Value: string): Boolean;
var
  TempDouble: Double;
begin
  Result := False;
  try
    TempDouble := StrToFloat(Value);
    Result := True;
  except
    Result := False;
  end;
end;

function IsLeapYear(Value: Integer): Boolean;
begin
  Result := ((Value mod 4) = 0) and (((Value mod 100) <> 0) or ((Value mod 400)
    = 0));
end;

function IsMonth(Value: Integer): Boolean;
begin
  Result := ((Value >= 1) and (Value <= MONTHS_PER_YEAR));
end;

function IsDay(Month: Integer; Value: Integer; LeapYear: Boolean = False):
  Boolean;
var
  TempMonthDays: array of Integer;
  TempDay: Integer;
begin
  if LeapYear then
    TempMonthDays := [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  else
    TempMonthDays := [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
  TempDay := TempMonthDays[Month - 1];
  Result := ((Value >= 1) and (Value <= TempDay));
end;

function IsHour(Value: Integer; AMPM: Boolean = False): Boolean;
begin
  if AMPM then
    Result := ((Value >= 0) and (Value <= AMPM_HOURS))
  else
    Result := ((Value >= 0) and (Value < HOURS_PER_DAY));
end;

function IsMinute(Value: Integer): Boolean;
begin
  Result := ((Value >= 0) and (Value < MINS_PER_HOUR));
end;

function IsSecond(Value: Integer): Boolean;
begin
  Result := ((Value >= 0) and (Value < SECS_PER_MINUTE));
end;

function IsMSecond(Value: Integer): Boolean;
begin
  Result := ((Value >= 0) and (Value < MSECS_PER_SECOND));
end;

function IsDate(const Value: string): Boolean;
begin
  Result := False;
  try
    StrToDate(Value);
    Result := True;
  except
  end;
end;

function IsTime(const Value: string): Boolean;
begin
  Result := False;
  try
    StrToTime(Value);
    Result := True;
  except
  end;
end;

function IsDateTime(const Value: string): Boolean;
begin
  Result := False;
  try
    StrToDateTime(Value);
    Result := True;
  except
  end;
end;

/* function BoolToStr(Value: Boolean): string;
begin
  Result := if Value then
    'True'
  else
    'False';
end;*/

function StrToBool(const Value: string): Boolean;
begin
  Result := False;
  if SameText(Value, BOOL_TRUE) then
    Result := True
  else if SameText(Value, BOOL_FALSE) then
    Result := False
  else
    raise Exception.Create(Translate('ERR_BOOLEAN_LITERAL', [Value]));
end;

function StrToDouble(n: string): Double;
begin
  asm
   var x = parseFloat(@n);
   if (!isNaN(x))
      @result = x;
   else
      throw "Invalid floating-point value";
  end;
end;

function DoubleToStr(a: Double; b: Double = nil): string;
begin
  asm
   if (@b != null )
      @result = Number(@a).toFixed(@b);
   else
      @result = Number(@a).toString();
  end;
end;

function HourOf(a: variant; b: Boolean = False): Integer;
begin
  asm
     if (@b)
        @result = new Date(@a).getUTCHours();
     else
        @result = new Date(@a).getHours();
  end;
end;

function MinuteOf(a: variant; b: Boolean = False): Integer;
begin
  asm
   if (@b)
      @result = new Date(@a).getUTCMinutes();
   else
      @result = new Date(@a).getMinutes();
  end;
end;

function SecondOf(a: variant; b: Boolean = False): Integer;
begin
  asm
   if (@b)
      @result = new Date(@a).getUTCSeconds();
   else
      @result = new Date(@a).getSeconds();
  end;
end;

function EncodeTime(a, b, c, d: Integer; e: Boolean = False): Integer;
begin
  asm
   var x = new Date(0);
   if (@e)
      x.setUTCHours(@a, @b, @c, @d);
   else
      x.setHours(@a, @b, @c, @d);
   var n = x.getTime();
   if (!isNaN(n))
      @result = n;
   else
      throw "Invalid time value";
  end;
end;

function EncodeDateTime(a, b, c, d, e, f, g: Integer; h: Boolean = False):
  Integer;
begin
  asm
   if (@h)
      var x = new Date(Date.UTC(@a, @b - 1, @c, @d, @e, @f, @g)).getTime();
   else
      var x = new Date(@a, @b - 1, @c, @d, @e, @f, @g).getTime();
   if (!isNaN(x))
      @result = x;
   else
      throw "Invalid date/time value";
  end;
end;

function YearOf(a: variant; b: Boolean = False): Integer;
begin
  asm
   if (@b)
      @result = new Date(@a).getUTCFullYear();
   else
      @result = new Date(@a).getFullYear();
  end;
end;

function MonthOf(a: variant; b: Boolean = False): Integer;
begin
  asm
   if (@b)
   @result = new Date(@a).getUTCMonth() + 1;
   else
   @result = new Date(@a).getMonth() + 1;
  end;
end;

function DayOf(a: variant; b: boolean = False): Integer;
begin
  asm
   if (@b)
      @result = new Date(@a).getUTCDate();
   else
      @result = new Date(@a).getDate();
  end;
end;

function TimeZoneOffset(a: variant): variant;
begin
  asm
   @result = new Date(@a).getTimezoneOffset();
  end;
end;

function EncodeDate(a, b, c: Integer; d: Boolean = False): Integer;
begin
  asm
   if (@d)
      var x = new Date(Date.UTC(@a, @b - 1, @c, 0, 0, 0, 0)).getTime();
   else
      var x = new Date(@a, @b - 1, @c, 0, 0, 0, 0).getTime();
   if (!isNaN(x))
      @result = x;
   else
      throw "Invalid date value";
  end;
end;

function Max(a, b: variant): variant;
begin
  asm
   @result = (@a > @b ? @a : @b);
  end;
end;

function Min(a, b: variant): variant;
begin
  asm
   @result = (@a < @b ? @a : @b);
  end;
end;

function LocaleUpperCase(a: variant): variant;
begin
  asm
   @result = (@a).toLocaleUpperCase();
  end;
end;

function Pos(a, b: variant; c: variant = nil): variant;
begin
  asm
   if (@c)
      @result =((@b).indexOf(@a, @c - 1) + 1);
   else
      @result = ((@b).indexOf(@a, 0) + 1);
  end;
end;

function Split(a: variant; b, c: variant = nil): variant;
begin
  if (c) then
    result := a.split(b, c)
  else if (b) then
    result := a.split(b)
  else
    result := a.split("");
end;

function InsertArray(a, b, c: variant): variant;
begin
  asm
   if (@a instanceof Array)
      @result = Array.prototype.splice.apply(@b, [@c, 0].concat(@a));
   else
      @result = (@b).splice(@c, 0, @a);
  end;
end;

function DeleteArray(a, b, c: variant): Variant;
begin
  /* if (c) then
    result := a.splice(b, c)
  else
    result := a.splice(b);
  */
    result := if (c = true) then
    a.splice(b, c)
  else
    a.splice(b);
end;

function Join(a: variant; b: variant = false): Variant;
begin
  result := if (b = true) then
    a.join(b)
  else
    a.join("");
end;

function DateTimeToISOstr(a: variant): variant;
begin
  asm @Result = new Date(@a).toISOString();
  end;
end;

function LookUpPropertyName(a: variant): variant;
begin
  {
     var x = $pm[a];
     if (x)
        return x;
     else
        return "";
  };

  //var x:= variantarray[a];
  result := if (a = true) then
    a
  else
    "";
end;

function ISOStrToDatetime(a: variant): variant;
begin
  asm
   var x = Date.parse(@a);
   if (!isNaN(x))
      @result = x;
   else
      throw "Invalid ISO 8601 date/time literal";
  end;
/* var
  x := Date.parse(a);
  if not (isNaN(x)) then
    result := x
  else
    raise exception("Invalid ISO 8601 date / time literal");
  //throw "Invalid ISO 8601 date/time literal";
  */
end;

function CreateMethod(a: TComponent; b: Variant {TMethod}): Variant;
begin
  asm
     @result = function() { @result = (@b).apply(@a, arguments) };
  end;
end;

function ClassByName(a: variant): TClass;
begin
  asm
   var n = $cl[(@a).toLowerCase()];
   if (n)
   {
      @result = n.$p;
   };
  end;
end;

function LocaleCompareStr(L, R: variant): Variant;
begin
  asm
   var n = (@L).localeCompare(@R);
   if (n < 0)
      @result = -1;
   else if (n > 0)
      @result = 1;
   else
      @result = n;
  end;
end;

function LocaleCompareText(L, R: variant): Variant;
begin
  asm
   var n = (@L).toLocaleUpperCase().localeCompare((@R).toLocaleUpperCase());
   if (n < 0)
      @result = -1;
   else if (n > 0)
      @result = 1;
   else
      @result = n;
  end;
end;

function GetSet: TSet;
begin
  Result := TSet(SetStack.Pop);
  if (Result = nil) then
    Result := TSet.Create
  else
    Result.Empty;
end;

procedure PutSet(ASet: TSet);
begin
  SetStack.Push(ASet);
end;

function FloatToStr(Value: Double; Decimals: Integer = -1): string;
begin
  if (Decimals <> -1) then
    Result := DoubleToStr(Value, Decimals)
  else
    Result := DoubleToStr(Value);
  if (FormatSettings.DecimalSeparator <> PERIOD) then
    Result := StrReplace(Result, PERIOD, FormatSettings.DecimalSeparator);
end;

function StrToFloat(const Value: string): Double;
var
  TempString: string;
begin
  if (FormatSettings.DecimalSeparator <> PERIOD) then
    TempString := StrReplace(Value, FormatSettings.DecimalSeparator, PERIOD)
  else
    TempString := Value;
  Result := StrToDouble(TempString);
end;

function TimeToStr(Value: DateTime; UTC: Boolean = False): string;
var
  I: Integer;
  TempHour: Integer;
begin
  Result := '';
  for I := 0 to 3 do
  begin
    case FormatSettings.ShortTimeFormatComp[I] of
      FULL_HOUR24_FORMAT:
        Result := Result + Pad(IntToStr(HourOf(Value, UTC)), 2, '0');
      PART_HOUR24_FORMAT:
        Result := Result + IntToStr(HourOf(Value, UTC));
      FULL_HOUR12_FORMAT:
        begin
          TempHour := HourOf(Value, UTC);
          if (TempHour > AMPM_HOURS) then
            Dec(TempHour, AMPM_HOURS);
          Result := Result + Pad(IntToStr(TempHour), 2, '0');
        end;
      PART_HOUR12_FORMAT:
        begin
          TempHour := HourOf(Value, UTC);
          if (TempHour > AMPM_HOURS) then
            Dec(TempHour, AMPM_HOURS);
          Result := Result + IntToStr(TempHour);
        end;
      FULL_MIN_FORMAT:
        Result := Result + Pad(IntToStr(MinuteOf(Value, UTC)), 2, '0');
      PART_MIN_FORMAT:
        Result := Result + IntToStr(MinuteOf(Value, UTC));
      FULL_SEC_FORMAT:
        Result := Result + Pad(IntToStr(SecondOf(Value, UTC)), 2, '0');
      PART_SEC_FORMAT:
        Result := Result + IntToStr(SecondOf(Value, UTC));
      FULL_AMPM_FORMAT:
        begin
          TempHour := HourOf(Value, UTC);
          if (TempHour >= AMPM_HOURS) then
            Result := Result + FormatSettings.TimePMString
          else
            Result := Result + FormatSettings.TimeAMString;
        end;
    end;
    if (I < 3) then
    begin
      if (FormatSettings.ShortTimeFormatComp[I + 1] <> '') then
      begin
        if (FormatSettings.ShortTimeFormatComp[I + 1] <> FULL_AMPM_FORMAT) then
          Result := Result + FormatSettings.TimeSeparator
        else
          Result := Result + ' ';
      end;
    end;
  end;
end;

function StrToTime(const Value: string; UTC: Boolean = False): DateTime;
var
  I: Integer;
  TempComps: TStringsArray;
  TempHour: Integer;
  TempMinute: Integer;
  TempSecond: Integer;
  TempAMPM: Boolean;
  TempMessage: string;
begin
  Result := 0; //DateTime(0);
  TempMessage := Translate('ERR_DATETIME_INVALID',
    [Translate('ERR_DATETIME_TIME'), Value]);
  try
    TempHour := 0;
    TempMinute := 0;
    TempSecond := 0;
    TempAMPM := False;
    TempComps := FormatSettings.ParseShortTime(Value);
    for I := 0 to 3 do
    begin
      if (FormatSettings.ShortTimeFormatComp[I] = FULL_HOUR24_FORMAT) or
        (FormatSettings.ShortTimeFormatComp[I] = PART_HOUR24_FORMAT) then
        TempHour := StrToInt(TempComps[I])
      else if (FormatSettings.ShortTimeFormatComp[I] = FULL_HOUR12_FORMAT) or
        (FormatSettings.ShortTimeFormatComp[I] = PART_HOUR12_FORMAT) then
        TempHour := StrToInt(TempComps[I])
      else if (FormatSettings.ShortTimeFormatComp[I] = FULL_MIN_FORMAT) or
        (FormatSettings.ShortTimeFormatComp[I] = PART_MIN_FORMAT) then
        TempMinute := StrToInt(TempComps[I])
      else if (FormatSettings.ShortTimeFormatComp[I] = FULL_SEC_FORMAT) or
        (FormatSettings.ShortTimeFormatComp[I] = PART_SEC_FORMAT) then
        TempSecond := StrToInt(TempComps[I])
      else if (FormatSettings.ShortTimeFormatComp[I] = FULL_AMPM_FORMAT) then
      begin
        TempAMPM := True;
        if SameText(TempComps[I], FormatSettings.TimePMString) and (TempHour <
          AMPM_HOURS) then
          Inc(TempHour, AMPM_HOURS);
      end;
    end;

    if (not (IsHour(TempHour, TempAMPM) and IsMinute(TempMinute) and
      IsSecond(TempSecond))) then
      raise Exception.Create(TempMessage)
    else
      Result := EncodeTime(TempHour, TempMinute, TempSecond, 0, UTC);
  except
    raise Exception.Create(TempMessage);
  end;
end;

function DateTimeToStr(Value: DateTime; UTC: Boolean = False): string;
begin
  Result := DateToStr(Value, UTC) + ' ' + TimeToStr(Value, UTC);
end;

function StrToDateTime(const Value: string; UTC: Boolean = False): DateTime;
var
  TempPos: Integer;
  TempDate: DateTime;
  TempTime: DateTime;
begin
  TempPos := Pos(' ', Value);
  if (TempPos > 0) then
  begin
    TempDate := StrToDate(Copy(Value, 1, TempPos - 1), UTC);
    TempTime := StrToTime(Copy(Value, TempPos + 1, Length(Value)), UTC);
    Result := EncodeDateTime(YearOf(TempDate, UTC), MonthOf(TempDate, UTC),
      DayOf(TempDate, UTC),
      HourOf(TempTime, UTC), MinuteOf(TempTime, UTC), SecondOf(TempTime, UTC),
      0, UTC);
  end
  else
    Result := StrToDate(Value, UTC);
end;

function DST(Value: DateTime; UTC: Boolean = False): Boolean;
var
  TempYear: Integer;
  TempOffset: Integer;
begin
  TempYear := YearOf(Value, UTC);
  TempOffset := Max(TimeZoneOffset(EncodeDate(TempYear, 1, 1, UTC)),
    TimeZoneOffset(EncodeDate(TempYear, 7, 1, UTC)));
  Result := (TimeZoneOffset(Value) < TempOffset);
end;

function AddFS(const Value: string): string;
begin
  Result := Value;
  if (Result <> '') and (Result[Length(Result)] <> SLASH) then
    Result := Result + SLASH;
end;

function RemoveFS(const Value: string): string;
begin
  Result := Value;
  if (Result <> '') and (Result[Length(Result)] = SLASH) then
    Result := Copy(Result, 1, Length(Result) - 1);
end;

function EscapeJSON(const Value: string): string;
var
  I: Integer;
  TempStringBuilder: TStringBuilder;
  TempChar: Char;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    I := 0;
    while (I < TempStringBuilder.Length) do
    begin
      case TempStringBuilder.Chars[I] of
        DOUBLE_QUOTE, BACKSLASH, SLASH:
          begin
            TempStringBuilder.Insert(I, BACKSLASH);
            Inc(I, 2);
          end;
      else
        begin
          if (TempStringBuilder.Chars[I] < SPACE) then
          begin
            TempChar := TempStringBuilder.Chars[I];
            TempStringBuilder.Remove(I, 1);
            TempStringBuilder.Insert(I, BACKSLASH + JSON_UNICODE +
              IntToHex(Ord(TempChar), 4));
            Inc(I, 6);
          end
          else
            Inc(I);
        end;
      end;
    end;
    Result := TempStringBuilder.ToString;

  finally
    TempStringBuilder.Free;
  end;
end;

function UnEscapeJSON(const Value: string): string;
var
  I: Integer;
  TempStringBuilder: TStringBuilder;
  TempString: string;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    I := 0;
    while (I < TempStringBuilder.Length) do
    begin
      if (TempStringBuilder.Chars[I] = BACKSLASH) then
      begin
        if (I < TempStringBuilder.Length) then
        begin
          Inc(I);
          case TempStringBuilder.Chars[I] of
            BACKSLASH, DOUBLE_QUOTE, SLASH:
              TempStringBuilder.Remove(I - 1, 1);
            JSON_BACKSPACE:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                TempStringBuilder.Chars[I - 1] := BACKSPACE;
              end;
            JSON_TAB:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                TempStringBuilder.Chars[I - 1] := TAB;
              end;
            JSON_CR:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                TempStringBuilder.Chars[I - 1] := CR;
              end;
            JSON_LF:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                TempStringBuilder.Chars[I - 1] := LF;
              end;
            JSON_CRLF:
              begin
                TempStringBuilder.Chars[I - 1] := CR;
                TempStringBuilder.Chars[I] := LF;
              end;
            JSON_UNICODE:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                TempString := TempStringBuilder.GetString(I, 4);
                TempStringBuilder.Chars[I - 1] := Chr(StrToInt(HEX_PREFIX +
                  TempString));
                TempStringBuilder.Remove(I, Length(TempString));
              end;
          end;
        end;
      end
      else
        Inc(I);
    end;
    Result := TempStringBuilder.ToString;

  finally
    TempStringBuilder.Free;
  end;
end;

function UnEscapeHTML(const Value: string): string;
var
  I: Integer;
  TempStringBuilder: TStringBuilder;
  TempString: string;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    I := 0;
    while (I < TempStringBuilder.Length) do
    begin
      if (TempStringBuilder.Chars[I] = AMPERSAND) then
      begin
        Inc(I);
        TempString := TempStringBuilder.GetString(I, 2);
        if SameText(TempString, HTML_LT) then
          TempStringBuilder.Chars[I - 1] := LEFT_ARROW
        else if SameText(TempString, HTML_GT) then
          TempStringBuilder.Chars[I - 1] := RIGHT_ARROW
        else
        begin
          TempString := TempStringBuilder.GetString(I, 3);
          if (not SameText(TempString, HTML_AMP)) then
          begin
            TempString := TempStringBuilder.GetString(I, 4);
            if SameText(TempString, HTML_QUOT) then
              TempStringBuilder.Chars[I - 1] := DOUBLE_QUOTE
            else if SameText(TempString, HTML_APOS) then
              TempStringBuilder.Chars[I - 1] := SINGLE_QUOTE
            else
              TempString := '';
          end;
        end;
        TempStringBuilder.Remove(I, Length(TempString));
      end
      else
        Inc(I);
    end;
    Result := TempStringBuilder.ToString;

  finally
    TempStringBuilder.Free;
  end;
end;

function EscapeStr(const Value: string): string;
var
  I: Integer;
  TempStringBuilder: TStringBuilder;
  TempChar: Char;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    I := 0;
    while (I < TempStringBuilder.Length) do
    begin
      case TempStringBuilder.Chars[I] of
        DOUBLE_QUOTE, BACKSLASH, SLASH:
          begin
            TempStringBuilder.Insert(I, BACKSLASH);
            Inc(I, 2);
          end;
      else
        begin
          if (TempStringBuilder.Chars[I] < SPACE) then
          begin
            TempChar := TempStringBuilder.Chars[I];
            TempStringBuilder.Remove(I, 1);
            TempStringBuilder.Insert(I, BACKSLASH + ESCAPE_UNICODE +
              IntToHex(Ord(TempChar),
              4));
            Inc(I, 6);
          end
          else
            Inc(I);
        end;
      end;
    end;
    Result := TempStringBuilder.ToString;
    //end;
  finally
    TempStringBuilder.Free;
  end;
end;

function UnEscapeStr(const Value: string): string;
var
  I: Integer;
  J: Integer;
  TempStringBuilder: TStringBuilder;
  TempString: string;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    I := 0;
    while (I < TempStringBuilder.Length) do
    begin
      if (TempStringBuilder.Chars[I] = BACKSLASH) then
      begin
        if (I < TempStringBuilder.Length) then
        begin
          Inc(I);
          case TempStringBuilder.Chars[I] of
            BACKSLASH, DOUBLE_QUOTE, SLASH:
              TempStringBuilder.Remove(I - 1, 1);
            ESCAPE_UNICODE:
              begin
                TempStringBuilder.Remove(I - 1, 1);
                J := I;
                TempString := '';
                while (J < TempStringBuilder.Length) and (J<(I + 4)) do
                begin
                  TempString := TempString + TempStringBuilder.Chars[J];
                  Inc(J);
                end;
                TempStringBuilder.Chars[I - 1] := Chr(StrToInt('0x' +
                  TempString));
                TempStringBuilder.Remove(I, Length(TempString));
              end;
          end;
        end;
      end
      else
        Inc(I);
    end;
    Result := TempStringBuilder.ToString;
    //end;
  finally
    TempStringBuilder.Free;
  end;
end;

function QuotedStr(const Value: string;
  QuoteChar: Char = SINGLE_QUOTE): string;
var
  I: Integer;
  TempStringBuilder: TStringBuilder;
begin
  TempStringBuilder := TStringBuilder.Create(Value);
  try
    for I := TempStringBuilder.Length - 1 downto 0 do
    begin
      if (TempStringBuilder.Chars[I] = QuoteChar) then
        TempStringBuilder.Insert(I, QuoteChar);
    end;
    TempStringBuilder.Insert(0, QuoteChar);
    TempStringBuilder.Append(QuoteChar);
    Result := TempStringBuilder.ToString;
  finally
    TempStringBuilder.Free;
  end;
end;

function StrReplace(const Value: string; const SearchValue: string;
  const ReplaceValue: string;
  ReplaceAll: Boolean = False;
  CaseInsensitive: Boolean = False): string;
var
  TempSearch: string;
  TempValue: string;
  TempPos: Integer;
  TempSearchPos: Integer;
begin
  if CaseInsensitive then
  begin
    TempSearch := LocaleUpperCase(SearchValue);
    TempValue := LocaleUpperCase(Value);
  end
  else
  begin
    TempSearch := SearchValue;
    TempValue := Value;
  end;
  Result := '';
  TempPos := 1;
  TempSearchPos := 0;
  TempSearchPos := Pos(TempSearch, TempValue, TempPos);
  while (TempSearchPos <> 0) do
  begin
    Result := Result + Copy(Value, TempPos, TempSearchPos - TempPos) +
      ReplaceValue;
    TempPos := (TempSearchPos + Length(TempSearch));
    if (not ReplaceAll) then
      Break;
    TempSearchPos := Pos(TempSearch, TempValue, TempPos);
  end;
  Result := Result + Copy(Value, TempPos, (Length(TempValue) - TempPos) + 1);
end;

/*function Trim(const Value: String): string;
var
  I: Integer;
  J: Integer;
begin
  Result := '';
  if (Length(Value) > 0) then
  begin
    I := 1;
    while (I < Length(Value)) and (Value[I] <= #32) do
      Inc(I);
    J := Length(Value);
    while (J > 1) and (Value[J] <= #32) do
      Dec(J);
    if (J >= I) and (Value[I] > #32) then
      Result := Copy(Value, I, ((J - I) + 1));
  end;
end;*/

function Trim(const Value: string; TrimChar: Char): string;
var
  I: Integer;
  J: Integer;
begin
  Result := '';
  if (Length(Value) > 0) then
  begin
    I := 1;
    while (I < Length(Value)) and (Value[I] = TrimChar) do
      Inc(I);
    J := Length(Value);
    while (J > 1) and (Value[J] = TrimChar) do
      Dec(J);
    if (J >= I) and (Value[I] <> TrimChar) then
      Result := Copy(Value, I, ((J - I) + 1));
  end;
end;

function Pad(const Value: string; PadLen: Integer;
  PadChar: Char = ' '): string;
begin
  Result := Value;
  while (Length(Result) < PadLen) do
    Result := (PadChar + Result);
end;

function Format(const Value: string; Values: array of string): string;
var
  TempStrings: Variant; //array of string;
  I: Integer;
begin
  TempStrings := Split(Value, '%s');
  if (Length(TempStrings) > 0) then
  begin
    Result := '';
    for I := 0 to Length(TempStrings) - 2 do
    begin
      Result := Result + TempStrings[I];
      if (I < Length(Values)) then
        Result := Result + Values[I];
    end;
    Result := Result + TempStrings[Length(TempStrings) - 1];
  end
  else
    Result := Value;
end;

function Translate(const ID: string): string;
begin
  Result := FormatSettings.Translations.Values[ID];
end;

function Translate(const ID: string; const Values: array of string): string;
begin
  Result := Format(Translate(ID), Values);
end;

function NumUnits(Value: Integer; UnitSize: Integer): Integer;
begin
  Result := Value;
  if ((Result mod UnitSize) <> 0) then
    Result := ((UnitSize * (Result div UnitSize)) + UnitSize);
end;

function DataTypeToStr(Value: TDataType): string;
begin
  case Value of
    dtUnknown:
      Result := Translate('TYPE_UNKNOWN');
    dtString:
      Result := Translate('TYPE_STRING');
    dtBoolean:
      Result := Translate('TYPE_BOOLEAN');
    dtInteger:
      Result := Translate('TYPE_INTEGER');
    dtFloat:
      Result := Translate('TYPE_FLOAT');
    dtDate:
      Result := Translate('TYPE_DATE');
    dtTime:
      Result := Translate('TYPE_TIME');
    dtDateTime:
      Result := Translate('TYPE_DATETIME');
    dtBlob:
      Result := Translate('TYPE_BLOB');
  else
    Result := '';
  end;
end;

procedure ConversionError(FromType: TDataType;
  ToType: TDataType);
begin
  raise Exception.Create(Translate('ERR_VALUE_CONVERT',
    [DataTypeToStr(FromType),
    DataTypeToStr(ToType)]));
end;

{ TParser }

procedure TParser.Initialize(const TextToParse: string;
  FullNumbers: Boolean = True;
  APropertyNameType: Char = tkString);
begin
  FText := TextToParse;
  FTextLength := Length(FText);
  FFullNumbers := FullNumbers;
  FPropertyNameType := APropertyNameType;
  FToken := tkTerm;
  FTokenString := '';
  FPos := 1;
  FLastPos := 1;
  FStart := 0;
  FEnd := 0;
  FEscaped := False;
  NextToken;
end;

procedure TParser.IncPos;
begin
  case FText[FPos] of
    CR:
      begin
        Inc(FPos);
        if (FPos <= FTextLength) and (FText[FPos] = LF) then
          Inc(FPos);
      end;
    LF:
      Inc(FPos);
  else
    Inc(FPos);
  end;
end;

procedure TParser.SkipBlanks;
begin
  while (FPos <= FTextLength) and (FText[FPos] <= SPACE) do
    IncPos;
end;

function TParser.GetTokenLiteral: string;
begin
  if (FStart > 0) and (FEnd > 0) then
    Result := Copy(FText, FStart, ((FEnd - FStart) + 1))
  else
    Result := '';
end;

function TParser.GetTokenPortion(EndPos: Integer): string;
begin
  if (EndPos >= FLastPos) then
    Result := Copy(FText, FLastPos, ((EndPos - FLastPos) + 1))
  else
    Result := '';
end;

procedure TParser.ParseString;
var
  TempStartPos: Integer;
  TempString: string;
begin
  FStart := FPos;
  FEnd := 0;
  Inc(FPos);
  FLastPos := FPos;
  while (FPos <= FTextLength) do
  begin
    if (FText[FPos] = DOUBLE_QUOTE) then
    begin
      FTokenString := (FTokenString + GetTokenPortion(FPos - 1));
      FEnd := FPos;
      Inc(FPos);
      Break;
    end
    else if (FText[FPos] = BACKSLASH) and (FPos < FTextLength) then
    begin
      FTokenString := (FTokenString + GetTokenPortion(FPos - 1));
      Inc(FPos);
      case FText[FPos] of
        BACKSLASH, DOUBLE_QUOTE, SLASH:
          begin
            FTokenString := (FTokenString + FText[FPos]);
            Inc(FPos);
          end;
        ESCAPE_UNICODE:
          begin
            Inc(FPos);
            TempStartPos := FPos;
            TempString := '';
            while (FPos <= FTextLength) and (FPos<(TempStartPos + 4)) do
            begin
              TempString := TempString + FText[FPos];
              Inc(FPos);
            end;
            FTokenString := (FTokenString + Chr(StrToInt('0x' + TempString)));
          end;
      else
        begin
          FTokenString := (FTokenString + FText[FPos - 1] + FText[FPos]);
          Inc(FPos);
        end;
      end;
      FLastPos := FPos;
    end
    else
      Inc(FPos);
  end;
  if (FEnd = 0) then
    FTokenString := (FTokenString + GetTokenPortion(FPos));
  FToken := tkString;
  if (FEnd = 0) then
    raise Exception.Create(Translate('ERR_PARSE_TERMSTR', [IntToStr(FStart -
        1)]));
end;

procedure TParser.ParseDigits;
begin
  while (FPos <= FTextLength) do
  begin
    if IsDigit(FText[FPos]) then
    begin
      FEnd := FPos;
      Inc(FPos);
    end
    else
      Break;
  end;
end;

function TParser.ParseChar(Value: Char): Boolean;
begin
  if (FPos <= FTextLength) and (FText[FPos] = Value) then
  begin
    Result := True;
    FEnd := FPos;
    Inc(FPos);
  end
  else
    Result := False;
end;

procedure TParser.ParseNumber;
begin
  FStart := FPos;
  FEnd := 0;
  if FFullNumbers then
    ParseChar(MINUS);
  if (FPos <= FTextLength) then
  begin
    ParseDigits;
    FToken := tkInteger;
    if FFullNumbers then
    begin
      if ParseChar(PERIOD) then
      begin
        ParseDigits;
        FToken := tkFloat;
      end;
      if ParseChar(EXP_LOWER) or ParseChar(EXP_UPPER) then
      begin
        ParseChar(MINUS);
        ParseDigits;
        FToken := tkFloat;
      end;
    end;
  end;
  if (FEnd = 0) and (FPos = (FTextLength + 1)) then
    FEnd := (FPos - 1);
  FTokenString := TokenLiteral;
end;

procedure TParser.ParseAlphaChars;
begin
  while (FPos <= FTextLength) do
  begin
    if IsAlpha(FText[FPos]) then
    begin
      FEnd := FPos;
      Inc(FPos);
    end
    else
      Break;
  end;
end;

procedure TParser.ParseSymbol;
begin
  FStart := FPos;
  FEnd := 0;
  FToken := tkSymbol;
  ParseAlphaChars;
  FTokenString := TokenLiteral;
end;

procedure TParser.NextToken;
begin
  FToken := tkTerm;
  FTokenString := '';
  FStart := 0;
  FEnd := 0;
  FEscaped := False;
  if (FPos <= FTextLength) then
  begin
    SkipBlanks;
    if (FPos <= FTextLength) then
    begin
      if (FText[FPos] = DOUBLE_QUOTE) then
        ParseString
      else if (FFullNumbers and (FText[FPos] = MINUS) and ((FPos + 1) <=
        FTextLength) and IsDigit(FText[FPos + 1])) or
        IsDigit(FText[FPos]) then
        ParseNumber
      else if IsAlpha(FText[FPos]) then
        ParseSymbol
      else
      begin
        FStart := FPos;
        FEnd := FPos;
        FToken := FText[FPos];
        FTokenString := FToken;
        Inc(FPos);
      end;
    end;
  end;
end;

function TParser.CheckToken(Value: Char): Boolean;
begin
  Result := (FToken = Value);
end;

function TParser.CheckString(const Value: string): Boolean;
begin
  Result := ((FToken = tkString) and SameText(FTokenString, Value));
end;

function TParser.CheckSymbol(const Value: string): Boolean;
begin
  Result := ((FToken = tkSymbol) and SameText(FTokenString, Value));
end;

procedure TParser.ExpectedError(const Value: string);
var
  TempValue: string;
begin
  case Value of
    tkSymbol:
      TempValue := Translate('TYPE_SYMBOL');
    tkString:
      TempValue := Translate('TYPE_STRING');
    tkInteger:
      TempValue := Translate('TYPE_INTEGER');
    tkFloat:
      TempValue := Translate('TYPE_FLOAT');
  else
    TempValue := DOUBLE_QUOTE + Value + DOUBLE_QUOTE;
  end;
  if (FStart = 0) or (FEnd = 0) then
    raise Exception.Create(Translate('ERR_PARSE_MISSING', [TempValue]))
  else
    raise Exception.Create(Translate('ERR_PARSE_EXPECT', [TempValue,
      TokenLiteral, IntToStr(FStart - 1)]));
end;

procedure TParser.ErrorIfNotToken(Value: Char);
begin
  if (not CheckToken(Value)) then
    ExpectedError(Value);
end;

procedure TParser.ErrorIfNotString(const Value: string);
begin
  if (not CheckString(Value)) then
    ExpectedError(Value);
end;

procedure TParser.ErrorIfNotSymbol(const Value: string);
begin
  if (not CheckSymbol(Value)) then
    ExpectedError(Value);
end;

function TParser.SkipToken(Value: Char): Boolean;
begin
  Result := False;
  if CheckToken(Value) then
  begin
    Result := True;
    NextToken;
  end;
end;

function TParser.SkipString(const Value: string): Boolean;
begin
  Result := False;
  if CheckString(Value) then
  begin
    Result := True;
    NextToken;
  end;
end;

function TParser.SkipSymbol(const Value: string): Boolean;
begin
  Result := False;
  if CheckSymbol(Value) then
  begin
    Result := True;
    NextToken;
  end;
end;

procedure TParser.ErrorIfNotSkipToken(Value: Char);
begin
  ErrorIfNotToken(Value);
  NextToken;
end;

procedure TParser.ErrorIfNotSkipString(const Value: string);
begin
  ErrorIfNotString(Value);
  NextToken;
end;

procedure TParser.ErrorIfNotSkipSymbol(const Value: string);
begin
  ErrorIfNotSymbol(Value);
  NextToken;
end;

function TParser.SkipObject: Boolean;
begin
  if SkipToken(LEFT_BRACE) then
  begin
    while True do
    begin
      SkipProperty;
      if (not SkipToken(COMMA)) then
        Break;
    end;
    ErrorIfNotSkipToken(RIGHT_BRACE);
    Result := True;
  end
  else
    Result := False;
end;

function TParser.SkipArray: Boolean;
begin
  if SkipToken(LEFT_BRACKET) then
  begin
    while True do
    begin
      if CheckToken(LEFT_BRACE) then
        SkipObject
      else if (not CheckToken(RIGHT_BRACKET)) then
        NextToken;
      if (not SkipToken(COMMA)) then
        Break;
    end;
    ErrorIfNotSkipToken(RIGHT_BRACKET);
    Result := True;
  end
  else
    Result := False;
end;

procedure TParser.SkipProperty;
begin
  if CheckToken(FPropertyNameType) then
  begin
    NextToken;
    ErrorIfNotSkipToken(COLON);
    SkipPropertyValue;
  end;
end;

procedure TParser.SkipPropertyValue;
begin
  if (not SkipObject) then
  begin
    if (not SkipArray) then
      NextToken;
  end;
end;

function TParser.GetString: string;
begin
  if (SkipObject or SkipArray) then
    Result := ''
  else
  begin
    ErrorIfNotToken(tkString);
    Result := FTokenString;
    NextToken;
  end;
end;

function TParser.GetInteger: Integer;
begin
  if (SkipObject or SkipArray) then
    Result := 0
  else
  begin
    ErrorIfNotToken(tkInteger);
    Result := StrToInt(FTokenString);
    NextToken;
  end;
end;

function TParser.GetBoolean: Boolean;
begin
  if (SkipObject or SkipArray) then
    Result := False
  else
  begin
    ErrorIfNotToken(tkSymbol);
    Result := StrToBool(FTokenString);
    NextToken;
  end;
end;

function TParser.GetFloat: Double;
begin
  if (SkipObject or SkipArray) then
    Result := 0
  else
  begin
    if (not CheckToken(tkInteger)) then
      ErrorIfNotToken(tkFloat);
    Result := StrToDouble(FTokenString);
    NextToken;
  end;
end;

{ TStringBuilder }

constructor TStringBuilder.Create(const Value: string);
begin
  inherited Create;
  Append(Value);
end;

procedure TStringBuilder.SetLength(Value: Integer);
begin
  if (Value <> FLength) then
  begin
    FMemory.SetLength(Value);
    FLength := Value;
  end;
end;

function TStringBuilder.GetChar(Index: Integer): Char;
begin
  Result := FMemory[Index];
end;

procedure TStringBuilder.SetChar(Index: Integer; Value: Char);
begin
  FMemory[Index] := Value;
end;

function TStringBuilder.GetString(Index: Integer; Count: Integer): string;
  function Copy(const Value: array of Char; Index: Integer;
    Count: Integer): array of Char; overload; external "copy";

var
  TempChars: TCharArray;
begin
  TempChars := Copy(FMemory, Index, Count);
  Result := Join(Variant(TempChars));
end;

procedure TStringBuilder.Append(const Value: Variant);
  function CreateArray: variant; external '[]' property;
  var
    TempChars := CreateArray; //TCharArray;
  begin
    if (Value <> '') then
    begin
      TempChars := Split(Value, nil, nil);
      InsertArray(TempChars, Variant(FMemory), FLength);
      Inc(FLength, Length(TempChars));
    end;
  end;

  procedure TStringBuilder.Append(Value: Char);
  begin
    SetLength(FLength + 1);
    FMemory[FLength - 1] := Value;
  end;


  /* procedure TStringBuilder.Append(Value: Integer);
  begin
    SetLength(FLength + 1);
    FMemory[FLength - 1] := IntToStr(Value);
  end;
  */

  procedure TStringBuilder.Insert(Position: Integer; Value: Char);
  begin
    if (Position < FLength) then
    begin
      InsertArray(Value, Variant(FMemory), Position);
      Inc(FLength);
    end
    else
      Append(Value);
  end;

  procedure TStringBuilder.Insert(Position: Integer; const Value: variant);
    function CreateArray: variant; external '[]' property;
    var
      TempChars := CreateArray; //TCharArray;
    begin
      if (Value <> '') then
      begin
        if (Position < FLength) then
        begin
          TempChars := Split(Value);
          InsertArray(TempChars, Variant(FMemory), Position);
          Inc(FLength, Length(TempChars));
        end
        else
          Append(Value);
      end;
    end;

    procedure TStringBuilder.Remove(Position: Integer; Count: Integer);
    begin
      if (Count > 0) then
      begin
        DeleteArray(Variant(FMemory), Position, Count);
        FLength := Length(FMemory);
      end;
    end;

    function TStringBuilder.ToString: string;
    begin
      Result := Join(Variant(FMemory));
    end;

    { TWriterState }

    constructor TWriterState.Create(APropertyCount: Integer;
      AIndent: Integer);
    begin
      inherited Create;
      FPropertyCount := APropertyCount;
      FIndent := AIndent;
    end;

    { TWriter }

    constructor TWriter.Create(ADateTimeFormat: TDateTimeFormat = dtfRaw;
      AIndentSpaces: Integer = 3;
      AIncludeLineFeeds: Boolean = True;
      ACompressWhitespace: Boolean = False);
    begin
      inherited Create;
      FDateTimeFormat := ADateTimeFormat;
      FIndentSpaces := AIndentSpaces;
      FLineFeeds := AIncludeLineFeeds;
      FCompressed := ACompressWhitespace;
    end;

    destructor TWriter.Destroy;
    begin
      FStack.Free;
      FStack := nil;
      inherited Destroy;
    end;

    procedure TWriter.Initialize;
    begin
      FOutput := '';
      FStack.Free;
      FStack := TObjectList.Create;
      FPropertyCount := 0;
      FIndent := 0;
    end;

    procedure TWriter.Append(const Value: string);
    begin
      FOutput := (FOutput + Value);
    end;

    procedure TWriter.Whitespace;
    begin
      if (not FCompressed) then
        Append(SPACE);
    end;

    procedure TWriter.Separator;
    begin
      Append(COMMA);
      Whitespace;
    end;

    procedure TWriter.IncIndent;
    begin
      Inc(FIndent, FIndentSpaces);
    end;

    procedure TWriter.DecIndent;
    begin
      Dec(FIndent, FIndentSpaces);
    end;

    procedure TWriter.NewLine;
    var
      I: Integer;
    begin
      if FLineFeeds and (not FCompressed) then
      begin
        Append(CRLF);
        for I := 1 to FIndent do
          Append(SPACE);
      end;
    end;

    procedure TWriter.BeginNewLine;
    begin
      FNewLine := True;
    end;

    procedure TWriter.CancelNewLine;
    begin
      FNewLine := False;
    end;

    procedure TWriter.Literal(const Value: string);
    begin
      Append(Value);
    end;

    procedure TWriter.BeginObject;
    begin
      FStack.Push(TWriterState.Create(FPropertyCount, FIndent));
      FPropertyCount := 0;
      Append(LEFT_BRACE);
      Whitespace;
    end;

    procedure TWriter.EndObject;
    var
      TempState: TWriterState;
    begin
      FNewLine := False;
      Whitespace;
      Append(RIGHT_BRACE);
      TempState := TWriterState(FStack.Pop);
      try
        FPropertyCount := TempState.PropertyCount;
        FIndent := TempState.Indent;
      finally
        TempState.Free;
      end;
    end;

    procedure TWriter.PropertyName(const Name: string);
    begin
      if (FPropertyCount > 0) then
        Separator;
      if FNewLine then
      begin
        NewLine;
        FNewLine := False;
      end;
      Append(DOUBLE_QUOTE);
      Append(Name);
      Append(DOUBLE_QUOTE);
      Append(COLON);
      Whitespace;
      Inc(FPropertyCount);
    end;

    procedure TWriter.NullProperty(const Name: string);
    begin
      PropertyName(Name);
      NullValue;
    end;

    procedure TWriter.NullValue;
    begin
      Append(NULL_VALUE);
    end;

    procedure TWriter.ObjectProperty(const Name: string);
    begin
      PropertyName(Name);
    end;

    procedure TWriter.StringProperty(const Name: string;
      const Value: string);
    begin
      PropertyName(Name);
      StringValue(Value);
    end;

    procedure TWriter.StringValue(const Value: string);
    begin
      Append(DOUBLE_QUOTE + EscapeStr(Value) + DOUBLE_QUOTE);
    end;

    procedure TWriter.DateTimeProperty(const Name: string;
      Value: DateTime);
    begin
      PropertyName(Name);
      DateTimeValue(Value);
    end;

    procedure TWriter.DateTimeValue(Value: DateTime);
    begin
      case FDateTimeFormat of
        dtfISO8601:
          Append(QuotedStr(DateTimeToISOStr(Value), DOUBLE_QUOTE));
      else
        Append(IntToStr(Integer(Value)));
      end;
    end;

    procedure TWriter.IntegerProperty(const Name: string;
      Value: Integer);
    begin
      PropertyName(Name);
      IntegerValue(Value);
    end;

    procedure TWriter.IntegerValue(Value: Integer);
    begin
      Append(IntToStr(Value));
    end;

    procedure TWriter.BooleanProperty(const Name: string;
      Value: Boolean);
    begin
      PropertyName(Name);
      BooleanValue(Value);
    end;

    procedure TWriter.BooleanValue(Value: Boolean);
    begin
      Append(LowerCase(BoolToStr(Value)));
    end;

    procedure TWriter.FloatProperty(const Name: string;
      Value: Double);
    begin
      PropertyName(Name);
      FloatValue(Value);
    end;

    procedure TWriter.FloatValue(Value: Double);
    begin
      Append(DoubleToStr(Value));
    end;

    procedure TWriter.BeginArray(HasElements: Boolean);
    begin
      Append(LEFT_BRACKET);
      if HasElements then
        WhiteSpace;
    end;

    procedure TWriter.EndArray(HasElements: Boolean);
    begin
      if HasElements then
        WhiteSpace;
      Append(RIGHT_BRACKET);
    end;

    { TFixup }
    constructor TFixup.Create(ARootComponent: TComponent;
      AInstance: TPersistent;
      APropertyName: string;
      AComponentName: string);
    begin
      inherited Create;
      FRootComponent := ARootComponent;
      FInstance := AInstance;
      FPropertyName := APropertyName;
      FComponentName := AComponentName;
    end;

    { TFixups }

    constructor TFixups.Create;
    begin
      inherited Create;
      FList := TObjectList.Create;
    end;

    destructor TFixups.Destroy;
    begin
      FList.Free;
      FList := nil;
      inherited Destroy;
    end;

    function TFixups.GetCount: Integer;
    begin
      Result := FList.Count;
    end;

    function TFixups.GetFixup(Index: Integer): TFixup;
    begin
      Result := TFixup(FList[Index]);
    end;

    procedure TFixups.Add(ARootComponent: TComponent;
      AInstance: TPersistent;
      const APropertyName: string;
      const AComponentName: string);
    begin
      FList.Add(TFixup.Create(ARootComponent, AInstance, APropertyName,
        AComponentName));
    end;

    { TReader }
    constructor TReader.Create(ADateTimeFormat: TDateTimeFormat = dtfRaw);
    begin
      inherited Create;
      FFixups := TFixups.Create;
      FParser := TParser.Create;
      FDateTimeFormat := ADateTimeFormat;
    end;

    destructor TReader.Destroy;
    begin
      FParser.Free;
      FParser := nil;
      FFixups.Free;
      FFixups := nil;
      inherited Destroy;
    end;

    procedure TReader.Initialize(const Value: string;
      ACompressedProperties: Boolean = False);
    begin
      FLevel := -1;
      FCompressedProperties := ACompressedProperties;
      if FCompressedProperties then
        FParser.Initialize(Value, True, tkSymbol)
      else
        FParser.Initialize(Value);
    end;

    function TReader.IsObject: Boolean;
    begin
      Result := FParser.CheckToken(LEFT_BRACE);
    end;

    procedure TReader.BeginObject;
    begin
      Inc(FLevel);
      FParser.ErrorIfNotSkipToken(LEFT_BRACE);
    end;

    function TReader.EndOfObject: Boolean;
    begin
      Result := FParser.CheckToken(RIGHT_BRACE);
    end;

    procedure TReader.EndObject;
    begin
      FParser.ErrorIfNotSkipToken(RIGHT_BRACE);
      Dec(FLevel);
    end;

    function TReader.GetPropertyName: string;
    begin
      if FParser.CheckToken(FParser.PropertyNameType) then
      begin
        if FCompressedProperties then
          Result := LookupPropertyName(FParser.TokenString)
        else
          Result := FParser.TokenString;
      end
      else
        Result := '';
    end;

    procedure TReader.SkipPropertyName;
    begin
      FParser.NextToken;
    end;

    procedure TReader.SkipPropertySeparator;
    begin
      FParser.ErrorIfNotSkipToken(COLON);
    end;

    procedure TReader.SkipProperty;
    begin
      FParser.SkipProperty;
    end;

    procedure TReader.SkipPropertyValue;
    begin
      FParser.SkipPropertyValue;
    end;

    function TReader.IsNull: Boolean;
    begin
      Result := FParser.CheckSymbol(NULL_VALUE);
    end;

    function TReader.IsString: Boolean;
    begin
      Result := FParser.CheckToken(tkString);
    end;

    function TReader.IsBoolean: Boolean;
    begin
      Result := FParser.CheckSymbol(BOOL_TRUE) or
        FParser.CheckSymbol(BOOL_FALSE);
    end;

    function TReader.ReadString: string;
    begin
      Result := FParser.GetString;
    end;

    function TReader.ReadDateTime: DateTime;
    begin
      case FDateTimeFormat of
        dtfISO8601:
          Result := ISOStrToDateTime(FParser.GetString);
      else
        Result := DateTime(FParser.GetInteger);
      end;
    end;

    function TReader.ReadInteger: Integer;
    begin
      Result := FParser.GetInteger;
    end;

    function TReader.ReadBoolean: Boolean;
    begin
      Result := FParser.GetBoolean;
    end;

    function TReader.ReadFloat: Double;
    begin
      Result := FParser.GetFloat;
    end;

    function TReader.MoreProperties: Boolean;
    begin
      Result := FParser.SkipToken(COMMA);
    end;

    function TReader.IsArray: Boolean;
    begin
      Result := FParser.CheckToken(LEFT_BRACKET);
    end;

    procedure TReader.BeginArray;
    begin
      Inc(FLevel);
      FParser.ErrorIfNotSkipToken(LEFT_BRACKET);
    end;

    function TReader.EndOfArray: Boolean;
    begin
      Result := FParser.CheckToken(RIGHT_BRACKET);
    end;

    procedure TReader.EndArray;
    begin
      FParser.ErrorIfNotSkipToken(RIGHT_BRACKET);
      Dec(FLevel);
    end;

    function TReader.MoreArrayElements: Boolean;
    begin
      Result := FParser.SkipToken(COMMA);
    end;

    procedure TReader.SkipArrayElement;
    begin
      FParser.SkipObject;
    end;

    procedure TReader.AddFixup(AInstance: TPersistent;
      const APropertyName: string;
      const AComponentName: string);
    begin
      if (Pos(PERIOD, AComponentName) > 0) then
        GlobalFixups.Add(FRootComponent, AInstance, APropertyName,
          AComponentName)
      else
        FFixups.Add(FRootComponent, AInstance, APropertyName, AComponentName);
    end;

    procedure TReader.ApplyFixups;
    var
      I: Integer;
      TempFixup: TFixup;
      TempPos: Integer;
      TempRootName: string;
      TempName: string;
      TempRootComponent: TComponent;
      TempGlobalComponent: TComponent;
      TempComponent: TComponent;
    begin
      if Assigned(FRootComponent) then
      begin
        for I := 0 to FFixups.Count - 1 do
        begin
          TempFixup := FFixups[I];
          TempComponent :=
            FRootComponent.FindComponent(TempFixup.ComponentName);
          if Assigned(TempComponent) then
            TempFixup.Instance.SetProperty(TempFixup.PropertyName,
              TempComponent);
        end;
        TempGlobalComponent := FGlobalComponent;
        if (not Assigned(TempGlobalComponent)) then
          TempGlobalComponent := FRootComponent.Owner;
        { Apply any global fixups }
        if Assigned(TempGlobalComponent) then
        begin
          for I := 0 to GlobalFixups.Count - 1 do
          begin
            TempFixup := GlobalFixups[I];
            if (TempFixup.RootComponent = FRootComponent) then
            begin
              TempName := TempFixup.ComponentName;
              TempPos := Pos(PERIOD, TempName);
              { TempPos should always be greater than 0 here, but
                we'll check anyways as a defensive measure }
              if (TempPos > 0) then
              begin
                TempRootName := Copy(TempName, 1, TempPos - 1);
                TempName := Copy(TempName, TempPos + 1, Length(TempName));
                TempRootComponent :=
                  TempGlobalComponent.FindComponent(TempRootName);
                if Assigned(TempRootComponent) then
                begin
                  TempComponent := TempRootComponent.FindComponent(TempName);
                  if Assigned(TempComponent) then
                    TempFixup.Instance.SetProperty(TempFixup.PropertyName,
                      TempComponent);
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    { TPersistent }
    function TPersistent.LoadProperty(AReader: TReader): Boolean;
    var
      TempName: string;
      TempType: Integer;
      TempInstance: TObject;
      TempMethod: Variant {TMethod}; //---- ????
      TempMethodName: string;
    begin
      Result := False;
      TempName := AReader.GetPropertyName;
      if (TempName <> '') then
      begin
        TempType := PropertyType(TempName);
        if (TempType <> TYPE_INFO_UNKNOWN) then
        begin
          Result := True;
          AReader.SkipPropertyName;
          AReader.SkipPropertySeparator;
          if AReader.IsNull then
            AReader.SkipPropertyValue
          else
          begin
            case TempType of
              TYPE_INFO_BOOLEAN:
                SetProperty(TempName, AReader.ReadBoolean);
              TYPE_INFO_CHAR, TYPE_INFO_STRING:
                SetProperty(TempName, AReader.ReadString);
              TYPE_INFO_CLASS:
                begin
                  TempInstance := GetProperty(TempName);
                  if Assigned(TempInstance) and (TempInstance is TPersistent)
                    then
                    TPersistent(TempInstance).Load(AReader)
                  else
                    AReader.SkipPropertyValue;
                end;
              TYPE_INFO_CLASSREF:
                AReader.AddFixup(Self, TempName, AReader.ReadString);
              TYPE_INFO_DATETIME:
                SetProperty(TempName, AReader.ReadDateTime);
              TYPE_INFO_ENUM, TYPE_INFO_INTEGER:
                SetProperty(TempName, AReader.ReadInteger);
              TYPE_INFO_DOUBLE:
                SetProperty(TempName, AReader.ReadFloat);
              TYPE_INFO_METHOD:
                begin
                  TempMethodName := AReader.ReadString;
                  if Assigned(AReader.RootComponent) then
                  begin
                    //TempMethod:=TMethod(AReader.RootComponent.GetMethod(TempMethodName));
                    TempMethod :=
                      (AReader.RootComponent.GetMethod(TempMethodName));
                    //if Assigned(TempMethod) then
                    if (TempMethod) then
                      SetProperty(TempName, CreateMethod(AReader.RootComponent,
                        TempMethod))
                    else
                      raise Exception.Create(Translate('ERR_LOAD_METHOD',
                        [TempMethodName]));
                  end;
                end;
            end;
          end;
        end;
      end;
    end;

    procedure TPersistent.LoadProperties(AReader: TReader);
    begin
      while (not AReader.EndOfObject) do
      begin
        if (not LoadProperty(AReader)) then
          AReader.SkipProperty;
        if (not AReader.MoreProperties) then
          Break;
      end;
    end;

    procedure TPersistent.LoadObject(AReader: TReader);
    begin
      AReader.BeginObject;
      LoadProperties(AReader);
      AReader.EndObject;
    end;

    function TPersistent.LoadArrayElement(AReader: TReader): Boolean;
    begin
      if AReader.IsObject then
      begin
        Result := True;
        LoadObject(AReader);
      end
      else
        Result := False;
    end;

    procedure TPersistent.LoadArrayElements(AReader: TReader);
    begin
      while (not AReader.EndOfArray) do
      begin
        if (not LoadArrayElement(AReader)) then
          AReader.SkipArrayElement;
        if (not AReader.MoreArrayElements) then
          Break;
      end;
    end;

    procedure TPersistent.LoadArray(AReader: TReader);
    begin
      AReader.BeginArray;
      LoadArrayElements(AReader);
      AReader.EndArray;
    end;

    procedure TPersistent.BeforeLoad;
    begin
      FLoading := True;
    end;

    procedure TPersistent.AfterLoad;
    begin
      FLoading := False;
    end;

    procedure TPersistent.LoadError(E: Exception);
    begin
      FLoading := False;
      raise Exception.Create(Translate('ERR_LOAD_PERSISTENT', [E.Message]));
    end;

    procedure TPersistent.Load(AReader: TReader);
    begin
      BeforeLoad;
      try
        if AReader.IsArray then
          LoadArray(AReader)
        else if AReader.IsObject then
          LoadObject(AReader)
        else
          LoadProperties(AReader);
        if (Self = AReader.RootComponent) then
          AReader.ApplyFixups;
        AfterLoad;
      except
        on E: Exception do
          LoadError(E);
      end;
    end;

    procedure TPersistent.BeforeSave;
    begin
    end;

    procedure TPersistent.AfterSave;
    begin
    end;

    procedure TPersistent.SaveError(E: Exception);
    begin
      raise Exception.Create(Translate('ERR_SAVE_PERSISTENT', [E.Message]));
    end;

    procedure TPersistent.SaveProperty(AWriter: TWriter; const AName: string);
    var
      TempType: Integer;
      TempInstance: TObject;
    begin
      TempType := PropertyType(AName);
      if (TempType <> TYPE_INFO_UNKNOWN) then
      begin
        AWriter.BeginNewLine;
        case TempType of
          TYPE_INFO_BOOLEAN:
            //AWriter.BooleanProperty(AName, GetProperty(AName));
            AWriter.BooleanProperty(AName, Variant(GetProperty(AName)));
          TYPE_INFO_CHAR, TYPE_INFO_STRING:
            //AWriter.StringProperty(AName,GetProperty(AName));
            AWriter.StringProperty(AName, Variant(GetProperty(AName)));
          TYPE_INFO_CLASS:
            begin
              TempInstance := GetProperty(AName);
              if Assigned(TempInstance) and (TempInstance is TPersistent) then
              begin
                AWriter.ObjectProperty(AName);
                AWriter.IncIndent;
                TPersistent(TempInstance).Save(AWriter);
                AWriter.DecIndent;
              end
              else
                AWriter.CancelNewLine;
            end;
          TYPE_INFO_DATETIME:
            //AWriter.DateTimeProperty(AName,GetProperty(AName));
            AWriter.DateTimeProperty(AName, Variant(GetProperty(AName)));
          TYPE_INFO_ENUM, TYPE_INFO_INTEGER:
            //AWriter.IntegerProperty(AName,GetProperty(AName));
            AWriter.IntegerProperty(AName, Variant(GetProperty(AName)));
          TYPE_INFO_DOUBLE:
            AWriter.FloatProperty(AName, GetProperty(AName));
        else
          AWriter.CancelNewLine;
        end;
      end;
    end;

    procedure TPersistent.SaveProperties(AWriter: TWriter);
    var
      TempCount: Integer;
      I: Integer;
      TempName: string;
    begin
      TempCount := PropertyCount;
      for I := 0 to TempCount - 1 do
      begin
        TempName := PropertyName(I);
        if (TempName <> '') then
          SaveProperty(AWriter, TempName);
      end;
    end;

    procedure TPersistent.SaveArrayElement(AWriter: TWriter);
    begin
    end;

    procedure TPersistent.SaveArrayElements(AWriter: TWriter);
    begin
    end;

    procedure TPersistent.Save(AWriter: TWriter);
    begin
      BeforeSave;
      AWriter.BeginObject;
      {AWriter.}SaveProperties(AWriter);
      AWriter.EndObject;
      AfterSave;
    end;

    procedure TPersistent.Assign(APersistent: TPersistent);
    begin
    end;


    function TPersistent.PropertyCount: Integer;
    begin // TODO
      console.log('TODO TPersistent.PropertyCount');
      result := 1;
    end;

    function TPersistent.PropertyName(AIndex: Integer): string;
    begin // TODO
      console.log(' TODO TPersistent.PropertyName');
      result := IntToStr(AIndex);
    end;

    function TPersistent.PropertyType(const AName: string): Integer;
    begin // TODO
      console.log('TODO TPersistent.PropertyType');
      result := StrToInt(AName);
    end;

    function TPersistent.GetProperty(const AName: string): TObject;
    begin // TODO
      console.log('TODO TPersistent.GetProperty');
      result := Self;
    end;

    function TPersistent.GetProperty(const AName: Boolean): Boolean;
    begin // TODO
      console.log('TODO TPersistent.GetProperty');
      result := AName;
    end;

    procedure TPersistent.SetProperty(const AName: String; Value: Variant);
    begin
      console.log('TODO TPersistent.SetProperty');
    end;

    procedure TPersistent.SetInstance(const AName: string; Value: TObject;
      ARoot: Boolean = False);
    begin // TODO
      console.log('TODO TPersistent.SetInstance');
    end;

    function TPersistent.GetMethod(const AName: string): Variant;
    begin // TODO
      console.log('TODO TPersistent.GetMethod');
      result := AName;
    end;

    
{ TComponent }
constructor TComponent.Create(AOwner: TComponent);
begin
  inherited Create;
  FOwner := AOwner;
  if Assigned(FOwner) then
    FOwner.AddComponent(Self);
  Initialize;
end;

destructor TComponent.Destroy;
begin
  if (not FDestroying) then
  begin
    SetDestroying;
    Notify(cmRemoveComp);
    FNotifications.Free;
    FNotifications := nil;
    FComponents.Free;
    FComponents := nil;
    if Assigned(FOwner) then
      FOwner.RemoveComponent(Self);
    inherited Destroy;
  end;
end;

procedure TComponent.CheckOwnerClass(AOwnerClass: TClass);
begin
  if (not InheritsFrom(FOwner, AOwnerClass)) then
    raise Exception.Create(Translate('ERR_OWNER', [AOwnerClass.ClassName]));
end;

procedure TComponent.SetDestroying;
begin
  FDestroying := True;
end;

procedure TComponent.Register(Component: TComponent);
begin
  if (not FRegistering) then
  begin
    FRegistering := True;
    try
      if FDestroying then
        raise Exception.Create(Translate('ERR_COMP_DESTROY', [FName]));
      if Component.Destroying then
        raise Exception.Create(Translate('ERR_COMP_DESTROY', [Component.Name]));
      if (FNotifications = nil) then
        FNotifications := TObjectList.Create(False);
      if (FNotifications.IndexOf(Component) = -1) then
      begin
        FNotifications.Add(Component);
        Component.Register(Self);
      end;
    finally
      FRegistering := False;
    end;
  end;
end;

procedure TComponent.UnRegister(Component: TComponent);
begin
  if (not FUnRegistering) and Assigned(FNotifications) then
  begin
    FUnRegistering := True;
    try
      Component.UnRegister(Self);
      FNotifications.Remove(Component);
    finally
      FUnRegistering := False;
    end;
  end;
end;

function TComponent.Notification(Sender: TComponent; ID: Integer; Data:
  TObject): Boolean;
begin
  Result := False;
  case ID of
    cmRemoveComp:
      begin
        if Assigned(Sender) then
          UnRegister(Sender);
      end;
  end;
end;

procedure TComponent.Notify(ID: Integer; Data: TObject = nil);
var
  I: Integer;
  TempCount: Integer;
begin
  if (not FNotifying) and Assigned(FNotifications) then
  begin
    FNotifying := True;
    try
      I := 0;
      TempCount := FNotifications.Count;
      while (I < TempCount) do
      begin
        { If the message was handled (returned True), then stop notifying }
        if TComponent(FNotifications[I]).Notification(Self, ID, Data) then
          Break
            { Need this to handle the possibility that the current component being
            notified is unregistered in response to the notification !!! }
        else if (FNotifications.Count = TempCount) then
          Inc(I);
        TempCount := FNotifications.Count;
      end;
    finally
      FNotifying := False;
    end;
  end;
end;

procedure TComponent.SetName(const Value: TComponentName);
begin
  if (Value <> FName) then
  begin
    FName := Value;
    NameChanged;
  end;
end;

function TComponent.GetIsInitializing: Boolean;
begin
  Result := FInitializing;
  if (not Result) and Assigned(FOwner) then
    Result := FOwner.IsInitializing;
end;

function TComponent.GetIsLoading: Boolean;
begin
  Result := Loading;
  if (not Result) and Assigned(FOwner) then
    Result := FOwner.IsLoading;
end;

procedure TComponent.Initialize;
begin
  BeforeInitialize;
  try
    InitializeProperties;
  finally
    AfterInitialize;
  end;
end;

procedure TComponent.InitializeProperties;
begin
end;

procedure TComponent.BeforeInitialize;
begin
  FInitializing := True;
end;

procedure TComponent.AfterInitialize;
begin
  { The IDE will reset this variable at design-time after loading
    all component properties and owned components !!! }
{$IFNDEF DESIGN}
  FInitializing := False;
{$ENDIF}
end;

procedure TComponent.NameChanged;
begin
  Notify(cmCompNameChanged);
end;

function TComponent.GetComponentCount: Integer;
begin
  Result := 0;
  if Assigned(FComponents) then
    Result := FComponents.Count;
end;

function TComponent.GetComponent(Value: Integer): TComponent;
begin
  Result := nil;
  if Assigned(FComponents) and (Value >= 0) and (Value < FComponents.Count) then
    Result := TComponent(FComponents[Value]);
end;

function TComponent.FindComponent(const Value: string; Recurse: Boolean =
  False): TComponent;
var
  I: Integer;
  TempComponent: TComponent;
begin
  Result := nil;
  if Assigned(FComponents) then
  begin
    for I := 0 to FComponents.Count - 1 do
    begin
      TempComponent := TComponent(FComponents[I]);
      if (TempComponent.Name <> '') then
      begin
        if SameText(TempComponent.Name, Value) then
        begin
          Result := TempComponent;
          Break;
        end;
      end;
    end;
    if (Result = nil) and Recurse then
    begin
      for I := 0 to FComponents.Count - 1 do
      begin
        TempComponent := TComponent(FComponents[I]);
        Result := TempComponent.FindComponent(Value, True);
        if Assigned(Result) then
          Break;
      end;
    end;
  end;
end;

procedure TComponent.AddComponent(Component: TComponent);
begin
  if (FComponents = nil) then
    FComponents := TObjectList.Create;
  FComponents.Add(Component);
end;

procedure TComponent.RemoveComponent(Component: TComponent);
begin
  if (not Destroying) then
  begin
    FComponents.Remove(Component, False);
    if (FComponents.Count = 0) then
    begin
      FComponents.Free;
      FComponents := nil;
    end;
  end;
end;

function TComponent.LoadProperty(AReader: TReader): Boolean;
var
  TempPropertyName: string;
  TempClass: TClass;
  TempComponent: TComponent;
  TempName: string;
begin
  Result := False;
  TempPropertyName := AReader.GetPropertyName;
  if (TempPropertyName <> '') then
  begin
    if SameText(TempPropertyName, PERSISTENT_LOAD_CLASSNAME) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      TempClass := ClassByName(AReader.ReadString);
      if Assigned(TempClass) then
      begin
        TempComponent :=
          TComponentClass(TempClass).Create(TComponent(AReader.RootComponent));
        TempComponent.Load(AReader);
      end;
    end
    else if SameText(TempPropertyName, PERSISTENT_LOAD_NAME) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      TempName := AReader.ReadString;
      SetProperty(TempPropertyName, TempName);
      AReader.RootComponent.SetInstance(TempName, Self);
    end
    else if SameText(TempPropertyName, PERSISTENT_LOAD_PROPERTIES) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      LoadObject(AReader);
    end
    else if SameText(TempPropertyName, PERSISTENT_LOAD_COMPONENTS) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      LoadArray(AReader);
    end
    else
      Result := inherited LoadProperty(AReader);
  end;
end;

{ TAbstractList }

procedure TAbstractList.HandleChanges;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

procedure TAbstractList.DoChanged;
begin
  if (FUpdateCount = 0) then
    HandleChanges
  else
    FUpdated := True;
end;

procedure TAbstractList.BeginUpdate;
begin
  Inc(FUpdateCount);
end;

procedure TAbstractList.EndUpdate;
begin
  if (FUpdateCount > 0) then
  begin
    Dec(FUpdateCount);
    if (FUpdateCount = 0) and FUpdated then
    begin
      FUpdated := False;
      HandleChanges;
    end;
  end;
end;

procedure TAbstractList.Load(AReader: TReader);
begin
  BeginUpdate;
  try
    inherited Load(AReader);
  finally
    EndUpdate;
  end;
end;

{ TObjectList }

constructor TObjectList.Create;
begin
  inherited Create;
end;

constructor TObjectList.Create(AOwnsObjects: Boolean);
begin
  inherited Create;
  FOwnsObjects := AOwnsObjects;
end;

destructor TObjectList.Destroy;
begin
  FDestroying := True;
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
      TempObject := FObjects[FCount - 1];
      FObjects[FCount - 1] := nil;
      Dec(FCount);
      if FOwnsObjects then
        TempObject.Free;
    end;
  finally
    FObjects.SetLength(0);
    FCount := 0;
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
        for I := FCount - 1 downto Value do
        begin
          FObjects[I].Free;
          FObjects[I] := nil;
        end;
      end;
      FObjects.SetLength(Value);
    end
    else if (Value > FCount) then
    begin
      FObjects.SetLength(Value);
      for I := FCount to Value - 1 do
        FObjects[I] := nil;
    end;
    FCount := Value;
    DoChanged;
  end;
end;

function TObjectList.AddObject(NewObject: TObject): Integer;
begin
  Result := FCount;
  Inc(FCount);
  FObjects.SetLength(FCount);
  FObjects[FCount - 1] := NewObject;
  DoChanged;
end;

procedure TObjectList.InsertObject(InsertPos: Integer; NewObject: TObject);
begin
  { This is done to initialize the array !! }
  FObjects.SetLength(FCount);
  InsertArray(NewObject, Variant(FObjects), InsertPos);
  Inc(FCount);
  DoChanged;
end;

procedure TObjectList.DeleteObject(DeletePos: Integer; FreeOwnedObject: Boolean
  = True);
var
  TempObject: TObject;
begin
  TempObject := FObjects[DeletePos];
  try
    if FOwnsObjects and FreeOwnedObject then
      TempObject.Free;
    //Delete(FObjects,DeletePos,1);
    DeleteArray(Variant(FObjects), DeletePos, 1);
  finally
    Dec(FCount);
    DoChanged;
  end;
end;

procedure TObjectList.CheckIndex(Index: Integer);
begin
  if (Index < 0) or (Index >= FCount) then
    raise Exception.Create(Translate('ERR_LIST_BOUNDS', [IntToStr(Index)]));
end;

function TObjectList.GetObject(Index: Integer): TObject;
begin
  CheckIndex(Index);
  Result := FObjects[Index];
end;

procedure TObjectList.SetObject(Index: Integer; AObject: TObject);
begin
  CheckIndex(Index);
  if (AObject <> FObjects[Index]) then
  begin
    FObjects[Index] := AObject;
    DoChanged;
  end;
end;

function TObjectList.IndexOf(AObject: TObject): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to FCount - 1 do
  begin
    if (FObjects[I] = AObject) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

function TObjectList.Add(AObject: TObject): Integer;
begin
  Result := AddObject(AObject);
end;

procedure TObjectList.Insert(Index: Integer; AObject: TObject);
begin
  if (Index < 0) or (FCount = 0) then
    Index := 0
  else if (Index > FCount) then
    Index := (FCount - 1);
  InsertObject(Index, AObject);
end;

procedure TObjectList.Delete(Index: Integer; FreeOwnedObject: Boolean = True);
begin
  if (not FDestroying) then
  begin
    CheckIndex(Index);
    DeleteObject(Index, FreeOwnedObject);
  end;
end;

function TObjectList.Remove(AObject: TObject; FreeOwnedObject: Boolean = True):
  Integer;
begin
  if FDestroying then
    Result := -1
  else
  begin
    Result := IndexOf(AObject);
    if (Result <> -1) then
      DeleteObject(Result, FreeOwnedObject);
  end;
end;

function TObjectList.First: TObject;
begin
  Result := nil;
  if (FCount > 0) then
    Result := FObjects[0];
end;

function TObjectList.Prior(AObject: TObject; Wrap: Boolean = False): TObject;
var
  I: Integer;
begin
  Result := nil;
  I := IndexOf(AObject);
  if (I <> -1) then
  begin
    if (I > 0) then
      Result := FObjects[I - 1]
    else if Wrap and (FCount > 0) then
      Result := FObjects[FCount - 1];
  end;
end;

function TObjectList.Next(AObject: TObject; Wrap: Boolean = False): TObject;
var
  I: Integer;
begin
  Result := nil;
  I := IndexOf(AObject);
  if (I <> -1) then
  begin
    if (I<(FCount - 1)) then
      Result := FObjects[I + 1]
    else if Wrap and (FCount > 0) then
      Result := FObjects[0];
  end;
end;

function TObjectList.Last: TObject;
begin
  Result := nil;
  if (FCount > 0) then
    Result := FObjects[FCount - 1];
end;

procedure TObjectList.Queue(AObject: TObject);
begin
  AddObject(AObject);
end;

function TObjectList.Dequeue: TObject;
begin
  Result := First;
  if Assigned(Result) then
    DeleteObject(0, False);
end;

procedure TObjectList.Requeue(AObject: TObject);
begin
  InsertObject(0, AObject);
end;

procedure TObjectList.Push(AObject: TObject);
begin
  AddObject(AObject);
end;

function TObjectList.Pop: TObject;
begin
  Result := Last;
  if Assigned(Result) then
    DeleteObject((FCount - 1), False);
end;

procedure TObjectList.Exchange(Source: Integer; Dest: Integer);
var
  TempObject: TObject;
begin
  CheckIndex(Source);
  CheckIndex(Dest);
  TempObject := FObjects[Source];
  FObjects[Source] := FObjects[Dest];
  FObjects[Dest] := TempObject;
  DoChanged;
end;

procedure TObjectList.Move(Source: Integer; Dest: Integer);
var
  TempObject: TObject;
begin
  CheckIndex(Source);
  if (Dest <> Source) then
  begin
    TempObject := FObjects[Source];
    Delete(Source, False);
    Insert(Dest, TempObject);
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
      for I := 0 to AList.Count - 1 do
        Add(AList[I]);
      for I := AList.Count - 1 downto 0 do
        AList.Delete(I, False);
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
    if FSorted then
      Sort;
  end;
end;

function TObjectList.SortCompare(L, R: TObject): Integer;
begin
  Result := CMP_LESS;
end;

function TObjectList.SortCompare(L: TObject; const R: string): Integer;
begin
  Result := CMP_LESS;
end;

procedure TObjectList.SortObjects(L, R: Integer);
var
  I: Integer;
  J: Integer;
  TempCompareObject: TObject;
  TempObject: TObject;
begin
  repeat
    I := L;
    J := R;
    TempCompareObject := FObjects[(L + R) shr 1];
    repeat
      while (SortCompare(FObjects[I], TempCompareObject) = CMP_LESS) do
        Inc(I);
      while (SortCompare(FObjects[J], TempCompareObject) = CMP_GREATER) do
        Dec(J);
      if (I <= J) then
      begin
        if (I <> J) then
        begin
          TempObject := FObjects[I];
          FObjects[I] := FObjects[J];
          FObjects[J] := TempObject;
        end;
        Inc(I);
        Dec(J);
      end;
    until (I > J);
    if (L < J) then
      SortObjects(L, J);
    L := I;
  until (I >= R);
end;

procedure TObjectList.Sort;
begin
  if (FCount > 1) then
    SortObjects(0, FCount - 1);
end;

function TObjectList.Find(const Value: string; NearestMatch: Boolean = False):
  Integer;
var
  I: Integer;
  J: Integer;
  TempResult: Integer;
begin
  Result := -1;
  if (not FSorted) then
    raise Exception.Create(Translate('ERR_LIST_SORT'));
  if (FCount > 0) then
  begin
    TempResult := CMP_LESS;
    I := 0;
    J := (FCount - 1);
    while (I <= J) do
    begin
      Result := ((I + J) div 2);
      TempResult := SortCompare(FObjects[Result], Value);
      case TempResult of
        CMP_LESS:
          I := (Result + 1);
        CMP_GREATER:
          J := (Result - 1);
        CMP_EQUAL:
          Break;
      end;
    end;
    if (TempResult <> CMP_EQUAL) and (not NearestMatch) then
      Result := -1;
  end;
end;

{ TCollectionItem }

constructor TCollectionItem.Create(ACollection: TCollection);
begin
  if (ACollection = nil) then
    InvalidCollectionError;
  inherited Create;
  FCollection := ACollection;
end;

procedure TCollectionItem.InvalidCollectionError;
begin
  raise Exception.Create(Translate('ERR_COLLECTION_OWNER'));
end;

procedure TCollectionItem.Initialize;
begin
  FName := ClassName + IntToStr(FID);
end;

procedure TCollectionItem.ValidateName(const Value: TCollectionItemName);
begin
end;

procedure TCollectionItem.SetName(const Value: TCollectionItemName);
begin
  FCollection.DoChanging;
  ValidateName(Value);
  FName := Value;
  FCollection.ItemsChanged(Self);
end;

procedure TCollectionItem.SetIndex(Value: Integer);
begin
  FCollection.Move(FIndex, Value);
end;

procedure TCollectionItem.UpdateID(Value: Integer);
begin
  FID := Value;
end;

procedure TCollectionItem.UpdateName(const Value: TCollectionItemName);
begin
  FName := Value;
end;

procedure TCollectionItem.UpdateIndex(Value: Integer);
begin
  FIndex := Value;
end;

{ TCollection }

constructor TCollection.Create(AItemClass: TCollectionItemClass);
begin
  inherited Create;
  FItemClass := AItemClass;
  FItems := TObjectList.Create;
  FItems.OnChanged := ItemsChanged;
end;

destructor TCollection.Destroy;
begin
  FItems.Free;
  FItems := nil;
  inherited Destroy;
end;

procedure TCollection.BeforeLoad;
begin
  inherited BeforeLoad;
  Clear;
end;

function TCollection.LoadProperty(AReader: TReader): Boolean;
var
  TempPropertyName: string;
begin
  Result := False;
  TempPropertyName := AReader.GetPropertyName;
  if (TempPropertyName <> '') then
  begin
    if SameText(TempPropertyName, PERSISTENT_LOAD_ITEMS) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      LoadArray(AReader);
    end
    else
      Result := inherited LoadProperty(AReader);
  end;
end;

function TCollection.LoadArrayElement(AReader: TReader): Boolean;
begin
  Result := Add.LoadArrayElement(AReader);
end;

procedure TCollection.Save(AWriter: TWriter);
var
  TempCount: Integer;
  I: Integer;
begin
  BeforeSave;
  AWriter.BeginObject;
  TempCount := FItems.Count;
  AWriter.BeginNewLine;
  AWriter.IntegerProperty(PERSISTENT_LOAD_COUNT, TempCount);
  AWriter.BeginNewLine;
  AWriter.PropertyName(PERSISTENT_LOAD_ITEMS);
  AWriter.BeginArray(TempCount > 0);
  AWriter.IncIndent;
  for I := 0 to TempCount - 1 do
  begin
    if (I > 0) then
      AWriter.Separator;
    AWriter.NewLine;
    GetItem(I).Save(AWriter);
  end;
  AWriter.EndArray(TempCount > 0);
  AWriter.DecIndent;
  SaveProperties(AWriter);
  AWriter.EndObject;
  AfterSave;
end;

procedure TCollection.UpdateIndexes;
var
  I: Integer;
begin
  for I := 0 to FItems.Count - 1 do
    TCollectionItem(FItems[I]).UpdateIndex(I);
end;

procedure TCollection.ItemsChanged(Sender: TObject);
begin
  DoChanged;
end;

function TCollection.GetCount: Integer;
begin
  Result := FItems.Count;
end;

function TCollection.GetItem(AIndex: Integer): TCollectionItem;
begin
  Result := TCollectionItem(FItems[AIndex]);
end;

function TCollection.GetItem_(const AName: string): TCollectionItem;
var
  I: Integer;
begin
  I := IndexOf(AName);
  if (I <> -1) then
    Result := TCollectionItem(Items[I])
  else
    Result := nil;
end;

function TCollection.IndexOf(const AName: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  if (Count > 0) then
  begin
    for I := 0 to Count - 1 do
    begin
      if SameText(TCollectionItem(Items[I]).Name, AName) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TCollection.GetUpdateCount: Integer;
begin
  Result := FItems.UpdateCount;
end;

procedure TCollection.BeginUpdate;
begin
  FItems.BeginUpdate;
end;

procedure TCollection.EndUpdate;
begin
  FItems.EndUpdate;
end;

procedure TCollection.DoChanging;
begin
end;

procedure TCollection.DoChanged;
begin
  if Assigned(FOnChanged) then
    FOnChanged(Self);
end;

function TCollection.FindItemByID(AID: Integer): TCollectionItem;
var
  I: Integer;
  TempItem: TCollectionItem;
begin
  Result := nil;
  for I := 0 to FItems.Count - 1 do
  begin
    TempItem := TCollectionItem(FItems[I]);
    if (TempItem.ID = AID) then
    begin
      Result := TempItem;
      Break;
    end;
  end;
end;

function TCollection.IndexOf(AItem: TCollectionItem): Integer;
begin
  Result := FItems.IndexOf(AItem);
end;

procedure TCollection.Clear;
begin
  DoChanging;
  FItems.Clear;
end;

function TCollection.CreateItem: TCollectionItem;
begin
  Result := FItemClass.Create(Self);
  Result.UpdateID(FNextID);
  Inc(FNextID);
  Result.Initialize;
end;

function TCollection.Add: TCollectionItem;
begin
  DoChanging;
  Result := CreateItem;
  FItems.Add(Result);
  { Always update indexes, even if in a BeginUpdate/EndUpdate block !!!! }
  UpdateIndexes;
end;

function TCollection.Insert(AIndex: Integer): TCollectionItem;
begin
  DoChanging;
  Result := CreateItem;
  FItems.Insert(AIndex, Result);
  { Always update indexes, even if in a BeginUpdate/EndUpdate block !!!! }
  UpdateIndexes;
end;

procedure TCollection.Delete(AIndex: Integer);
begin
  DoChanging;
  FItems.Delete(AIndex);
  { Always update indexes, even if in a BeginUpdate/EndUpdate block !!!! }
  UpdateIndexes;
end;

procedure TCollection.Move(Source: Integer; Dest: Integer);
begin
  DoChanging;
  FItems.Move(Source, Dest);
  { Always update indexes, even if in a BeginUpdate/EndUpdate block !!!! }
  UpdateIndexes;
end;

function TCollection.GetNames: array of string;
var
  I: Integer;
begin
  Result.SetLength(FItems.Count);
  for I := 0 to FItems.Count - 1 do
    Result[I] := TCollectionItem(FItems[I]).Name;
end;

{ TStrings }

procedure TStrings.BeforeLoad;
begin
  inherited BeforeLoad;
  Clear;
end;

function TStrings.LoadProperty(AReader: TReader): Boolean;
var
  TempPropertyName: string;
begin
  Result := False;
  TempPropertyName := AReader.GetPropertyName;
  if (TempPropertyName <> '') then
  begin
    if SameText(TempPropertyName, PERSISTENT_LOAD_STRINGS) then
    begin
      Result := True;
      AReader.SkipPropertyName;
      AReader.SkipPropertySeparator;
      LoadArray(AReader);
    end
    else
      Result := inherited LoadProperty(AReader);
  end;
end;

function TStrings.LoadArrayElement(AReader: TReader): Boolean;
begin
  Add(AReader.ReadString);
  Result := True;
end;

procedure TStrings.Save(AWriter: TWriter);
var
  TempCount: Integer;
  I: Integer;
begin
  BeforeSave;

  AWriter.BeginObject;
  TempCount := Count;
  AWriter.BeginNewLine;
  AWriter.IntegerProperty(PERSISTENT_LOAD_COUNT, TempCount);
  AWriter.BeginNewLine;
  AWriter.PropertyName(PERSISTENT_LOAD_STRINGS);
  AWriter.BeginArray(TempCount > 0);
  AWriter.IncIndent;
  for I := 0 to TempCount - 1 do
  begin
    if (I > 0) then
      AWriter.Separator;
    AWriter.NewLine;
    //INTERNAL ERRR:
    //AWriter.StringValue(GetString(I));
    AWriter.StringValue('warleyalex');
  end;
  AWriter.EndArray(TempCount > 0);
  AWriter.DecIndent;
  SaveProperties(AWriter);
  AWriter.EndObject;
  AfterSave;
end;

procedure TStrings.CheckIndex(Index: Integer);
begin
  if (Index < 0) or (Index >= Count) then
    raise Exception.Create(Translate('ERR_LIST_BOUNDS', [IntToStr(Index)]));
end;

procedure TStrings.SetString(Index: Integer; const Value: string);
begin
  DoChanged;
end;

function TStrings.ExtractName(const Value: string): string;
var
  TempPos: Integer;
begin
  TempPos := Pos(FNameValueSeparator, Value);
  if (TempPos <> 0) then
    Result := Copy(Value, 1, (TempPos - 1))
  else
    Result := '';
end;

function TStrings.ExtractValue(const Value: string): string;
var
  TempPos: Integer;
begin
  TempPos := Pos(FNameValueSeparator, Value);
  if (TempPos <> 0) then
    Result := Copy(Value, (TempPos + 1), Length(Value))
  else
    Result := '';
end;

function TStrings.GetName(Index: Integer): string;
begin
  Result := ExtractName(GetString(Index));
end;

function TStrings.GetValue(const Name: string): string;
var
  I: Integer;
begin
  I := IndexOfName(Name);
  if (I >= 0) then
    Result := ExtractValue(GetString(I))
  else
    Result := '';
end;

procedure TStrings.SetValue(const Name, Value: string);
var
  I: Integer;
  TempString: string;
begin
  I := IndexOfName(Name);
  if (Value <> '') then
  begin
    TempString := (Name + FNameValueSeparator + Value);
    if (I < 0) then
      Add(TempString)
    else
      SetString(I, TempString);
  end
  else
  begin
    if (I >= 0) then
      Self.Delete(I);
  end;
end;

function TStrings.GetValueFromIndex(Index: Integer): string;
var
  TempString: string;
  TempName: string;
begin
  if (Index >= 0) then
  begin
    TempString := GetString(Index);
    TempName := ExtractName(TempString);
    if (TempName <> '') then
      Result := ExtractValue(TempString)
    else
      Result := '';
  end
  else
    Result := '';
end;

procedure TStrings.SetValueFromIndex(Index: Integer; const Value: string);
var
  TempString: string;
begin
  if (Value <> '') then
  begin
    TempString := (Names[Index] + FNameValueSeparator + Value);
    if (Index < 0) then
      Add(TempString)
    else
      SetString(Index, TempString);
  end
  else
  begin
    if (Index >= 0) then
      Self.Delete(Index);
  end;
end;

function TStrings.IndexOf(const Value: string; StartIndex: Integer = 0;
  PartialMatch: Boolean = False): Integer;
var
  I: Integer;
begin
  Result := -1;
  if PartialMatch and (Value <> '') then
  begin
    for I := StartIndex to Count - 1 do
    begin
      if SameText(Copy(GetString(I), 1, Length(Value)), Value) then
      begin
        Result := I;
        Break;
      end;
    end;
  end
  else
  begin
    for I := StartIndex to Count - 1 do
    begin
      if SameText(GetString(I), Value) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TStrings.IndexOfName(const Name: string; StartIndex: Integer = 0;
  PartialMatch: Boolean = False): Integer;
var
  I: Integer;
begin
  Result := -1;
  if PartialMatch and (Name <> '') then
  begin
    for I := StartIndex to Count - 1 do
    begin
      if SameText(Copy(ExtractName(GetString(I)), 1, Length(Name)), Name) then
      begin
        Result := I;
        Break;
      end;
    end;
  end
  else
  begin
    for I := StartIndex to Count - 1 do
    begin
      if SameText(ExtractName(GetString(I)), Name) then
      begin
        Result := I;
        Break;
      end;
    end;
  end;
end;

function TStrings.IndexOfValue(const Value: string): Integer;
var
  I: Integer;
begin
  Result := -1;
  for I := 0 to Count - 1 do
  begin
    if SameText(ExtractValue(GetString(I)), Value) then
    begin
      Result := I;
      Break;
    end;
  end;
end;

procedure TStrings.Assign(Value: TStrings);
var
  I: Integer;
begin
  BeginUpdate;
  try
    Clear;
    for I := 0 to Value.Count - 1 do
      Add(Value[I]);
  finally
    EndUpdate;
  end;
end;

function TStrings.Add(const Value: string): Integer;
begin
  Result := AddString(Value);
  DoChanged;
end;

procedure TStrings.Clear;
begin
  DeleteAllStrings;
  DoChanged;
end;

procedure TStrings.Insert(Index: Integer; const Value: string);
begin
  InsertString(Index, Value);
  DoChanged;
end;

procedure TStrings.Delete(Index: Integer);
begin
  DeleteString(Index);
  DoChanged;
end;

function TStrings.Remove(const Value: string): Integer;
begin
  Result := IndexOf(Value);
  if (Result <> -1) then
  begin
    DeleteString(Result);
    DoChanged;
  end;
end;

function TStrings.GetText: string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Count - 1 do
    Result := Result + GetString(I) + FLineSeparator;
end;

procedure TStrings.SetText(const Value: string);
var
  I: Integer;
  TempCount: Integer;
  TempStrings: Variant; // TStringsArray;
begin
  DeleteAllStrings;
  if (Value <> '') then
  begin
    if (FLineSeparator <> '') then
      TempStrings := Split(Value, FLineSeparator)
    else
    begin
      TempStrings.SetLength(1);
      TempStrings[0] := Value;
    end;
  end
  else
    TempStrings.SetLength(0);
  //if Assigned(TempStrings) then
  if (TempStrings) then
  begin
    TempCount := Length(TempStrings);
    if (TempCount > 0) and (TempStrings[TempCount - 1] = '') then
      Dec(TempCount);
    for I := 0 to TempCount - 1 do
      AddString(TempStrings[I]);
  end;
  DoChanged;
end;

{ TStringList }

function TStringList.GetCount: Integer;
begin
  Result := FCount;
end;

procedure TStringList.SetCount(Value: Integer);
var
  I: Integer;
begin
  if (Value <> FCount) then
  begin
    FStrings.SetLength(Value);
    if (Value > FCount) then
    begin
      for I := FCount to Value - 1 do
        FStrings[I] := '';
    end;
    FCount := Value;
    DoChanged;
  end;
end;

procedure TStringList.HandleChanges;
begin
  if FSorted then
    Sort;
  inherited HandleChanges;
end;

function TStringList.AddString(const Value: string): Integer;
begin
  Result := FCount;
  Inc(FCount);
  FStrings.SetLength(FCount);
  FStrings[FCount - 1] := Value;
end;

procedure TStringList.InsertString(Index: Integer; const Value: string);
begin
  //if (not Assigned(FStrings)) then
  if (not Variant(FStrings)) then
    FStrings.SetLength(0);
  InsertArray(Value, Variant(FStrings), Index);
  Inc(FCount);
end;

procedure TStringList.DeleteString(Index: Integer);
begin
  CheckIndex(Index);
  try
    DeleteArray(Variant(FStrings), Index, 1);
  finally
    Dec(FCount);
  end;
end;

procedure TStringList.DeleteAllStrings;
begin
  FStrings.SetLength(0);
  FCount := 0;
end;

function TStringList.GetString(Index: Integer): string;
begin
  CheckIndex(Index);
  Result := FStrings[Index];
end;

procedure TStringList.SetString(Index: Integer; const Value: string);
begin
  CheckIndex(Index);
  FStrings[Index] := Value;
  DoChanged;
end;

function TStringList.GetText: string;
begin
  if (FCount > 0) then
    Result := Join(Variant(FStrings), LineSeparator)
  else
    Result := '';
end;

procedure TStringList.SetText(const Value: string);
/*
    function Split(a: variant; b, c: variant = nil): Variant;
  begin
    if (c) then
      result := a.split(b, c)
    else if (b) then
      result := a.split(b)
    else
      result := a.split("");
  end;
  */

begin
  if (Value <> '') then
  begin
    if (LineSeparator <> '') then
      FStrings := [Split(Value, LineSeparator)]
    else
    begin
      FStrings.SetLength(1);
      FStrings[0] := Value;
    end;
  end
  else
    FStrings.SetLength(0);
  //if Assigned(FStrings) then
  if (FStrings.Count > 0) then
  begin
    FCount := Length(FStrings);
    if (FCount > 0) and (FStrings[FCount - 1] = '') then
    begin
      Dec(FCount);
      FStrings.SetLength(FCount);
    end;
  end
  else
    FCount := 0;
  DoChanged;
end;

procedure TStringList.SetSorted(Value: Boolean);
begin
  if (Value <> FSorted) then
  begin
    FSorted := Value;
    if FSorted then
      Sort;
  end;
end;

procedure TStringList.SetSortCaseInsensitive(Value: Boolean);
begin
  if (Value <> FSortCaseInsensitive) then
  begin
    FSortCaseInsensitive := Value;
    if FSorted then
      Sort;
  end;
end;

procedure TStringList.SetSortLocaleInsensitive(Value: Boolean);
begin
  if (Value <> FSortLocaleInsensitive) then
  begin
    FSortLocaleInsensitive := Value;
    if FSorted then
      Sort;
  end;
end;

function TStringList.SortCompare(const L, R: string): Integer;
begin
  if FSortLocaleInsensitive then
  begin
    if FSortCaseInsensitive then
      Result := CompareStr(L, R)
    else
      Result := CompareText(L, R);
  end
  else
  begin
    if FSortCaseInsensitive then
      Result := LocaleCompareStr(L, R)
    else
      Result := LocaleCompareText(L, R);
  end;
end;

procedure TStringList.SortStrings(L, R: Integer);
var
  I: Integer;
  J: Integer;
  TempCompareString: string;
  TempString: string;
begin
  repeat
    I := L;
    J := R;
    TempCompareString := FStrings[(L + R) shr 1];
    repeat
      while (SortCompare(FStrings[I], TempCompareString) = CMP_LESS) do
        Inc(I);
      while (SortCompare(FStrings[J], TempCompareString) = CMP_GREATER) do
        Dec(J);
      if (I <= J) then
      begin
        if (I <> J) then
        begin
          TempString := FStrings[I];
          FStrings[I] := FStrings[J];
          FStrings[J] := TempString;
        end;
        Inc(I);
        Dec(J);
      end;
    until (I > J);
    if (L < J) then
      SortStrings(L, J);
    L := I;
  until (I >= R);
end;

procedure TStringList.Sort;
begin
  if (FCount > 1) then
    SortStrings(0, FCount - 1);
end;

function TStringList.Find(const Value: string; NearestMatch: Boolean = False):
  Integer;
var
  I: Integer;
  J: Integer;
  TempResult: Integer;
begin
  Result := -1;
  if (not FSorted) then
    raise Exception.Create(Translate('ERR_LIST_SORT'));
  if (FCount > 0) then
  begin
    TempResult := CMP_LESS;
    I := 0;
    J := (FCount - 1);
    while (I <= J) do
    begin
      Result := ((I + J) div 2);
      TempResult := SortCompare(FStrings[Result], Value);
      case TempResult of
        CMP_LESS:
          I := (Result + 1);
        CMP_GREATER:
          J := (Result - 1);
        CMP_EQUAL:
          Break;
      end;
    end;
    if (TempResult <> CMP_EQUAL) and (not NearestMatch) then
      Result := -1;
  end;
end;

{ TSet }
//constructor TSet.Create(const AValues: TIntegerArray);

constructor TSet.Create(AValues: TIntegerArray);
begin
  inherited Create;
  Initialize(AValues);
end;

destructor TSet.Destroy;
begin
  FValues := nil;
  inherited Destroy;
end;

procedure TSet.RangeError(Value: Integer);
begin
  raise Exception.Create(Translate('ERR_SET_RANGE', [IntToStr(Value)]));
end;

function TSet.GetCount: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to FLength - 1 do
  begin
    if FValues[I] then
      Inc(Result);
  end;
end;

function TSet.GetMax: Integer;
begin
  Result := (FLength - 1);
end;

procedure TSet.SetLength(Value: Integer);
var
  I: Integer;
begin
  if (Value > FLength) then
  begin
    FValues.SetLength(Value);
    for I := FLength to Value - 1 do
      FValues[I] := False;
    FLength := Value;
  end;
end;

function TSet.IsEmpty: Boolean;
var
  I: Integer;
begin
  Result := True;
  for I := 0 to FLength - 1 do
  begin
    if (not FValues[I]) then
    begin
      Result := False;
      Break;
    end;
  end;
end;

procedure TSet.Empty;
var
  I: Integer;
begin
  for I := 0 to FLength - 1 do
    FValues[I] := False;
end;

procedure TSet.Initialize(const AValues: TIntegerArray);
var
  I: Integer;
begin
  Empty;
  for I := 0 to Length(AValues) - 1 do
    Add(AValues[I]);
end;

function TSet.Add(Value: Integer): Boolean;
begin
  Result := False;
  if (Value >= 0) and (Value < HIGH_INT) then
  begin
    Result := (not Exists(Value));
    if Result then
    begin
      SetLength(Value + 1);
      FValues[Value] := True;
    end;
  end
  else
    RangeError(Value);
end;

function TSet.Remove(Value: Integer): Boolean;
begin
  Result := Exists(Value);
  if Result then
    FValues[Value] := False;
end;

function TSet.Exists(Value: Integer): Boolean;
begin
  if (Value >= 0) and (Value < FLength) then
    Result := FValues[Value]
  else
    Result := False;
end;

procedure TSet.Assign(Value: TSet);
var
  I: Integer;
begin
  SetLength(Value.Length);
  for I := 0 to FLength - 1 do
    FValues[I] := Value.Values[I];
end;

procedure TSet.All(ACount: Integer);
var
  I: Integer;
begin
  SetLength(ACount);
  for I := 0 to FLength - 1 do
    FValues[I] := True;
end;

procedure TSet.Range(AStart, AEnd: Integer);
var
  I: Integer;
begin
  if (AStart < 0) then
    RangeError(AStart);
  if (AEnd < 0) or (AEnd < AStart) then
    RangeError(AEnd);
  SetLength(AEnd + 1);
  for I := AStart to AEnd do
    FValues[I] := True;
end;

procedure TSet.Union(Value: TSet);
  function Max(A, B: Double): Double; overload; external "max";
var
  I: Integer;
begin
  Self.SetLength(Max(FLength, Value.Length));
  for I := 0 to FLength - 1 do
    FValues[I] := (FValues[I] or Value.Values[I]);
end;

procedure TSet.&except(Value: TSet);
  function Max(A, B: Double): Double; overload; external "max";
var
  I: Integer;
begin
  Self.SetLength(Max(FLength, Value.Length));
  for I := 0 to FLength - 1 do
    FValues[I] := (FValues[I] xor Value.Values[I]);
end;

procedure TSet.Intersect(Value: TSet);
  function Max(A, B: Double): Double; overload; external "max";
var
  I: Integer;
begin
  Self.SetLength(Max(FLength, Value.Length));
  for I := 0 to FLength - 1 do
    FValues[I] := (FValues[I] and Value.Values[I]);
end;

function TSet.Copy: TSet;
begin
  Result := TSet.Create;
  Result.Assign(Self);
end;

{ TDataValue }

constructor TDataValue.Create(AValues: TDataValues = nil;
  AIndex: Integer = -1);
begin
  inherited Create;
  FValues := AValues;
  FIndex := AIndex;
end;

function TDataValue.GetName: string;
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueName(FIndex)
  else
    Result := '';
end;

function TDataValue.GetDataType: TDataType;
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueDataType(FIndex)
  else
    Result := dtUnknown;
end;

function TDataValue.GetLength: Integer {TDataType};
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueLength(FIndex)
  else
    Result := -1;
end;

function TDataValue.GetScale: Integer {TDataType};
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueScale(FIndex)
  else
    Result := -1;
end;

function TDataValue.GetDateTimeFormat: TDateTimeFormat;
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueDateTimeFormat(FIndex)
  else
    Result := dtfRaw;
end;

function TDataValue.GetLocalizeDateTime: Boolean;
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueLocalizeDateTime(FIndex)
  else
    Result := False;
end;

procedure TDataValue.CheckNotReadOnly;
begin
  if ReadOnly then
    raise Exception.Create(Translate('ERR_VALUE_READONLY', [Name]));
end;

function TDataValue.GetReadOnly: Boolean;
begin
  if Assigned(FValues) and (FIndex <> -1) then
    Result := FValues.GetValueReadOnly(FIndex)
  else
    Result := False;
end;

procedure TDataValue.NotifyChange;
begin
  if Assigned(FValues) and FValues.NotifyChanges and (FIndex <> -1) then
    FValues.ValueChanged(FIndex);
end;

procedure TDataValue.SetValue;
begin
  FNull := False;
  SetModified;
  NotifyChange;
end;

procedure TDataValue.Assign(Value: TDataValue);
begin
  if Value.Null then
  begin
    FNull := True;
    ClearValue;
  end
  else
  begin
    FNull := False;
    AssignValue(Value);
  end;
  FModified := Value.Modified;
end;

function TDataValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  if FNull and (not Value.Null) then
    Result := CMP_LESS
  else if (not FNull) and Value.Null then
    Result := CMP_GREATER
  else
    Result := CMP_EQUAL;
end;

procedure TDataValue.Clear;
begin
  CheckNotReadOnly;
  if (not FNull) then
  begin
    FNull := True;
    ClearValue;
    SetModified;
    NotifyChange;
  end;
end;

procedure TDataValue.SetModified;
begin
  if FValues.NotifyModified then
  begin
    FModified := True;
    FValues.SetModified;
  end;
end;

procedure TDataValue.ResetModified;
begin
  FModified := False;
end;

procedure TDataValue.Initialize;
begin
  FNull := True;
  ClearValue;
end;

function TDataValue.GetJSON: string;
begin
  Result := '"' + EscapeStr(Name) + '": ';
  if FNull then
    Result := Result + 'null'
  else
  begin
    case DataType of
      dtString, dtBlob:
        Result := Result + '"' + EscapeStr(AsString) + '"';
      dtBoolean:
        Result := Result + LowerCase(AsString);
      dtFloat:
        Result := Result + DoubleToStr(AsFloat);
      dtDate, dtTime, dtDateTime:
        Result := Result + IntToStr(AsInteger);
    else
      Result := Result + AsString;
    end;
  end;
end;

function TDataValue.GetAsDate: DateTime;
begin
  Result := GetAsDateTime;
end;

procedure TDataValue.SetAsDate(Value: DateTime);
begin
  SetAsDateTime(Value);
end;

function TDataValue.GetAsTime: DateTime;
begin
  Result := GetAsDateTime;
end;

procedure TDataValue.SetAsTime(Value: DateTime);
begin
  SetAsDateTime(Value);
end;

{ TStringValue }

procedure TStringValue.AssignValue(NewValue: TDataValue);
begin
  FValue := NewValue.AsString;
end;

procedure TStringValue.ClearValue;
begin
  FValue := '';
  //inherited ClearValue;
end;

function TStringValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
    Result := FValue;
end;

procedure TStringValue.SetAsString(const Value: string);
begin
  CheckNotReadOnly;
  if (Null or (Value <> FValue)) then
  begin
    FValue := Value;
    SetValue;
  end;
end;

function TStringValue.GetAsBoolean: Boolean;
begin
  Result := StrToBool(FValue);
end;

procedure TStringValue.SetAsBoolean(Value: Boolean);
begin
  SetAsString(BoolToStr(Value));
end;

function TStringValue.GetAsInteger: Integer;
begin
  Result := StrToInt(FValue);
end;

procedure TStringValue.SetAsInteger(Value: Integer);
begin
  SetAsString(IntToStr(Value));
end;

function TStringValue.GetAsFloat: Double;
begin
  Result := StrToFloat(FValue);
end;

procedure TStringValue.SetAsFloat(Value: Double);
begin
  SetAsString(FloatToStr(Value, Scale));
end;

function TStringValue.GetAsDate: DateTime;
begin
  case DateTimeFormat of
    dtfISO8601:
      Result := ISOStrToDateTime(FValue);
  else
    Result := StrToDate(FValue, (not LocalizeDateTime));
  end;
end;

procedure TStringValue.SetAsDate(Value: DateTime);
begin
  case DateTimeFormat of
    dtfISO8601:
      SetAsString(DateTimeToISOStr(Value));
  else
    SetAsString(DateToStr(Value, (not LocalizeDateTime)));
  end;
end;

function TStringValue.GetAsTime: DateTime;
begin
  case DateTimeFormat of
    dtfISO8601:
      Result := ISOStrToDateTime(FValue);
  else
    Result := StrToTime(FValue, (not LocalizeDateTime));
  end;
end;

procedure TStringValue.SetAsTime(Value: DateTime);
begin
  case DateTimeFormat of
    dtfISO8601:
      SetAsString(DateTimeToISOStr(Value));
  else
    SetAsString(TimeToStr(Value, (not LocalizeDateTime)));
  end;
end;

function TStringValue.GetAsDateTime: DateTime;
begin
  case DateTimeFormat of
    dtfISO8601:
      Result := ISOStrToDateTime(FValue);
  else
    Result := StrToDateTime(FValue, (not LocalizeDateTime));
  end;
end;

procedure TStringValue.SetAsDateTime(Value: DateTime);
begin
  case DateTimeFormat of
    dtfISO8601:
      SetAsString(DateTimeToISOStr(Value));
  else
    SetAsString(DateTimeToStr(Value, (not LocalizeDateTime)));
  end;
end;

function TStringValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  Result := inherited Compare(Value, CaseInsensitive, LocaleInsensitive);
  if (Result = CMP_EQUAL) then
  begin
    if LocaleInsensitive then
    begin
      if CaseInsensitive then
        Result := CompareText(FValue, Value.AsString)
      else
        Result := CompareStr(FValue, Value.AsString);
    end
    else
    begin
      if CaseInsensitive then
        Result := LocaleCompareText(FValue, Value.AsString)
      else
        Result := LocaleCompareStr(FValue, Value.AsString);
    end;
  end;
end;

{ TBooleanValue }

procedure TBooleanValue.AssignValue(NewValue: TDataValue);
begin
  FValue := NewValue.AsBoolean;
end;

procedure TBooleanValue.ClearValue;
begin
  FValue := False;
  //inherited ClearValue;
end;

function TBooleanValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
    Result := BoolToStr(FValue);
end;

procedure TBooleanValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
    SetAsBoolean(StrToBool(Value));
end;

function TBooleanValue.GetAsBoolean: Boolean;
begin
  Result := FValue;
end;

procedure TBooleanValue.SetAsBoolean(Value: Boolean);
begin
  CheckNotReadOnly;
  if (Null or (Value <> FValue)) then
  begin
    FValue := Value;
    SetValue;
  end;
end;

function TBooleanValue.GetAsInteger: Integer;
begin
  if FValue then
    Result := 1
  else
    Result := 0;
end;

procedure TBooleanValue.SetAsInteger(Value: Integer);
begin
  SetAsBoolean(Value > 0);
end;

function TBooleanValue.GetAsFloat: Double;
begin
  if FValue then
    Result := 1
  else
    Result := 0;
end;

procedure TBooleanValue.SetAsFloat(Value: Double);
begin
  SetAsBoolean(Value > 0);
end;

function TBooleanValue.GetAsDateTime: DateTime;
begin
  Result := {DateTime}(0);
  ConversionError(dtBoolean, dtDateTime);
end;

procedure TBooleanValue.SetAsDateTime(Value: DateTime);
begin
  ConversionError(dtDateTime, dtBoolean);
end;

function TBooleanValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  Result := inherited Compare(Value, CaseInsensitive);
  if (Result = CMP_EQUAL) then
  begin
    if (not FValue) and Value.AsBoolean then
      Result := CMP_LESS
    else if FValue and (not Value.AsBoolean) then
      Result := CMP_GREATER;
  end;
end;

{ TIntegerValue }

procedure TIntegerValue.AssignValue(NewValue: TDataValue);
begin
  FValue := NewValue.AsInteger;
end;

procedure TIntegerValue.ClearValue;
begin
  FValue := 0;
  //inherited ClearValue;
end;

function TIntegerValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
    Result := IntToStr(FValue);
end;

procedure TIntegerValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
    SetAsInteger(StrToInt(Value));
end;

function TIntegerValue.GetAsBoolean: Boolean;
begin
  Result := (FValue > 0);
end;

procedure TIntegerValue.SetAsBoolean(Value: Boolean);
begin
  if Value then
    SetAsInteger(1)
  else
    SetAsInteger(0);
end;

function TIntegerValue.GetAsInteger: Integer;
begin
  Result := FValue;
end;

procedure TIntegerValue.SetAsInteger(Value: Integer);
begin
  CheckNotReadOnly;
  if (Null or (Value <> FValue)) then
  begin
    FValue := Value;
    SetValue;
  end;
end;

function TIntegerValue.GetAsFloat: Double;
begin
  Result := FValue;
end;

procedure TIntegerValue.SetAsFloat(Value: Double);
begin
  SetAsInteger(Floor(Value));
end;

function TIntegerValue.GetAsDateTime: DateTime;
begin
  Result := DateTime(FValue);
end;

procedure TIntegerValue.SetAsDateTime(Value: DateTime);
begin
  SetAsInteger(Integer(Value));
end;

function TIntegerValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  Result := inherited Compare(Value, CaseInsensitive);
  if (Result = CMP_EQUAL) then
  begin
    if (FValue < Value.AsInteger) then
      Result := CMP_LESS
    else if (FValue > Value.AsInteger) then
      Result := CMP_GREATER;
  end;
end;

{ TDateTimeValue }

procedure TDateTimeValue.AssignValue(NewValue: TDataValue);
begin
  FValue := NewValue.AsDateTime;
end;

procedure TDateTimeValue.ClearValue;
begin
  FValue := DateTime(0);
  //inherited ClearValue;
end;

function TDateTimeValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        Result := DateTimeToISOStr(FValue);
    else
      Result := DateTimeToStr(FValue, (not LocalizeDateTime));
    end;
  end;
end;

procedure TDateTimeValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        SetAsDateTime(ISOStrToDateTime(Value));
    else
      SetAsDateTime(StrToDateTime(Value, (not LocalizeDateTime)));
    end;
  end;
end;

function TDateTimeValue.GetAsBoolean: Boolean;
begin
  Result := False;
  ConversionError(dtDateTime, dtBoolean);
end;

procedure TDateTimeValue.SetAsBoolean(Value: Boolean);
begin
  ConversionError(dtBoolean, dtDateTime);
end;

function TDateTimeValue.GetAsInteger: Integer;
begin
  Result := Integer(FValue);
end;

procedure TDateTimeValue.SetAsInteger(Value: Integer);
begin
  SetAsDateTime(DateTime(Value));
end;

function TDateTimeValue.GetAsFloat: Double;
begin
  Result := 0;
  ConversionError(dtDateTime, dtFloat);
end;

procedure TDateTimeValue.SetAsFloat(Value: Double);
begin
  ConversionError(dtFloat, dtDateTime);
end;

function TDateTimeValue.GetAsDateTime: DateTime;
begin
  Result := FValue;
end;

procedure TDateTimeValue.SetAsDateTime(Value: DateTime);
begin
  CheckNotReadOnly;
  if (Null or (Value <> FValue)) then
  begin
    FValue := Value;
    SetValue;
  end;
end;

function TDateTimeValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  Result := inherited Compare(Value, CaseInsensitive);
  if (Result = CMP_EQUAL) then
  begin
    if (FValue < Value.AsDateTime) then
      Result := CMP_LESS
    else if (FValue > Value.AsDateTime) then
      Result := CMP_GREATER;
  end;
end;

{ TDateValue }

function TDateValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        Result := DateTimeToISOStr(Value);
    else
      Result := DateToStr(Value, (not LocalizeDateTime));
    end;
  end;
end;

procedure TDateValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        SetAsDateTime(ISOStrToDateTime(Value));
    else
      SetAsDateTime(StrToDate(Value, (not LocalizeDateTime)));
    end;
  end;
end;

{ TTimeValue }

function TTimeValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        Result := DateTimeToISOStr(Value);
    else
      Result := TimeToStr(Value, (not LocalizeDateTime));
    end;
  end;
end;

procedure TTimeValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
  begin
    case DateTimeFormat of
      dtfISO8601:
        SetAsDateTime(ISOStrToDateTime(Value));
    else
      SetAsDateTime(StrToTime(Value, (not LocalizeDateTime)));
    end;
  end;
end;

{ TFloatValue }

procedure TFloatValue.AssignValue(NewValue: TDataValue);
begin
  FValue := NewValue.AsFloat;
end;

procedure TFloatValue.ClearValue;
begin
  FValue := 0;
  //inherited ClearValue;
end;

function TFloatValue.GetAsString: string;
begin
  if Null then
    Result := ''
  else
    Result := FloatToStr(FValue, Scale);
end;

procedure TFloatValue.SetAsString(const Value: string);
begin
  if (Value = '') then
    Clear
  else
    SetAsFloat(StrToFloat(Value));
end;

function TFloatValue.GetAsBoolean: Boolean;
begin
  Result := (FValue > 0);
end;

procedure TFloatValue.SetAsBoolean(Value: Boolean);
begin
  if Value then
    SetAsFloat(1)
  else
    SetAsFloat(0);
end;

function TFloatValue.GetAsInteger: Integer;
begin
  Result := Floor(FValue);
end;

procedure TFloatValue.SetAsInteger(Value: Integer);
begin
  SetAsFloat(Value);
end;

function TFloatValue.GetAsFloat: Double;
begin
  Result := FValue;
end;

procedure TFloatValue.SetAsFloat(Value: Double);
begin
  CheckNotReadOnly;
  if (Null or (Value <> FValue)) then
  begin
    FValue := Value;
    SetValue;
  end;
end;

function TFloatValue.GetAsDateTime: DateTime;
begin
  Result := DateTime(0);
  ConversionError(dtFloat, dtDateTime);
end;

procedure TFloatValue.SetAsDateTime(Value: DateTime);
begin
  ConversionError(dtDateTime, dtFloat);
end;

function TFloatValue.Compare(Value: TDataValue;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
begin
  Result := inherited Compare(Value, CaseInsensitive);
  if (Result = CMP_EQUAL) then
  begin
    if (FValue < Value.AsFloat) then
      Result := CMP_LESS
    else if (FValue > Value.AsFloat) then
      Result := CMP_GREATER;
  end;
end;

{ TDataValues }

constructor TDataValues.Create(AID: Integer; ACount: Integer);
begin
  inherited Create;
  FID := AID;
  FValues := TObjectList.Create;
  SetCount(ACount);
end;

destructor TDataValues.Destroy;
begin
  FValues.Free;
  FValues := nil;
  inherited Destroy;
end;

procedure TDataValues.SetID(Value: Integer);
begin
  FID := Value;
end;

function TDataValues.GetValueName(Index: Integer): string;
begin
  Result := '';
end;

function TDataValues.GetValueDataType(Index: Integer): TDataType;
begin
  Result := dtUnknown;
end;

function TDataValues.GetValueLength(Index: Integer): Integer;
begin
  Result := -1;
end;

function TDataValues.GetValueScale(Index: Integer): Integer;
begin
  Result := -1;
end;

function TDataValues.GetValueDateTimeFormat(Index: Integer): TDateTimeFormat;
begin
  Result := dtfRaw;
end;

function TDataValues.GetValueLocalizeDateTime(Index: Integer): Boolean;
begin
  Result := False;
end;

function TDataValues.GetValueReadOnly(Index: Integer): Boolean;
begin
  Result := False;
end;

procedure TDataValues.ValueChanged(Index: Integer);
begin
end;

function TDataValues.NotifyModified: Boolean;
begin
  Result := FNotifyChanges;
end;

procedure TDataValues.SetModified;
begin
  FModified := True;
end;

procedure TDataValues.ResetModified;
var
  I: Integer;
begin
  FModified := False;
  for I := 0 to FValues.Count - 1 do
    TDataValue(FValues[I]).ResetModified;
end;

function TDataValues.GetCount: Integer;
begin
  Result := FValues.Count;
end;

procedure TDataValues.SetCount(Value: Integer);
var
  TempCount: Integer;
  I: Integer;
begin
  TempCount := FValues.Count;
  FValues.Count := Value;
  if (FValues.Count > TempCount) then
  begin
    for I := TempCount to Value - 1 do
      FValues[I] := CreateValue(I);
  end;
end;

function TDataValues.GetValue(Index: Integer): TDataValue;
begin
  Result := TDataValue(FValues[Index]);
end;

procedure TDataValues.Assign(NewValues: TDataValues);
var
  I: Integer;
begin
  FID := NewValues.ID;
  FModified := NewValues.Modified;
  for I := 0 to FValues.Count - 1 do
    TDataValue(FValues[I]).Assign(NewValues[I]);
end;

procedure TDataValues.Initialize;
var
  I: Integer;
begin
  for I := 0 to FValues.Count - 1 do
    TDataValue(FValues[I]).Initialize;
  ResetModified;
end;

function TDataValues.Compare(Value: TDataValues;
  CaseInsensitive: Boolean = False;
  LocaleInsensitive: Boolean = False): Integer;
var
  I: Integer;
begin
  Result := CMP_EQUAL;
  for I := 0 to FValues.Count - 1 do
  begin
    Result := TDataValue(FValues[I]).Compare(Value[I], CaseInsensitive,
      LocaleInsensitive);
    if (Result <> CMP_EQUAL) then
      Break;
  end;
end;

function TDataValues.GetJSON(ModifiedOnly: Boolean = False;
  IncludeID: Boolean = False;
  {const}IDName: string = ''): string;
var
  I: Integer;
  TempCount: Integer;
begin
  if IncludeID and (IDName <> '') then
  begin
    Result := '{ "' + IDName + '": ' + IntToStr(ID);
    TempCount := 1;
  end
  else
  begin
    Result := '{ ';
    TempCount := 0;
  end;
  for I := 0 to Count - 1 do
  begin
    if ((ModifiedOnly and Modified) or (not ModifiedOnly)) then
    begin
      if (TempCount > 0) then
        Result := Result + ', ';
      Result := Result + GetJSON;
      Inc(TempCount);
    end;
  end;
  Result := Result + ' }';
end;

{ TFormatSettings }

constructor TFormatSettings.Create;
begin
  inherited Create;
  FParser := TParser.Create;
  FTranslations := TStringList.Create;
  SetupTranslations;
end;

destructor TFormatSettings.Destroy;
begin
  FParser.Free;
  FParser := nil;
  FTranslations.Free;
  FTranslations := nil;
  inherited Destroy;
end;

procedure TFormatSettings.Initialize;
begin
  FShortDateFormatComps := ParseShortDate(FShortDateFormat, True);
  FShortTimeFormatComps := ParseShortTime(FShortTimeFormat, True);
  FShortMonthNames.SetLength(MONTHS_PER_YEAR);
  FShortMonthNames[0] := 'Jan';
  FShortMonthNames[1] := 'Feb';
  FShortMonthNames[2] := 'Mar';
  FShortMonthNames[3] := 'Apr';
  FShortMonthNames[4] := 'May';
  FShortMonthNames[5] := 'Jun';
  FShortMonthNames[6] := 'Jul';
  FShortMonthNames[7] := 'Aug';
  FShortMonthNames[8] := 'Sep';
  FShortMonthNames[9] := 'Oct';
  FShortMonthNames[10] := 'Nov';
  FShortMonthNames[11] := 'Dec';

  FLongMonthNames.SetLength(MONTHS_PER_YEAR);
  FLongMonthNames[0] := 'January';
  FLongMonthNames[1] := 'February';
  FLongMonthNames[2] := 'March';
  FLongMonthNames[3] := 'April';
  FLongMonthNames[4] := 'May';
  FLongMonthNames[5] := 'June';
  FLongMonthNames[6] := 'July';
  FLongMonthNames[7] := 'August';
  FLongMonthNames[8] := 'September';
  FLongMonthNames[9] := 'October';
  FLongMonthNames[10] := 'November';
  FLongMonthNames[11] := 'December';

  FShortDayNames.SetLength(DAYS_PER_WEEK);
  FShortDayNames[0] := 'Mon';
  FShortDayNames[1] := 'Tue';
  FShortDayNames[2] := 'Wed';
  FShortDayNames[3] := 'Thu';
  FShortDayNames[4] := 'Fri';
  FShortDayNames[5] := 'Sat';
  FShortDayNames[6] := 'Sun';

  FLongDayNames.SetLength(DAYS_PER_WEEK);
  FLongDayNames[0] := 'Monday';
  FLongDayNames[1] := 'Tuesday';
  FLongDayNames[2] := 'Wednesday';
  FLongDayNames[3] := 'Thursday';
  FLongDayNames[4] := 'Friday';
  FLongDayNames[5] := 'Saturday';
  FLongDayNames[6] := 'Sunday';
end;

procedure TFormatSettings.SetupTranslations;
begin
  FTranslations.BeginUpdate;
  try
    FTranslations.Add('TYPE_UNKNOWN=Unknown');
    FTranslations.Add('TYPE_STRING=String');
    FTranslations.Add('TYPE_BOOLEAN=Boolean');
    FTranslations.Add('TYPE_INTEGER=Integer');
    FTranslations.Add('TYPE_FLOAT=Float');
    FTranslations.Add('TYPE_DATE=Date');
    FTranslations.Add('TYPE_TIME=Time');
    FTranslations.Add('TYPE_DATETIME=DateTime');
    FTranslations.Add('TYPE_BLOB=Blob');
    FTranslations.Add('TYPE_SYMBOL=Symbol');
    FTranslations.Add('DLG_MSG=Message');
    FTranslations.Add('DLG_BTN_OK=OK');
    FTranslations.Add('DLG_BTN_CANCEL=Cancel');
    FTranslations.Add('DLG_BTN_ABORT=Abort');
    FTranslations.Add('DLG_BTN_RETRY=Retry');
    FTranslations.Add('DLG_BTN_IGNORE=Ignore');
    FTranslations.Add('DLG_BTN_YES=Yes');
    FTranslations.Add('DLG_BTN_NO=No');
    FTranslations.Add('DLG_BTN_ALL=All');
    FTranslations.Add('DLG_BTN_NOTOALL=No to All');
    FTranslations.Add('DLG_BTN_YESTOALL=Yes to All');
    FTranslations.Add('DLG_BTN_CLOSE=Close');
    FTranslations.Add('ERR_CMP_DESTROY="%s" component already destroyed');
    FTranslations.Add('ERR_LOAD_PERSISTENT=Persistent load error (%s)');
    FTranslations.Add('ERR_LOAD_METHOD=Method %s not found');
    FTranslations.Add('ERR_SAVE_PERSISTENT=Persistent save error (%s)');
    FTranslations.Add('ERR_SET_RANGE=Value "%s" out of range for set');
    FTranslations.Add('ERR_BOOLEAN_LITERAL=Invalid boolean literal "%s" specified');
    FTranslations.Add('ERR_FORMAT=Error in the format string %s (%s)');
    FTranslations.Add('ERR_VALUE_CONVERT=Error converting %s value to %s value');
    FTranslations.Add('ERR_VALUE_READONLY="%s" is read-only and cannot be modified');
    FTranslations.Add('ERR_DATETIME_DATE=date');
    FTranslations.Add('ERR_DATETIME_TIME=time');
    FTranslations.Add('ERR_DATETIME_MONTH=Invalid month %s specified');
    FTranslations.Add('ERR_DATETIME_DAY=Invalid day %s specified');
    FTranslations.Add('ERR_DATETIME_TOOMANYCOMPS=Too many %s components');
    FTranslations.Add('ERR_DATETIME_MISSINGCOMP=Missing %s component');
    FTranslations.Add('ERR_DATETIME_INVALIDCOMP=Invalid %s component');
    FTranslations.Add('ERR_DATETIME_INVALIDFORMAT=Invalid %s format');
    FTranslations.Add('ERR_DATETIME_INVALID=Invalid %s (%s)');
    FTranslations.Add('ERR_PARSE_TERMSTR=Unterminated string at %s');
    FTranslations.Add('ERR_PARSE_MISSING=Missing %s');
    FTranslations.Add('ERR_PARSE_EXPECT=Expected %s, instead found %s at %s');
    FTranslations.Add('ERR_LIST_BOUNDS=List index %s out of bounds');
    FTranslations.Add('ERR_LIST_SORT=You can only use the Find method when a list is sorted');
    FTranslations.Add('ERR_OWNER=Invalid owner class %s passed to constructor');
    FTranslations.Add('ERR_LOADUI_STATE=Error loading interface state (%s)');
    FTranslations.Add('ERR_UI_DUPSTATE=The interface state %s already exists');
    FTranslations.Add('ERR_UI_ELEMENTCLASS=Cannot find registered element class information '
      +
      'for the %s class');
    FTranslations.Add('ERR_DOM_EVENTADD=Cannot add event handler to "%s" element for "%s" event');
    FTranslations.Add('ERR_DOM_EVENTCLEAR=Cannot remove "%s" event handler from "%s"');
    FTranslations.Add('ERR_HTTP_REQUEST=Error executing request "%s" (%s)');
    FTranslations.Add('ERR_DATA_DUPCOL=The "%s" column already exists');
    FTranslations.Add('ERR_DATA_COLNAME=Column names cannot be blank (%s)');
    FTranslations.Add('ERR_DATA_COLTYPE=Unknown column type (%s)');
    FTranslations.Add('ERR_DATA_COLLENGTH=Invalid "%s" column length %s');
    FTranslations.Add('ERR_DATA_COLSCALE=Invalid "%s" column scale %s');
    FTranslations.Add('ERR_DATA_CONNECT=Cannot connect to server');
    FTranslations.Add('ERR_DATA_LOADCODE=Status code %s');
    FTranslations.Add('ERR_DATA_LOAD=Dataset load response error (%s)');
    FTranslations.Add('ERR_DATA_COMMIT=Database commit response error (%s)');
    FTranslations.Add('ERR_DATA_TRANSACTIVE=A transaction is not active');
    FTranslations.Add('ERR_DATA_PENDREQUEST=There are no pending requests');
    FTranslations.Add('ERR_DATA_COLUMNS=At least one column must be defined for the "%s" dataset');
    FTranslations.Add('ERR_DATA_OPEN=The "%s" dataset must be open in order to complete this operation');
    FTranslations.Add('ERR_DATA_NOTOPEN=The "%s" dataset cannot be open when completing this operation');
    FTranslations.Add('ERR_DATA_NOTEDITING=The "%s" dataset must be in an editable mode before a column '
      +
      'can be assigned a value');
    FTranslations.Add('ERR_DATA_TRANSCLOSE=Cannot close the "%s" dataset while there are still '
      +
      'active transaction operations for the dataset');
    FTranslations.Add('ERR_DATA_FINDMODE=The "%s" dataset is not in Find mode');
    FTranslations.Add('ERR_DATA_FINDNEAR=You can only search for nearest matches in the "%s" dataset '
      +
      'when searching on columns that match the current sort order');
    FTranslations.Add('ERR_DATA_COLNOTFOUND=Column "%s" not found');
    FTranslations.Add('ERR_DATA_TRANSDATASET=Invalid dataset "%s" specified in the transaction operations');
    FTranslations.Add('ERR_DATA_TRANSOPTYPE=Invalid or unknown operation type %s specified in the transaction operations');
    FTranslations.Add('ERR_DATA_DATASETDB=The "%s" dataset cannot be loaded using the "%s" database');
    FTranslations.Add('ERR_APP_ERRORLINE=Line: %s');
    FTranslations.Add('ERR_APP_ERRORTITLE=Application Error');
    FTranslations.Add('APP_LOAD_MESSAGE=Loading %s...');
    FTranslations.Add('ERR_DLG_BUTTONS=You must specify at least one button for the message dialog');
    FTranslations.Add('ERR_FORM_SHOWMODAL=You cannot call ShowModal for the embedded form %s');
    FTranslations.Add('ERR_CTRL_PARENT=The %s control cannot be a parent of the %s control');
    FTranslations.Add('ERR_CALENDAR_COLINDEX=Column index %s out of bounds');
    FTranslations.Add('ERR_CALENDAR_ROWINDEX=Row index %s out of bounds');
    FTranslations.Add('ERR_GRID_COLINDEX=Column index %s out of bounds');
    FTranslations.Add('ERR_GRID_ROWINDEX=Row index %s out of bounds');
    FTranslations.Add('ERR_GRID_COLNOTFOUND=Column "%s" not found');
    FTranslations.Add('ERR_CANVAS=Your browser does not have HTML5 canvas support');
    FTranslations.Add('ERR_STORAGE=Your browser does not have HTML5 persistent storage support');
    FTranslations.Add('ERR_SCRIPT_LOAD=Your browser does not support dynamic script loading');
    FTranslations.Add('ERR_MEDIA=Your browser does not have HTML5 media support');
    FTranslations.Add('ERR_MAP=The map API has not been loaded');
    FTranslations.Add('ERR_MAP_GEOCODE=Geocoding request error "%s"');
    FTranslations.Add('ERR_MAP_LOCNOTFOUND=Location "%s" not found');
    FTranslations.Add('ERR_MAP_DUPLOC=The "%s" location already exists');
    FTranslations.Add('ERR_MAP_LOCNAME=Location names cannot be blank (%s)');
    FTranslations.Add('ERR_SIZER_CONTROL=The sizer control itself cannot be assigned as the target control');
    FTranslations.Add('ERR_ZOOM_FACTOR=Zoom factor %s invalid, factor must be between 1 and 100');
    FTranslations.Add('ERR_SLIDE_COUNT=At least %s slide images must be specifed before the slide '
      +
      'show can be started');
  finally
    FTranslations.EndUpdate;
  end;
end;

procedure TFormatSettings.Error(const Format: string;
  const Msg: string);
begin
  raise Exception.Create(Translate('ERR_FORMAT', [Format, Msg]));
end;

procedure TFormatSettings.CheckMonth(Value: Integer);
begin
  if (Value < 1) or (Value > MONTHS_PER_YEAR) then
    raise Exception.Create(Translate('ERR_DATETIME_MONTH', [IntToStr(Value)]));
end;

procedure TFormatSettings.CheckDay(Value: Integer);
begin
  if (Value < 1) or (Value > DAYS_PER_WEEK) then
    raise Exception.Create(Translate('ERR_DATETIME_DAY', [IntToStr(Value)]));
end;

function TFormatSettings.GetShortMonthName(Month: Integer): string;
begin
  CheckMonth(Month);
  Result := FShortMonthNames[Month - 1];
end;

procedure TFormatSettings.SetShortMonthName(Month: Integer; const Value:
  string);
begin
  CheckMonth(Month);
  FShortMonthNames[Month - 1] := Value;
end;

function TFormatSettings.GetLongMonthName(Month: Integer): string;
begin
  CheckMonth(Month);
  Result := FLongMonthNames[Month - 1];
end;

procedure TFormatSettings.SetLongMonthName(Month: Integer; const Value: string);
begin
  CheckMonth(Month);
  FLongMonthNames[Month - 1] := Value;
end;

function TFormatSettings.GetShortDayName(Day: Integer): string;
begin
  CheckDay(Day);
  Result := FShortDayNames[Day - 1];
end;

procedure TFormatSettings.SetShortDayName(Day: Integer; const Value: string);
begin
  CheckDay(Day);
  FShortDayNames[Day - 1] := Value;
end;

function TFormatSettings.GetLongDayName(Day: Integer): string;
begin
  CheckDay(Day);
  Result := FLongDayNames[Day - 1];
end;

procedure TFormatSettings.SetLongDayName(Day: Integer; const Value: string);
begin
  CheckDay(Day);
  FLongDayNames[Day - 1] := Value;
end;

procedure TFormatSettings.SetStartOfWeek(Day: Integer);
begin
  CheckDay(Day);
  FStartOfWeek := Day;
end;

function TFormatSettings.GetDateName: string;
begin
  Result := Translate('ERR_DATETIME_DATE');
end;

function TFormatSettings.GetTimeName: string;
begin
  Result := Translate('ERR_DATETIME_TIME');
end;

procedure TFormatSettings.ComponentError(const Format: string;
  const Value: string);
begin
  Error(Format, Translate('ERR_DATETIME_INVALIDCOMP', [Value]));
end;

procedure TFormatSettings.ValidateShortDateComp(const Format: string;
  const Value: string);
var
  I: Integer;
begin
  if (Value = '') then
    Error(Format, Translate('ERR_DATETIME_MISSINGCOMP', [GetDateName]));
  case Value[1] of
    YEAR_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_YEAR_FORMAT)) or
          (Length(Value) > Length(FULL_YEAR_FORMAT)) then
          ComponentError(Format, YEAR_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> YEAR_FORMAT_CHAR) then
            ComponentError(Format, YEAR_FORMAT_CHAR);
        end;
      end;
    MONTH_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_MONTH_FORMAT)) or
          (Length(Value) > Length(FULL_MONTH_FORMAT)) then
          ComponentError(Format, MONTH_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> MONTH_FORMAT_CHAR) then
            ComponentError(Format, MONTH_FORMAT_CHAR);
        end;
      end;
    DAY_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_DAY_FORMAT)) or
          (Length(Value) > Length(FULL_DAY_FORMAT)) then
          ComponentError(Format, DAY_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> DAY_FORMAT_CHAR) then
            ComponentError(Format, DAY_FORMAT_CHAR);
        end;
      end;
  else
    Error(Format, Translate('ERR_DATETIME_INVALIDFORMAT', [GetDateName]));
  end;
end;

function TFormatSettings.ParseShortDate(const Value: string;
  Format: Boolean = False): TStringsArray;
var
  I: Integer;
begin
  Result.SetLength(3);
  Result[0] := '';
  Result[1] := '';
  Result[2] := '';
  I := 0;
  FParser.Initialize(Value, False);
  while (not FParser.CheckToken(tkTerm)) do
  begin
    if (I = 3) then
      Error(Value, Translate('ERR_DATETIME_TOOMANYCOMPS', [GetDateName]));
    if (not FParser.SkipToken(FDateSeparator)) then
    begin
      if Format then
      begin
        if FParser.CheckToken(tkSymbol) then
          Result[I] := FParser.TokenString;
      end
      else
      begin
        if FParser.CheckToken(tkInteger) then
          Result[I] := FParser.TokenString;
      end;
      Inc(I);
      FParser.NextToken;
    end;
  end;
  //end;
end;

function TFormatSettings.GetShortDateFormatComp(Index: Integer): string;
begin
  if (Index < Length(FShortDateFormatComps)) then
    Result := FShortDateFormatComps[Index]
  else
    Result := '';
end;

procedure TFormatSettings.SetShortDateFormat(const Value: string);
var
  TempComps: TStringsArray;
begin
  if (Value <> FShortDateFormat) then
  begin
    TempComps := ParseShortDate(Value, True);
    ValidateShortDateComp(Value, TempComps[0]);
    ValidateShortDateComp(Value, TempComps[1]);
    ValidateShortDateComp(Value, TempComps[2]);
    FShortDateFormat := Value;
    FShortDateFormatComps := TempComps;
  end;
end;

procedure TFormatSettings.SetTranslations(Value: TStrings);
begin
  FTranslations.Assign(Value);
end;

function DateToStr(Value: DateTime; UTC: Boolean = False): string;
var
  I: Integer;
  TempYear: string;
begin
  Result := '';

  for I := 0 to 2 do
  begin
    case FormatSettings.ShortDateFormatComp[I] of
      FULL_YEAR_FORMAT:
        Result := Result + IntToStr(YearOf(Value, UTC));
      PART_YEAR_FORMAT:
        begin
          TempYear := IntToStr(YearOf(Value, UTC));
          Result := Result + Copy(TempYear, (Length(TempYear) - 1), 2);
        end;
      FULL_MONTH_FORMAT:
        Result := Result + Pad(IntToStr(MonthOf(Value, UTC)), 2, '0');
      PART_MONTH_FORMAT:
        Result := Result + IntToStr(MonthOf(Value, UTC));
      FULL_DAY_FORMAT:
        Result := Result + Pad(IntToStr(DayOf(Value, UTC)), 2, '0');
      PART_DAY_FORMAT:
        Result := Result + IntToStr(DayOf(Value, UTC));
    end;
    if (I < 2) then
      Result := Result + FormatSettings.DateSeparator;
  end;
end;

function StrToDate(const Value: string; UTC: Boolean = False): DateTime;
var
  I: Integer;
  TempComps: TStringsArray;
  TempYear: Integer;
  TempMonth: Integer;
  TempDay: Integer;
  TempCentury: Integer;
  TempMessage: string;
begin
  Result := DateTime(0);
  TempMessage := Translate('ERR_DATETIME_INVALID',
    [Translate('ERR_DATETIME_DATE'), Value]);
  try
    TempYear := 0;
    TempMonth := 0;
    TempDay := 0;

    TempComps := FormatSettings.ParseShortDate(Value);
    for I := 0 to 2 do
    begin
      if (FormatSettings.ShortDateFormatComp[I] = FULL_YEAR_FORMAT) then
        TempYear := StrToInt(TempComps[I])
      else if (FormatSettings.ShortDateFormatComp[I] = PART_YEAR_FORMAT) then
      begin
        TempYear := StrToInt(TempComps[I]);
        TempCentury := (YearOf(Date, UTC) -
          FormatSettings.TwoDigitYearCenturyWindow);
        Inc(TempYear, ((TempCentury div 100) * 100));
        if (TempYear < TempCentury) then
          Inc(TempYear, 100);
      end
      else if (FormatSettings.ShortDateFormatComp[I] = FULL_MONTH_FORMAT) or
        (FormatSettings.ShortDateFormatComp[I] = PART_MONTH_FORMAT) then
        TempMonth := StrToInt(TempComps[I])
      else if (FormatSettings.ShortDateFormatComp[I] = FULL_DAY_FORMAT) or
        (FormatSettings.ShortDateFormatComp[I] = PART_DAY_FORMAT) then
        TempDay := StrToInt(TempComps[I]);
    end;

    if (not (IsMonth(TempMonth) and IsDay(TempMonth, TempDay,
      IsLeapYear(TempYear)))) then
      raise Exception.Create(TempMessage)
    else
      Result := EncodeDate(TempYear, TempMonth, TempDay, UTC);
  except
    raise Exception.Create(TempMessage);
  end;
end;

procedure TFormatSettings.ValidateShortTimeComp(const Format: string;
  const Value: string);
var
  I: Integer;
begin
  if (Value = '') then
    Error(Format, Translate('ERR_DATETIME_MISSINGCOMP', [GetTimeName]));
  case Value[1] of
    HOUR12_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_HOUR12_FORMAT)) or
          (Length(Value) > Length(FULL_HOUR12_FORMAT)) then
          ComponentError(Format, HOUR12_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> HOUR12_FORMAT_CHAR) then
            ComponentError(Format, HOUR12_FORMAT_CHAR);
        end;
      end;
    HOUR24_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_HOUR24_FORMAT)) or
          (Length(Value) > Length(FULL_HOUR24_FORMAT)) then
          ComponentError(Format, HOUR24_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> HOUR24_FORMAT_CHAR) then
            ComponentError(Format, HOUR24_FORMAT_CHAR);
        end;
      end;
    MIN_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_MIN_FORMAT)) or
          (Length(Value) > Length(FULL_MIN_FORMAT)) then
          ComponentError(Format, MIN_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> MIN_FORMAT_CHAR) then
            ComponentError(Format, MIN_FORMAT_CHAR);
        end;
      end;
    SEC_FORMAT_CHAR:
      begin
        if (Length(Value) < Length(PART_SEC_FORMAT)) or
          (Length(Value) > Length(FULL_SEC_FORMAT)) then
          ComponentError(Format, SEC_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> SEC_FORMAT_CHAR) then
            ComponentError(Format, SEC_FORMAT_CHAR);
        end;
      end;
    AMPM_FORMAT_CHAR:
      begin
        if (Length(Value) > Length(FULL_AMPM_FORMAT)) then
          ComponentError(Format, AMPM_FORMAT_CHAR);
        for I := 2 to Length(Value) do
        begin
          if (Value[I] <> AMPM_FORMAT_CHAR) then
            ComponentError(Format, AMPM_FORMAT_CHAR);
        end;
      end;
  else
    Error(Format, Translate('ERR_DATETIME_INVALIDFORMAT', [GetTimeName]));
  end;
end;

function TFormatSettings.ParseShortTime(const Value: string;
  Format: Boolean = False): TStringsArray;
var
  I: Integer;
begin
  Result.SetLength(4);
  Result[0] := '';
  Result[1] := '';
  Result[2] := '';
  Result[3] := '';
  I := 0;

  FParser.Initialize(Value, False);
  while (not FParser.CheckToken(tkTerm)) do
  begin
    if (I = 4) then
      Error(Value, Translate('ERR_DATETIME_TOOMANYCOMPS', [GetTimeName]));
    if (not FParser.SkipToken(FTimeSeparator)) then
    begin
      if Format then
      begin
        if FParser.CheckToken(tkSymbol) then
          Result[I] := FParser.TokenString;
      end
      else
      begin
        if FParser.CheckToken(tkInteger) or
          FParser.CheckToken(tkSymbol) then
          Result[I] := FParser.TokenString;
      end;
      Inc(I);
      FParser.NextToken;
    end;
  end;
end;

function TFormatSettings.GetShortTimeFormatComp(Index: Integer): string;
begin
  if (Index < Length(FShortTimeFormatComps)) then
    Result := FShortTimeFormatComps[Index]
  else
    Result := '';
end;

procedure TFormatSettings.SetShortTimeFormat(const Value: string);
var
  TempComps: TStringsArray;
  TempHour: string;
  TempAMPM: string;
  I: Integer;
begin
  if (Value <> FShortTimeFormat) then
  begin
    TempComps := ParseShortTime(Value, True);
    ValidateShortTimeComp(Value, TempComps[0]);
    TempHour := TempComps[0];
    ValidateShortTimeComp(Value, TempComps[1]);
    if (TempComps[2] <> '') then
      ValidateShortTimeComp(Value, TempComps[2]);
    TempAMPM := '';
    for I := 3 downto 1 do
    begin
      if (TempComps[I] = FULL_AMPM_FORMAT) then
      begin
        TempAMPM := TempComps[I];
        Break;
      end;
    end;
    if (TempHour[1] = HOUR12_FORMAT_CHAR) then
      ValidateShortTimeComp(Value, TempAMPM)
    else if (TempAMPM <> '') then
      Error(Value, Translate('ERR_DATETIME_TOOMANYCOMPS', [GetTimeName]));
    FShortTimeFormat := Value;
    FShortTimeFormatComps := TempComps;
  end;
end;

initialization
  FormatSettings := TFormatSettings.Create;
  FormatSettings.Initialize;
  GlobalFixups := TFixups.Create;
finalization
  GlobalFixups.Free;
  GlobalFixups := nil;
  FormatSettings.Free;
  FormatSettings := nil;

end.
