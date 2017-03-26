unit Unit2;

interface

uses 
   SmartCL.System, SmartCL.Components, W3C.Console;
type
  TComp = class(TW3CustomControl)
  private
    { Private declarations }
    procedure createInnerComponent;
  protected
    { Protected declarations }
    procedure InitializeObject; override;
    procedure FinalizeObject; override;
  public
    { Public declarations }
  published
    { Published declarations }
  end;

implementation

var
  document external "document": variant;

function btnsRipple : boolean;
begin
  console.log('button was clicked');
end;

procedure TComp.createInnerComponent;
begin
(*+--------------------------------------------------------------------------+
  |Since the document fragment is in memory and not part of the main DOM     |
  |tree, appending children to it does not cause page reflow (computation of |
  |elements position and geometry). Consequently, using documentfragments    |
  |often results in better performance.                                      |
  +--------------------------------------------------------------------------+*)
var docFragment := document.createDocumentFragment(); // contains all gathered nodes

var button := document.createElement('BUTTON');
button.setAttribute("class", "TW3Button");
docFragment.appendChild(button);
var text := document.createTextNode("button1");
button.appendChild(text);
button.addEventListener('click', @btnsRipple, false);
Self.Handle.appendChild( docFragment );

end;

procedure TComp.InitializeObject;
begin
  inherited;
(*+--------------------------------------------------------------------------+
  | this is a good place to initialize the component                         |
  +--------------------------------------------------------------------------+*)
  
//createInnerComponent;
(*+--------------------------------------------------------------------------+
  | make the control display itself correctly when its ready in the DOM      |
  +--------------------------------------------------------------------------+*)

  Handle.ReadyExecute(procedure()
  begin
    (* call createInnerComponent *)
    createInnerComponent;

(*+--------------------------------------------------------------------------+
  | some basic style attributes after render                                 |
  +--------------------------------------------------------------------------+*)
    Self.Handle.style["width"] := null;
    Self.Handle.style["height"] := null;
  end);

end;

procedure TComp.FinalizeObject;
begin
  inherited;
  
end;

procedure InsertCSS;
begin
(*+--------------------------------------------------------------------------+
  |  Inserts a new style rule into the current stylesheet, dynamically       |
  |  change classes, so style information can be kept in  genuine            |
  |  stylesheets "and avoid adding extra elements to the DOM").              |
  +--------------------------------------------------------------------------+*)

end;

initialization

end.
