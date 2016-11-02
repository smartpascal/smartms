unit uPromise;

interface

uses
  SmartCL.System, W3C.Console, W3C.HTML5, W3C.DOM, W3C.XMLHttpRequest;

type
  JDeferred = class;
  TCallback = procedure(Value: Variant);
  TCallbackFn = procedure(d: variant; f: variant);
  TJDeferred_object_new_fn_ = function (d: TCallback): variant;
  TJDeferred_object_new_fn  = procedure (resolve: TCallback; reject: TCallback);
  TPromiseCallback = function(Value: Variant): Variant;
	TEventHandler = function(event: variant): Variant;

  JPromise = class external "Promise"
    constructor create(fn: TJDeferred_object_new_fn_{ = nil}); overload;
    constructor create(resolve: TJDeferred_object_new_fn_; reject: TJDeferred_object_new_fn_); overload;
    constructor create(fn: TJDeferred_object_new_fn); overload;
    function always(alwaysCallbacks: array of variant): JPromise;
    function done(doneCallbacks: array of variant): JPromise; overload;
    function done(doneCallbacks: variant): JPromise; overload;
    function fail(failCallbacks: array of variant): JPromise;
    function progress(progressCallbacks: array of variant): JPromise;
    function state(): string;
    function &then(doneCallbacks: variant; failCallbacks: variant = undefined; progressCallbacks: variant = undefined): JPromise;
    function &then(onFulfilled: TPromiseCallback = nil): JPromise; overload;
    function &then(onFulfilled: TPromiseCallback; onRejected: TPromiseCallback): JPromise; overload;
    function catch(rejectCallback: Variant = nil): JPromise; overload;
    function catch(rejectCallback: TPromiseCallback): JPromise; overload;
    class function promise(target: Variant): JPromise;
  end;

type
  JDeferred = class external "Promise"(JPromise)
    function notify(args: array of variant): JDeferred;
    function notifyWith(context: variant; args: array of variant): JDeferred;
    function reject(args: array of variant): JDeferred; overload;
    function reject(args: variant): JDeferred; overload;
    function reject(args: TEventHandler): JDeferred; overload;
    function rejectWith(context: variant; args: array of variant): JDeferred;
    function resolve(args: array of variant): JDeferred; overload;
    class function resolve(value: variant = nil): JPromise; overload;
    function resolveWith(context: variant; args: array of variant): JDeferred;
    function all(iterable: Array of Variant): JPromise;
    function race(iterable: Array of Variant): JPromise;
  end;

  { global external functions }
  function Promise : JDeferred; external 'Promise' property;
  function Error(message: variant): variant; external 'Error';
  function document: variant; external "document" property;
  function window : Variant; external 'window' property;
  function &typeof(obj:variant): variant; overload; external "typeof";

  function getImage(url: variant): JPromise;

implementation

function getImage(url: variant): JPromise;
begin
Result := JPromise.create(
  procedure(resolve: TCallback; reject: TCallback)
  var img: JHTMLImageElement;
  var rand := round( random() * 1000 ); // add random delay to resolve and reject to accentuate asynchronicity
  begin
    img := JHTMLImageElement(Document.createElement('img'));
    JGlobalEventHandlers(img).onload := lambda
      w3_SetTimeout(lambda()
        resolve(url);
      end, rand);
    end;
    JGlobalEventHandlers(img).onerror := lambda
      w3_SetTimeout(lambda()
        reject(url);
      end, rand);
    end;
    img.src := url;
end);
end;

end.
