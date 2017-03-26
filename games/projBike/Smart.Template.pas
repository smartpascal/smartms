(*
 ╔═══════════════════════════════════════════════════════════════════════════════════════════════════════╗
 ║ This is a custom wrapper for Template7. Template7 is a mobile-first JavaScript template engine with   ║
 ║ Handlebars-like syntax.  It is used as default template engine in Framework7                          ║
 ║ It is ultra lightweight (around 1KB minified and gzipped) and blazing fast (up to 2-3 times faster    ║
 ║ than Handlebars in mobile Safari).                                                                    ║
 ║ by warleyalex                                                                                         ║
 ╚═══════════════════════════════════════════════════════════════════════════════════════════════════════╝   }
 *)

unit Smart.Template;

{$R 'lib\template7.min.js'}

interface

  uses W3C.HTML5, W3C.DOM;

type
  THandle = variant;
  TFunc = function(fn: variant): variant;
  TMyTemp = function(p: variant) : THandle;

type
  JHelpers7 = class external 'Object'
  /*
    function _partial(partialName, options: variant): JHelpers7;
    function escape(context, options: variant): JHelpers7;
    function &if(context, options: variant): JHelpers7;
    function unless(context, options: variant): JHelpers7;
    function each(context, options: variant): JHelpers7;
    function &with(context, options: variant): JHelpers7;
    function join(context, options: variant): JHelpers7;
    function js(expression, options: variant): JHelpers7;
    function js_compare(expression, options: variant): JHelpers7;
    */
   end;

type
  JOptions7 = class external 'Object'
  end;

type
  JPartials7 = class external 'Object'
end;

type
  JTemplate7 = class external 'Object'
  helpers: JHelpers7;
  options: JOptions7;
  partials: JPartials7;
  global: THandle;
  templates : THandle;
  function registerHelper(name, fn: variant): JTemplate7; overload;
  function registerHelper(name: variant; fn: TFunc): JTemplate7; overload;
  function unregisterHelper(name: variant): JTemplate7;
  function registerPartial(name, template: variant): JTemplate7;
  function unregisterPartial(name, template: variant): JTemplate7;
  function compile(template, options: variant): JTemplate7; overload;
  //function compile(template: variant) : variant; overload;
  function compile(template: variant) : TMyTemp; overload;
  //function source(template: variant) : variant; overload;
  //property source : TMyTemp; overload;
end;

var Template7 external "Template7" : JTemplate7;
