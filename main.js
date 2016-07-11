var $R = [
	"Method %s in class %s threw exception [%s]",
	"Procedure %s threw exception [%s]",
	"Internal tag-object is null error",
	"Failed to create internal tag-object",
	"Invalid tag handle error",
	"Invalid attribute-name error",
	"Invalid property-name error",
	"Invalid style-name error",
	"Failed to attach element to owner",
	"Owner tag-object is NIL error",
	"invalid owner handle error",
	"Failed to initialize from graphics-context: ",
	"Invalid component registration",
	"Failed to create attribute storage object, invalid handle error",
	"Failed to read attribute field, browser threw exception: %s",
	"Failed to write attribute field, browser threw exception: %s",
	"invalid owner handle error"];
function Trim$_String_Integer_Integer_(s,a,b) { if (a<0) a=0; if (b<0) b=0; return s.substr(a,s.length-a-b) }
function Trim$_String_(s) { return s.replace(/^\s\s*/, "").replace(/\s\s*$/, "") }
var TObject={
	$ClassName: "TObject",
	$Parent: null,
	ClassName: function (s) { return s.$ClassName },
	ClassType: function (s) { return s },
	ClassParent: function (s) { return s.$Parent },
	$Init: function () {},
	Create: function (s) { return s },
	Destroy: function (s) { for (var prop in s) if (s.hasOwnProperty(prop)) delete s.prop },
	Destroy$: function(s) { return s.ClassType.Destroy(s) },
	Free: function (s) { if (s!==null) s.ClassType.Destroy(s) }
}
function StrReplace(s,o,n) { return o?s.replace(new RegExp(StrRegExp(o), "g"), n):s }
function StrRegExp(s) { return s.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&") }
function SameText(a,b) { return a.toUpperCase()==b.toUpperCase() }
function IntToHex2(v) { var r=v.toString(16); return (r.length==1)?"0"+r:r }
/**
sprintf() for JavaScript 0.7-beta1
http://www.diveintojavascript.com/projects/javascript-sprintf

Copyright (c) Alexandru Marasteanu <alexaholic [at) gmail (dot] com>
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of sprintf() for JavaScript nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL Alexandru Marasteanu BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
**/

var sprintf = (function() {
	function get_type(variable) {
		return Object.prototype.toString.call(variable).slice(8, -1).toLowerCase();
	}
	function str_repeat(input, multiplier) {
		for (var output = []; multiplier > 0; output[--multiplier] = input) {/* do nothing */}
		return output.join('');
	}

	var str_format = function() {
		if (!str_format.cache.hasOwnProperty(arguments[0])) {
			str_format.cache[arguments[0]] = str_format.parse(arguments[0]);
		}
		return str_format.format.call(null, str_format.cache[arguments[0]], arguments);
	};

	str_format.format = function(parse_tree, argv) {
		var cursor = 1, tree_length = parse_tree.length, node_type = '', arg, output = [], i, k, match, pad, pad_character, pad_length;
		for (i = 0; i < tree_length; i++) {
			node_type = get_type(parse_tree[i]);
			if (node_type === 'string') {
				output.push(parse_tree[i]);
			}
			else if (node_type === 'array') {
				match = parse_tree[i]; // convenience purposes only
				if (match[2]) { // keyword argument
					arg = argv[cursor];
					for (k = 0; k < match[2].length; k++) {
						if (!arg.hasOwnProperty(match[2][k])) {
							throw(sprintf('[sprintf] property "%s" does not exist', match[2][k]));
						}
						arg = arg[match[2][k]];
					}
				}
				else if (match[1]) { // positional argument (explicit)
					arg = argv[match[1]];
				}
				else { // positional argument (implicit)
					arg = argv[cursor++];
				}

				if (/[^s]/.test(match[8]) && (get_type(arg) != 'number')) {
					throw(sprintf('[sprintf] expecting number but found %s', get_type(arg)));
				}
				switch (match[8]) {
					case 'b': arg = arg.toString(2); break;
					case 'c': arg = String.fromCharCode(arg); break;
					case 'd': arg = String(parseInt(arg, 10)); if (match[7]) { arg = str_repeat('0', match[7]-arg.length)+arg } break;
					case 'e': arg = match[7] ? arg.toExponential(match[7]) : arg.toExponential(); break;
					case 'f': arg = match[7] ? parseFloat(arg).toFixed(match[7]) : parseFloat(arg); break;
					case 'o': arg = arg.toString(8); break;
					case 's': arg = ((arg = String(arg)) && match[7] ? arg.substring(0, match[7]) : arg); break;
					case 'u': arg = Math.abs(arg); break;
					case 'x': arg = arg.toString(16); break;
					case 'X': arg = arg.toString(16).toUpperCase(); break;
				}
				arg = (/[def]/.test(match[8]) && match[3] && arg >= 0 ? '+'+ arg : arg);
				pad_character = match[4] ? match[4] == '0' ? '0' : match[4].charAt(1) : ' ';
				pad_length = match[6] - String(arg).length;
				pad = match[6] ? str_repeat(pad_character, pad_length) : '';
				output.push(match[5] ? arg + pad : pad + arg);
			}
		}
		return output.join('');
	};

	str_format.cache = {};

	str_format.parse = function(fmt) {
		var _fmt = fmt, match = [], parse_tree = [], arg_names = 0;
		while (_fmt) {
			if ((match = /^[^\x25]+/.exec(_fmt)) !== null) {
				parse_tree.push(match[0]);
			}
			else if ((match = /^\x25{2}/.exec(_fmt)) !== null) {
				parse_tree.push('%');
			}
			else if ((match = /^\x25(?:([1-9]\d*)\$|\(([^\)]+)\))?(\+)?(0|'[^$])?(-)?(\d+)?(?:\.(\d+))?([b-fosuxX])/.exec(_fmt)) !== null) {
				if (match[2]) {
					arg_names |= 1;
					var field_list = [], replacement_field = match[2], field_match = [];
					if ((field_match = /^([a-z_][a-z_\d]*)/i.exec(replacement_field)) !== null) {
						field_list.push(field_match[1]);
						while ((replacement_field = replacement_field.substring(field_match[0].length)) !== '') {
							if ((field_match = /^\.([a-z_][a-z_\d]*)/i.exec(replacement_field)) !== null) {
								field_list.push(field_match[1]);
							}
							else if ((field_match = /^\[(\d+)\]/.exec(replacement_field)) !== null) {
								field_list.push(field_match[1]);
							}
							else {
								throw('[sprintf] huh?');
							}
						}
					}
					else {
						throw('[sprintf] huh?');
					}
					match[2] = field_list;
				}
				else {
					arg_names |= 2;
				}
				if (arg_names === 3) {
					throw('[sprintf] mixing positional and named placeholders is not (yet) supported');
				}
				parse_tree.push(match);
			}
			else {
				throw('[sprintf] huh?');
			}
			_fmt = _fmt.substring(match[0].length);
		}
		return parse_tree;
	};

	return str_format;
})();
function Format(f,a) { a.unshift(f); return sprintf.apply(null,a) }
function FloatToStr$_Float_(i) { return i.toString() }
function FloatToStr$_Float_Integer_(i,p) { return (p==99)?i.toString():i.toFixed(p) }
var Exception={
	$ClassName: "Exception",
	$Parent: TObject,
	$Init: function () { FMessage="" },
	Create: function (s,Msg) { s.FMessage=Msg; return s }
}
function Delete(s,i,n) { var v=s.v; if ((i<=0)||(i>v.length)||(n<=0)) return; s.v=v.substr(0,i-1)+v.substr(i+n-1); }
function ClampInt(v,mi,ma) { return v<mi ? mi : v>ma ? ma : v }
function $W(e) { return e.ClassType?e:Exception.Create($New(Exception),e.constructor.name+", "+e.message) }
function $SetInc(s,v,m,n) { v-=m; if (v>=0 && v<n) s[v>>5]|=1<<(v&31) }
function $SetIn(s,v,m,n) { v-=m; return (v<0 && v>=n)?false:(s[v>>5]&(1<<(v&31)))!=0 }
function $SetExc(s,v,m,n) { v-=m; if (v>=0 && v<n) s[v>>5]&=~(1<<(v&31)) }
function $NewDyn(c,z) {
	if (c==null) throw Exception.Create($New(Exception),"ClassType is nil"+z);
	var i={ClassType:c};
	c.$Init(i);
	return i
}
function $New(c) { var i={ClassType:c}; c.$Init(i); return i }
function $Is(o,c) {
	if (o===null) return false;
	return $Inh(o.ClassType,c);
}
;
function $Inh(s,c) {
	if (s===null) return false;
	while ((s)&&(s!==c)) s=s.$Parent;
	return (s)?true:false;
}
;
function $Event1(i,f) {
	var li=i,lf=f;
	return function(a) {
		return lf.call(li,li,a)
	}
}
function $Event0(i,f) {
	var li=i,lf=f;
	return function() {
		return lf.call(li,li)
	}
}
function $AsClass(s,c) {
	if ((s===null)||$Inh(s,c)) return s;
	throw Exception.Create($New(Exception),"Cannot cast class \""+s.$ClassName+"\" to class \""+c.$ClassName+"\"");
}
function $As(o,c) {
	if ((o===null)||$Is(o,c)) return o;
	throw Exception.Create($New(Exception),"Cannot cast instance of type \""+o.ClassType.$ClassName+"\" to class \""+c.$ClassName+"\"");
}
function $ArraySwap(a,i1,i2) { var t=a[i1]; a[i1]=a[i2]; a[i2]=t }
function WriteLn(value$5) {
   if (BrowserAPI().Console) {
      BrowserAPI().Console.log(value$5);
   }
};
function w3_setStyle(tagRef, aStyleName, aStyleValue) {
   tagRef.style[aStyleName] = aStyleValue;
};
function w3_setElementParentByRef(aElement, aParent) {
   aParent.appendChild(aElement);
};
function w3_setAttrib(tagRef$1, aAttribName, aValue) {
   tagRef$1.setAttribute(aAttribName,aValue);
};
function w3_RequestAnimationFrame(aMethod) {
   var Result = undefined;
   if (!vRequestAnimFrame) {
      InitAnimationFrameShim();
   }
   Result = vRequestAnimFrame(aMethod);
   return Result
};
function w3_RemoveEvent(a_tagRef, a_eventName, a_callback, a_useCapture) {
   if (a_eventName=="mousewheel") {
      a_eventName = "DOMMouseScroll";
   }
   a_tagRef.removeEventListener(a_eventName,a_callback,a_useCapture);
};
function w3_RemoveElementByRef(aElement$1, aParent$1) {
   aParent$1.removeChild(aElement$1);
};
function w3_RemoveClass(tagRef$2, aClassName) {
   var reg;
   reg = new RegExp("(\\s|^)" + aClassName + "(\\s|$)");
    (tagRef$2).className=(tagRef$2).className.replace(reg," ").replace('  ',' ').trim();
};
function w3_NameToUrlStr(aUrl) {
   var Result = "";
   Result = "url("+aUrl+")";
   return Result
};
function w3_HasClass(tagRef$3, aClassName$1) {
   var Result = false;
   Result = ((tagRef$3).className.match(new RegExp("(\\s|^)"+aClassName$1+"(\\s|$)")))?true:false;
   return Result
};
function w3_GetUniqueObjId() {
   var Result = "";
   ++vUniqueNumber;
   Result = "OBJ"+vUniqueNumber.toString();
   return Result
};
function w3_GetUniqueNumber() {
   var Result = 0;
   ++vUniqueNumber;
   Result = vUniqueNumber;
   return Result
};
function w3_getStyleAsStr(tagRef$4, aStyleName$1) {
   var Result = "";
   var mObj = undefined;
   var mData;
   mObj   = document.defaultView.getComputedStyle(tagRef$4,null);

    if (mObj)
    mData = (mObj).getPropertyValue(aStyleName$1);

    if (mData)
    {
      if (typeof(mData) === "number") {
        Result = String(mData);
      } else {
        if (typeof(mData) === "string")
        Result = mData;
      }
    }
   return Result
};
function w3_getStyleAsInt(tagRef$5, aStyleName$2) {
   var Result = 0;
   var mObj$1 = undefined;
   var mData$1;
   mObj$1   = document.defaultView.getComputedStyle(tagRef$5,null);

    if (mObj$1)
      mData$1 = (mObj$1).getPropertyValue(aStyleName$2);

    if (mData$1)
    {
      if (typeof(mData$1) === "number")
      {
        Result = mData$1;
      } else {
        if (typeof(mData$1) === "string")
        {
          mData$1 = parseInt(mData$1);
          if (typeof(mData$1) === "number")
          Result = mData$1;
        }
      }
    }
   return Result
};
function w3_getStyleAsFloat(tagRef$6, aStyleName$3) {
   var Result = 0;
   var mObj$2 = undefined;
   var mData$2;
   mObj$2   = document.defaultView.getComputedStyle(tagRef$6,null);

    if (mObj$2)
    mData$2 = (mObj$2).getPropertyValue(aStyleName$3);

    if (mData$2)
    {
      if (typeof(mData$2) === "number") {
        Result = mData$2
      } else {
        if (typeof(mData$2) === "string")
        {
          mData$2 = parseFloat(mData$2);
          if (!isNaN(mData$2))
          Result = mData$2;
        }
      }
    }
   return Result
};
function w3_getStyle(tagRef$7, aStyleName$4) {
   var Result = undefined;
   var mObj$3 = undefined;
   mObj$3   = document.defaultView.getComputedStyle(tagRef$7,null);
    if (mObj$3)
    Result = (mObj$3).getPropertyValue(aStyleName$4);
   return Result
};
function w3_getPropertyAsInt(tagRef$8, aPropName) {
   var Result = 0;
   Result = parseInt(tagRef$8[aPropName],10);
   return Result
};
function w3_getAttribAsStr(tagRef$9, aAttribName$1, default$1) {
   var Result = "";
   var mRef = undefined;
   mRef = tagRef$9.getAttribute(aAttribName$1,0);
   if (mRef) {
      Result = String(mRef);
   } else {
      Result = default$1;
   }
   return Result
};
function w3_CSSPrefixDef(aCSS) {
   var Result = "";
   Result = "-"+BrowserAPIx.CSSToken+"-"+aCSS;
   return Result
};
function w3_CSSPrefix(aCSS$1) {
   var Result = "";
   Result = BrowserAPIx.CSSToken+aCSS$1;
   return Result
};
function w3_createHtmlElement(aTypeName) {
   var Result = undefined;
   Result = BrowserAPI().Document.createElement(aTypeName);
   return Result
};
function w3_bind2(obj_ref, event_name, callback) {
   obj_ref[event_name] = callback;
};
function w3_AddEvent(a_tagRef$1, a_eventName$1, a_callback$1, a_useCapture$1) {
   if (a_eventName$1=="mousewheel") {
      a_eventName$1 = "DOMMouseScroll";
   }
   a_tagRef$1.addEventListener(a_eventName$1,a_callback$1,a_useCapture$1);
};
function w3_AddClass(tagRef$10, aClassName$2) {
   var _qr = ((tagRef$10).className.match(new RegExp("(\\s|^)"+aClassName$2+"(\\s|$)"))) ? true : false;
    if (_qr === false)
      (tagRef$10).className += (" " + aClassName$2);
};
/// TW3BrowserVendor enumeration
///  [line: 159, column: 3, file: SmartCL.System]
var TW3BrowserVendor = [ "bvUnknown", "bviOS", "bvAndroid", "bvChrome", "bvSafari", "bvFirefox", "bvOpera", "bvIE" ];
/// function TControlHandleHelper.Ready(const Self: TControlHandle) : Boolean
///  [line: 387, column: 32, file: SmartCL.System]
function TControlHandleHelper$Ready(Self$2) {
   var Result = false;
   var mRef$2 = undefined;
   if (TControlHandleHelper$Valid(Self$2)) {
      mRef$2 = TControlHandleHelper$Root(Self$2);
      Result = TControlHandleHelper$Valid(mRef$2)&&mRef$2.body;
   }
   return Result
}
/// procedure TControlHandleHelper.ReadyExecute(const Self: TControlHandle; OnReady: TProcedureRef)
///  [line: 448, column: 32, file: SmartCL.System]
function TControlHandleHelper$ReadyExecute(Self$3, OnReady) {
   function DelayedDispatch(EntryPoint, Delay) {
      setTimeout(EntryPoint,Delay);
   };
   if (TControlHandleHelper$Valid(Self$3)) {
      if (TControlHandleHelper$Ready(Self$3)) {
         OnReady();
      } else {
         DelayedDispatch(function () {
            TControlHandleHelper$ReadyExecute(Self$3,OnReady);
         },100);
      }
   }
}
/// function TControlHandleHelper.Root(const Self: TControlHandle) : TControlHandle
///  [line: 405, column: 32, file: SmartCL.System]
function TControlHandleHelper$Root(Self$4) {
   var Result = undefined;
   var mAncestor = undefined;
   if (TControlHandleHelper$Valid(Self$4)) {
      mAncestor = Self$4;
      while (mAncestor.parentNode) {
         mAncestor = mAncestor.parentNode;
      }
      Result = mAncestor;
   } else {
      Result = null;
   }
   return Result
}
/// function TControlHandleHelper.Valid(const Self: TControlHandle) : Boolean
///  [line: 380, column: 32, file: SmartCL.System]
function TControlHandleHelper$Valid(Self$5) {
   var Result = false;
   Result = !( (Self$5 == undefined) || (Self$5 == null) );
   return Result
}
function BrowserAPI() {
   var Result = undefined;
   Result = BrowserAPIx;
   return Result
};
function InitAnimationFrameShim() {
   vRequestAnimFrame = (function(){
      return  window.requestAnimationFrame       ||
              window.webkitRequestAnimationFrame ||
              window.mozRequestAnimationFrame    ||
              window.msRequestAnimationFrame     ||
              function( callback ){
                return window.setTimeout(callback, 1000 / 60);
              };
    })();
    vCancelAnimFrame = (function(){
      return  window.cancelAnimationFrame       ||
              window.webkitCancelAnimationFrame ||
              window.mozCancelAnimationFrame    ||
              window.msCancelAnimationFrame     ||
              function( handle ){
                window.clearTimeout(handle);
              };
    })();
};
/// anonymous TClassSymbol
function VarIsValidRef(aRef) {
   var Result = false;
   Result = !((aRef == null) || (aRef == undefined));
   return Result
};
/// function TW3VariantHelper.IsArray(const Self: Variant) : Boolean
///  [line: 545, column: 27, file: System.Types]
function TW3VariantHelper$IsArray(Self$6) {
   var Result = false;
   Result = ((Self$6) !== undefined)
      && (typeof Self$6 !== null)
      && (typeof Self$6 === "object")
      && ((Self$6).length !== undefined);
   return Result
}
/// function TW3VariantHelper.IsBoolean(const Self: Variant) : Boolean
///  [line: 507, column: 27, file: System.Types]
function TW3VariantHelper$IsBoolean(Self$7) {
   var Result = false;
   Result = ((Self$7) !== undefined)
      && (typeof Self$7 !== null)
      && (typeof Self$7  === "boolean");
   return Result
}
/// function TW3VariantHelper.IsFloat(const Self: Variant) : Boolean
///  [line: 525, column: 27, file: System.Types]
function TW3VariantHelper$IsFloat(Self$8) {
   var Result = false;
   Result = ((Self$8) !== undefined)
      && (typeof Self$8 !== null)
      && (typeof Self$8  === "number")
      && (Math.round(Self$8) != Self$8);
   return Result
}
/// function TW3VariantHelper.IsFunction(const Self: Variant) : Boolean
///  [line: 498, column: 27, file: System.Types]
function TW3VariantHelper$IsFunction(Self$9) {
   var Result = false;
   Result = ((Self$9) !== undefined)
      && (typeof Self$9 !== null)
      && (typeof Self$9  === "function");
   return Result
}
/// function TW3VariantHelper.IsInteger(const Self: Variant) : Boolean
///  [line: 535, column: 27, file: System.Types]
function TW3VariantHelper$IsInteger$1(Self$10) {
   var Result = false;
   Result = ((Self$10) !== undefined)
      && (typeof Self$10 !== null)
      && (typeof Self$10  === "number")
      && (Math.round(Self$10) === Self$10);
   return Result
}
/// function TW3VariantHelper.IsObject(const Self: Variant) : Boolean
///  [line: 479, column: 27, file: System.Types]
function TW3VariantHelper$IsObject(Self$11) {
   var Result = false;
   Result = ((Self$11) !== undefined)
      && (typeof Self$11 !== null)
      && (typeof Self$11  === "object")
      && ((Self$11).length === undefined);
   return Result
}
/// function TW3VariantHelper.IsString(const Self: Variant) : Boolean
///  [line: 516, column: 27, file: System.Types]
function TW3VariantHelper$IsString$1(Self$12) {
   var Result = false;
   Result = ((Self$12) !== undefined)
      && (typeof Self$12 !== null)
      && (typeof Self$12  === "string");
   return Result
}
/// function TW3VariantHelper.IsSymbol(const Self: Variant) : Boolean
///  [line: 489, column: 27, file: System.Types]
function TW3VariantHelper$IsSymbol(Self$13) {
   var Result = false;
   Result = ((Self$13) !== undefined)
      && (typeof Self$13 !== null)
      && (typeof Self$13  === "symbol");
   return Result
}
/// TW3VariantDataType enumeration
///  [line: 331, column: 3, file: System.Types]
var TW3VariantDataType = [ "vdUnknown", "vdBoolean", "vdInteger", "vdFloat", "vdString", "vdSymbol", "vdFunction", "vdObject", "vdArray" ];
/// TW3OwnedObject = class (TObject)
///  [line: 113, column: 3, file: System.Types]
var TW3OwnedObject = {
   $ClassName:"TW3OwnedObject",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FOwner = null;
   }
   /// function TW3OwnedObject.AcceptParent(aObject: TObject) : Boolean
   ///  [line: 398, column: 25, file: System.Types]
   ,AcceptParent:function(Self, aObject) {
      var Result = false;
      Result = true;
      return Result
   }
   /// constructor TW3OwnedObject.Create(AOwner: TObject)
   ///  [line: 388, column: 28, file: System.Types]
   ,Create$11:function(Self, AOwner) {
      TObject.Create(Self);
      if (TW3OwnedObject.AcceptParent$(Self,AOwner)) {
         Self.FOwner = AOwner;
      } else {
         throw EW3Exception.CreateFmt($New(EW3OwnedObject),$R[0],["constructor", TObject.ClassName(Self.ClassType), "Unsuitable owner object-type error"]);
      }
      return Self
   }
   ,Destroy:TObject.Destroy
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11$:function($){return $.ClassType.Create$11.apply($.ClassType, arguments)}
};
/// TVariant = class (TObject)
///  [line: 305, column: 3, file: System.Types]
var TVariant = {
   $ClassName:"TVariant",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
   }
   /// function TVariant.AsInteger(const aValue: Variant) : Integer
   ///  [line: 1573, column: 25, file: System.Types]
   ,AsInteger:function(aValue$1) {
      var Result = 0;
      if (aValue$1!=undefined&&aValue$1!=null) {
         Result = parseInt(aValue$1,10);
      }
      return Result
   }
   /// function TVariant.AsObject(const aValue: Variant) : TObject
   ///  [line: 1594, column: 25, file: System.Types]
   ,AsObject:function(aValue$2) {
      var Result = null;
      if (aValue$2!=undefined&&aValue$2!=null) {
         Result = aValue$2;
      }
      return Result
   }
   /// function TVariant.AsString(const aValue: Variant) : String
   ///  [line: 1580, column: 25, file: System.Types]
   ,AsString:function(aValue$3) {
      var Result = "";
      if (aValue$3!=undefined&&aValue$3!=null) {
         Result = String(aValue$3);
      }
      return Result
   }
   /// function TVariant.CreateObject() : Variant
   ///  [line: 1613, column: 25, file: System.Types]
   ,CreateObject:function() {
      var Result = undefined;
      return {};
      return Result
   }
   /// function TVariant.IsNumber(const aValue: Variant) : Boolean
   ///  [line: 1641, column: 25, file: System.Types]
   ,IsNumber:function(aValue$4) {
      var Result = false;
      if (aValue$4 == null) return false;
    if (aValue$4 == undefined) return false;
    if (typeof(aValue$4) === "number") return true;
      return Result
   }
   /// function TVariant.IsString(const aValue: Variant) : Boolean
   ///  [line: 1632, column: 25, file: System.Types]
   ,IsString:function(aValue$5) {
      var Result = false;
      if (aValue$5 == null) return false;
    if (aValue$5 == undefined) return false;
    if (typeof(aValue$5) === "string") return true;
      return Result
   }
   /// function TVariant.ValidRef(const aValue: Variant) : Boolean
   ///  [line: 1566, column: 25, file: System.Types]
   ,ValidRef:function(aValue$6) {
      var Result = false;
      Result = !((aValue$6 == null) || (aValue$6 == undefined));
      return Result
   }
   ,Destroy:TObject.Destroy
};
/// TRectF = record
///  [line: 238, column: 3, file: System.Types]
function Copy$TRectF(s,d) {
   d.Bottom=s.Bottom;
   d.Left=s.Left;
   d.Right=s.Right;
   d.Top=s.Top;
   return d;
}
function Clone$TRectF($) {
   return {
      Bottom:$.Bottom,
      Left:$.Left,
      Right:$.Right,
      Top:$.Top
   }
}
/// function TRectF.CreateBounded(x1: Float; y1: Float; x2: Float; y2: Float) : TRectF
///  [line: 1054, column: 23, file: System.Types]
function CreateBounded(x1$6, y1$6, x2$6, y2$6) {
   var Result = {Bottom:0,Left:0,Right:0,Top:0};
   if (x1$6<x2$6) {
      Result.Left = x1$6;
      Result.Right = x2$6;
   } else {
      Result.Left = x2$6;
      Result.Right = x1$6;
   }
   if (y1$6<y2$6) {
      Result.Top = y1$6;
      Result.Bottom = y2$6;
   } else {
      Result.Top = y2$6;
      Result.Bottom = y1$6;
   }
   return Result
}
/// function TRectF.Height(var Self: TRectF) : Float
///  [line: 1178, column: 17, file: System.Types]
function TRectF$Height(Self$14) {
   var Result = 0;
   Result = Self$14.Bottom-Self$14.Top;
   return Result
}
/// function TRectF.Width(var Self: TRectF) : Float
///  [line: 1173, column: 17, file: System.Types]
function TRectF$Width(Self$15) {
   var Result = 0;
   Result = Self$15.Right-Self$15.Left;
   return Result
}
/// TRect = record
///  [line: 202, column: 3, file: System.Types]
function Copy$TRect(s,d) {
   d.Bottom$1=s.Bottom$1;
   d.Left$1=s.Left$1;
   d.Right$1=s.Right$1;
   d.Top$1=s.Top$1;
   return d;
}
function Clone$TRect($) {
   return {
      Bottom$1:$.Bottom$1,
      Left$1:$.Left$1,
      Right$1:$.Right$1,
      Top$1:$.Top$1
   }
}
/// function TRect.Height(var Self: TRect) : Integer
///  [line: 833, column: 16, file: System.Types]
function TRect$Height$1(Self$16) {
   var Result = 0;
   Result = Self$16.Bottom$1-Self$16.Top$1;
   return Result
}
/// function TRect.Width(var Self: TRect) : Integer
///  [line: 828, column: 16, file: System.Types]
function TRect$Width$1(Self$17) {
   var Result = 0;
   Result = Self$17.Right$1-Self$17.Left$1;
   return Result
}
/// TPointF = record
///  [line: 161, column: 3, file: System.Types]
function Copy$TPointF(s,d) {
   d.X=s.X;
   d.Y=s.Y;
   return d;
}
function Clone$TPointF($) {
   return {
      X:$.X,
      Y:$.Y
   }
}
/// TPoint = record
///  [line: 126, column: 3, file: System.Types]
function Copy$TPoint(s,d) {
   d.X$1=s.X$1;
   d.Y$1=s.Y$1;
   return d;
}
function Clone$TPoint($) {
   return {
      X$1:$.X$1,
      Y$1:$.Y$1
   }
}
/// function TPoint.Create(const aCol: Integer; const aRow: Integer) : TPoint
///  [line: 564, column: 23, file: System.Types]
function Create$17(aCol, aRow) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = aCol;
   Result.Y$1 = aRow;
   return Result
}
/// TPairData = record
///  [line: 359, column: 3, file: System.Types]
function Copy$TPairData(s,d) {
   return d;
}
function Clone$TPairData($) {
   return {

   }
}
/// TInteger = class (TObject)
///  [line: 272, column: 3, file: System.Types]
var TInteger = {
   $ClassName:"TInteger",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
   }
   /// function TInteger.Diff(const Primary: Integer; const Secondary: Integer) : Integer
   ///  [line: 1441, column: 25, file: System.Types]
   ,Diff:function(Primary, Secondary) {
      var Result = 0;
      if (Primary!=Secondary) {
         if (Primary>Secondary) {
            Result = Primary-Secondary;
         } else {
            Result = Secondary-Primary;
         }
         if (Result<0) {
            Result = (Result-1)^(-1);
         }
      } else {
         Result = 0;
      }
      return Result
   }
   /// function TInteger.ToPxStr(const aValue: Integer) : String
   ///  [line: 1373, column: 25, file: System.Types]
   ,ToPxStr:function(aValue$7) {
      var Result = "";
      Result = aValue$7.toString()+"px";
      return Result
   }
   /// function TInteger.WrapRange(const aValue: Integer; const aLowRange: Integer; const aHighRange: Integer) : Integer
   ///  [line: 1409, column: 25, file: System.Types]
   ,WrapRange:function(aValue$8, aLowRange, aHighRange) {
      var Result = 0;
      if (aValue$8>aHighRange) {
         Result = aLowRange+TInteger.Diff(aHighRange,(aValue$8-1));
         if (Result>aHighRange) {
            Result = TInteger.WrapRange(Result,aLowRange,aHighRange);
         }
      } else if (aValue$8<aLowRange) {
         Result = aHighRange-TInteger.Diff(aLowRange,(aValue$8+1));
         if (Result<aLowRange) {
            Result = TInteger.WrapRange(Result,aLowRange,aHighRange);
         }
      } else {
         Result = aValue$8;
      }
      return Result
   }
   ,Destroy:TObject.Destroy
};
/// TExposure enumeration
///  [line: 199, column: 3, file: System.Types]
var TExposure = [ "esVisible", "esPartly", "esNone" ];
/// function TBufferHandleHelper.Valid(const Self: TBufferHandle) : Boolean
///  [line: 407, column: 30, file: System.Types]
function TBufferHandleHelper$Valid$1(Self$18) {
   var Result = false;
   Result = !( (Self$18 == undefined) || (Self$18 == null) );
   return Result
}
function OffsetPoint(a$34, b$2) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = a$34.X$1+b$2.X$1;
   Result.Y$1 = a$34.Y$1+b$2.Y$1;
   return Result
};
function OffsetPoint$1(a$35, b$3) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = a$35.X$1+b$3;
   Result.Y$1 = a$35.Y$1+b$3;
   return Result
};
function OffsetPoint$2(a$36, b$4) {
   var Result = {X:0,Y:0};
   Result.X = a$36.X+b$4.X;
   Result.Y = a$36.Y+b$4.Y;
   return Result
};
function OffsetPoint$3(a$37, b$5) {
   var Result = {X:0,Y:0};
   Result.X = a$37.X+b$5;
   Result.Y = a$37.Y+b$5;
   return Result
};
function OffsetPoint$4(a$38, b$6) {
   var Result = {X:0,Y:0};
   Result.X = a$38.X+b$6;
   Result.Y = a$38.Y+b$6;
   return Result
};
function MinusPoint(a$39, b$7) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = a$39.X$1-b$7.X$1;
   Result.Y$1 = a$39.Y$1-b$7.Y$1;
   return Result
};
function MinusPoint$1(a$40, b$8) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = a$40.X$1-b$8;
   Result.Y$1 = a$40.Y$1-b$8;
   return Result
};
function MinusPoint$2(a$41, b$9) {
   var Result = {X:0,Y:0};
   Result.X = a$41.X-b$9.X;
   Result.Y = a$41.Y-b$9.Y;
   return Result
};
function MinusPoint$3(a$42, b$10) {
   var Result = {X:0,Y:0};
   Result.X = a$42.X-b$10;
   Result.Y = a$42.Y-b$10;
   return Result
};
function MinusPoint$4(a$43, b$11) {
   var Result = {X:0,Y:0};
   Result.X = a$43.X-b$11;
   Result.Y = a$43.Y-b$11;
   return Result
};
function ExpandPoint(a$44, b$12) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = Math.round(a$44.X$1*b$12.X$1);
   Result.Y$1 = Math.round(a$44.Y$1*b$12.Y$1);
   return Result
};
function ExpandPoint$1(a$45, b$13) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = Math.round(a$45.X$1*b$13);
   Result.Y$1 = Math.round(a$45.Y$1*b$13);
   return Result
};
function ExpandPoint$2(a$46, b$14) {
   var Result = {X$1:0,Y$1:0};
   Result.X$1 = Math.round(a$46.X$1*b$14);
   Result.Y$1 = Math.round(a$46.Y$1*b$14);
   return Result
};
function ExpandPoint$3(a$47, b$15) {
   var Result = {X:0,Y:0};
   Result.X = a$47.X*b$15.X;
   Result.Y = a$47.Y*b$15.Y;
   return Result
};
function ExpandPoint$4(a$48, b$16) {
   var Result = {X:0,Y:0};
   Result.X = a$48.X*b$16;
   Result.Y = a$48.Y*b$16;
   return Result
};
function ExpandPoint$5(a$49, b$17) {
   var Result = {X:0,Y:0};
   Result.X = a$49.X*b$17;
   Result.Y = a$49.Y*b$17;
   return Result
};
/// EW3Exception = class (Exception)
///  [line: 105, column: 3, file: System.Types]
var EW3Exception = {
   $ClassName:"EW3Exception",$Parent:Exception
   ,$Init:function ($) {
      Exception.$Init($);
   }
   /// constructor EW3Exception.CreateFmt(aText: String; const aValues: array of const)
   ///  [line: 457, column: 26, file: System.Types]
   ,CreateFmt:function(Self, aText, aValues) {
      Exception.Create(Self,Format(aText,aValues.slice(0)));
      return Self
   }
   ,Destroy:Exception.Destroy
};
/// EW3OwnedObject = class (EW3Exception)
///  [line: 111, column: 3, file: System.Types]
var EW3OwnedObject = {
   $ClassName:"EW3OwnedObject",$Parent:EW3Exception
   ,$Init:function ($) {
      EW3Exception.$Init($);
   }
   ,Destroy:Exception.Destroy
};
/// TW3CustomApplication = class (TObject)
///  [line: 128, column: 3, file: SmartCL.Application]
var TW3CustomApplication = {
   $ClassName:"TW3CustomApplication",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FBody = $.FCurrentForm = $.FDisplay = $.FMainForm = $.FOnBeforeUnload = $.FOnUnload = $.FTransDst = $.FTransSrc = null;
      $.FEntryEffect = 0;
      $.FFormChangeActive = $.FTerminated = false;
      $.FForms = [];
   }
   /// procedure TW3CustomApplication.AdjustScreen()
   ///  [line: 971, column: 32, file: SmartCL.Application]
   ,AdjustScreen:function(Self) {
      TW3ScrollInfo.ScrollTo(TW3CustomControl.GetScrollInfo(Self.FDisplay),0,0);
      TW3MovableControl.SetBounds$2(Self.FDisplay,0,0,TDocumentBody.GetWidth$5(Self.FBody),TDocumentBody.GetHeight$5(Self.FBody));
   }
   /// procedure TW3CustomApplication.ApplicationClosing()
   ///  [line: 1006, column: 32, file: SmartCL.Application]
   ,ApplicationClosing:function(Self) {
   }
   /// procedure TW3CustomApplication.ApplicationStarted()
   ///  [line: 996, column: 32, file: SmartCL.Application]
   ,ApplicationStarted:function(Self) {
   }
   /// procedure TW3CustomApplication.ApplicationStarting()
   ///  [line: 1001, column: 32, file: SmartCL.Application]
   ,ApplicationStarting:function(Self) {
      TW3CustomApplication.AdjustScreen(Self);
   }
   /// procedure TW3CustomApplication.CBOnBeforeUnload()
   ///  [line: 923, column: 32, file: SmartCL.Application]
   ,CBOnBeforeUnload:function(Self) {
      if (Self.FOnBeforeUnload) {
         Self.FOnBeforeUnload(Self);
      }
   }
   /// procedure TW3CustomApplication.CBOnOrientationChange()
   ///  [line: 945, column: 32, file: SmartCL.Application]
   ,CBOnOrientationChange:function(Self) {
      var mOrientation = 0;
      var mTemp$1 = 0;
      var mEntry = null;
      mTemp$1 = parseInt(BrowserAPI().Window.orientation,10);
      switch (mTemp$1) {
         case 0 :
            mOrientation = 0;
            break;
         case 90 :
            mOrientation = 1;
            break;
         case (-90) :
            mOrientation = 2;
            break;
         case 180 :
            mOrientation = 3;
            break;
      }
      try {
         if (Self.FDisplay) {
            mEntry = Self.FDisplay.FOnOrient;
            if (mEntry) {
               mEntry(Self.FDisplay,mOrientation,mTemp$1);
            }
         }
      } finally {
         TW3CustomApplication.AdjustScreen(Self);
      }
   }
   /// procedure TW3CustomApplication.CBOnReSize()
   ///  [line: 940, column: 32, file: SmartCL.Application]
   ,CBOnReSize:function(Self) {
      TW3CustomApplication.AdjustScreen(Self);
   }
   /// procedure TW3CustomApplication.CBOnUnLoad()
   ///  [line: 929, column: 32, file: SmartCL.Application]
   ,CBOnUnLoad:function(Self) {
      try {
         if (Self.FOnUnload) {
            Self.FOnUnload(Self);
         }
      } finally {
         if (!Self.FTerminated) {
            TW3CustomApplication.Terminate(Self);
         }
      }
   }
   /// constructor TW3CustomApplication.Create()
   ///  [line: 699, column: 34, file: SmartCL.Application]
   ,Create$3:function(Self) {
      TObject.Create(Self);
      Self.FBody = TW3Component.Create$24$($New(TDocumentBody),null);
      Self.FDisplay = TW3Component.Create$24$($New(TW3Display),Self.FBody);
      if (!Instance) {
         Instance = Self;
      }
      return Self
   }
   /// destructor TW3CustomApplication.Destroy()
   ///  [line: 710, column: 33, file: SmartCL.Application]
   ,Destroy:function(Self) {
      if (!Self.FTerminated) {
         TW3CustomApplication.Terminate(Self);
      }
      TObject.Free(Self.FDisplay);
      TObject.Free(Self.FBody);
      Instance = null;
      TObject.Destroy(Self);
   }
   /// procedure TW3CustomApplication.GotoFormByRef(aForm: TW3CustomForm; Effect: TFormEntryEffect = 0)
   ///  [line: 1172, column: 32, file: SmartCL.Application]
   ,GotoFormByRef:function(Self, aForm, Effect) {
      var mIndex = 0;
      if (Self.FTerminated) {
         return;
      }
      if (Self.FFormChangeActive) {
         throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.GotoFormByRef", TObject.ClassName(Self.ClassType), "A form transition is already active error"]);
      }
      if (aForm===null) {
         throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.GotoFormByRef", TObject.ClassName(Self.ClassType), "Form parameter is NIL error"]);
      }
      mIndex = Self.FForms.indexOf(aForm);
      if (mIndex<0) {
         throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.GotoFormByRef", TObject.ClassName(Self.ClassType), "Form not registered error"]);
      }
      if (aForm===Self.FCurrentForm) {
         return;
      }
      if (Self.FCurrentForm===null) {
         Self.FCurrentForm = aForm;
         TW3Display.PositionFormInView(Self.FDisplay,aForm);
         TW3MovableControl.SetVisible(aForm,true);
         TW3CustomForm.FormActivated(aForm);
         return;
      }
      TW3CustomForm.FormDeactivated(Self.FCurrentForm);
      TW3MovableControl.SetVisible(Self.FCurrentForm,false);
      TW3MovableControl.SetVisible(aForm,true);
      TW3Display.PositionFormInView(Self.FDisplay,aForm);
      TW3CustomForm.FormActivated(aForm);
      Self.FCurrentForm = aForm;
      return;
      Self.FFormChangeActive = true;
      Self.FEntryEffect = Effect;
      TW3CustomControl.BringToFront(aForm);
      TW3CustomForm.FormDeactivated(Self.FCurrentForm);
      Self.FTransSrc = Self.FCurrentForm;
      Self.FTransDst = aForm;
      TW3MovableControl.SetVisible(aForm,true);
      TW3Display.PositionFormInView(Self.FDisplay,aForm);
   }
   /// procedure TW3CustomApplication.HookWindowEvents()
   ///  [line: 732, column: 32, file: SmartCL.Application]
   ,HookWindowEvents:function(Self) {
      w3_bind2(BrowserAPI().Body,"onunload",$Event0(Self,TW3CustomApplication.CBOnUnLoad));
      w3_bind2(BrowserAPI().Body,"onbeforeunload",$Event0(Self,TW3CustomApplication.CBOnBeforeUnload));
      w3_bind2(BrowserAPI().Window,"onresize",$Event0(Self,TW3CustomApplication.CBOnReSize));
      w3_bind2(BrowserAPI().Window,"onorientationchange",$Event0(Self,TW3CustomApplication.CBOnOrientationChange));
   }
   /// procedure TW3CustomApplication.RegisterFormInstance(aForm: TW3CustomForm; isMainForm: Boolean = False)
   ///  [line: 1043, column: 32, file: SmartCL.Application]
   ,RegisterFormInstance:function(Self, aForm$1, isMainForm) {
      if (Self.FTerminated) {
         return;
      }
      if (aForm$1) {
         if (Self.FForms.indexOf(aForm$1)<0) {
            try {
               Self.FForms.push(aForm$1);
            } catch ($e) {
               var e$1 = $W($e);
               throw EW3Exception.CreateFmt($New(EW3Exception),$R[0],["TW3CustomApplication.RegisterFormInstance", TObject.ClassName(Self.ClassType), e$1.FMessage]);
            }
            w3_RequestAnimationFrame($Event0(aForm$1,TW3MovableControl.AdjustToParentBox));
            if (isMainForm) {
               Self.FMainForm = aForm$1;
            } else {
               TW3MovableControl.SetVisible(aForm$1,false);
            }
         } else {
            throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.RegisterFormInstance", TObject.ClassName(Self.ClassType), "Form already registered"]);
         }
      } else {
         throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.RegisterFormInstance", TObject.ClassName(Self.ClassType), "Form parameter is NIL error"]);
      }
   }
   /// procedure TW3CustomApplication.RunApp()
   ///  [line: 1011, column: 32, file: SmartCL.Application]
   ,RunApp:function(Self) {
      var FTemp = null;
      TW3CustomApplication.HookWindowEvents(Self);
      TW3CustomApplication.ApplicationStarting(Self);
      TApplicationFormsList.AutoCreateForms(FormsFactory(),Self.FDisplay.FView);
      if (Self.FMainForm) {
         FTemp = Self.FMainForm;
         Self.FMainForm = null;
         TW3CustomApplication.GotoFormByRef(Self,FTemp,0);
      }
      TW3CustomApplication.ApplicationStarted(Self);
   }
   /// procedure TW3CustomApplication.Terminate()
   ///  [line: 977, column: 32, file: SmartCL.Application]
   ,Terminate:function(Self) {
      var x$33 = 0;
      if (Self.FTerminated) {
         return;
      }
      Self.FTerminated = true;
      TW3CustomApplication.ApplicationClosing(Self);
      try {
         var $temp1;
         for(x$33=0,$temp1=Self.FForms.length;x$33<$temp1;x$33++) {
            TObject.Free(Self.FForms[x$33]);
            Self.FForms[x$33]=null;
         }
         Self.FForms.length=0;
      } finally {
         TObject.Free(Self);
      }
   }
   /// procedure TW3CustomApplication.UnRegisterFormInstance(aForm: TW3CustomForm)
   ///  [line: 1081, column: 32, file: SmartCL.Application]
   ,UnRegisterFormInstance:function(Self, aForm$2) {
      var mIndex$1 = 0;
      if (!Self.FTerminated) {
         if (aForm$2) {
            mIndex$1 = Self.FForms.indexOf(aForm$2);
            if (mIndex$1>=0) {
               if (Self.FMainForm!==aForm$2) {
                  if (Self.FCurrentForm===aForm$2) {
                     TW3CustomApplication.GotoFormByRef(Self,Self.FMainForm,0);
                  }
                  Self.FForms.splice(mIndex$1,1)
                  ;
                  try {
                     TObject.Free(aForm$2);
                  } catch ($e) {
                     var e$2 = $W($e);
                     throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.UnRegisterFormInstance", TObject.ClassName(Self.ClassType), e$2.FMessage]);
                  }
               } else {
                  throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.UnRegisterFormInstance", TObject.ClassName(Self.ClassType), "Main form cannot be removed error"]);
               }
            }
         } else {
            throw EW3Exception.CreateFmt($New(EW3Application),$R[0],["TW3CustomApplication.UnRegisterFormInstance", TObject.ClassName(Self.ClassType), "Form parameter is NIL error"]);
         }
      }
   }
   ,Destroy$:function($){return $.ClassType.Destroy($)}
};
/// TApplication = class (TW3CustomApplication)
///  [line: 11, column: 3, file: Unit1]
var TApplication = {
   $ClassName:"TApplication",$Parent:TW3CustomApplication
   ,$Init:function ($) {
      TW3CustomApplication.$Init($);
   }
   ,Destroy:TW3CustomApplication.Destroy
};
/// TW3DisplayViewArangeType enumeration
///  [line: 60, column: 3, file: SmartCL.Application]
var TW3DisplayViewArangeType = [ "dvaSizeToView", "dvaVStack", "dvaHStack" ];
/// TW3TagObj = class (TObject)
///  [line: 204, column: 3, file: SmartCL.Components]
var TW3TagObj = {
   $ClassName:"TW3TagObj",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FAccess = null;
      $.FComponentState = [0];
      $.FHandle = undefined;
      $.FOwner$1 = undefined;
      $.FTagId = "";
      $.FUpdating = 0;
   }
   /// procedure TW3TagObj.AddToComponentState(const Flags: TComponentState)
   ///  [line: 1121, column: 21, file: SmartCL.Components]
   ,AddToComponentState:function(Self, Flags) {
      if ($SetIn(Flags,0,0,6)) {
         $SetInc(Self.FComponentState,0,0,6);
      }
      if ($SetIn(Flags,1,0,6)) {
         $SetInc(Self.FComponentState,1,0,6);
      }
      if ($SetIn(Flags,2,0,6)) {
         $SetInc(Self.FComponentState,2,0,6);
      }
      if ($SetIn(Flags,3,0,6)) {
         $SetInc(Self.FComponentState,3,0,6);
      }
      if ($SetIn(Flags,4,0,6)) {
         $SetInc(Self.FComponentState,4,0,6);
      }
      if ($SetIn(Flags,5,0,6)) {
         $SetInc(Self.FComponentState,5,0,6);
      }
   }
   /// procedure TW3TagObj.AfterUpdate()
   ///  [line: 1161, column: 21, file: SmartCL.Components]
   ,AfterUpdate:function(Self) {
   }
   /// procedure TW3TagObj.BeginUpdate()
   ///  [line: 1146, column: 21, file: SmartCL.Components]
   ,BeginUpdate:function(Self) {
      ++Self.FUpdating;
   }
   /// constructor TW3TagObj.Create()
   ///  [line: 1041, column: 23, file: SmartCL.Components]
   ,Create$23:function(Self) {
      TObject.Create(Self);
      $SetInc(Self.FComponentState,0,0,6);
      try {
         Self.FTagId = TW3TagObj.MakeElementTagId$(Self);
         Self.FHandle = TW3TagObj.MakeElementTagObj$(Self);
      } catch ($e) {
         var e$3 = $W($e);
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.Create",Self,e$3.FMessage)      }
      $SetInc(Self.FComponentState,1,0,6);
      if (TVariant.AsObject(Self.FHandle)!==TVariant.AsObject(BrowserAPI().Body)) {
         if (Self.FTagId.length>0) {
            w3_setAttrib(Self.FHandle,"id",Self.FTagId);
         }
      }
      TW3TagObj.StyleTagObject$(Self);
      TW3TagObj.BeginUpdate(Self);
      try {
         TW3TagObj.InitializeObject$(Self);
      } finally {
         TW3TagObj.EndUpdate(Self);
      }
      setTimeout(function () {
         $SetExc(Self.FComponentState,1,0,6);
         $SetExc(Self.FComponentState,0,0,6);
      },100);
      $SetInc(Self.FComponentState,2,0,6);
      return Self
   }
   /// destructor TW3TagObj.Destroy()
   ///  [line: 1086, column: 22, file: SmartCL.Components]
   ,Destroy:function(Self) {
      $SetInc(Self.FComponentState,5,0,6);
      if (Self.FHandle) {
         try {
            TW3TagObj.UnHookEvents(Self);
            if (Self.FOwner$1) {
               TW3TagObj.RemoveFrom(Self);
            }
         } finally {
            TW3TagObj.FinalizeObject$(Self);
            Self.FTagId = "";
            Self.FHandle = null;
         }
         TObject.Destroy(Self);
      }
      if (Self.FAccess) {
         TObject.Free(Self.FAccess);
      }
      TObject.Destroy(Self);
   }
   /// procedure TW3TagObj.EndUpdate()
   ///  [line: 1151, column: 21, file: SmartCL.Components]
   ,EndUpdate:function(Self) {
      if (Self.FUpdating>0) {
         --Self.FUpdating;
         if (Self.FUpdating==0) {
            TW3TagObj.AfterUpdate$(Self);
         }
      }
   }
   /// procedure TW3TagObj.FinalizeObject()
   ///  [line: 1217, column: 21, file: SmartCL.Components]
   ,FinalizeObject:function(Self) {
   }
   /// procedure TW3TagObj.InitializeObject()
   ///  [line: 1213, column: 21, file: SmartCL.Components]
   ,InitializeObject:function(Self) {
   }
   /// procedure TW3TagObj.InsertInto(const OwnerHandle: THandle)
   ///  [line: 1265, column: 21, file: SmartCL.Components]
   ,InsertInto:function(Self, OwnerHandle) {
      if (!OwnerHandle) {
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.InsertInto",Self,$R[9]);
      }
      if (!Self.FHandle) {
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.InsertInto",Self,$R[2]);
      }
      try {
         if (Self.FOwner$1) {
            TW3TagObj.RemoveFrom(Self);
         }
         if (OwnerHandle) {
            w3_setElementParentByRef(Self.FHandle,OwnerHandle);
         }
         Self.FOwner$1 = OwnerHandle;
      } catch ($e) {
         var e$4 = $W($e);
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.InsertInto",Self,e$4.FMessage)      }
   }
   /// function TW3TagObj.MakeElementTagId() : String
   ///  [line: 1240, column: 20, file: SmartCL.Components]
   ,MakeElementTagId:function(Self) {
      var Result = "";
      Result = w3_GetUniqueObjId();
      return Result
   }
   /// function TW3TagObj.MakeElementTagObj() : THandle
   ///  [line: 1245, column: 20, file: SmartCL.Components]
   ,MakeElementTagObj:function(Self) {
      var Result = undefined;
      Result = w3_createHtmlElement("div");
      return Result
   }
   /// procedure TW3TagObj.RemoveFrom()
   ///  [line: 1289, column: 21, file: SmartCL.Components]
   ,RemoveFrom:function(Self) {
      if (Self.FOwner$1==undefined) {
         return;
      }
      if (!Self.FOwner$1) {
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.RemoveFrom",Self,$R[9]);
      }
      if (!Self.FHandle) {
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.RemoveFrom",Self,$R[2]);
      }
      try {
         w3_RemoveElementByRef(Self.FHandle,Self.FOwner$1);
         Self.FOwner$1 = undefined;
      } catch ($e) {
         var e$5 = $W($e);
         EW3TagObj.RaiseCntErrMethod("TW3TagObj.RemoveFrom",Self,e$5.FMessage)      }
   }
   /// procedure TW3TagObj.RemoveFromComponentState(const Flags: TComponentState)
   ///  [line: 1131, column: 21, file: SmartCL.Components]
   ,RemoveFromComponentState:function(Self, Flags$1) {
      if ($SetIn(Flags$1,0,0,6)) {
         $SetExc(Self.FComponentState,0,0,6);
      }
      if ($SetIn(Flags$1,1,0,6)) {
         $SetExc(Self.FComponentState,1,0,6);
      }
      if ($SetIn(Flags$1,2,0,6)) {
         $SetExc(Self.FComponentState,2,0,6);
      }
      if ($SetIn(Flags$1,3,0,6)) {
         $SetExc(Self.FComponentState,3,0,6);
      }
      if ($SetIn(Flags$1,4,0,6)) {
         $SetExc(Self.FComponentState,4,0,6);
      }
      if ($SetIn(Flags$1,5,0,6)) {
         $SetExc(Self.FComponentState,5,0,6);
      }
   }
   /// function TW3TagObj.Showing() : Boolean
   ///  [line: 1114, column: 20, file: SmartCL.Components]
   ,Showing:function(Self) {
      var Result = false;
      Result = Self.FHandle!=undefined&&Self.FHandle!=null&&$SetIn(Self.FComponentState,2,0,6);
      return Result
   }
   /// procedure TW3TagObj.StyleTagObject()
   ///  [line: 1221, column: 21, file: SmartCL.Components]
   ,StyleTagObject:function(Self) {
      Self.FHandle.style["visibility"] = "hidden";
      Self.FHandle.style["display"] = "none";
      Self.FHandle.style["position"] = "absolute";
      Self.FHandle.style["overflow"] = "hidden";
      Self.FHandle.style["left"] = "0px";
      Self.FHandle.style["top"] = "0px";
   }
   /// procedure TW3TagObj.UnHookEvents()
   ///  [line: 1165, column: 21, file: SmartCL.Components]
   ,UnHookEvents:function(Self) {
      Self.FHandle.onresize = null;
      Self.FHandle.onselectstart = null;
      Self.FHandle.onfocus = null;
      Self.FHandle.onblur = null;
      Self.FHandle.onchange = null;
      Self.FHandle.onmousedown = null;
      Self.FHandle.onmouseup = null;
      Self.FHandle.onmousemove = null;
      Self.FHandle.onmouseover = null;
      Self.FHandle.onmouseout = null;
      Self.FHandle.onclick = null;
      Self.FHandle.ondblclick = null;
      Self.FHandle.onkeydown = null;
      Self.FHandle.onkeyup = null;
      Self.FHandle.onkeypress = null;
      Self.FHandle.webkitAnimationStart = null;
      Self.FHandle.webkitAnimationEnd = null;
   }
   ,Destroy$:function($){return $.ClassType.Destroy($)}
   ,AfterUpdate$:function($){return $.ClassType.AfterUpdate($)}
   ,FinalizeObject$:function($){return $.ClassType.FinalizeObject($)}
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId$:function($){return $.ClassType.MakeElementTagId($)}
   ,MakeElementTagObj$:function($){return $.ClassType.MakeElementTagObj($)}
   ,Showing$:function($){return $.ClassType.Showing($)}
   ,StyleTagObject$:function($){return $.ClassType.StyleTagObject($)}
};
/// TW3Component = class (TW3TagObj)
///  [line: 260, column: 3, file: SmartCL.Components]
var TW3Component = {
   $ClassName:"TW3Component",$Parent:TW3TagObj
   ,$Init:function ($) {
      TW3TagObj.$Init($);
      $.FChildren = [];
      $.FName = "";
      $.FParent = null;
   }
   /// procedure TW3Component.CBNoBehavior()
   ///  [line: 1336, column: 24, file: SmartCL.Components]
   ,CBNoBehavior:function(Self) {
      if (BrowserAPI().Event) {
         BrowserAPI().Event.preventDefault();
      }
   }
   /// procedure TW3Component.ChildAdded(aChild: TW3Component)
   ///  [line: 1445, column: 24, file: SmartCL.Components]
   ,ChildAdded:function(Self, aChild) {
   }
   /// procedure TW3Component.ChildRemoved(aChild: TW3Component)
   ///  [line: 1449, column: 24, file: SmartCL.Components]
   ,ChildRemoved:function(Self, aChild$1) {
   }
   /// constructor TW3Component.Create(AOwner: TW3Component)
   ///  [line: 1316, column: 26, file: SmartCL.Components]
   ,Create$24:function(Self, AOwner$1) {
      Self.FParent = AOwner$1;
      TW3TagObj.Create$23(Self);
      if (Self.FParent!==null) {
         TW3Component.RegisterChild(Self.FParent,Self);
      }
      return Self
   }
   /// procedure TW3Component.FinalizeObject()
   ///  [line: 1389, column: 24, file: SmartCL.Components]
   ,FinalizeObject:function(Self) {
      TW3Component.FreeChildren(Self);
      if (Self.FParent!==null) {
         TW3Component.UnRegisterChild(Self.FParent,Self);
      }
      Self.FChildren.length=0;
      TW3TagObj.FinalizeObject(Self);
   }
   /// procedure TW3Component.FreeChildren()
   ///  [line: 1419, column: 24, file: SmartCL.Components]
   ,FreeChildren:function(Self) {
      var oldCount = 0;
      try {
         while (Self.FChildren.length>0) {
            oldCount = Self.FChildren.length;
            TObject.Free(Self.FChildren[0]);
            if (oldCount==Self.FChildren.length) {
               Self.FChildren.shift();
            }
         }
      } finally {
         Self.FChildren.length=0;
      }
   }
   /// function TW3Component.GetChildCount() : Integer
   ///  [line: 1404, column: 23, file: SmartCL.Components]
   ,GetChildCount:function(Self) {
      var Result = 0;
      Result = Self.FChildren.length;
      return Result
   }
   /// function TW3Component.GetChildObject(index: Integer) : TW3Component
   ///  [line: 1409, column: 23, file: SmartCL.Components]
   ,GetChildObject:function(Self, index) {
      var Result = null;
      Result = Self.FChildren[index];
      return Result
   }
   /// procedure TW3Component.InitializeObject()
   ///  [line: 1384, column: 24, file: SmartCL.Components]
   ,InitializeObject:function(Self) {
      TW3TagObj.InitializeObject(Self);
   }
   /// procedure TW3Component.RegisterChild(aChild: TW3Component)
   ///  [line: 1453, column: 24, file: SmartCL.Components]
   ,RegisterChild:function(Self, aChild$2) {
      if (aChild$2!==null&&Self.FChildren.indexOf(aChild$2)<0) {
         Self.FChildren.push(aChild$2);
         TW3TagObj.InsertInto(aChild$2,Self.FHandle);
         TW3Component.ChildAdded(Self,aChild$2);
      }
   }
   /// procedure TW3Component.SetName(Value: String)
   ///  [line: 1414, column: 24, file: SmartCL.Components]
   ,SetName:function(Self, Value$1) {
      Self.FName = Value$1;
   }
   /// function TW3Component.Showing() : Boolean
   ///  [line: 1330, column: 23, file: SmartCL.Components]
   ,Showing:function(Self) {
      var Result = false;
      Result = TW3TagObj.Showing(Self)&&Self.FParent!==null;
      return Result
   }
   /// procedure TW3Component.UnRegisterChild(aChild: TW3Component)
   ///  [line: 1463, column: 24, file: SmartCL.Components]
   ,UnRegisterChild:function(Self, aChild$3) {
      var mIndex$2 = 0;
      if (aChild$3!==null) {
         mIndex$2 = Self.FChildren.indexOf(aChild$3);
         if (mIndex$2>=0) {
            Self.FChildren.splice(mIndex$2,1)
            ;
            TW3Component.ChildRemoved(Self,aChild$3);
         }
         TW3TagObj.RemoveFrom(aChild$3);
      }
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3TagObj.AfterUpdate
   ,FinalizeObject$:function($){return $.ClassType.FinalizeObject($)}
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing$:function($){return $.ClassType.Showing($)}
   ,StyleTagObject:TW3TagObj.StyleTagObject
   ,Create$24$:function($){return $.ClassType.Create$24.apply($.ClassType, arguments)}
};
/// TW3MovableControl = class (TW3Component)
///  [line: 393, column: 3, file: SmartCL.Components]
var TW3MovableControl = {
   $ClassName:"TW3MovableControl",$Parent:TW3Component
   ,$Init:function ($) {
      TW3Component.$Init($);
      $.FAdjusted = $.FTransparent = $.FUseAlpha = false;
      $.FAlpha = $.FSyncCount = 0;
      $.FBackground = $.FBorders = $.FConstraints = null;
      $.FColor = 0;
   }
   /// procedure TW3MovableControl.AdjustToParentBox()
   ///  [line: 1879, column: 29, file: SmartCL.Components]
   ,AdjustToParentBox:function(Self) {
      var x$34 = 0;
      var dx$3 = 0;
      var dy$3 = 0;
      var mChild = null;
      var mCtrl = null;
      if (Self.FHandle) {
         if (!Self.FAdjusted) {
            Self.FAdjusted = true;
            dx$3 = TW3Borders.GetHSpace(TW3MovableControl.GetBorder(Self));
            dy$3 = TW3Borders.GetVSpace(TW3MovableControl.GetBorder(Self));
            var $temp2;
            for(x$34=0,$temp2=TW3Component.GetChildCount(Self);x$34<$temp2;x$34++) {
               mChild = TW3Component.GetChildObject(Self,x$34);
               if ($Is(mChild,TW3MovableControl)) {
                  mCtrl = $As(mChild,TW3MovableControl);
                  if (TW3MovableControl.supportAdjustment(mCtrl.ClassType)) {
                     if (dx$3>0||dy$3>0) {
                        TW3MovableControl.SetSize(mCtrl,TW3MovableControl.GetWidth(mCtrl)-dx$3,TW3MovableControl.GetHeight(mCtrl)-dy$3);
                     }
                     setTimeout($Event0(mCtrl,TW3MovableControl.AdjustToParentBox),1);
                  }
               }
            }
         }
      }
   }
   /// procedure TW3MovableControl.AfterUpdate()
   ///  [line: 2010, column: 29, file: SmartCL.Components]
   ,AfterUpdate:function(Self) {
      TW3TagObj.RemoveFromComponentState(Self,[24]);
   }
   /// function TW3MovableControl.DisplayMode() : String
   ///  [line: 2030, column: 34, file: SmartCL.Components]
   ,DisplayMode:function(Self) {
      var Result = "";
      Result = "inline-block";
      return Result
   }
   /// procedure TW3MovableControl.FinalizeObject()
   ///  [line: 1982, column: 29, file: SmartCL.Components]
   ,FinalizeObject:function(Self) {
      if (Self.FBackground) {
         TObject.Free(Self.FBackground);
      }
      if (Self.FBorders) {
         TObject.Free(Self.FBorders);
      }
      if (Self.FConstraints) {
         TObject.Free(Self.FConstraints);
      }
      TW3Component.FinalizeObject(Self);
   }
   /// function TW3MovableControl.GetBorder() : TW3Borders
   ///  [line: 2003, column: 28, file: SmartCL.Components]
   ,GetBorder:function(Self) {
      var Result = null;
      if (Self.FBorders===null) {
         Self.FBorders = TW3OwnedObject.Create$11$($New(TW3Borders),Self);
      }
      Result = Self.FBorders;
      return Result
   }
   /// function TW3MovableControl.GetBoundsRect() : TRect
   ///  [line: 2056, column: 28, file: SmartCL.Components]
   ,GetBoundsRect:function(Self) {
      var Result = {Bottom$1:0,Left$1:0,Right$1:0,Top$1:0};
      Result.Left$1 = w3_getStyleAsInt(Self.FHandle,"left");
      Result.Top$1 = w3_getStyleAsInt(Self.FHandle,"top");
      if (Self.FHandle) {
         Result.Right$1 = parseInt((Result.Left$1+Self.FHandle.offsetWidth),10);
         Result.Bottom$1 = parseInt((Result.Top$1+Self.FHandle.offsetHeight),10);
      } else {
         Result.Right$1 = Result.Left$1;
         Result.Bottom$1 = Result.Top$1;
      }
      return Result
   }
   /// function TW3MovableControl.GetHeight() : Integer
   ///  [line: 2177, column: 28, file: SmartCL.Components]
   ,GetHeight:function(Self) {
      var Result = 0;
      if (Self.FHandle) {
         Result = parseInt(Self.FHandle.offsetHeight,10);
      }
      return Result
   }
   /// function TW3MovableControl.GetLeft() : Integer
   ///  [line: 2073, column: 28, file: SmartCL.Components]
   ,GetLeft:function(Self) {
      var Result = 0;
      var mObj$4 = undefined;
      var mData$3,
         tagRef$11 = undefined;
      tagRef$11 = Self.FHandle;
      mObj$4   = document.defaultView.getComputedStyle(tagRef$11,null);

    if (mObj$4)
      mData$3 = (mObj$4).getPropertyValue('left');

    if (mData$3)
    {
      if (typeof(mData$3) === "number")
      {
        Result = mData$3;
      } else {
        if (typeof(mData$3) === "string")
        {
          mData$3 = parseInt(mData$3);
          if (typeof(mData$3) === "number")
          Result = mData$3;
        }
      }
    }
      return Result
   }
   /// function TW3MovableControl.GetTop() : Integer
   ///  [line: 2114, column: 28, file: SmartCL.Components]
   ,GetTop:function(Self) {
      var Result = 0;
      var mObj$5 = undefined;
      var mData$4,
         tagRef$12 = undefined;
      tagRef$12 = Self.FHandle;
      mObj$5   = document.defaultView.getComputedStyle(tagRef$12,null);

    if (mObj$5)
      mData$4 = (mObj$5).getPropertyValue('top');

    if (mData$4)
    {
      if (typeof(mData$4) === "number")
      {
        Result = mData$4;
      } else {
        if (typeof(mData$4) === "string")
        {
          mData$4 = parseInt(mData$4);
          if (typeof(mData$4) === "number")
          Result = mData$4;
        }
      }
    }
      return Result
   }
   /// function TW3MovableControl.GetVisible() : Boolean
   ///  [line: 2022, column: 28, file: SmartCL.Components]
   ,GetVisible:function(Self) {
      var Result = false;
      var mValue = "";
      mValue = w3_getStyleAsStr(Self.FHandle,"visibility");
      Result = (mValue).toLocaleLowerCase()=="visible";
      return Result
   }
   /// function TW3MovableControl.GetWidth() : Integer
   ///  [line: 2155, column: 28, file: SmartCL.Components]
   ,GetWidth:function(Self) {
      var Result = 0;
      if (Self.FHandle) {
         Result = parseInt(Self.FHandle.offsetWidth,10);
      }
      return Result
   }
   /// procedure TW3MovableControl.InitializeObject()
   ///  [line: 1757, column: 29, file: SmartCL.Components]
   ,InitializeObject:function(Self) {
      TW3Component.InitializeObject(Self);
      Self.FAlpha = 255;
      Self.FColor = 536870911;
      Self.FTransparent = false;
      if (Self.FParent) {
         TW3MovableControl.ReadySync(Self);
      } else {
         TW3MovableControl.ObjectReady(Self);
      }
   }
   /// procedure TW3MovableControl.Moved()
   ///  [line: 2225, column: 29, file: SmartCL.Components]
   ,Moved:function(Self) {
   }
   /// procedure TW3MovableControl.ObjectReady()
   ///  [line: 1812, column: 29, file: SmartCL.Components]
   ,ObjectReady:function(Self) {
      TW3TagObj.AddToComponentState(Self,[4]);
      if (TW3MovableControl.GetVisible(Self)) {
         TW3MovableControl.Resize$(Self);
      }
   }
   /// procedure TW3MovableControl.ReadySync()
   ///  [line: 1788, column: 29, file: SmartCL.Components]
   ,ReadySync:function(Self) {
      if (Self.FHandle&&TControlHandleHelper$Ready(Self.FHandle)&&(!$SetIn(Self.FComponentState,0,0,6))&&(!$SetIn(Self.FComponentState,1,0,6))) {
         TW3MovableControl.ObjectReady(Self);
      } else {
         ++Self.FSyncCount;
         if (Self.FSyncCount>600) {
            TW3MovableControl.ObjectReady(Self);
            return;
         }
         w3_RequestAnimationFrame($Event0(Self,TW3MovableControl.ReadySync));
      }
   }
   /// procedure TW3MovableControl.Resize()
   ///  [line: 2229, column: 29, file: SmartCL.Components]
   ,Resize:function(Self) {
   }
   /// procedure TW3MovableControl.SetAlpha(const aValue: Integer)
   ///  [line: 2315, column: 29, file: SmartCL.Components]
   ,SetAlpha:function(Self, aValue$9) {
      Self.FAlpha = ClampInt(aValue$9,0,255);
      if (Self.FUseAlpha) {
         Self.FHandle.style["opacity"] = Self.FAlpha*0.01;
      }
   }
   /// procedure TW3MovableControl.SetBounds(aLeft: Integer; aTop: Integer; aWidth: Integer; aHeight: Integer)
   ///  [line: 2242, column: 29, file: SmartCL.Components]
   ,SetBounds$2:function(Self, aLeft, aTop, aWidth, aHeight) {
      var mSized = false;
      var mMoved = false;
      aWidth = Math.max(0,aWidth);
      aHeight = Math.max(0,aHeight);
      mMoved = aLeft!=TW3MovableControl.GetLeft(Self)||aTop!=TW3MovableControl.GetTop(Self);
      mSized = aWidth!=Self.FHandle.offsetWidth||aHeight!=Self.FHandle.offsetHeight;
      if ($SetIn(Self.FComponentState,2,0,6)) {
         TW3TagObj.BeginUpdate(Self);
         Self.FHandle.style["left"] = aLeft.toString()+"px";
         Self.FHandle.style["top"] = aTop.toString()+"px";
         Self.FHandle.style["width"] = aWidth.toString()+"px";
         Self.FHandle.style["height"] = aHeight.toString()+"px";
         if (mMoved) {
            TW3TagObj.AddToComponentState(Self,[16]);
         }
         if (mSized) {
            TW3TagObj.AddToComponentState(Self,[8]);
         }
         TW3TagObj.EndUpdate(Self);
      } else {
         Self.FHandle.style["left"] = aLeft.toString()+"px";
         Self.FHandle.style["top"] = aTop.toString()+"px";
         Self.FHandle.style["width"] = aWidth.toString()+"px";
         Self.FHandle.style["height"] = aHeight.toString()+"px";
      }
   }
   /// procedure TW3MovableControl.SetColor(const aValue: TColor)
   ///  [line: 2340, column: 29, file: SmartCL.Components]
   ,SetColor:function(Self, aValue$10) {
      var mText = "";
      if (aValue$10!=Self.FColor) {
         Self.FColor = aValue$10;
         mText = ColorToWebStr(Self.FColor,(Self.FTransparent)?0:255);
         Self.FHandle.style["backgroundColor"] = mText;
      }
   }
   /// procedure TW3MovableControl.SetHeight(aValue: Integer)
   ///  [line: 2183, column: 29, file: SmartCL.Components]
   ,SetHeight:function(Self, aValue$11) {
      aValue$11 = Math.max(aValue$11,0);
      if (aValue$11!=TW3MovableControl.GetHeight(Self)) {
         if ($SetIn(Self.FComponentState,2,0,6)) {
            TW3TagObj.BeginUpdate(Self);
            Self.FHandle.style["height"] = TInteger.ToPxStr(aValue$11);
            TW3TagObj.AddToComponentState(Self,[8]);
            TW3TagObj.EndUpdate(Self);
         } else {
            Self.FHandle.style["height"] = TInteger.ToPxStr(aValue$11);
         }
      }
   }
   /// procedure TW3MovableControl.SetLeft(const aValue: Integer)
   ///  [line: 2102, column: 29, file: SmartCL.Components]
   ,SetLeft:function(Self, aValue$12) {
      if ($SetIn(Self.FComponentState,2,0,6)) {
         TW3TagObj.BeginUpdate(Self);
         Self.FHandle.style["left"] = TInteger.ToPxStr(aValue$12);
         TW3TagObj.AddToComponentState(Self,[16]);
         TW3TagObj.EndUpdate(Self);
      } else {
         Self.FHandle.style["left"] = TInteger.ToPxStr(aValue$12);
      }
   }
   /// procedure TW3MovableControl.SetSize(aWidth: Integer; aHeight: Integer)
   ///  [line: 2280, column: 29, file: SmartCL.Components]
   ,SetSize:function(Self, aWidth$1, aHeight$1) {
      aWidth$1 = Math.max(aWidth$1,0);
      aHeight$1 = Math.max(aHeight$1,0);
      if (aWidth$1!=Self.FHandle.offsetWidth||aHeight$1!=Self.FHandle.offsetHeight) {
         if ($SetIn(Self.FComponentState,2,0,6)) {
            TW3TagObj.BeginUpdate(Self);
            Self.FHandle.style["width"] = aWidth$1.toString()+"px";
            Self.FHandle.style["height"] = aHeight$1.toString()+"px";
            TW3TagObj.AddToComponentState(Self,[8]);
            TW3TagObj.EndUpdate(Self);
         } else {
            Self.FHandle.style["width"] = aWidth$1.toString()+"px";
            Self.FHandle.style["height"] = aHeight$1.toString()+"px";
         }
      }
   }
   /// procedure TW3MovableControl.SetTop(const aValue: Integer)
   ///  [line: 2143, column: 29, file: SmartCL.Components]
   ,SetTop:function(Self, aValue$13) {
      if ($SetIn(Self.FComponentState,2,0,6)) {
         TW3TagObj.BeginUpdate(Self);
         Self.FHandle.style["top"] = TInteger.ToPxStr(aValue$13);
         TW3TagObj.AddToComponentState(Self,[16]);
         TW3TagObj.EndUpdate(Self);
      } else {
         Self.FHandle.style["top"] = TInteger.ToPxStr(aValue$13);
      }
   }
   /// procedure TW3MovableControl.SetTransparent(const aValue: Boolean)
   ///  [line: 2325, column: 29, file: SmartCL.Components]
   ,SetTransparent:function(Self, aValue$14) {
      var mText$1 = "";
      if (aValue$14!=Self.FTransparent) {
         TW3TagObj.BeginUpdate(Self);
         Self.FTransparent = aValue$14;
         mText$1 = ColorToWebStr(Self.FColor,(aValue$14)?0:255);
         Self.FHandle.style["backgroundColor"] = mText$1;
         TW3TagObj.AddToComponentState(Self,[16]);
         TW3TagObj.EndUpdate(Self);
      }
   }
   /// procedure TW3MovableControl.SetUseAlpha(const aValue: Boolean)
   ///  [line: 2301, column: 29, file: SmartCL.Components]
   ,SetUseAlpha:function(Self, aValue$15) {
      var mBlend = 0;
      if (aValue$15==Self.FUseAlpha) {
         return;
      }
      Self.FUseAlpha = aValue$15;
      if (aValue$15) {
         mBlend = Self.FAlpha*0.01;
      } else {
         mBlend = 1;
      }
      Self.FHandle.style["opacity"] = mBlend;
   }
   /// procedure TW3MovableControl.SetVisible(const aValue: Boolean)
   ///  [line: 2035, column: 29, file: SmartCL.Components]
   ,SetVisible:function(Self, aValue$16) {
      TW3TagObj.BeginUpdate(Self);
      if (aValue$16) {
         Self.FHandle.style["display"] = TW3MovableControl.DisplayMode(Self.ClassType);
         Self.FHandle.style["visibility"] = "visible";
         TW3TagObj.AddToComponentState(Self,[8]);
      } else {
         Self.FHandle.style["display"] = "none";
         Self.FHandle.style["visibility"] = "hidden";
      }
      TW3TagObj.EndUpdate(Self);
   }
   /// procedure TW3MovableControl.SetWidth(aValue: Integer)
   ///  [line: 2161, column: 29, file: SmartCL.Components]
   ,SetWidth:function(Self, aValue$17) {
      aValue$17 = Math.max(aValue$17,0);
      if (aValue$17!=TW3MovableControl.GetWidth(Self)) {
         if ($SetIn(Self.FComponentState,2,0,6)) {
            TW3TagObj.BeginUpdate(Self);
            Self.FHandle.style["width"] = TInteger.ToPxStr(aValue$17);
            TW3TagObj.AddToComponentState(Self,[8]);
            TW3TagObj.EndUpdate(Self);
         } else {
            Self.FHandle.style["width"] = TInteger.ToPxStr(aValue$17);
         }
      }
   }
   /// function TW3MovableControl.Showing() : Boolean
   ///  [line: 1776, column: 28, file: SmartCL.Components]
   ,Showing:function(Self) {
      var Result = false;
      Result = TW3Component.Showing(Self)&&TW3MovableControl.GetWidth(Self)>0&&TW3MovableControl.GetHeight(Self)>0&&TW3MovableControl.GetLeft(Self)>=0&&TW3MovableControl.GetLeft(Self)<TW3MovableControl.GetWidth(Self)&&TW3MovableControl.GetTop(Self)>=0&&TW3MovableControl.GetTop(Self)<TW3MovableControl.GetHeight(Self)&&TW3MovableControl.GetVisible(Self);
      return Result
   }
   /// function TW3MovableControl.supportAdjustment() : Boolean
   ///  [line: 1874, column: 34, file: SmartCL.Components]
   ,supportAdjustment:function(Self) {
      var Result = false;
      Result = true;
      return Result
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate$:function($){return $.ClassType.AfterUpdate($)}
   ,FinalizeObject$:function($){return $.ClassType.FinalizeObject($)}
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing$:function($){return $.ClassType.Showing($)}
   ,StyleTagObject:TW3TagObj.StyleTagObject
   ,Create$24:TW3Component.Create$24
   ,Resize$:function($){return $.ClassType.Resize($)}
};
/// TW3CustomControl = class (TW3MovableControl)
///  [line: 487, column: 3, file: SmartCL.Components]
var TW3CustomControl = {
   $ClassName:"TW3CustomControl",$Parent:TW3MovableControl
   ,$Init:function ($) {
      TW3MovableControl.$Init($);
      $.FClassNames = $.FFont = $.FGestureData = $.FNoBehavior = $.FOnClick = $.FOnGotFocus = $.FOnLostFocus = $.FOnResize = $.FScrollInfo = $.FTouchData = null;
   }
   /// procedure TW3CustomControl.AfterUpdate()
   ///  [line: 3201, column: 28, file: SmartCL.Components]
   ,AfterUpdate:function(Self) {
      if ($SetIn(Self.FComponentState,2,0,6)) {
         if ($SetIn(Self.FComponentState,3,0,6)) {
            TW3TagObj.RemoveFromComponentState(Self,[8]);
            TW3MovableControl.Resize$(Self);
            if (Self.FOnResize) {
               Self.FOnResize(Self);
            }
         }
         if ($SetIn(Self.FComponentState,4,0,6)) {
            TW3TagObj.RemoveFromComponentState(Self,[16]);
            TW3MovableControl.Moved(Self);
            TW3CustomControl.Invalidate(Self);
         }
      }
      TW3MovableControl.AfterUpdate(Self);
   }
   /// procedure TW3CustomControl.BringToFront()
   ///  [line: 2594, column: 28, file: SmartCL.Components]
   ,BringToFront:function(Self) {
      if (Self.FHandle) {
         Self.FHandle.style.zIndex = (TW3CustomControl.GetMaxZIndex($As(Self.FParent,TW3CustomControl))+1);
      }
   }
   /// procedure TW3CustomControl.CBClick(eventObj: JEvent)
   ///  [line: 2862, column: 28, file: SmartCL.Components]
   ,CBClick:function(Self, eventObj) {
      if (Self.FOnClick) {
         Self.FOnClick(Self);
      }
   }
   /// procedure TW3CustomControl.CBFocused()
   ///  [line: 2509, column: 28, file: SmartCL.Components]
   ,CBFocused:function(Self) {
      if (Self.FOnGotFocus) {
         Self.FOnGotFocus(Self);
      }
   }
   /// procedure TW3CustomControl.CBLostFocus()
   ///  [line: 2515, column: 28, file: SmartCL.Components]
   ,CBLostFocus:function(Self) {
      if (Self.FOnLostFocus) {
         Self.FOnLostFocus(Self);
      }
   }
   /// constructor TW3CustomControl.Create(AOwner: TW3Component)
   ///  [line: 2412, column: 30, file: SmartCL.Components]
   ,Create$24:function(Self, AOwner$2) {
      TW3Component.Create$24(Self,AOwner$2);
      Self.FHandle["onclick"] = $Event1(Self,TW3CustomControl.CBClick);
      return Self
   }
   /// procedure TW3CustomControl.FinalizeObject()
   ///  [line: 2434, column: 28, file: SmartCL.Components]
   ,FinalizeObject:function(Self) {
      TObject.Free(Self.FFont);
      TObject.Free(Self.FClassNames);
      TObject.Free(Self.FScrollInfo);
      TObject.Free(Self.FTouchData);
      TObject.Free(Self.FGestureData);
      TW3MovableControl.FinalizeObject(Self);
   }
   /// function TW3CustomControl.GetChildrenSortedByYPos() : TW3ComponentArray
   ///  [line: 2600, column: 27, file: SmartCL.Components]
   ,GetChildrenSortedByYPos:function(Self) {
      var Result = [];
      var mCount = 0;
      var x$35 = 0;
      var mAltered = false;
      var mObj$6 = null;
      var mLast = null;
      var mCurrent = null;
      Result.length=0;
      mCount = TW3Component.GetChildCount(Self);
      if (mCount>0) {
         var $temp3;
         for(x$35=0,$temp3=mCount;x$35<$temp3;x$35++) {
            mObj$6 = TW3Component.GetChildObject(Self,x$35);
            if ($Is(mObj$6,TW3CustomControl)) {
               Result.push(mObj$6);
            }
         }
         if (Result.length>1) {
            do {
               mAltered = false;
               var $temp4;
               for(x$35=1,$temp4=mCount;x$35<$temp4;x$35++) {
                  mLast = $As(Result[x$35-1],TW3CustomControl);
                  mCurrent = $As(Result[x$35],TW3CustomControl);
                  if (TW3MovableControl.GetTop(mCurrent)<TW3MovableControl.GetTop(mLast)) {
                     $ArraySwap(Result,(x$35-1),x$35);
                     mAltered = true;
                  }
               }
            } while (!(mAltered==false));
         }
      }
      return Result
   }
   /// function TW3CustomControl.GetMaxZIndex() : Integer
   ///  [line: 2578, column: 27, file: SmartCL.Components]
   ,GetMaxZIndex:function(Self) {
      var Result = 0;
      var iChild = 0;
      var obj = null,
         objZIndex = 0;
      Result = 0;
      var $temp5;
      for(iChild=0,$temp5=TW3Component.GetChildCount(Self);iChild<$temp5;iChild++) {
         obj = TW3Component.GetChildObject(Self,iChild);
         if ((obj!==null)&&$Is(obj,TW3CustomControl)&&obj.FHandle) {
            objZIndex = TW3CustomControl.GetZIndexAsInt($As(obj,TW3CustomControl),0);
            if (objZIndex>Result) {
               Result = objZIndex;
            }
            objZIndex = TW3CustomControl.GetMaxZIndex($As(obj,TW3CustomControl));
            if (objZIndex>Result) {
               Result = objZIndex;
            }
         }
      }
      return Result
   }
   /// function TW3CustomControl.GetScrollInfo() : TW3ScrollInfo
   ///  [line: 2486, column: 27, file: SmartCL.Components]
   ,GetScrollInfo:function(Self) {
      var Result = null;
      if (Self.FScrollInfo===null) {
         Self.FScrollInfo = TW3OwnedObject.Create$11$($New(TW3ScrollInfo),Self);
      }
      Result = Self.FScrollInfo;
      return Result
   }
   /// function TW3CustomControl.GetStyleClass() : String
   ///  [line: 2643, column: 27, file: SmartCL.Components]
   ,GetStyleClass:function(Self) {
      var Result = "";
      Result = w3_getAttribAsStr(Self.FHandle,"class","");
      return Result
   }
   /// function TW3CustomControl.GetZIndexAsInt(default: Integer = 0) : Integer
   ///  [line: 2521, column: 27, file: SmartCL.Components]
   ,GetZIndexAsInt:function(Self, default$2) {
      var Result = 0;
      var mData$5;
      Result = default$2;
      mData$5 = Self.FHandle.style["zIndex"];
      if (Self.FHandle) {
         if (TVariant.IsNumber(mData$5)) {
            Result = parseInt(mData$5,10);
         } else if (TVariant.IsString(mData$5)) {
            Result = parseInt(mData$5,10);
            if (isNaN(Result)) {
               Result = default$2;
            }
         }
      }
      return Result
   }
   /// procedure TW3CustomControl.InitializeObject()
   ///  [line: 2418, column: 28, file: SmartCL.Components]
   ,InitializeObject:function(Self) {
      TW3MovableControl.InitializeObject(Self);
      Self.FNoBehavior = $Event0(Self,TW3Component.CBNoBehavior);
      w3_bind2(Self.FHandle,"onselectstart",$Event0(Self,TW3Component.CBNoBehavior));
      w3_bind2(Self.FHandle,"onfocus",$Event0(Self,TW3CustomControl.CBFocused));
      w3_bind2(Self.FHandle,"onblur",$Event0(Self,TW3CustomControl.CBLostFocus));
   }
   /// procedure TW3CustomControl.Invalidate()
   ///  [line: 3153, column: 28, file: SmartCL.Components]
   ,Invalidate:function(Self) {
   }
   /// procedure TW3CustomControl.LayoutChildren()
   ///  [line: 3158, column: 28, file: SmartCL.Components]
   ,LayoutChildren:function(Self) {
      var x$36 = 0;
      var mChild$1 = null;
      TW3TagObj.BeginUpdate(Self);
      var $temp6;
      for(x$36=0,$temp6=TW3Component.GetChildCount(Self);x$36<$temp6;x$36++) {
         mChild$1 = TW3Component.GetChildObject(Self,x$36);
         if ($Is(mChild$1,TW3CustomControl)) {
            TW3CustomControl.LayoutChildren($As(mChild$1,TW3CustomControl));
         }
      }
      TW3TagObj.AddToComponentState(Self,[24]);
      TW3TagObj.EndUpdate(Self);
   }
   /// procedure TW3CustomControl.SetStyleClass(aStyle: String)
   ///  [line: 2648, column: 28, file: SmartCL.Components]
   ,SetStyleClass:function(Self, aStyle) {
      w3_setAttrib(Self.FHandle,"class",aStyle);
   }
   /// procedure TW3CustomControl.StyleTagObject()
   ///  [line: 2454, column: 28, file: SmartCL.Components]
   ,StyleTagObject:function(Self) {
      TW3TagObj.StyleTagObject(Self);
      TW3CustomControl.SetStyleClass(Self,TObject.ClassName(Self.ClassType));
      TW3MovableControl.SetVisible(Self,true);
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate$:function($){return $.ClassType.AfterUpdate($)}
   ,FinalizeObject$:function($){return $.ClassType.FinalizeObject($)}
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject$:function($){return $.ClassType.StyleTagObject($)}
   ,Create$24$:function($){return $.ClassType.Create$24.apply($.ClassType, arguments)}
   ,Resize:TW3MovableControl.Resize
};
/// TW3DisplayView = class (TW3CustomControl)
///  [line: 65, column: 3, file: SmartCL.Application]
var TW3DisplayView = {
   $ClassName:"TW3DisplayView",$Parent:TW3CustomControl
   ,$Init:function ($) {
      TW3CustomControl.$Init($);
      $.FArrange = false;
      $.FArrangeKind = 0;
   }
   /// procedure TW3DisplayView.ArrangeChildren(aKind: TW3DisplayViewArangeType)
   ///  [line: 504, column: 26, file: SmartCL.Application]
   ,ArrangeChildren:function(Self, aKind) {
      var x$37 = 0;
      var dx$4 = 0;
      var dy$4 = 0;
      var mObj$7 = null;
      var mCount$1 = 0;
      var mRect = {Bottom$1:0,Left$1:0,Right$1:0,Top$1:0};
      var wd = 0;
      var hd = 0;
      mCount$1 = TW3Component.GetChildCount(Self);
      if (mCount$1>0) {
         mRect = TW3MovableControl.GetBoundsRect(Self);
         switch (aKind) {
            case 0 :
               wd = TRect$Width$1(mRect);
               hd = TRect$Height$1(mRect);
               var $temp7;
               for(x$37=0,$temp7=mCount$1;x$37<$temp7;x$37++) {
                  mObj$7 = TW3Component.GetChildObject(Self,x$37);
                  if ($Is(mObj$7,TW3CustomControl)&&(!$Is(mObj$7,TW3BlockBox))) {
                     TW3MovableControl.SetSize($As(mObj$7,TW3CustomControl),wd,hd);
                  }
               }
               break;
            case 1 :
               dy$4 = mRect.Top$1;
               wd = TRect$Width$1(mRect);
               var $temp8;
               for(x$37=0,$temp8=mCount$1;x$37<$temp8;x$37++) {
                  mObj$7 = TW3Component.GetChildObject(Self,x$37);
                  if ($Is(mObj$7,TW3CustomControl)&&(!$Is(mObj$7,TW3BlockBox))) {
                     hd = TW3MovableControl.GetHeight($As(mObj$7,TW3CustomControl));
                     TW3MovableControl.SetBounds$2($As(mObj$7,TW3CustomControl),mRect.Left$1,dy$4,wd,hd);
                     (dy$4+= hd);
                  }
               }
               break;
            case 2 :
               dx$4 = mRect.Left$1;
               hd = TRect$Height$1(mRect);
               var $temp9;
               for(x$37=0,$temp9=mCount$1;x$37<$temp9;x$37++) {
                  mObj$7 = TW3Component.GetChildObject(Self,x$37);
                  if ($Is(mObj$7,TW3CustomControl)&&(!$Is(mObj$7,TW3BlockBox))) {
                     wd = TW3MovableControl.GetWidth($As(mObj$7,TW3CustomControl));
                     TW3MovableControl.SetBounds$2($As(mObj$7,TW3CustomControl),dx$4,mRect.Top$1,wd,hd);
                     (dx$4+= wd);
                  }
               }
               break;
         }
      }
   }
   /// procedure TW3DisplayView.InitializeObject()
   ///  [line: 455, column: 26, file: SmartCL.Application]
   ,InitializeObject:function(Self) {
      TW3CustomControl.InitializeObject(Self);
      Self.FArrange = true;
      Self.FArrangeKind = 0;
   }
   /// procedure TW3DisplayView.ReSize()
   ///  [line: 590, column: 26, file: SmartCL.Application]
   ,Resize:function(Self) {
      TW3MovableControl.Resize(Self);
      if (Self.FArrange) {
         TW3DisplayView.ArrangeChildren(Self,Self.FArrangeKind);
      }
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject:TW3CustomControl.FinalizeObject
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject:TW3CustomControl.StyleTagObject
   ,Create$24:TW3CustomControl.Create$24
   ,Resize$:function($){return $.ClassType.Resize($)}
};
/// TW3Display = class (TW3CustomControl)
///  [line: 81, column: 3, file: SmartCL.Application]
var TW3Display = {
   $ClassName:"TW3Display",$Parent:TW3CustomControl
   ,$Init:function ($) {
      TW3CustomControl.$Init($);
      $.FFooter = $.FHeader = $.FOnOrient = $.FView = null;
   }
   /// procedure TW3Display.FinalizeObject()
   ///  [line: 609, column: 22, file: SmartCL.Application]
   ,FinalizeObject:function(Self) {
      TObject.Free(Self.FView);
      if (Self.FHeader) {
         TObject.Free(Self.FHeader);
      }
      if (Self.FFooter) {
         TObject.Free(Self.FFooter);
      }
      TW3CustomControl.FinalizeObject(Self);
   }
   /// function TW3Display.GetHeightOfChildren() : Integer
   ///  [line: 630, column: 21, file: SmartCL.Application]
   ,GetHeightOfChildren:function(Self) {
      var Result = 0;
      var x$38 = 0;
      var mObj$8 = null;
      var $temp10;
      for(x$38=0,$temp10=TW3Component.GetChildCount(Self);x$38<$temp10;x$38++) {
         mObj$8 = TW3Component.GetChildObject(Self,x$38);
         if (mObj$8!==Self.FView&&$Is(mObj$8,TW3CustomControl)&&(!$Is(mObj$8,TW3BlockBox))) {
            (Result+= TW3MovableControl.GetHeight($As(mObj$8,TW3CustomControl)));
         }
      }
      return Result
   }
   /// procedure TW3Display.InitializeObject()
   ///  [line: 602, column: 22, file: SmartCL.Application]
   ,InitializeObject:function(Self) {
      TW3CustomControl.InitializeObject(Self);
      Self.FView = TW3Component.Create$24$($New(TW3DisplayView),Self);
      TW3MovableControl.SetTop(Self.FView,5);
   }
   /// procedure TW3Display.PositionFormInView(aForm: TW3CustomForm)
   ///  [line: 674, column: 22, file: SmartCL.Application]
   ,PositionFormInView:function(Self, aForm$3) {
      var mApp = null;
      var dx$5 = 0;
      var dy$5 = 0;
      if (aForm$3) {
         mApp = Application();
         if ((mApp!==null)&&(!mApp.FTerminated)) {
            dx$5 = TW3ScrollInfo.GetScrollLeft(TW3CustomControl.GetScrollInfo(Self.FView));
            dy$5 = TW3ScrollInfo.GetScrollTop(TW3CustomControl.GetScrollInfo(Self.FView));
            TW3MovableControl.SetBounds$2(aForm$3,dx$5,dy$5,TW3MovableControl.GetWidth(Self.FView),TW3MovableControl.GetHeight(Self.FView));
         }
      } else {
         throw EW3Exception.CreateFmt($New(EW3Screen),$R[0],["PositionFormInView", TObject.ClassName(Self.ClassType), "Form parameter was NIL error"]);
      }
   }
   /// procedure TW3Display.ReSize()
   ///  [line: 643, column: 22, file: SmartCL.Application]
   ,Resize:function(Self) {
      var mTotal = 0;
      var mList = [],
         x$39 = 0;
      var dy$6 = 0;
      var mObj$9 = null;
      TW3MovableControl.Resize(Self);
      mTotal = TW3Display.GetHeightOfChildren(Self);
      TW3MovableControl.SetHeight(Self.FView,TW3MovableControl.GetHeight(Self)-mTotal);
      mList = TW3CustomControl.GetChildrenSortedByYPos(Self);
      dy$6 = 0;
      var $temp11;
      for(x$39=0,$temp11=mList.length;x$39<$temp11;x$39++) {
         mObj$9 = $As(mList[x$39],TW3CustomControl);
         if (!$Is(mObj$9,TW3BlockBox)) {
            TW3MovableControl.SetBounds$2(mObj$9,0,dy$6,TW3MovableControl.GetWidth(Self),TW3MovableControl.GetHeight(mObj$9));
            (dy$6+= TW3MovableControl.GetHeight(mObj$9));
         } else {
            TW3MovableControl.SetBounds$2(mObj$9,0,0,TW3MovableControl.GetWidth(Self),TW3MovableControl.GetHeight(Self));
         }
      }
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject$:function($){return $.ClassType.FinalizeObject($)}
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject:TW3CustomControl.StyleTagObject
   ,Create$24:TW3CustomControl.Create$24
   ,Resize$:function($){return $.ClassType.Resize($)}
};
/// TW3BlockBox = class (TW3CustomControl)
///  [line: 62, column: 3, file: SmartCL.Application]
var TW3BlockBox = {
   $ClassName:"TW3BlockBox",$Parent:TW3CustomControl
   ,$Init:function ($) {
      TW3CustomControl.$Init($);
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject:TW3CustomControl.FinalizeObject
   ,InitializeObject:TW3CustomControl.InitializeObject
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject:TW3CustomControl.StyleTagObject
   ,Create$24:TW3CustomControl.Create$24
   ,Resize:TW3MovableControl.Resize
};
/// TFormEntryEffect enumeration
///  [line: 36, column: 3, file: SmartCL.Application]
var TFormEntryEffect = [ "feNone", "feFromRight", "feToLeft" ];
/// TDisplayOrientation enumeration
///  [line: 38, column: 3, file: SmartCL.Application]
var TDisplayOrientation = [ "soPortrait", "soLandscapeLeft", "soLandscapeRight", "soFlipped", "soPortraitPrimary", "soPortraitSecondary", "soLandscapePrimary", "soLandscapeSecondary", "soLandscape", "soDefault" ];
/// TApplicationFormsList = class (TObject)
///  [line: 224, column: 3, file: SmartCL.Application]
var TApplicationFormsList = {
   $ClassName:"TApplicationFormsList",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FFormOwner = null;
      $.FList = [];
      $.FNextAutoCreate = 0;
   }
   /// procedure TApplicationFormsList.AutoCreateForm(aFormInfo: TApplicationFormInfo)
   ///  [line: 1266, column: 33, file: SmartCL.Application]
   ,AutoCreateForm:function(Self, aFormInfo) {
      if (!aFormInfo.Instance) {
         aFormInfo.Instance = TW3Component.Create$24$($NewDyn(aFormInfo.FormClass,""),Self.FFormOwner);
         TW3CustomApplication.RegisterFormInstance(Application(),aFormInfo.Instance,aFormInfo.IsMainForm);
      }
      aFormInfo.InitialAutoCreateDone = true;
   }
   /// procedure TApplicationFormsList.AutoCreateForms(owner: TW3Component)
   ///  [line: 1276, column: 33, file: SmartCL.Application]
   ,AutoCreateForms:function(Self, owner) {
      var a$50 = 0;
      var info = null;
      var a$51 = [];
      Self.FFormOwner = owner;
      Self.FNextAutoCreate = 0;
      a$51 = Self.FList;
      var $temp12;
      for(a$50=0,$temp12=a$51.length;a$50<$temp12;a$50++) {
         info = a$51[a$50];
         TApplicationFormsList.AutoCreateForm(Self,info);
         ++Self.FNextAutoCreate;
         if (info.IsMainForm) {
            break;
         }
      }
      setTimeout($Event0(Self,TApplicationFormsList.AutoCreateNextForm),50);
   }
   /// procedure TApplicationFormsList.AutoCreateNextForm()
   ///  [line: 1291, column: 33, file: SmartCL.Application]
   ,AutoCreateNextForm:function(Self) {
      var iForm = 0;
      var info$1 = null;
      var $temp13;
      for(iForm=Self.FNextAutoCreate,$temp13=Self.FList.length;iForm<$temp13;iForm++) {
         info$1 = Self.FList[iForm];
         if (info$1.IsAutoCreated&&(!(info$1.Instance!==null))&&(!info$1.InitialAutoCreateDone)) {
            TApplicationFormsList.AutoCreateForm(Self,info$1);
            ++Self.FNextAutoCreate;
            if (Self.FNextAutoCreate<(Self.FList.length-1)) {
               setTimeout($Event0(Self,TApplicationFormsList.AutoCreateNextForm),50);
            }
            break;
         }
      }
   }
   /// function TApplicationFormsList.IndexOfFormClass(aFormClass: TW3CustomFormClass) : Integer
   ///  [line: 1325, column: 32, file: SmartCL.Application]
   ,IndexOfFormClass:function(Self, aFormClass) {
      var Result = 0;
      var $temp14;
      for(Result=0,$temp14=Self.FList.length;Result<$temp14;Result++) {
         if (Self.FList[Result].FormClass==aFormClass) {
            return Result;
         }
      }
      Result = -1;
      return Result
   }
   /// function TApplicationFormsList.IndexOfUnitName(aUnitName: String) : Integer
   ///  [line: 1333, column: 32, file: SmartCL.Application]
   ,IndexOfUnitName:function(Self, aUnitName) {
      var Result = 0;
      var $temp15;
      for(Result=0,$temp15=Self.FList.length;Result<$temp15;Result++) {
         if (SameText(Self.FList[Result].UnitName,aUnitName)) {
            return Result;
         }
      }
      Result = -1;
      return Result
   }
   /// procedure TApplicationFormsList.RegisterAutoCreate(aUnitName: String; isAutoCreate: Boolean; isMainForm: Boolean)
   ///  [line: 1341, column: 33, file: SmartCL.Application]
   ,RegisterAutoCreate:function(Self, aUnitName$1, isAutoCreate, isMainForm$1) {
      var formInfo = null;
      var idx = 0;
      idx = TApplicationFormsList.IndexOfUnitName(Self,aUnitName$1);
      if (idx>=0) {
         formInfo = Self.FList[idx];
      } else {
         formInfo = TObject.Create($New(TApplicationFormInfo));
         formInfo.UnitName = aUnitName$1;
         Self.FList.push(formInfo);
      }
      formInfo.IsMainForm = isMainForm$1;
      formInfo.IsAutoCreated = isAutoCreate;
   }
   /// procedure TApplicationFormsList.RegisterForm(aUnitName: String; aFormClass: TW3CustomFormClass)
   ///  [line: 1357, column: 33, file: SmartCL.Application]
   ,RegisterForm:function(Self, aUnitName$2, aFormClass$1) {
      var formInfo$1 = null;
      var idx$1 = 0;
      idx$1 = TApplicationFormsList.IndexOfUnitName(Self,aUnitName$2);
      if (idx$1>=0) {
         formInfo$1 = Self.FList[idx$1];
      } else {
         formInfo$1 = TObject.Create($New(TApplicationFormInfo));
         formInfo$1.UnitName = aUnitName$2;
         Self.FList.push(formInfo$1);
      }
      formInfo$1.FormClass = aFormClass$1;
   }
   /// procedure TApplicationFormsList.RegisterFormInstance(aFormClass: TW3CustomFormClass; aFormInstance: TW3CustomForm)
   ///  [line: 1372, column: 33, file: SmartCL.Application]
   ,RegisterFormInstance$1:function(Self, aFormClass$2, aFormInstance) {
      var formInfo$2 = null;
      var idx$2 = 0;
      idx$2 = TApplicationFormsList.IndexOfFormClass(Self,aFormClass$2);
      if (idx$2>=0) {
         formInfo$2 = Self.FList[idx$2];
      } else {
         formInfo$2 = TObject.Create($New(TApplicationFormInfo));
         formInfo$2.FormClass = aFormClass$2;
         Self.FList.push(formInfo$2);
      }
      formInfo$2.Instance = aFormInstance;
      formInfo$2.InitialAutoCreateDone = true;
   }
   /// procedure TApplicationFormsList.UnregisterFormInstance(aFormInstance: TW3CustomForm)
   ///  [line: 1388, column: 33, file: SmartCL.Application]
   ,UnregisterFormInstance:function(Self, aFormInstance$1) {
      var i = 0;
      var $temp16;
      for(i=0,$temp16=Self.FList.length;i<$temp16;i++) {
         if (Self.FList[i].Instance===aFormInstance$1) {
            Self.FList[i].Instance = null;
         }
      }
   }
   ,Destroy:TObject.Destroy
};
/// TApplicationFormInfo = class (TObject)
///  [line: 214, column: 3, file: SmartCL.Application]
var TApplicationFormInfo = {
   $ClassName:"TApplicationFormInfo",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.InitialAutoCreateDone = $.IsMainForm = $.IsAutoCreated = false;
      $.UnitName = "";
      $.Instance = null;
      $.FormClass = null;
   }
   ,Destroy:TObject.Destroy
};
function Forms$2() {
   var Result = null;
   Result = FormsFactory();
   return Result
};
/// EW3Screen = class (EW3Exception)
///  [line: 33, column: 3, file: SmartCL.Application]
var EW3Screen = {
   $ClassName:"EW3Screen",$Parent:EW3Exception
   ,$Init:function ($) {
      EW3Exception.$Init($);
   }
   ,Destroy:Exception.Destroy
};
/// EW3Application = class (EW3Exception)
///  [line: 34, column: 3, file: SmartCL.Application]
var EW3Application = {
   $ClassName:"EW3Application",$Parent:EW3Exception
   ,$Init:function ($) {
      EW3Exception.$Init($);
   }
   ,Destroy:Exception.Destroy
};
function Application() {
   var Result = null;
   Result = Instance;
   return Result
};
function FormsFactory() {
   var Result = null;
   if (!GForms) {
      GForms = TObject.Create($New(TApplicationFormsList));
   }
   Result = GForms;
   return Result
};
/// TW3CustomForm = class (TW3CustomControl)
///  [line: 27, column: 3, file: SmartCL.Forms]
var TW3CustomForm = {
   $ClassName:"TW3CustomForm",$Parent:TW3CustomControl
   ,$Init:function ($) {
      TW3CustomControl.$Init($);
      $.FCaption = "";
      $.FInitialized = false;
      $.FOnActivate = null;
      $.FOnDeactivate = null;
   }
   /// constructor TW3CustomForm.Create(AOwner: TW3Component)
   ///  [line: 68, column: 27, file: SmartCL.Forms]
   ,Create$24:function(Self, AOwner$3) {
      TW3CustomControl.Create$24(Self,AOwner$3);
      TApplicationFormsList.RegisterFormInstance$1(Forms$2(),$AsClass(TObject.ClassType(Self.ClassType),TW3CustomForm),Self);
      return Self
   }
   /// destructor TW3CustomForm.Destroy()
   ///  [line: 74, column: 26, file: SmartCL.Forms]
   ,Destroy:function(Self) {
      TW3CustomApplication.UnRegisterFormInstance(Application(),Self);
      TApplicationFormsList.UnregisterFormInstance(Forms$2(),Self);
      TW3TagObj.Destroy(Self);
   }
   /// procedure TW3CustomForm.FormActivated()
   ///  [line: 99, column: 25, file: SmartCL.Forms]
   ,FormActivated:function(Self) {
      if (!Self.FInitialized) {
         Self.FInitialized = true;
         TW3CustomForm.InitializeForm$(Self);
         if (Self.FOnActivate) {
            Self.FOnActivate(Self);
         }
         TW3CustomControl.LayoutChildren(Self);
      } else if (Self.FOnActivate) {
         Self.FOnActivate(Self);
      }
   }
   /// procedure TW3CustomForm.FormDeactivated()
   ///  [line: 113, column: 25, file: SmartCL.Forms]
   ,FormDeactivated:function(Self) {
      if (Self.FOnDeactivate) {
         Self.FOnDeactivate(Self);
      }
   }
   /// procedure TW3CustomForm.InitializeForm()
   ///  [line: 89, column: 25, file: SmartCL.Forms]
   ,InitializeForm:function(Self) {
   }
   /// procedure TW3CustomForm.setCaption(Value: String)
   ///  [line: 94, column: 25, file: SmartCL.Forms]
   ,setCaption:function(Self, Value$2) {
      Self.FCaption = Value$2;
   }
   /// procedure TW3CustomForm.StyleTagObject()
   ///  [line: 81, column: 25, file: SmartCL.Forms]
   ,StyleTagObject:function(Self) {
      TW3CustomControl.StyleTagObject(Self);
      w3_setStyle(Self.FHandle,w3_CSSPrefix("Transform"),"none");
      TW3CustomControl.SetStyleClass(Self,"TW3CustomForm");
   }
   ,Destroy$:function($){return $.ClassType.Destroy($)}
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject:TW3CustomControl.FinalizeObject
   ,InitializeObject:TW3CustomControl.InitializeObject
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject$:function($){return $.ClassType.StyleTagObject($)}
   ,Create$24$:function($){return $.ClassType.Create$24.apply($.ClassType, arguments)}
   ,Resize:TW3MovableControl.Resize
   ,InitializeForm$:function($){return $.ClassType.InitializeForm($)}
};
/// TW3Form = class (TW3CustomForm)
///  [line: 51, column: 3, file: SmartCL.Forms]
var TW3Form = {
   $ClassName:"TW3Form",$Parent:TW3CustomForm
   ,$Init:function ($) {
      TW3CustomForm.$Init($);
   }
   ,Destroy:TW3CustomForm.Destroy
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject:TW3CustomControl.FinalizeObject
   ,InitializeObject:TW3CustomControl.InitializeObject
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject:TW3CustomForm.StyleTagObject
   ,Create$24:TW3CustomForm.Create$24
   ,Resize:TW3MovableControl.Resize
   ,InitializeForm:TW3CustomForm.InitializeForm
};
/// TW3ScrollInfo = class (TW3OwnedObject)
///  [line: 373, column: 3, file: SmartCL.Components]
var TW3ScrollInfo = {
   $ClassName:"TW3ScrollInfo",$Parent:TW3OwnedObject
   ,$Init:function ($) {
      TW3OwnedObject.$Init($);
   }
   /// function TW3ScrollInfo.AcceptParent(aObject: TObject) : Boolean
   ///  [line: 1580, column: 24, file: SmartCL.Components]
   ,AcceptParent:function(Self, aObject$1) {
      var Result = false;
      Result = (aObject$1!==null)&&$Is(aObject$1,TW3TagObj);
      return Result
   }
   /// function TW3ScrollInfo.GetScrollLeft() : Integer
   ///  [line: 1638, column: 24, file: SmartCL.Components]
   ,GetScrollLeft:function(Self) {
      var Result = 0;
      var mRef$3 = undefined;
      mRef$3 = $As(Self.FOwner,TW3TagObj).FHandle;
      if (mRef$3) {
         Result = parseInt(mRef$3.scrollLeft,10);
      } else {
         EW3TagObj.RaiseCntErrMethod("TW3ScrollInfo.GetScrollLeft",Self,"invalid owner handle error");
      }
      return Result
   }
   /// function TW3ScrollInfo.GetScrollTop() : Integer
   ///  [line: 1649, column: 24, file: SmartCL.Components]
   ,GetScrollTop:function(Self) {
      var Result = 0;
      var mRef$4 = undefined;
      mRef$4 = $As(Self.FOwner,TW3TagObj).FHandle;
      if (mRef$4) {
         Result = parseInt(mRef$4.scrollTop,10);
      } else {
         EW3TagObj.RaiseCntErrMethod("TW3ScrollInfo.GetScrollTop",Self,"invalid owner handle error");
      }
      return Result
   }
   /// procedure TW3ScrollInfo.ScrollTo(aLeft: Integer; aTop: Integer)
   ///  [line: 1660, column: 25, file: SmartCL.Components]
   ,ScrollTo:function(Self, aLeft$1, aTop$1) {
      var mRef$5 = undefined;
      mRef$5 = $As(Self.FOwner,TW3TagObj).FHandle;
      if (mRef$5) {
         mRef$5.scrollLeft = aLeft$1;
         mRef$5.scrollTop = aTop$1;
      } else {
         EW3TagObj.RaiseCntErrMethod("TW3ScrollInfo.ScrollTo",Self,"invalid owner handle error");
      }
   }
   ,Destroy:TObject.Destroy
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11:TW3OwnedObject.Create$11
};
/// TW3ControlSizeInfo = record
///  [line: 192, column: 3, file: SmartCL.Components]
function Copy$TW3ControlSizeInfo(s,d) {
   return d;
}
function Clone$TW3ControlSizeInfo($) {
   return {

   }
}
/// TW3CustomFont = class (TObject)
///  [line: 25, column: 3, file: SmartCL.Fonts]
var TW3CustomFont = {
   $ClassName:"TW3CustomFont",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FOnChange = null;
   }
   ,Destroy:TObject.Destroy
   ,GetHandle$4$:function($){return $.ClassType.GetHandle$4($)}
};
/// TW3ControlFont = class (TW3CustomFont)
///  [line: 329, column: 3, file: SmartCL.Components]
var TW3ControlFont = {
   $ClassName:"TW3ControlFont",$Parent:TW3CustomFont
   ,$Init:function ($) {
      TW3CustomFont.$Init($);
      $.FOwner$3 = null;
   }
   /// function TW3ControlFont.GetHandle() : THandle
   ///  [line: 1571, column: 25, file: SmartCL.Components]
   ,GetHandle$4:function(Self) {
      var Result = undefined;
      Result = Self.FOwner$3.FHandle;
      return Result
   }
   /// constructor TW3ControlFont.Create(AOwner: TW3CustomControl)
   ///  [line: 1562, column: 28, file: SmartCL.Components]
   ,Create$44:function(Self, AOwner$4) {
      TObject.Create(Self);
      if (AOwner$4) {
         Self.FOwner$3 = AOwner$4;
      } else {
         EW3TagObj.RaiseCntErrMethod("TW3ControlFont.Create",Self,"Owner was nil error");
      }
      return Self
   }
   ,Destroy:TObject.Destroy
   ,GetHandle$4$:function($){return $.ClassType.GetHandle$4($)}
};
/// TW3ControlBackground = class (TW3OwnedObject)
///  [line: 340, column: 3, file: SmartCL.Components]
var TW3ControlBackground = {
   $ClassName:"TW3ControlBackground",$Parent:TW3OwnedObject
   ,$Init:function ($) {
      TW3OwnedObject.$Init($);
      $.FHandle$4 = undefined;
   }
   /// function TW3ControlBackground.AcceptParent(aObject: TObject) : Boolean
   ///  [line: 996, column: 31, file: SmartCL.Components]
   ,AcceptParent:function(Self, aObject$2) {
      var Result = false;
      Result = aObject$2!==null&&$Is(aObject$2,TW3MovableControl);
      if (Result) {
         Self.FHandle$4 = $As(aObject$2,TW3MovableControl).FHandle;
      }
      return Result
   }
   ,Destroy:TObject.Destroy
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11:TW3OwnedObject.Create$11
};
/// TW3Constraints = class (TW3OwnedObject)
///  [line: 353, column: 3, file: SmartCL.Components]
var TW3Constraints = {
   $ClassName:"TW3Constraints",$Parent:TW3OwnedObject
   ,$Init:function ($) {
      TW3OwnedObject.$Init($);
   }
   /// function TW3Constraints.AcceptParent(aObject: TObject) : Boolean
   ///  [line: 915, column: 26, file: SmartCL.Components]
   ,AcceptParent:function(Self, aObject$3) {
      var Result = false;
      Result = (aObject$3!==null)&&$Is(aObject$3,TW3TagObj);
      return Result
   }
   /// function TW3Constraints.GetMaxHeight() : Integer
   ///  [line: 965, column: 26, file: SmartCL.Components]
   ,GetMaxHeight:function(Self) {
      var Result = 0;
      var mRef$6 = undefined;
      mRef$6 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$6) {
         Result = w3_getStyleAsInt(mRef$6,"max-height");
      }
      return Result
   }
   /// function TW3Constraints.GetMaxWidth() : Integer
   ///  [line: 956, column: 26, file: SmartCL.Components]
   ,GetMaxWidth:function(Self) {
      var Result = 0;
      var mRef$7 = undefined;
      mRef$7 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$7) {
         Result = w3_getStyleAsInt(mRef$7,"max-width");
      }
      return Result
   }
   /// function TW3Constraints.GetMinHeight() : Integer
   ///  [line: 929, column: 26, file: SmartCL.Components]
   ,GetMinHeight:function(Self) {
      var Result = 0;
      var mRef$8 = undefined;
      mRef$8 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$8) {
         Result = w3_getStyleAsInt(mRef$8,"min-height");
      }
      return Result
   }
   /// function TW3Constraints.GetMinWidth() : Integer
   ///  [line: 920, column: 26, file: SmartCL.Components]
   ,GetMinWidth:function(Self) {
      var Result = 0;
      var mRef$9 = undefined;
      mRef$9 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$9) {
         Result = w3_getStyleAsInt(mRef$9,"min-width");
      }
      return Result
   }
   /// procedure TW3Constraints.SetMaxHeight(aValue: Integer)
   ///  [line: 983, column: 26, file: SmartCL.Components]
   ,SetMaxHeight:function(Self, aValue$18) {
      var mRef$10 = undefined;
      mRef$10 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$10) {
         mRef$10.style["max-height"] = TInteger.ToPxStr(aValue$18);
      }
   }
   /// procedure TW3Constraints.SetMaxWidth(aValue: Integer)
   ///  [line: 974, column: 26, file: SmartCL.Components]
   ,SetMaxWidth:function(Self, aValue$19) {
      var mRef$11 = undefined;
      mRef$11 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$11) {
         mRef$11.style["max-width"] = TInteger.ToPxStr(aValue$19);
      }
   }
   /// procedure TW3Constraints.SetMinHeight(aValue: Integer)
   ///  [line: 947, column: 26, file: SmartCL.Components]
   ,SetMinHeight:function(Self, aValue$20) {
      var mRef$12 = undefined;
      mRef$12 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$12) {
         mRef$12.style["min-height"] = TInteger.ToPxStr(aValue$20);
      }
   }
   /// procedure TW3Constraints.SetMinWidth(aValue: Integer)
   ///  [line: 938, column: 26, file: SmartCL.Components]
   ,SetMinWidth:function(Self, aValue$21) {
      var mRef$13 = undefined;
      mRef$13 = $As(Self.FOwner,TW3MovableControl).FHandle;
      if (mRef$13) {
         mRef$13.style["min-width"] = TInteger.ToPxStr(aValue$21);
      }
   }
   ,Destroy:TObject.Destroy
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11:TW3OwnedObject.Create$11
};
/// TW3AttrAccess = class (TObject)
///  [line: 134, column: 3, file: SmartCL.Components]
var TW3AttrAccess = {
   $ClassName:"TW3AttrAccess",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FHandle$5 = undefined;
   }
   /// constructor TW3AttrAccess.Create(const aHandle: THandle)
   ///  [line: 748, column: 27, file: SmartCL.Components]
   ,Create$45:function(Self, aHandle) {
      TObject.Create(Self);
      if (TBufferHandleHelper$Valid$1(aHandle)) {
         Self.FHandle$5 = aHandle;
      } else {
         throw Exception.Create($New(Exception),$R[13]);
      }
      return Self
   }
   ,Destroy:TObject.Destroy
};
/// TShiftStateEnum enumeration
///  [line: 54, column: 3, file: SmartCL.Components]
var TShiftStateEnum = [ "ssShift", "ssAlt", "ssCtrl", "ssMeta", "ssLeft", "ssRight", "ssMiddle" ];
/// TShiftState = class (TObject)
///  [line: 90, column: 3, file: SmartCL.Components]
var TShiftState = {
   $ClassName:"TShiftState",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FEvent = null;
      $.FMouseButtons = 0;
   }
   /// function TShiftState.CheckShiftStateEnum(value: TShiftStateEnum) : Boolean
   ///  [line: 821, column: 22, file: SmartCL.Components]
   ,CheckShiftStateEnum:function(Self, value$6) {
      var Result = false;
      if (Self.FEvent===null) {
         Result = false;
      } else {
         switch (value$6) {
            case 0 :
               Result = Self.FEvent.shiftKey;
               break;
            case 1 :
               Result = Self.FEvent.altKey;
               break;
            case 2 :
               Result = Self.FEvent.ctrlKey;
               break;
            case 3 :
               Result = Self.FEvent.metaKey;
               break;
            case 4 :
               Result = (Self.FMouseButtons&1)!=0;
               break;
            case 5 :
               Result = (Self.FMouseButtons&4)!=0;
               break;
            case 6 :
               Result = (Self.FMouseButtons&2)!=0;
               break;
         }
      }
      return Result
   }
   ,Destroy:TObject.Destroy
};
/// TMouseButton enumeration
///  [line: 52, column: 3, file: SmartCL.Components]
var TMouseButton = [ "mbLeft", "mbMiddle", "mbRight" ];
/// TCustomAppContainer = class (TW3Component)
///  [line: 294, column: 3, file: SmartCL.Components]
var TCustomAppContainer = {
   $ClassName:"TCustomAppContainer",$Parent:TW3Component
   ,$Init:function ($) {
      TW3Component.$Init($);
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3TagObj.AfterUpdate
   ,FinalizeObject:TW3Component.FinalizeObject
   ,InitializeObject:TW3Component.InitializeObject
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3Component.Showing
   ,StyleTagObject:TW3TagObj.StyleTagObject
   ,Create$24:TW3Component.Create$24
};
/// TDocumentBody = class (TCustomAppContainer)
///  [line: 302, column: 3, file: SmartCL.Components]
var TDocumentBody = {
   $ClassName:"TDocumentBody",$Parent:TCustomAppContainer
   ,$Init:function ($) {
      TCustomAppContainer.$Init($);
   }
   /// function TDocumentBody.GetHeight() : Integer
   ///  [line: 1552, column: 24, file: SmartCL.Components]
   ,GetHeight$5:function(Self) {
      var Result = 0;
      Result = parseInt(BrowserAPI().Window.innerHeight,10);
      return Result
   }
   /// function TDocumentBody.GetWidth() : Integer
   ///  [line: 1547, column: 24, file: SmartCL.Components]
   ,GetWidth$5:function(Self) {
      var Result = 0;
      Result = parseInt(BrowserAPI().Window.innerWidth,10);
      return Result
   }
   /// function TDocumentBody.makeElementTagId() : String
   ///  [line: 1488, column: 24, file: SmartCL.Components]
   ,MakeElementTagId:function(Self) {
      var Result = "";
      Result = "";
      return Result
   }
   /// function TDocumentBody.makeElementTagObj() : THandle
   ///  [line: 1512, column: 24, file: SmartCL.Components]
   ,MakeElementTagObj:function(Self) {
      var Result = undefined;
      Result = BrowserAPI().Body;
      return Result
   }
   /// procedure TDocumentBody.StyleTagObject()
   ///  [line: 1483, column: 25, file: SmartCL.Components]
   ,StyleTagObject:function(Self) {
   }
   ,Destroy:TW3TagObj.Destroy
   ,AfterUpdate:TW3TagObj.AfterUpdate
   ,FinalizeObject:TW3Component.FinalizeObject
   ,InitializeObject:TW3Component.InitializeObject
   ,MakeElementTagId$:function($){return $.ClassType.MakeElementTagId($)}
   ,MakeElementTagObj$:function($){return $.ClassType.MakeElementTagObj($)}
   ,Showing:TW3Component.Showing
   ,StyleTagObject$:function($){return $.ClassType.StyleTagObject($)}
   ,Create$24:TW3Component.Create$24
};
/// EW3TagObj = class (EW3Exception)
///  [line: 44, column: 3, file: SmartCL.Components]
var EW3TagObj = {
   $ClassName:"EW3TagObj",$Parent:EW3Exception
   ,$Init:function ($) {
      EW3Exception.$Init($);
   }
   /// procedure EW3TagObj.RaiseCntErrMethod(methName: String; instance: TObject; msg: String)
   ///  [line: 811, column: 27, file: SmartCL.Components]
   ,RaiseCntErrMethod:function(methName, instance, msg) {
      throw EW3Exception.CreateFmt($New(EW3TagObj),$R[0],[methName, (instance!==null)?TObject.ClassName(instance.ClassType):"nil", msg]);
   }
   ,Destroy:Exception.Destroy
};
/// TW3RGBA = record
///  [line: 175, column: 3, file: System.Colors]
function Copy$TW3RGBA(s,d) {
   d.A$2=s.A$2;
   d.B$1=s.B$1;
   d.G$1=s.G$1;
   d.R$2=s.R$2;
   return d;
}
function Clone$TW3RGBA($) {
   return {
      A$2:$.A$2,
      B$1:$.B$1,
      G$1:$.G$1,
      R$2:$.R$2
   }
}
function StrToColor(aColorStr) {
   aColorStr={v:aColorStr};
   var Result = {v:0};
   try {
      var mTemp = "";
      var xpos = 0;
      var r$2 = 0;
      var g = 0;
      var b$1 = 0;
      aColorStr.v = Trim$_String_(aColorStr.v);
      if (aColorStr.v.length==0) {
         return Result.v;
      }
      if ((aColorStr.v).toLocaleLowerCase()=="transparent") {
         Result.v = 536870911;
         return Result.v;
      }
      if (aColorStr.v.charAt(0)=="#"||aColorStr.v.charAt(0)=="$") {
         Result.v = parseInt("0x"+Trim$_String_Integer_Integer_(aColorStr.v,1,0),16);
      } else {
         if ((aColorStr.v).substr(0,2)=="0x") {
            Result.v = parseInt(aColorStr.v,16);
         } else if (((aColorStr.v).substr(0,4)).toLowerCase()=="rgb(") {
            aColorStr.v = Trim$_String_Integer_Integer_(aColorStr.v,4,0);
            try {
               xpos = (aColorStr.v.indexOf(",")+1);
               if (xpos>1) {
                  mTemp = aColorStr.v.substr(0,(xpos-1));
                  Delete(aColorStr,1,xpos);
                  if (mTemp.charAt(0)=="$") {
                     mTemp = "0x"+Trim$_String_Integer_Integer_(mTemp,1,0);
                  }
                  r$2 = parseInt(mTemp,10);
               }
               xpos = (aColorStr.v.indexOf(",")+1);
               if (xpos>1) {
                  mTemp = aColorStr.v.substr(0,(xpos-1));
                  Delete(aColorStr,1,xpos);
                  if (mTemp.charAt(0)=="$") {
                     mTemp = "0x"+Trim$_String_Integer_Integer_(mTemp,1,0);
                  }
                  g = parseInt(mTemp,10);
               }
               xpos = (aColorStr.v.indexOf(")")+1);
               if (xpos>1) {
                  mTemp = aColorStr.v.substr(0,(xpos-1));
                  if (mTemp.charAt(0)=="$") {
                     mTemp = "0x"+Trim$_String_Integer_Integer_(mTemp,1,0);
                  }
                  b$1 = parseInt(mTemp,10);
               }
               Result.v = RGBToColor(r$2,g,b$1);
            } catch ($e) {
               var e$6 = $W($e);
               return Result.v;
            }
         }
      }
   } finally {return Result.v}
};
function RGBToColor(aRed, aGreen, aBlue) {
   var Result = 0;
   Result = (aBlue|(aGreen<<8))|(aRed<<16);
   return Result
};
function ColorToWebStr(aColor, alpha) {
   var Result = "";
   Result = ColorToWebStr$1((aColor>>>16)&255,(aColor>>>8)&255,aColor&255,alpha);
   return Result
};
function ColorToWebStr$1(r$3, g$1, b$18, a$52) {
   var Result = "";
   Result = (a$52==255)?"#"+IntToHex2(r$3)+IntToHex2(g$1)+IntToHex2(b$18):"rgba("+r$3.toString()+","+g$1.toString()+","+b$18.toString()+","+FloatToStr$_Float_(a$52/255)+")";
   return Result
};
function W3FontDetector() {
   var Result = null;
   if (_FontDetect===null) {
      _FontDetect = TW3FontDetector.Create$48($New(TW3FontDetector));
   }
   Result = _FontDetect;
   return Result
};
/// TW3TextMetric = record
///  [line: 54, column: 3, file: SmartCL.Fonts]
function Copy$TW3TextMetric(s,d) {
   d.tmWidth=s.tmWidth;
   d.tmHeight=s.tmHeight;
   return d;
}
function Clone$TW3TextMetric($) {
   return {
      tmWidth:$.tmWidth,
      tmHeight:$.tmHeight
   }
}
/// TW3FontInfo = record
///  [line: 64, column: 3, file: SmartCL.Fonts]
function Copy$TW3FontInfo(s,d) {
   d.fiName=s.fiName;
   d.fiSize=s.fiSize;
   return d;
}
function Clone$TW3FontInfo($) {
   return {
      fiName:$.fiName,
      fiSize:$.fiSize
   }
}
/// TW3FontDetector = class (TObject)
///  [line: 77, column: 3, file: SmartCL.Fonts]
var TW3FontDetector = {
   $ClassName:"TW3FontDetector",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FBaseFonts = [];
      $.FdefaultHeight = $.FdefaultWidth = undefined;
      $.Fh = undefined;
      $.Fs = undefined;
      $.FtestSize = "72px";
      $.FtestString = "mmmmmmmmmmlli";
   }
   /// constructor TW3FontDetector.Create()
   ///  [line: 150, column: 29, file: SmartCL.Fonts]
   ,Create$48:function(Self) {
      var x$40 = 0;
      TObject.Create(Self);
      Self.FBaseFonts.push("monospace");
      Self.FBaseFonts.push("sans-serif");
      Self.FBaseFonts.push("serif");
      Self.Fh = BrowserAPI().document.body;
      Self.Fs = BrowserAPI().document.createElement("span");
      Self.Fs.style.fontSize = Self.FtestSize;
      Self.Fs.innerHTML = Self.FtestString;
      Self.FdefaultWidth = TVariant.CreateObject();
      Self.FdefaultHeight = TVariant.CreateObject();
      if (Self.FBaseFonts.length>0) {
         var $temp17;
         for(x$40=0,$temp17=Self.FBaseFonts.length;x$40<$temp17;x$40++) {
            Self.Fs.style.fontFamily = Self.FBaseFonts[x$40];
            Self.Fh.appendChild(Self.Fs);
            Self.FdefaultWidth[Self.FBaseFonts[x$40]] = Self.Fs.offsetWidth;
            Self.FdefaultHeight[Self.FBaseFonts[x$40]] = Self.Fs.offsetHeight;
            Self.Fh.removeChild(Self.Fs);
         }
      }
      return Self
   }
   /// function TW3FontDetector.Detect(aFont: String) : Boolean
   ///  [line: 212, column: 26, file: SmartCL.Fonts]
   ,Detect:function(Self, aFont) {
      var Result = false;
      var x$41 = 0;
      aFont = Trim$_String_(aFont);
      if (aFont.length>0) {
         if (Self.FBaseFonts.length>0) {
            var $temp18;
            for(x$41=0,$temp18=Self.FBaseFonts.length;x$41<$temp18;x$41++) {
               Self.Fs.style.fontFamily = (aFont+","+Self.FBaseFonts[x$41]);
               Self.Fh.appendChild(Self.Fs);
               Result = Self.Fs.offsetWidth!=Self.FdefaultWidth[Self.FBaseFonts[x$41]]&&Self.Fs.offsetHeight!=Self.FdefaultHeight[Self.FBaseFonts[x$41]];
               Self.Fh.removeChild(Self.Fs);
               if (Result) {
                  break;
               }
            }
         }
      }
      return Result
   }
   /// function TW3FontDetector.getFontInfo(const aHandle: THandle) : TW3FontInfo
   ///  [line: 178, column: 26, file: SmartCL.Fonts]
   ,getFontInfo$2:function(Self, aHandle$1) {
      var Result = {fiName:"",fiSize:0};
      var mName = "";
      var mSize = 0;
      var mData$6 = [],
         x$42 = 0;
      Result.fiSize = -1;
      if (TBufferHandleHelper$Valid$1(aHandle$1)) {
         mName = w3_getStyleAsStr(aHandle$1,"font-family");
         mSize = w3_getStyleAsInt(aHandle$1,"font-size");
         if (mName.length>0) {
            mData$6 = (mName).split(",");
            if (mData$6.length>0) {
               var $temp19;
               for(x$42=0,$temp19=mData$6.length;x$42<$temp19;x$42++) {
                  if (TW3FontDetector.Detect(Self,mData$6[x$42])) {
                     Result.fiName = mData$6[x$42];
                     Result.fiSize = mSize;
                     break;
                  }
               }
            }
         }
      }
      return Result
   }
   /// function TW3FontDetector.MeasureText(aFontName: String; aFontSize: Integer; aFixedWidth: Integer; aContent: String) : TW3TextMetric
   ///  [line: 278, column: 26, file: SmartCL.Fonts]
   ,MeasureText$5:function(Self, aFontName, aFontSize, aFixedWidth, aContent) {
      var Result = {tmWidth:0,tmHeight:0};
      var mElement = undefined;
      if (TW3FontDetector.Detect(Self,aFontName)) {
         aContent = Trim$_String_(aContent);
         if (aContent.length>0) {
            mElement = BrowserAPI().document.createElement("p");
            if (mElement) {
               mElement.style["font-family"] = aFontName;
               mElement.style["font-size"] = TInteger.ToPxStr(aFontSize);
               mElement.style["overflow"] = "scroll";
               mElement.style.maxWidth = TInteger.ToPxStr(aFixedWidth);
               mElement.style.width = TInteger.ToPxStr(aFixedWidth);
               mElement.innerHTML = aContent;
               Self.Fh.appendChild(mElement);
               Result.tmWidth = parseInt(mElement.scrollWidth,10);
               Result.tmHeight = parseInt(mElement.scrollHeight,10);
               Self.Fh.removeChild(mElement);
            }
         }
      }
      return Result
   }
   /// function TW3FontDetector.MeasureText(aFontName: String; aFontSize: Integer; aContent: String) : TW3TextMetric
   ///  [line: 246, column: 26, file: SmartCL.Fonts]
   ,MeasureText$4:function(Self, aFontName$1, aFontSize$1, aContent$1) {
      var Result = {tmWidth:0,tmHeight:0};
      var mElement$1 = undefined;
      if (TW3FontDetector.Detect(Self,aFontName$1)) {
         aContent$1 = Trim$_String_(aContent$1);
         if (aContent$1.length>0) {
            mElement$1 = BrowserAPI().document.createElement("p");
            if (mElement$1) {
               mElement$1.style["font-family"] = aFontName$1;
               mElement$1.style["font-size"] = TInteger.ToPxStr(aFontSize$1);
               mElement$1.style["overflow"] = "scroll";
               mElement$1.style["display"] = "inline-block";
               mElement$1.style["white-space"] = "nowrap";
               mElement$1.innerHTML = StrReplace(aContent$1," ","_");
               Self.Fh.appendChild(mElement$1);
               Result.tmWidth = parseInt(mElement$1.scrollWidth,10);
               Result.tmHeight = parseInt(mElement$1.scrollHeight,10);
               Self.Fh.removeChild(mElement$1);
            }
         }
      }
      return Result
   }
   /// function TW3FontDetector.MeasureText(aFontInfo: TW3FontInfo; aFixedWidth: Integer; aContent: String) : TW3TextMetric
   ///  [line: 233, column: 26, file: SmartCL.Fonts]
   ,MeasureText$3:function(Self, aFontInfo, aFixedWidth$1, aContent$2) {
      var Result = {tmWidth:0,tmHeight:0};
      Result = TW3FontDetector.MeasureText$5(Self,aFontInfo.fiName,aFontInfo.fiSize,aFixedWidth$1,aContent$2);
      return Result
   }
   /// function TW3FontDetector.MeasureText(aFontInfo: TW3FontInfo; aContent: String) : TW3TextMetric
   ///  [line: 240, column: 26, file: SmartCL.Fonts]
   ,MeasureText$2:function(Self, aFontInfo$1, aContent$3) {
      var Result = {tmWidth:0,tmHeight:0};
      Result = TW3FontDetector.MeasureText$4(Self,aFontInfo$1.fiName,aFontInfo$1.fiSize,aContent$3);
      return Result
   }
   ,Destroy:TObject.Destroy
};
/// TW3CSSClassStyleNames = class (TW3OwnedObject)
///  [line: 24, column: 3, file: SmartCL.CssNames]
var TW3CSSClassStyleNames = {
   $ClassName:"TW3CSSClassStyleNames",$Parent:TW3OwnedObject
   ,$Init:function ($) {
      TW3OwnedObject.$Init($);
      $.FCache = [];
      $.FToken = "";
   }
   /// function TW3CSSClassStyleNames.AcceptParent(aObject: TObject) : Boolean
   ///  [line: 73, column: 32, file: SmartCL.CssNames]
   ,AcceptParent:function(Self, aObject$4) {
      var Result = false;
      Result = (aObject$4!==null)&&$Is(aObject$4,TW3CustomControl);
      return Result
   }
   /// constructor TW3CSSClassStyleNames.Create(AOwner: TObject)
   ///  [line: 60, column: 35, file: SmartCL.CssNames]
   ,Create$11:function(Self, AOwner$5) {
      TW3OwnedObject.Create$11(Self,AOwner$5);
      Self.FToken = "class";
      Self.FCache = [];
      return Self
   }
   /// destructor TW3CSSClassStyleNames.Destroy()
   ///  [line: 67, column: 34, file: SmartCL.CssNames]
   ,Destroy:function(Self) {
      Self.FCache.length=0;
      TObject.Destroy(Self);
   }
   ,Destroy$:function($){return $.ClassType.Destroy($)}
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11$:function($){return $.ClassType.Create$11.apply($.ClassType, arguments)}
};
/// TW3TouchList = class (TObject)
///  [line: 58, column: 3, file: SmartCL.Touch]
var TW3TouchList = {
   $ClassName:"TW3TouchList",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FObjects = [];
   }
   /// procedure TW3TouchList.Clear()
   ///  [line: 131, column: 24, file: SmartCL.Touch]
   ,Clear$1:function(Self) {
      Self.FObjects.length=0;
   }
   /// procedure TW3TouchList.Update(refObj: JTouchList)
   ///  [line: 141, column: 24, file: SmartCL.Touch]
   ,Update:function(Self, refObj) {
      var mCount$2 = 0;
      var x$43 = 0;
      var mObj$10 = null;
      mCount$2 = refObj.length;
      if (mCount$2==Self.FObjects.length) {
         var $temp20;
         for(x$43=0,$temp20=mCount$2;x$43<$temp20;x$43++) {
            TW3Touch.Consume$1(Self.FObjects[x$43],refObj[x$43]);
         }
      } else {
         TW3TouchList.Clear$1(Self);
         var $temp21;
         for(x$43=0,$temp21=mCount$2;x$43<$temp21;x$43++) {
            mObj$10 = TObject.Create($New(TW3Touch));
            TW3Touch.Consume$1(mObj$10,refObj[x$43]);
            Self.FObjects.push(mObj$10);
         }
      }
   }
   ,Destroy:TObject.Destroy
};
/// TW3TouchData = class (TObject)
///  [line: 70, column: 3, file: SmartCL.Touch]
var TW3TouchData = {
   $ClassName:"TW3TouchData",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FChanged = $.FTouches = null;
   }
   /// procedure TW3TouchData.Update(eventObj: JTouchEvent)
   ///  [line: 172, column: 24, file: SmartCL.Touch]
   ,Update$1:function(Self, eventObj$1) {
      if (Self.FTouches) {
         TW3TouchList.Update(Self.FTouches,eventObj$1.touches);
      }
      if (Self.FChanged) {
         TW3TouchList.Update(Self.FChanged,eventObj$1.changedTouches);
      }
   }
   ,Destroy:TObject.Destroy
};
/// TW3Touch = class (TObject)
///  [line: 34, column: 3, file: SmartCL.Touch]
var TW3Touch = {
   $ClassName:"TW3Touch",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FClientX = $.FClientY = $.FPageX = $.FPageY = $.FScreenX = $.FScreenY = 0;
      $.FIdent = undefined;
      $.FTarget = null;
   }
   /// procedure TW3Touch.Consume(touch: JTouch)
   ///  [line: 104, column: 20, file: SmartCL.Touch]
   ,Consume$1:function(Self, touch) {
      Self.FScreenX = touch.screenX;
      Self.FScreenY = touch.screenY;
      Self.FClientX = touch.clientX;
      Self.FClientY = touch.clientY;
      Self.FPageX = touch.pageX;
      Self.FPageY = touch.pageY;
      Self.FIdent = touch.identifier;
      Self.FTarget = TVariant.AsObject(touch.target);
   }
   ,Destroy:TObject.Destroy
};
/// TW3GestureData = class (TObject)
///  [line: 83, column: 3, file: SmartCL.Touch]
var TW3GestureData = {
   $ClassName:"TW3GestureData",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FRotation = $.FScale = 0;
   }
   /// procedure TW3GestureData.Consume(refObj: THandle)
   ///  [line: 206, column: 26, file: SmartCL.Touch]
   ,Consume$2:function(Self, refObj$1) {
      Self.FRotation = Number(refObj$1.rotation);
      Self.FScale = Number(refObj$1.scale);
   }
   /// procedure TW3GestureData.Update()
   ///  [line: 213, column: 26, file: SmartCL.Touch]
   ,Update$2:function(Self) {
      TW3GestureData.Consume$2(Self,BrowserAPI().Event);
   }
   ,Destroy:TObject.Destroy
};
/// JMouseButton enumeration
///  [line: 156, column: 3, file: W3C.DOM]
var JMouseButton = [ "Left", "Middle", "Right" ];
/// TW3Borders = class (TW3OwnedObject)
///  [line: 56, column: 3, file: SmartCL.Borders]
var TW3Borders = {
   $ClassName:"TW3Borders",$Parent:TW3OwnedObject
   ,$Init:function ($) {
      TW3OwnedObject.$Init($);
      $.FBottom = $.FLeft = $.FRight = $.FTop = null;
   }
   /// function TW3Borders.AcceptParent(AObject: TObject) : Boolean
   ///  [line: 348, column: 21, file: SmartCL.Borders]
   ,AcceptParent:function(Self, AObject) {
      var Result = false;
      Result = $Is(AObject,TW3TagObj);
      return Result
   }
   /// constructor TW3Borders.Create(AOwner: TObject)
   ///  [line: 301, column: 24, file: SmartCL.Borders]
   ,Create$11:function(Self, AOwner$6) {
      TW3OwnedObject.Create$11(Self,AOwner$6);
      Self.FLeft = TW3Border.Create$51($New(TW3Border),Self,0);
      Self.FTop = TW3Border.Create$51($New(TW3Border),Self,1);
      Self.FRight = TW3Border.Create$51($New(TW3Border),Self,2);
      Self.FBottom = TW3Border.Create$51($New(TW3Border),Self,3);
      return Self
   }
   /// destructor TW3Borders.Destroy()
   ///  [line: 310, column: 23, file: SmartCL.Borders]
   ,Destroy:function(Self) {
      TObject.Free(Self.FLeft);
      TObject.Free(Self.FTop);
      TObject.Free(Self.FRight);
      TObject.Free(Self.FBottom);
      TObject.Destroy(Self);
   }
   /// function TW3Borders.GetHSpace() : Integer
   ///  [line: 343, column: 21, file: SmartCL.Borders]
   ,GetHSpace:function(Self) {
      var Result = 0;
      Result = TW3Border.GetWidth$6(Self.FLeft)+TW3Border.GetPadding(Self.FLeft)+TW3Border.GetWidth$6(Self.FRight)+TW3Border.GetPadding(Self.FRight);
      return Result
   }
   /// function TW3Borders.GetVSpace() : Integer
   ///  [line: 338, column: 21, file: SmartCL.Borders]
   ,GetVSpace:function(Self) {
      var Result = 0;
      Result = TW3Border.GetWidth$6(Self.FTop)+TW3Border.GetPadding(Self.FTop)+TW3Border.GetWidth$6(Self.FBottom)+TW3Border.GetPadding(Self.FBottom);
      return Result
   }
   ,Destroy$:function($){return $.ClassType.Destroy($)}
   ,AcceptParent$:function($){return $.ClassType.AcceptParent.apply($.ClassType, arguments)}
   ,Create$11$:function($){return $.ClassType.Create$11.apply($.ClassType, arguments)}
};
/// TW3BorderEdgeStyle enumeration
///  [line: 23, column: 3, file: SmartCL.Borders]
var TW3BorderEdgeStyle = [ "besNone", "besSolid", "besDotted", "besDouble", "besGroove", "besInset", "besOutset" ];
/// TW3BorderEdge enumeration
///  [line: 22, column: 3, file: SmartCL.Borders]
var TW3BorderEdge = [ "beLeft", "beTop", "beRight", "beBottom" ];
/// TW3Border = class (TObject)
///  [line: 28, column: 3, file: SmartCL.Borders]
var TW3Border = {
   $ClassName:"TW3Border",$Parent:TObject
   ,$Init:function ($) {
      TObject.$Init($);
      $.FEdge = 0;
      $.FEdgeName = "";
      $.FOwner$4 = null;
   }
   /// constructor TW3Border.Create(AOwner: TW3Borders; AEdge: TW3BorderEdge)
   ///  [line: 94, column: 23, file: SmartCL.Borders]
   ,Create$51:function(Self, AOwner$7, AEdge) {
      TObject.Create(Self);
      Self.FOwner$4 = AOwner$7;
      Self.FEdge = Self.FEdge;
      switch (AEdge) {
         case 0 :
            Self.FEdgeName = "left";
            break;
         case 1 :
            Self.FEdgeName = "top";
            break;
         case 2 :
            Self.FEdgeName = "right";
            break;
         case 3 :
            Self.FEdgeName = "bottom";
            break;
      }
      return Self
   }
   /// function TW3Border.GetPadding() : Integer
   ///  [line: 131, column: 20, file: SmartCL.Borders]
   ,GetPadding:function(Self) {
      var Result = 0;
      var mRef$14 = undefined;
      var mKey = "";
      Result = 0;
      mRef$14 = $As(Self.FOwner$4.FOwner,TW3TagObj).FHandle;
      if (mRef$14) {
         mKey = "padding-"+Self.FEdgeName;
         Result = w3_getStyleAsInt(mRef$14,mKey);
      }
      return Result
   }
   /// function TW3Border.GetWidth() : Integer
   ///  [line: 193, column: 20, file: SmartCL.Borders]
   ,GetWidth$6:function(Self) {
      var Result = 0;
      var mRef$15 = undefined;
      var mKey$1 = "";
      Result = 0;
      mRef$15 = $As(Self.FOwner$4.FOwner,TW3TagObj).FHandle;
      if (mRef$15) {
         mKey$1 = "border-"+Self.FEdgeName+"-width";
         Result = w3_getStyleAsInt(mRef$15,mKey$1);
      }
      return Result
   }
   /// procedure TW3Border.SetPadding(aValue: Integer)
   ///  [line: 146, column: 21, file: SmartCL.Borders]
   ,SetPadding:function(Self, aValue$22) {
      var mRef$16 = undefined;
      var mKey$2 = "";
      mRef$16 = $As(Self.FOwner$4.FOwner,TW3TagObj).FHandle;
      if (mRef$16) {
         mKey$2 = "padding-"+Self.FEdgeName;
         w3_setStyle(mRef$16,mKey$2,TInteger.ToPxStr(aValue$22));
      } else {
         throw EW3Exception.CreateFmt($New(EW3TagObj),$R[0],["TW3Border.SetPadding", TObject.ClassName(Self.ClassType), $R[16]]);
      }
   }
   /// procedure TW3Border.SetWidth(aValue: Integer)
   ///  [line: 208, column: 21, file: SmartCL.Borders]
   ,SetWidth$1:function(Self, aValue$23) {
      var mRef$17 = undefined;
      var mKey$3 = "";
      mRef$17 = $As(Self.FOwner$4.FOwner,TW3TagObj).FHandle;
      if (mRef$17) {
         mKey$3 = "border-"+Self.FEdgeName+"-width";
         w3_setStyle(mRef$17,mKey$3,TInteger.ToPxStr(aValue$23));
      } else {
         throw EW3Exception.CreateFmt($New(EW3TagObj),$R[0],["TW3Border.SetWidth", TObject.ClassName(Self.ClassType), $R[16]]);
      }
   }
   ,Destroy:TObject.Destroy
};
/// TW3AnimationTiming enumeration
///  [line: 89, column: 3, file: SmartCL.Effects]
var TW3AnimationTiming = [ "atEase", "atLinear", "atEaseIn", "atEaseOut", "atEaseInOut" ];
var cW3AnimationTiming = ["ease","linear","ease-in","ease-out","ease-in-out"];
/// TForm1 = class (TW3Form)
///  [line: 10, column: 3, file: Form1]
var TForm1 = {
   $ClassName:"TForm1",$Parent:TW3Form
   ,$Init:function ($) {
      TW3Form.$Init($);
   }
   /// procedure TForm1.InitializeForm()
   ///  [line: 23, column: 18, file: Form1]
   ,InitializeForm:function(Self) {
      TW3CustomForm.InitializeForm(Self);
   }
   /// procedure TForm1.InitializeObject()
   ///  [line: 29, column: 18, file: Form1]
   ,InitializeObject:function(Self) {
      TW3CustomControl.InitializeObject(Self);
      TW3CustomForm.setCaption(Self,"W3Form");
      TW3Component.SetName(Self,"Form1");
   }
   /// procedure TForm1.Resize()
   ///  [line: 35, column: 18, file: Form1]
   ,Resize:function(Self) {
      TW3MovableControl.Resize(Self);
   }
   ,Destroy:TW3CustomForm.Destroy
   ,AfterUpdate:TW3CustomControl.AfterUpdate
   ,FinalizeObject:TW3CustomControl.FinalizeObject
   ,InitializeObject$:function($){return $.ClassType.InitializeObject($)}
   ,MakeElementTagId:TW3TagObj.MakeElementTagId
   ,MakeElementTagObj:TW3TagObj.MakeElementTagObj
   ,Showing:TW3MovableControl.Showing
   ,StyleTagObject:TW3CustomForm.StyleTagObject
   ,Create$24:TW3CustomForm.Create$24
   ,Resize$:function($){return $.ClassType.Resize($)}
   ,InitializeForm$:function($){return $.ClassType.InitializeForm($)}
};
var vColorNames = [],
   vColorNames = ["aqua", "black", "blue", "fuchsia", "green", "gray", "lime", "maroon", "navy", "olive", "purple", "red", "silver", "teal", "white", "yellow"].slice();
var vColorValues = [],
   vColorValues = ["#0ff", "#000", "#00f", "#f0f", "#008000", "#808080", "#0f0", "#800000", "#000080", "#808000", "#800080", "#f00", "#c0c0c0", "#008080", "#fff", "#ff00"].slice();
var vCurrent = null;
var RegisterComponentsProc = null;
var DefaultDuration = 0,
   DefaultDuration = 2;
var DefaultTiming = 0,
   DefaultTiming = 1;
var Instance = null;
var Application$1 = null;
var GForms = null;
var _FontDetect = null;
var BrowserAPIx,
   vUniqueNumber = 0;
var vVendor = 0;
var vRequestAnimFrame = null;
var vCancelAnimFrame = null;
var BrowserAPIx = {
      "Window" : window
      ,"Styles" : window.style
      ,"Self" : self
      ,"Navigator" : navigator
      ,"GetWindow" : window
      ,"GetStyles" : window.style
      ,"GetDocument" : document
      ,"GetBody" : document.body
      ,"Event" : event
      ,"Document" : document
      ,"DevicePixelRatio" : function () {
         var Result = 0;
         Result = window.devicePixelRatio || 1;
         return Result
      }
      ,"CSSToken" : ["webkit","Moz","O","ms"]
      ,"Console" : window.console
      ,"classname" : ["TW3WebkitBrowserAPI","TW3FirefoxBrowserAPI","TW3OperaBrowserAPI","TW3IEBrowserAPI"]
      ,"Body" : document.body
   };
TApplicationFormsList.RegisterForm(Forms$2(),"Form1",TForm1);
TApplicationFormsList.RegisterAutoCreate(Forms$2(),"Form1",true,true);
var $Application = function() {
   try {
      Application$1 = TW3CustomApplication.Create$3($New(TApplication));
      TW3CustomApplication.RunApp(Application$1);
   } catch ($e) {
      var e$7 = $W($e);
      alert(e$7.FMessage)   }
}
$Application();
var $Application = function() {
   if (_FontDetect) {
      TObject.Free(_FontDetect);
   }
}
$Application();

