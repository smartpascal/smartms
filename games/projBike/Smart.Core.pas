(*
 ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════╗
 ║ This is a custom wrapper for DOM manipulation. This library utilizes most edge and high-performance   ║
 ║ methods for DOM manipulation. You don't need to learn something new, its usage is very simple because ║
 ║ it has the same syntax as well known jQuery library with support of the most popular and widely used  ║
 ║ methods and jQuery-like chaining.                                                                     ║
 ║ by warleyalex                                                                                         ║
 ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════╝   }
 *)

unit Smart.Core;

{$R 'lib\sms.core.min.js'}

interface

uses W3C.HTML5, W3C.DOM;

type
  THandle = variant;
  TProcedure = procedure;
  aCallBack =  procedure(page: Variant);
  ajaxCallBack =  procedure(xhr: Variant);
  prerouteCallBack = procedure(view, options: variant);
  preprocessCallBack = procedure(content, url, next: variant);
  pageCallBack = procedure(app, page: variant);
  eachCallBack = procedure(index, value: variant);
  TXMLHttpRequest_onreadystatechange_ = function (ev: JEvent): variant;
  TXMLHttpRequest_onload_ = function (ev: JEvent): variant;

type
  TArray_sort_compareFn_ = function (a: Jelement; b: Jelement): integer;
  TArray_every_callbackfn_ = function (value: Jelement; index: integer; &array: array of Jelement): boolean;
  TArray_some_callbackfn_ = function (value: Jelement; index: integer; &array: array of Jelement): boolean;
  TArray_forEach_callbackfn_ = procedure (value: Jelement; index: integer; &array: array of Jelement);
  TArray_map_callbackfn_ = function (value: Jelement; index: integer; &array: array of Jelement): variant;
  TArray_filter_callbackfn_ = function (value: Jelement; index: integer; &array: array of Jelement): boolean;
  TArray_reduce_callbackfn_ = function (previousValue: variant; currentValue: variant; currentIndex: integer; &array: array of Jelement): variant;
  TArray_reduceRight_callbackfn_ = function (previousValue: variant; currentValue: variant; currentIndex: integer; &array: array of Jelement): variant;

type
  JArray = class external "Object"
    function toString(): string;
    function toLocaleString(): string;
    function concat({many?}items: array of array of Jelement): array of Jelement;
    function concat({many?}items: array of Jelement): array of Jelement;overload;
    function join(seperator: string = ""): string;
    function pop(): Jelement;
    function push({many?}items: array of Jelement): integer;
    function reverse(): array of Jelement;
    function shift(): Jelement;
    function slice(start: integer; &end: integer = 0): array of Jelement;
    function sort(compareFn: TArray_sort_compareFn_ = nil): array of Jelement;
    function splice(start: integer): array of Jelement;
    function splice(start: integer; deleteCount: integer; {many?}items: array of Jelement): array of Jelement;overload;
    function unshift({many?}items: array of Jelement): integer;
    function indexOf(searchElement: Jelement; fromIndex: integer = 0): integer;
    function lastIndexOf(searchElement: Jelement; fromIndex: integer = 0): integer;
    function every(callbackfn: TArray_every_callbackfn_; thisArg: variant = undefined): boolean;
    function some(callbackfn: TArray_some_callbackfn_; thisArg: variant = undefined): boolean;
    procedure forEach(callbackfn: TArray_forEach_callbackfn_; thisArg: variant = undefined);
    function map(callbackfn: TArray_map_callbackfn_; thisArg: variant = undefined): array of variant;
    function filter(callbackfn: TArray_filter_callbackfn_; thisArg: variant = undefined): array of Jelement;
    function reduce(callbackfn: TArray_reduce_callbackfn_; initialValue: variant = undefined): variant;
    function reduceRight(callbackfn: TArray_reduceRight_callbackfn_; initialValue: variant = undefined): variant;
    property length: integer;
  end;

type
  JArray1 = class external "&Array"
  public
    function &new({many?}items: array of variant): array of variant;
    function isArray(arg: variant): boolean;
    property prototype: JArray;
  end;

  function &Array: JArray1; external 'JArray1' property;


type
  JEventTarget = class external "Object"
    procedure removeEventListener(&type: string; listener: JEventListener; useCapture: boolean = false);
    procedure addEventListener(&type: string; listener: JEventListener; useCapture: boolean = false);
    function dispatchEvent(evt: JEvent): boolean;
  end;

type
  JXMLHttpRequest = class external "Object"(JEventTarget)
    property onreadystatechange: TXMLHttpRequest_onreadystatechange_;
    property status: integer;
    property onload: TXMLHttpRequest_onload_;
    property readyState: integer;
    property responseText: string;
    property responseXML: JDocument;
    property statusText: string;
    procedure open(method: string; url: string; async: boolean = false; user: string = ""; password: string = "");
    procedure send(data: variant = undefined);
    procedure abort();
    function getAllResponseHeaders(): string;
    procedure setRequestHeader(header: string; value: string);
    function getResponseHeader(header: string): string;
    property LOADING: integer;
    property DONE: integer;
    property UNSENT: integer;
    property OPENED: integer;
    property HEADERS_RECEIVED: integer;
  end;

  JXMLHttpRequest1 = class external "XMLHttpRequest"
  public
    property prototype: JXMLHttpRequest;
    function &new(): JXMLHttpRequest;
    property LOADING: integer;
    property DONE: integer;
    property UNSENT: integer;
    property OPENED: integer;
    property HEADERS_RECEIVED: integer;
  end;

  function XMLHttpRequest_var: JXMLHttpRequest1; external 'JXMLHttpRequest1' property;

//------------------------------------------------------------------------------
type
  JDom7XHR = class external(JXMLHttpRequest)
    requestParameters: Variant;
    requestUrl: String;
  end;

  JDomAjaxSettings = class external
    function beforeSend(jqXHR: JDom7XHR; settings: JDomAjaxSettings): Variant;
    function error(jqXHR: JDom7XHR; textStatus: String; errorThrown: String): Variant;
    function success(data: Variant; textStatus: String; jqXHR: JDom7XHR): Variant;
    function complete(jqXHR: JDom7XHR; textStatus: String): Variant;
    statusCode: record
      _statusCode: string;
      // property Item[key: String]: Variant;
    end;
  end;

//------------------------------------------------------------------------------
  TJAjaxSettings_headers_object = class external
    public
     function  GetItems(key: string): variant; external array;
     procedure SetItems(key: string; value: variant); external array;
     property Items[key: string]: variant read GetItems write SetItems; default;
  end;

  TJAjaxSettings_statusCode_object = class external
    public
      function  GetItems(key: string): variant; external array;
      procedure SetItems(key: string; value: variant); external array;
      property Items[key: string]: variant read GetItems write SetItems; default;
  end;

  TJAjaxSettings_xhrFields_object = class external
    public
      function  GetItems(key: string): variant; external array;
      procedure SetItems(key: string; value: variant); external array;
      property Items[key: string]: variant read GetItems write SetItems; default;
    end;

  JAjaxSettings = class external
    //---------- Parameters ----------//
    property async: boolean;
    property &method: string;
    property cache: boolean;
    property contentType: string;
    property crossDomain: boolean;
    property data: variant;
    property processData: boolean;
    property dataType: string;
    property username: string;
    property password: string;
    property timeout: integer;
    property headers: TJAjaxSettings_headers_object;      
    property xhrFields: TJAjaxSettings_xhrFields_object;
    /*
    headers: record
      { property Item[key: String]: Variant; }
    end;
    xhrFields: record
      { property Item[key: String]: Variant; }
    end;
    */
    //---------- Callbacks ----------//
    procedure beforeSend(xhr: variant; settings: JAjaxSettings);
    function error(xhr: variant; textStatus: string; errorThrow: string): variant;
    procedure success(data: variant; textStatus: string; jqXHR: variant);
    procedure complete(xhr: variant; textStatus: string);
    property statusCode: TJAjaxSettings_statusCode_object;
  end;


//--------------------------------------------------
type
  JEvent = class external;
  JBaseEventObject = class external "Object"(JEvent);
  JEventObject = class external "Object"(JBaseEventObject);
  TFunction_on_handler = function (eventObject: JEventObject): variant;

type
  JDom7 = class external
  (*
    function SMS(selector: String; context: Variant {JElement or JDom7}): JDom7; overload;
    function SMS(element: JElement): JDom7; overload;
    function SMS(element: variant): JDom7; overload;
    function SMS(element: String): variant; overload;
    function SMS(elementArray: array of JElement): JDom7; overload;
  *)
    _length: Float;
    //-------- Classes --------//
    function addClass(className : string): JDom7; overload;
    function removeClass(className : string): JDom7; overload;
    function hasClass(className : string): JDom7; overload;
    function toggleClass(className : string): JDom7; overload;
    //-------- Attributes and properties --------//
    function prop(propName : string): JDom7; overload;
    function prop(propName : string; propValue: boolean): JDom7; overload;
    function prop(propertiesObject : variant): JDom7; overload;

    function attr(attrName : string): JDom7; overload;
    function attr(attrName, attrValue : string): JDom7; overload;
    function attr(attributesObject : variant): JDom7; overload;

    function removeAttr(attrName : string): JDom7; overload;
    function val(): JDom7; overload;
    //function val(): Variant; overload;
    function val(newValue : string): JDom7; overload;
    function val(newValue : variant): JDom7; overload;

    //-------- Data storage --------//
    function data(key : string; value: variant): JDom7; overload;
    function data(key : string): JDom7; overload;
    function removeData(key : string): JDom7; overload;

    //-------- Data Set --------//
    function dataset(): JDom7; overload;

    //-------- CSS transform, transitions --------//
    function transform(CSSTransformString : string): JDom7; overload;
    function transition(transitionDuration : float): JDom7; overload;

    //-------- Events --------//
    function &on(eventName: String; handler: procedure(event: JEvent)): JDom7; overload;
    function &on(eventName: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;
    function &on(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent)): JDom7; overload;
    function &on(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;

    function &on(objParams: JObject): JDom7; overload;
    function &on(eventName: string; handler: TFunction_on_handler = nil): JDom7; overload;
    function &on(eventName: variant; delegatedTarget: variant = undefined; handler: TFunction_on_handler = nil): JDom7; overload;

    function once(eventName: String; handler: procedure(event: JEvent)): JDom7; overload;
    function once(eventName: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;
    function once(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent)): JDom7; overload;
    function once(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;

    function once(eventName: string; handler: TFunction_on_handler = nil): JDom7; overload;
    function once(eventName: variant; delegatedTarget: variant = undefined; handler: TFunction_on_handler = nil): JDom7; overload;

    function off(eventName: String; handler: procedure(event: JEvent)): JDom7; overload;
    function off(eventName: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;
    function off(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent)): JDom7; overload;
    function off(eventName: String; delegatedTarget: String; handler: procedure(event: JEvent); useCapture: Boolean): JDom7; overload;

    function off(eventName: string): JDom7; overload;
    function off(eventName: string; handler: TProcedure): JDom7; overload;
    function off(eventName: variant; delegatedTarget: variant = undefined; handler: TProcedure = nil): JDom7; overload;
    //function &off(eventName: string; delegatedTarget: variant = undefined; handler: TProcedure = nil): JDom7; overload;

    function trigger(eventName: string; eventData: variant): JDom7; overload;

    function transitionEnd(callback: procedure; permanent: Boolean): JDom7; overload;
    function transitionEnd(callback: TProcedure): JDom7; overload;
    function animationEnd(callback: TProcedure): JDom7; overload;

    //-------- Styles --------//
    function width(): float; overload;
    function width(value: Variant {String or Float}): JDom7; overload;

    function outerWidth: Float; overload;
    function outerWidth(includeMargin: Boolean): Float; overload;
    function outerWidth(value: Variant {String or Float}): JDom7; overload;

    function height: Float; overload;
    function height(value: Variant {String or Float}): JDom7; overload;

    function outerHeight: Float; overload;
    function outerHeight(includeMargin: Boolean): Float; overload;
    function outerHeight(value: Variant {String or Float}): JDom7; overload;

    function offset(): float; overload;
    function offset(value: Variant {String or Float}): JDom7; overload;
    function hide(): JDom7; overload;
    function show(): JDom7; overload;

    function css(&property: String): Variant {String or Float}; overload;
    function css(&property: String; value: Variant {String or Float}): JDom7; overload;
    function css(propertiesObject: Variant): JDom7; overload;

    //-------- Scroll --------//
    function scrollTop: Float; overload;
    function scrollTop(position: Float): JDom7; overload;
    function scrollTop(position: Float; duration: Float): JDom7; overload;
    function scrollTop(position: Float; duration: Float; callback: procedure): JDom7; overload;
    function scrollTop(position: integer; duration: integer; callback: TProcedure): JDom7; overload;

    function scrollLeft: Float; overload;
    function scrollLeft(position: Float): JDom7; overload;
    function scrollLeft(position: Float; duration: Float): JDom7; overload;
    function scrollLeft(position: Float; duration: Float; callback: procedure): JDom7; overload;
    function scrollLeft(position: integer; duration: integer; callback: TProcedure): JDom7; overload;

    function scrollTo(left: Float; top: Float): JDom7; overload;
    function scrollTo(left: Float; top: Float; duration: Float): JDom7; overload;
    function scrollTo(left: Float; top: Float; duration: Float; callback: procedure): JDom7; overload;
    function scrollTo(left, top, duration: integer; callback: TProcedure): JDom7; overload;

    //-------- Dom Manipulation --------//
    function add(html: String): JDom7; overload;
    function add(elements: JArray): JDom7; overload;
    function add(elements: variant): JDom7; overload;

    /* Dom7.each(object/array, callback) - iterate through object or array
       object/array - object or array - to iterate over. Required.
       callback - function - callback function that will be executed on every object property, or on every array element. Required.*/
    function each(obj: variant; callback: eachCallBack): JDom7; overload;
    function each(callback: TProcedure): JDom7; overload;
    function each(callback: procedure(index: Float; element: Variant)): JDom7; overload;

    function html(newInnerHTML: variant): JDom7; overload;
    function html: String; overload;
    function html(newInnerHTML: String): JDom7; overload;

    function text: String; overload;
    function text(newTextContent: String): JDom7; overload;
    function text(newTextContent: variant): JDom7; overload;

    function &is(CSSSelector: string): JDom7; overload;
    //function &is(HTMLElement: variant): JDom7; overload;
    function &is(CSSSelector: Variant {String or JElement or JDom7}): Boolean; overload;

    /* Dom7.isArray(obj) - Determine whether the argument is an array
       obj - object - Object to test whether or not it is an array
       returns a Boolean indicating whether the object is a JavaScript array*/
    //function isArray(obj: variant): JDom7; overload;
    function isArray(target: Variant): Boolean; overload;

    function index: Boolean; 

    /* Dom7.dataset(el) - Get element's data set (set of data- attributes) as plain Object
       el - HTMLElement or string (with CSS selector) - element with data- attributes to get dataset from
       returns a new plain object with dataset  */
    //function dataset(el: variant): JDom7; overload
    function dataset(target: Variant {String or JHTMLElement or JDom7}): Variant; overload;

    function eq(index: variant): JDom7; overload;
    function eq(index: Float): Boolean; overload;

    function append(HTMLString: string): JDom7; overload;
    function append(HTMLElement: variant): JDom7; overload;
    
    function appendTo(element: Variant {String or JElement or JDom7}): JDom7;

    /* Dom7.parseUrlQuery(url) - parse url query get parameters
       url - string - url with GET parameters. Required.
       Method returns object with query parameters */
    function parseUrlQuery(url: string): JDom7; overload;
    //function parseUrlQuery(url: String): Variant; overload;

    function prepend(HTMLString: string): JDom7; overload;
    function prepend(HTMLElement: variant): JDom7; overload;
    function prependTo(element: Variant {String or JElement or JDom7}): JDom7;

    function insertBefore(element: Variant {String or JElement or JDom7}): JDom7;
    function insertAfter(element: Variant {String or JElement or JDom7}): JDom7;

    function next: JDom7; overload;
    function next(selector: string): JDom7; overload;
    function nextAll(selector: variant): JDom7; overload;
    function nextAll: JDom7; overload;
    function nextAll(selector: String): JDom7; overload;

    function prev: JDom7; overload;
    function prev(selector: String): JDom7; overload;
    function prev(selector: variant): JDom7; overload;

    function prevAll(selector: variant): JDom7; overload;
    function prevAll: JDom7; overload;
    function prevAll(selector: String): JDom7; overload;

    function parent: JDom7; overload;
    function parent(selector: String): JDom7; overload;
    function parent(selector: variant): JDom7; overload;

    function parents(selector: variant): JDom7; overload;
    function parents: JDom7; overload;
    function parents(selector: String): JDom7; overload;

    function find(selector: variant): JDom7; overload;
    function find: JDom7; overload;
    function find(selector: String): JDom7; overload;

    function children(selector: variant): JDom7; overload;
    function children: JDom7; overload;
    function children(selector: String): JDom7; overload;

    function filter(callback: TProcedure): JDom7; overload;
    function filter(callback: function(index: Float; element: Variant): Boolean): JDom7; overload;

    function remove(): JDom7; overload;

    /* Dom7.requestAnimationFrame(callback) - Cross-browser implementation on requestAnimationFrame
       callback - function - A parameter specifying a function to call when it's time to update your animation for the next repaint
       returns animation request id, that uniquely identifies the entry in the callback list  */
    //function requestAnimationFrame(callback: TProcedure): JDom7; overload;
    function requestAnimationFrame(callback: procedure): Float; overload;

    /* Dom7.cancelAnimationFrame(requestID) - Cancels an animation frame request
       requestID - number - The ID value returned by the call to $$.requestAnimationFrame() that requested the callback  */
    function cancelAnimationFrame(requestID: integer): JDom7; overload;

    /* Dom7.serializeObject(object) - Create a serialized representation of a plain object suitable for use in a URL query string
       object - object - Object to serialize
       returns a new unique array  */
    //function serializeObject(obj: variant): JDom7; overload;
    function serializeObject(target: Variant): String; overload;

    /* Dom7.toCamelCase(string) - Convert hypens-case string to camelCase string
       string - string - hypens-case string
       returns a new camelCase string */
    //function toCamelCase(str: string): JDom7; overload;
    function toCamelCase(&string: String): String; overload;

    /* Dom7.unique(array) - Remove duplicates in passed array
       obj - array - Array to remove duplicates
       returns a new unique array */
    function unique(arr: variant): JDom7; overload;
    function unique(target: array of variant): array of variant; overload;

    //-------- Shortcuts --------//
    function click: JDom7; overload;
    function click(handler: procedure(event: JEvent)): JDom7; overload;
    function click(handler: TProcedure): JDom7; overload;

    function blur(): JDom7; overload;
    function blur(handler: TProcedure): JDom7; overload;
    function blur(handler: procedure(event: JEvent)): JDom7; overload;

    function focus(): JDom7; overload;
    function focus(handler: TProcedure): JDom7; overload;
    function focus(handler: procedure(event: JEvent)): JDom7; overload;

    function focusin(): JDom7; overload;
    function focusin(handler: TProcedure): JDom7; overload;
    function focusin(handler: procedure(event: JEvent)): JDom7; overload;

    function focusout(): JDom7; overload;
    function focusout(handler: TProcedure): JDom7; overload;
    function focusout(handler: procedure(event: JEvent)): JDom7; overload;

    function keyup(): JDom7; overload;
    function keyup(handler: TProcedure): JDom7; overload;
    function keyup(handler: procedure(event: JEvent)): JDom7; overload;

    function keydown(): JDom7; overload;
    function keydown(handler: TProcedure): JDom7; overload;
    function keydown(handler: procedure(event: JEvent)): JDom7; overload;

    function keypress(): JDom7; overload;
    function keypress(handler: TProcedure): JDom7; overload;
    function keypress(handler: procedure(event: JEvent)): JDom7; overload;

    function submit(): JDom7; overload;
    function submit(handler: TProcedure): JDom7; overload;
    function submit(handler: procedure(event: JEvent)): JDom7; overload;

    function change(): JDom7; overload;
    function change(handler: TProcedure): JDom7; overload;
    function change(handler: procedure(event: JEvent)): JDom7; overload;

    function mousedown(): JDom7; overload;
    function mousedown(handler: TProcedure): JDom7; overload;
    function mousedown(handler: procedure(event: JEvent)): JDom7; overload;

    function mousemove(): JDom7; overload;
    function mousemove(handler: TProcedure): JDom7; overload;
    function mousemove(handler: procedure(event: JEvent)): JDom7; overload;

    function mouseup(): JDom7; overload;
    function mouseup(handler: TProcedure): JDom7; overload;
    function mouseup(handler: procedure(event: JEvent)): JDom7; overload;

    function mouseenter(): JDom7; overload;
    function mouseenter(handler: TProcedure): JDom7; overload;
    function mouseenter(handler: procedure(event: JEvent)): JDom7; overload;

    function mouseleave(): JDom7; overload;
    function mouseleave(handler: TProcedure): JDom7; overload;
    function mouseleave(handler: procedure(event: JEvent)): JDom7; overload;

    function mouseout(): JDom7; overload;
    function mouseout(handler: TProcedure): JDom7; overload;
    function mouseout(handler: procedure(event: JEvent)): JDom7; overload;

    function mouseover(): JDom7; overload;
    function mouseover(handler: TProcedure): JDom7; overload;
    function mouseover(handler: procedure(event: JEvent)): JDom7; overload;

    function touchstart(): JDom7; overload;
    function touchstart(handler: TProcedure): JDom7; overload;
    function touchstart(handler: procedure(event: JEvent)): JDom7; overload;

    function touchend(): JDom7; overload;
    function touchend(handler: TProcedure): JDom7; overload;
    function touchend(handler: procedure(event: JEvent)): JDom7; overload;

    function touchmove(): JDom7; overload;
    function touchmove(handler: TProcedure): JDom7; overload;
    function touchmove(handler: procedure(event: JEvent)): JDom7; overload;

    function resize(handler: TProcedure): JDom7; overload;
    function resize(handler: procedure(event: JEvent)): JDom7; overload;

    function scroll(handler: procedure(event: JEvent)): JDom7; overload;
    function scroll(handler: TProcedure): JDom7; overload;

//------------------------------------------------------------------------------
    //-------- Ajax --------//
    /*  $$.ajax(parameters) - Load data from the server
        parameters - object - Request parameters
        returns plain XHR object */
    //function ajax(parameters: JAjaxSettings): JDom7; overload;
    function ajax(parameters: JAjaxSettings): JDom7XHR; overload;

    /* $$.get(url, data, success) - Load data from the server using a HTTP GET request
       url - string - Request url
       data - object - A plain object or string that is sent to the server with the request. Optional
       success - function (data, status, xhr) - A callback function that is executed if the request succeeds. Optional
       returns plain XHR object  */
    function get(url: string; data: variant; success: aCallBack): JDom7; overload;
    function get(url: String; data: Variant; success: procedure(data: Variant; status: Float; xhr: JDom7XHR)): JDom7XHR; overload;

    /* $$.post(url, data, success) - Load data from the server using a HTTP POST request
       url - string - Request url
       data - object - A plain object or FormData or string that is sent to the server with the request. Optional
       success - function (data, status, xhr) - A callback function that is executed if the request succeeds. Optional
       returns plain XHR object
    */
    function post(url: string; data: variant; success: aCallBack): JDom7; overload;
    function post(url: String; data: Variant; success: procedure(data: Variant; status: Float; xhr: JDom7XHR)): JDom7XHR; overload;

    /*
      $$.getJSON(url, data, success) - Load JSON-encoded data from the server using a GET HTTP request
      url - string - Request url
      data - object - A plain object or FormData or string that is sent to the server with the request. Optional
      success - function (data, status, xhr) - A callback function that is executed if the request succeeds. Optional
      returns plain XHR object
    */
    function getJSON(url: string; data: variant=undefined; success: variant=undefined): JDom7; overload;
    function getJSON(url: String; data: Variant; success: procedure(data: Variant; status: Float; xhr: JDom7XHR)): JDom7XHR; overload;
end;

  var window external "window" : THandle;
  function this: variant; external 'this' property;
  function SMS_(selector: variant): JDom7; external 'window.smartms';
  function SMS(selector: variant): Variant; external 'window.smartms';

implementation

end.
