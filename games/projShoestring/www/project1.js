var pas = {};

var rtl = {

  quiet: false,
  debug_load_units: false,
  debug_rtti: false,

  debug: function(){
    if (rtl.quiet || !console || !console.log) return;
    console.log(arguments);
  },

  error: function(s){
    rtl.debug('Error: ',s);
    throw s;
  },

  warn: function(s){
    rtl.debug('Warn: ',s);
  },

  hasString: function(s){
    return rtl.isString(s) && (s.length>0);
  },

  isArray: function(a) {
    return Array.isArray(a);
  },

  isFunction: function(f){
    return typeof(f)==="function";
  },

  isModule: function(m){
    return rtl.isObject(m) && rtl.hasString(m.$name) && (pas[m.$name]===m);
  },

  isImplementation: function(m){
    return rtl.isObject(m) && rtl.isModule(m.$module) && (m.$module.$impl===m);
  },

  isNumber: function(n){
    return typeof(n)==="number";
  },

  isObject: function(o){
    var s=typeof(o);
    return (typeof(o)==="object") && (o!=null);
  },

  isString: function(s){
    return typeof(s)==="string";
  },

  getNumber: function(n){
    return typeof(n)==="number"?n:NaN;
  },

  getChar: function(c){
    return ((typeof(c)==="string") && (c.length===1)) ? c : "";
  },

  getObject: function(o){
    return ((typeof(o)==="object") || (typeof(o)==='function')) ? o : null;
  },

  isPasClass: function(type){
    return (rtl.isObject(type) && type.hasOwnProperty('$classname') && rtl.isObject(type.$module));
  },

  isPasClassInstance: function(type){
    return (rtl.isObject(type) && rtl.isPasClass(type.$class));
  },

  hexStr: function(n,digits){
    return ("000000000000000"+n.toString(16).toUpperCase()).slice(-digits);
  },

  m_loading: 0,
  m_loading_intf: 1,
  m_intf_loaded: 2,
  m_loading_impl: 3, // loading all used unit
  m_initializing: 4, // running initialization
  m_initialized: 5,

  module: function(module_name, intfuseslist, intfcode, impluseslist, implcode){
    if (rtl.debug_load_units) rtl.debug('rtl.module name="'+module_name+'" intfuses='+intfuseslist+' impluses='+impluseslist+' hasimplcode='+rtl.isFunction(implcode));
    if (!rtl.hasString(module_name)) rtl.error('invalid module name "'+module_name+'"');
    if (!rtl.isArray(intfuseslist)) rtl.error('invalid interface useslist of "'+module_name+'"');
    if (!rtl.isFunction(intfcode)) rtl.error('invalid interface code of "'+module_name+'"');
    if (!(impluseslist==undefined) && !rtl.isArray(impluseslist)) rtl.error('invalid implementation useslist of "'+module_name+'"');
    if (!(implcode==undefined) && !rtl.isFunction(implcode)) rtl.error('invalid implementation code of "'+module_name+'"');

    if (pas[module_name])
      rtl.error('module "'+module_name+'" is already registered');

    var module = pas[module_name] = {
      $name: module_name,
      $intfuseslist: intfuseslist,
      $impluseslist: impluseslist,
      $state: rtl.m_loading,
      $intfcode: intfcode,
      $implcode: implcode,
      $impl: null,
      $rtti: Object.create(rtl.tSectionRTTI)
    };
    module.$rtti.$module = module;
    if (implcode) module.$impl = {
      $module: module,
      $rtti: module.$rtti
    };
  },

  exitcode: 0,

  run: function(module_name){
  
    function doRun(){
      if (!rtl.hasString(module_name)) module_name='program';
      if (rtl.debug_load_units) rtl.debug('rtl.run module="'+module_name+'"');
      rtl.initRTTI();
      var module = pas[module_name];
      if (!module) rtl.error('rtl.run module "'+module_name+'" missing');
      rtl.loadintf(module);
      rtl.loadimpl(module);
      if (module_name=='program'){
        if (rtl.debug_load_units) rtl.debug('running $main');
        var r = pas.program.$main();
        if (rtl.isNumber(r)) rtl.exitcode = r;
      }
    }
    
    if (rtl.showUncaughtExceptions) {
      try{
        doRun();
      } catch(re) {
        var errMsg = re.hasOwnProperty('$class') ? re.$class.$classname : '';
	    errMsg +=  ((errMsg) ? ': ' : '') + (re.hasOwnProperty('fMessage') ? re.fMessage : re);
        alert('Uncaught Exception : '+errMsg);
        rtl.exitCode = 216;
      }
    } else {
      doRun();
    }
    return rtl.exitcode;
  },

  loadintf: function(module){
    if (module.$state>rtl.m_loading_intf) return; // already finished
    if (rtl.debug_load_units) rtl.debug('loadintf: "'+module.$name+'"');
    if (module.$state===rtl.m_loading_intf)
      rtl.error('unit cycle detected "'+module.$name+'"');
    module.$state=rtl.m_loading_intf;
    // load interfaces of interface useslist
    rtl.loaduseslist(module,module.$intfuseslist,rtl.loadintf);
    // run interface
    if (rtl.debug_load_units) rtl.debug('loadintf: run intf of "'+module.$name+'"');
    module.$intfcode(module.$intfuseslist);
    // success
    module.$state=rtl.m_intf_loaded;
    // Note: units only used in implementations are not yet loaded (not even their interfaces)
  },

  loaduseslist: function(module,useslist,f){
    if (useslist==undefined) return;
    for (var i in useslist){
      var unitname=useslist[i];
      if (rtl.debug_load_units) rtl.debug('loaduseslist of "'+module.$name+'" uses="'+unitname+'"');
      if (pas[unitname]==undefined)
        rtl.error('module "'+module.$name+'" misses "'+unitname+'"');
      f(pas[unitname]);
    }
  },

  loadimpl: function(module){
    if (module.$state>=rtl.m_loading_impl) return; // already processing
    if (module.$state<rtl.m_intf_loaded) rtl.error('loadimpl: interface not loaded of "'+module.$name+'"');
    if (rtl.debug_load_units) rtl.debug('loadimpl: load uses of "'+module.$name+'"');
    module.$state=rtl.m_loading_impl;
    // load interfaces of implementation useslist
    rtl.loaduseslist(module,module.$impluseslist,rtl.loadintf);
    // load implementation of interfaces useslist
    rtl.loaduseslist(module,module.$intfuseslist,rtl.loadimpl);
    // load implementation of implementation useslist
    rtl.loaduseslist(module,module.$impluseslist,rtl.loadimpl);
    // Note: At this point all interfaces used by this unit are loaded. If
    //   there are implementation uses cycles some used units might not yet be
    //   initialized. This is by design.
    // run implementation
    if (rtl.debug_load_units) rtl.debug('loadimpl: run impl of "'+module.$name+'"');
    if (rtl.isFunction(module.$implcode)) module.$implcode(module.$impluseslist);
    // run initialization
    if (rtl.debug_load_units) rtl.debug('loadimpl: run init of "'+module.$name+'"');
    module.$state=rtl.m_initializing;
    if (rtl.isFunction(module.$init)) module.$init();
    // unit initialized
    module.$state=rtl.m_initialized;
  },

  createCallback: function(scope, fn){
    var cb;
    if (typeof(fn)==='string'){
      cb = function(){
        return scope[fn].apply(scope,arguments);
      };
    } else {
      cb = function(){
        return fn.apply(scope,arguments);
      };
    };
    cb.scope = scope;
    cb.fn = fn;
    return cb;
  },

  cloneCallback: function(cb){
    return rtl.createCallback(cb.scope,cb.fn);
  },

  eqCallback: function(a,b){
    // can be a function or a function wrapper
    if (a==b){
      return true;
    } else {
      return (a!=null) && (b!=null) && (a.fn) && (a.scope===b.scope) && (a.fn==b.fn);
    }
  },

  initClass: function(c,parent,name,initfn){
    parent[name] = c;
    c.$classname = name;
    if ((parent.$module) && (parent.$module.$impl===parent)) parent=parent.$module;
    c.$parent = parent;
    c.$fullname = parent.$name+'.'+name;
    if (rtl.isModule(parent)){
      c.$module = parent;
      c.$name = name;
    } else {
      c.$module = parent.$module;
      c.$name = parent.name+'.'+name;
    };
    // rtti
    if (rtl.debug_rtti) rtl.debug('initClass '+c.$fullname);
    var t = c.$module.$rtti.$Class(c.$name,{ "class": c, module: parent });
    c.$rtti = t;
    if (rtl.isObject(c.$ancestor)) t.ancestor = c.$ancestor.$rtti;
    if (!t.ancestor) t.ancestor = null;
    // init members
    initfn.call(c);
  },

  createClass: function(parent,name,ancestor,initfn){
    // create a normal class,
    // ancestor must be null or a normal class,
    // the root ancestor can be an external class
    var c = null;
    if (ancestor != null){
      c = Object.create(ancestor);
      c.$ancestor = ancestor;
      // Note:
      // if root is an "object" then c.$ancestor === Object.getPrototypeOf(c)
      // if root is a "function" then c.$ancestor === c.__proto__, Object.getPrototypeOf(c) returns the root
    } else {
      c = {};
      c.$create = function(fnname,args){
        if (args == undefined) args = [];
        var o = Object.create(this);
        o.$class = this; // Note: o.$class === Object.getPrototypeOf(o)
        o.$init();
        try{
          o[fnname].apply(o,args);
          o.AfterConstruction();
        } catch($e){
          o.$destroy;
          throw $e;
        }
        return o;
      };
      c.$destroy = function(fnname){
        this.BeforeDestruction();
        this[fnname]();
        this.$final;
      };
    };
    rtl.initClass(c,parent,name,initfn);
  },

  createClassExt: function(parent,name,ancestor,newinstancefnname,initfn){
    // Create a class using an external ancestor.
    // If newinstancefnname is given, use that function to create the new object.
    // If exist call BeforeDestruction and AfterConstruction.
    var c = null;
    c = Object.create(ancestor);
    c.$create = function(fnname,args){
      if (args == undefined) args = [];
      var o = null;
      if (newinstancefnname.length>0){
        o = this[newinstancefnname](fnname,args);
      } else {
        o = Object.create(this);
      }
      o.$class = this; // Note: o.$class === Object.getPrototypeOf(o)
      o.$init();
      try{
        o[fnname].apply(o,args);
        if (o.AfterConstruction) o.AfterConstruction();
      } catch($e){
        o.$destroy;
        throw $e;
      }
      return o;
    };
    c.$destroy = function(fnname){
      if (this.BeforeDestruction) this.BeforeDestruction();
      this[fnname]();
      this.$final;
    };
    rtl.initClass(c,parent,name,initfn);
  },

  tObjectDestroy: "Destroy",

  free: function(obj,name){
    if (obj[name]==null) return;
    obj[name].$destroy(rtl.tObjectDestroy);
    obj[name]=null;
  },

  freeLoc: function(obj){
    if (obj==null) return;
    obj.$destroy(rtl.tObjectDestroy);
    return null;
  },

  is: function(instance,type){
    return type.isPrototypeOf(instance) || (instance===type);
  },

  isExt: function(instance,type,mode){
    // mode===1 means instance must be a Pascal class instance
    // mode===2 means instance must be a Pascal class
    // Notes:
    // isPrototypeOf and instanceof return false on equal
    // isPrototypeOf does not work for Date.isPrototypeOf(new Date())
    //   so if isPrototypeOf is false test with instanceof
    // instanceof needs a function on right side
    if (instance == null) return false; // Note: ==null checks for undefined too
    if ((typeof(type) !== 'object') && (typeof(type) !== 'function')) return false;
    if (instance === type){
      if (mode===1) return false;
      if (mode===2) return rtl.isPasClass(instance);
      return true;
    }
    if (type.isPrototypeOf && type.isPrototypeOf(instance)){
      if (mode===1) return rtl.isPasClassInstance(instance);
      if (mode===2) return rtl.isPasClass(instance);
      return true;
    }
    if ((typeof type == 'function') && (instance instanceof type)) return true;
    return false;
  },

  Exception: null,
  EInvalidCast: null,
  EAbstractError: null,
  ERangeError: null,

  raiseE: function(typename){
    var t = rtl[typename];
    if (t==null){
      var mod = pas.SysUtils;
      if (!mod) mod = pas.sysutils;
      if (mod){
        t = mod[typename];
        if (!t) t = mod[typename.toLowerCase()];
        if (!t) t = mod['Exception'];
        if (!t) t = mod['exception'];
      }
    }
    if (t){
      if (t.Create){
        throw t.$create("Create");
      } else if (t.create){
        throw t.$create("create");
      }
    }
    if (typename === "EInvalidCast") throw "invalid type cast";
    if (typename === "EAbstractError") throw "Abstract method called";
    if (typename === "ERangeError") throw "range error";
    throw typename;
  },

  as: function(instance,type){
    if((instance === null) || rtl.is(instance,type)) return instance;
    rtl.raiseE("EInvalidCast");
  },

  asExt: function(instance,type,mode){
    if((instance === null) || rtl.isExt(instance,type,mode)) return instance;
    rtl.raiseE("EInvalidCast");
  },

  createInterface: function(module, name, guid, fnnames, ancestor, initfn){
    //console.log('createInterface name="'+name+'" guid="'+guid+'" names='+fnnames);
    var i = ancestor?Object.create(ancestor):{};
    module[name] = i;
    i.$module = module;
    i.$name = name;
    i.$fullname = module.$name+'.'+name;
    i.$guid = guid;
    i.$guidr = null;
    i.$names = fnnames?fnnames:[];
    if (rtl.isFunction(initfn)){
      // rtti
      if (rtl.debug_rtti) rtl.debug('createInterface '+i.$fullname);
      var t = i.$module.$rtti.$Interface(name,{ "interface": i, module: module });
      i.$rtti = t;
      if (ancestor) t.ancestor = ancestor.$rtti;
      if (!t.ancestor) t.ancestor = null;
      initfn.call(i);
    }
    return i;
  },

  strToGUIDR: function(s,g){
    var p = 0;
    function n(l){
      var h = s.substr(p,l);
      p+=l;
      return parseInt(h,16);
    }
    p+=1; // skip {
    g.D1 = n(8);
    p+=1; // skip -
    g.D2 = n(4);
    p+=1; // skip -
    g.D3 = n(4);
    p+=1; // skip -
    if (!g.D4) g.D4=[];
    g.D4[0] = n(2);
    g.D4[1] = n(2);
    p+=1; // skip -
    for(var i=2; i<8; i++) g.D4[i] = n(2);
    return g;
  },

  guidrToStr: function(g){
    if (g.$intf) return g.$intf.$guid;
    var h = rtl.hexStr;
    var s='{'+h(g.D1,8)+'-'+h(g.D2,4)+'-'+h(g.D3,4)+'-'+h(g.D4[0],2)+h(g.D4[1],2)+'-';
    for (var i=2; i<8; i++) s+=h(g.D4[i],2);
    s+='}';
    return s;
  },

  createTGUID: function(guid){
    var TGuid = (pas.System)?pas.System.TGuid:pas.system.tguid;
    var g = rtl.strToGUIDR(guid,new TGuid());
    return g;
  },

  getIntfGUIDR: function(intfTypeOrVar){
    if (!intfTypeOrVar) return null;
    if (!intfTypeOrVar.$guidr){
      var g = rtl.createTGUID(intfTypeOrVar.$guid);
      if (!intfTypeOrVar.hasOwnProperty('$guid')) intfTypeOrVar = Object.getPrototypeOf(intfTypeOrVar);
      g.$intf = intfTypeOrVar;
      intfTypeOrVar.$guidr = g;
    }
    return intfTypeOrVar.$guidr;
  },

  addIntf: function (aclass, intf, map){
    function jmp(fn){
      if (typeof(fn)==="function"){
        return function(){ return fn.apply(this.$o,arguments); };
      } else {
        return function(){ rtl.raiseE('EAbstractError'); };
      }
    }
    if(!map) map = {};
    var t = intf;
    var item = Object.create(t);
    aclass.$intfmaps[intf.$guid] = item;
    do{
      var names = t.$names;
      if (!names) break;
      for (var i=0; i<names.length; i++){
        var intfname = names[i];
        var fnname = map[intfname];
        if (!fnname) fnname = intfname;
        //console.log('addIntf: intftype='+t.$name+' index='+i+' intfname="'+intfname+'" fnname="'+fnname+'" proc='+typeof(fn));
        item[intfname] = jmp(aclass[fnname]);
      }
      t = Object.getPrototypeOf(t);
    }while(t!=null);
  },

  getIntfG: function (obj, guid, query){
    if (!obj) return null;
    //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' query='+query);
    // search
    var maps = obj.$intfmaps;
    if (!maps) return null;
    var item = maps[guid];
    if (!item) return null;
    // check delegation
    //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' query='+query+' item='+typeof(item));
    if (typeof item === 'function') return item.call(obj); // COM: contains _AddRef
    // check cache
    var intf = null;
    if (obj.$interfaces){
      intf = obj.$interfaces[guid];
      //console.log('getIntfG: obj='+obj.$classname+' guid='+guid+' cache='+typeof(intf));
    }
    if (!intf){ // intf can be undefined!
      intf = Object.create(item);
      intf.$o = obj;
      if (!obj.$interfaces) obj.$interfaces = {};
      obj.$interfaces[guid] = intf;
    }
    if (typeof(query)==='object'){
      // called by queryIntfT
      var o = null;
      if (intf.QueryInterface(rtl.getIntfGUIDR(query),
          {get:function(){ return o; }, set:function(v){ o=v; }}) === 0){
        return o;
      } else {
        return null;
      }
    } else if(query===2){
      // called by TObject.GetInterfaceByStr
      if (intf.$kind === 'com') intf._AddRef();
    }
    return intf;
  },

  getIntfT: function(obj,intftype){
    return rtl.getIntfG(obj,intftype.$guid);
  },

  queryIntfT: function(obj,intftype){
    return rtl.getIntfG(obj,intftype.$guid,intftype);
  },

  queryIntfIsT: function(obj,intftype){
    var i = rtl.queryIntfG(obj,intftype.$guid);
    if (!i) return false;
    if (i.$kind === 'com') i._Release();
    return true;
  },

  asIntfT: function (obj,intftype){
    var i = rtl.getIntfG(obj,intftype.$guid);
    if (i!==null) return i;
    rtl.raiseEInvalidCast();
  },

  intfIsClass: function(intf,classtype){
    return (intf!=null) && (rtl.is(intf.$o,classtype));
  },

  intfAsClass: function(intf,classtype){
    if (intf==null) return null;
    return rtl.as(intf.$o,classtype);
  },

  intfToClass: function(intf,classtype){
    if ((intf!==null) && rtl.is(intf.$o,classtype)) return intf.$o;
    return null;
  },

  // interface reference counting
  intfRefs: { // base object for temporary interface variables
    ref: function(id,intf){
      // called for temporary interface references needing delayed release
      var old = this[id];
      //console.log('rtl.intfRefs.ref: id='+id+' old="'+(old?old.$name:'null')+'" intf="'+(intf?intf.$name:'null'));
      if (old){
        // called again, e.g. in a loop
        delete this[id];
        old._Release(); // may fail
      }
      this[id]=intf;
      return intf;
    },
    free: function(){
      //console.log('rtl.intfRefs.free...');
      for (var id in this){
        if (this.hasOwnProperty(id)) this[id]._Release;
      }
    }
  },

  createIntfRefs: function(){
    //console.log('rtl.createIntfRefs');
    return Object.create(rtl.intfRefs);
  },

  setIntfP: function(path,name,value,skipAddRef){
    var old = path[name];
    //console.log('rtl.setIntfP path='+path+' name='+name+' old="'+(old?old.$name:'null')+'" value="'+(value?value.$name:'null')+'"');
    if (old === value) return;
    if (old !== null){
      path[name]=null;
      old._Release();
    }
    if (value !== null){
      if (!skipAddRef) value._AddRef();
      path[name]=value;
    }
  },

  setIntfL: function(old,value,skipAddRef){
    //console.log('rtl.setIntfL old="'+(old?old.$name:'null')+'" value="'+(value?value.$name:'null')+'"');
    if (old !== value){
      if (value!==null){
        if (!skipAddRef) value._AddRef();
      }
      if (old!==null){
        old._Release();  // Release after AddRef, to avoid double Release if Release creates an exception
      }
    } else if (skipAddRef){
      if (old!==null){
        old._Release();  // value has an AddRef
      }
    }
    return value;
  },

  _AddRef: function(intf){
    //if (intf) console.log('rtl._AddRef intf="'+(intf?intf.$name:'null')+'"');
    if (intf) intf._AddRef();
    return intf;
  },

  _Release: function(intf){
    //if (intf) console.log('rtl._Release intf="'+(intf?intf.$name:'null')+'"');
    if (intf) intf._Release();
    return intf;
  },

  checkMethodCall: function(obj,type){
    if (rtl.isObject(obj) && rtl.is(obj,type)) return;
    rtl.raiseE("EInvalidCast");
  },

  rc: function(i,minval,maxval){
    // range check integer
    if ((Math.floor(i)===i) && (i>=minval) && (i<=maxval)) return i;
    rtl.raiseE('ERangeError');
  },

  rcc: function(c,minval,maxval){
    // range check char
    if ((typeof(c)==='string') && (c.length===1)){
      var i = c.charCodeAt(0);
      if ((i>=minval) && (i<=maxval)) return c;
    }
    rtl.raiseE('ERangeError');
  },

  rcSetCharAt: function(s,index,c){
    // range check setCharAt
    if ((typeof(s)!=='string') || (index<0) || (index>=s.length)) rtl.raiseE('ERangeError');
    return rtl.setCharAt(s,index,c);
  },

  rcCharAt: function(s,index){
    // range check charAt
    if ((typeof(s)!=='string') || (index<0) || (index>=s.length)) rtl.raiseE('ERangeError');
    return s.charAt(index);
  },

  rcArrR: function(arr,index){
    // range check read array
    if (Array.isArray(arr) && (typeof(index)==='number') && (index>=0) && (index<arr.length)){
      if (arguments.length>2){
        // arr,index1,index2,...
        arr=arr[index];
        for (var i=2; i<arguments.length; i++) arr=rtl.rcArrR(arr,arguments[i]);
        return arr;
      }
      return arr[index];
    }
    rtl.raiseE('ERangeError');
  },

  rcArrW: function(arr,index,value){
    // range check write array
    // arr,index1,index2,...,value
    for (var i=3; i<arguments.length; i++){
      arr=rtl.rcArrR(arr,index);
      index=arguments[i-1];
      value=arguments[i];
    }
    if (Array.isArray(arr) && (typeof(index)==='number') && (index>=0) && (index<arr.length)){
      return arr[index]=value;
    }
    rtl.raiseE('ERangeError');
  },

  length: function(arr){
    return (arr == null) ? 0 : arr.length;
  },

  arraySetLength: function(arr,defaultvalue,newlength){
    // multi dim: (arr,defaultvalue,dim1,dim2,...)
    if (arr == null) arr = [];
    var p = arguments;
    function setLength(a,argNo){
      var oldlen = a.length;
      var newlen = p[argNo];
      if (oldlen!==newlength){
        a.length = newlength;
        if (argNo === p.length-1){
          if (rtl.isArray(defaultvalue)){
            for (var i=oldlen; i<newlen; i++) a[i]=[]; // nested array
          } else if (rtl.isFunction(defaultvalue)){
            for (var i=oldlen; i<newlen; i++) a[i]=new defaultvalue(); // e.g. record
          } else if (rtl.isObject(defaultvalue)) {
            for (var i=oldlen; i<newlen; i++) a[i]={}; // e.g. set
          } else {
            for (var i=oldlen; i<newlen; i++) a[i]=defaultvalue;
          }
        } else {
          for (var i=oldlen; i<newlen; i++) a[i]=[]; // nested array
        }
      }
      if (argNo < p.length-1){
        // multi argNo
        for (var i=0; i<newlen; i++) a[i]=setLength(a[i],argNo+1);
      }
      return a;
    }
    return setLength(arr,2);
  },

  arrayEq: function(a,b){
    if (a===null) return b===null;
    if (b===null) return false;
    if (a.length!==b.length) return false;
    for (var i=0; i<a.length; i++) if (a[i]!==b[i]) return false;
    return true;
  },

  arrayClone: function(type,src,srcpos,end,dst,dstpos){
    // type: 0 for references, "refset" for calling refSet(), a function for new type()
    // src must not be null
    // This function does not range check.
    if (rtl.isFunction(type)){
      for (; srcpos<end; srcpos++) dst[dstpos++] = new type(src[srcpos]); // clone record
    } else if((typeof(type)==="string") && (type === 'refSet')) {
      for (; srcpos<end; srcpos++) dst[dstpos++] = rtl.refSet(src[srcpos]); // ref set
    }  else {
      for (; srcpos<end; srcpos++) dst[dstpos++] = src[srcpos]; // reference
    };
  },

  arrayConcat: function(type){
    // type: see rtl.arrayClone
    var a = [];
    var l = 0;
    for (var i=1; i<arguments.length; i++) l+=arguments[i].length;
    a.length = l;
    l=0;
    for (var i=1; i<arguments.length; i++){
      var src = arguments[i];
      if (src == null) continue;
      rtl.arrayClone(type,src,0,src.length,a,l);
      l+=src.length;
    };
    return a;
  },

  arrayCopy: function(type, srcarray, index, count){
    // type: see rtl.arrayClone
    // if count is missing, use srcarray.length
    if (srcarray == null) return [];
    if (index < 0) index = 0;
    if (count === undefined) count=srcarray.length;
    var end = index+count;
    if (end>srcarray.length) end = srcarray.length;
    if (index>=end) return [];
    if (type===0){
      return srcarray.slice(index,end);
    } else {
      var a = [];
      a.length = end-index;
      rtl.arrayClone(type,srcarray,index,end,a,0);
      return a;
    }
  },

  setCharAt: function(s,index,c){
    return s.substr(0,index)+c+s.substr(index+1);
  },

  getResStr: function(mod,name){
    var rs = mod.$resourcestrings[name];
    return rs.current?rs.current:rs.org;
  },

  createSet: function(){
    var s = {};
    for (var i=0; i<arguments.length; i++){
      if (arguments[i]!=null){
        s[arguments[i]]=true;
      } else {
        var first=arguments[i+=1];
        var last=arguments[i+=1];
        for(var j=first; j<=last; j++) s[j]=true;
      }
    }
    return s;
  },

  cloneSet: function(s){
    var r = {};
    for (var key in s) r[key]=true;
    return r;
  },

  refSet: function(s){
    s.$shared = true;
    return s;
  },

  includeSet: function(s,enumvalue){
    if (s.$shared) s = rtl.cloneSet(s);
    s[enumvalue] = true;
    return s;
  },

  excludeSet: function(s,enumvalue){
    if (s.$shared) s = rtl.cloneSet(s);
    delete s[enumvalue];
    return s;
  },

  diffSet: function(s,t){
    var r = {};
    for (var key in s) if (!t[key]) r[key]=true;
    delete r.$shared;
    return r;
  },

  unionSet: function(s,t){
    var r = {};
    for (var key in s) r[key]=true;
    for (var key in t) r[key]=true;
    delete r.$shared;
    return r;
  },

  intersectSet: function(s,t){
    var r = {};
    for (var key in s) if (t[key]) r[key]=true;
    delete r.$shared;
    return r;
  },

  symDiffSet: function(s,t){
    var r = {};
    for (var key in s) if (!t[key]) r[key]=true;
    for (var key in t) if (!s[key]) r[key]=true;
    delete r.$shared;
    return r;
  },

  eqSet: function(s,t){
    for (var key in s) if (!t[key] && (key!='$shared')) return false;
    for (var key in t) if (!s[key] && (key!='$shared')) return false;
    return true;
  },

  neSet: function(s,t){
    return !rtl.eqSet(s,t);
  },

  leSet: function(s,t){
    for (var key in s) if (!t[key] && (key!='$shared')) return false;
    return true;
  },

  geSet: function(s,t){
    for (var key in t) if (!s[key] && (key!='$shared')) return false;
    return true;
  },

  strSetLength: function(s,newlen){
    var oldlen = s.length;
    if (oldlen > newlen){
      return s.substring(0,newlen);
    } else if (s.repeat){
      // Note: repeat needs ECMAScript6!
      return s+' '.repeat(newlen-oldlen);
    } else {
       while (oldlen<newlen){
         s+=' ';
         oldlen++;
       };
       return s;
    }
  },

  spaceLeft: function(s,width){
    var l=s.length;
    if (l>=width) return s;
    if (s.repeat){
      // Note: repeat needs ECMAScript6!
      return ' '.repeat(width-l) + s;
    } else {
      while (l<width){
        s=' '+s;
        l++;
      };
    };
  },

  floatToStr : function(d,w,p){
    // input 1-3 arguments: double, width, precision
    if (arguments.length>2){
      return rtl.spaceLeft(d.toFixed(p),w);
    } else {
	  // exponent width
	  var pad = "";
	  var ad = Math.abs(d);
	  if (ad<1.0e+10) {
		pad='00';
	  } else if (ad<1.0e+100) {
		pad='0';
      }  	
	  if (arguments.length<2) {
	    w=9;		
      } else if (w<9) {
		w=9;
      }		  
      var p = w-8;
      var s=(d>0 ? " " : "" ) + d.toExponential(p);
      s=s.replace(/e(.)/,'E$1'+pad);
      return rtl.spaceLeft(s,w);
    }
  },

  initRTTI: function(){
    if (rtl.debug_rtti) rtl.debug('initRTTI');

    // base types
    rtl.tTypeInfo = { name: "tTypeInfo" };
    function newBaseTI(name,kind,ancestor){
      if (!ancestor) ancestor = rtl.tTypeInfo;
      if (rtl.debug_rtti) rtl.debug('initRTTI.newBaseTI "'+name+'" '+kind+' ("'+ancestor.name+'")');
      var t = Object.create(ancestor);
      t.name = name;
      t.kind = kind;
      rtl[name] = t;
      return t;
    };
    function newBaseInt(name,minvalue,maxvalue,ordtype){
      var t = newBaseTI(name,1 /* tkInteger */,rtl.tTypeInfoInteger);
      t.minvalue = minvalue;
      t.maxvalue = maxvalue;
      t.ordtype = ordtype;
      return t;
    };
    newBaseTI("tTypeInfoInteger",1 /* tkInteger */);
    newBaseInt("shortint",-0x80,0x7f,0);
    newBaseInt("byte",0,0xff,1);
    newBaseInt("smallint",-0x8000,0x7fff,2);
    newBaseInt("word",0,0xffff,3);
    newBaseInt("longint",-0x80000000,0x7fffffff,4);
    newBaseInt("longword",0,0xffffffff,5);
    newBaseInt("nativeint",-0x10000000000000,0xfffffffffffff,6);
    newBaseInt("nativeuint",0,0xfffffffffffff,7);
    newBaseTI("char",2 /* tkChar */);
    newBaseTI("string",3 /* tkString */);
    newBaseTI("tTypeInfoEnum",4 /* tkEnumeration */,rtl.tTypeInfoInteger);
    newBaseTI("tTypeInfoSet",5 /* tkSet */);
    newBaseTI("double",6 /* tkDouble */);
    newBaseTI("boolean",7 /* tkBool */);
    newBaseTI("tTypeInfoProcVar",8 /* tkProcVar */);
    newBaseTI("tTypeInfoMethodVar",9 /* tkMethod */,rtl.tTypeInfoProcVar);
    newBaseTI("tTypeInfoArray",10 /* tkArray */);
    newBaseTI("tTypeInfoDynArray",11 /* tkDynArray */);
    newBaseTI("tTypeInfoPointer",15 /* tkPointer */);
    var t = newBaseTI("pointer",15 /* tkPointer */,rtl.tTypeInfoPointer);
    t.reftype = null;
    newBaseTI("jsvalue",16 /* tkJSValue */);
    newBaseTI("tTypeInfoRefToProcVar",17 /* tkRefToProcVar */,rtl.tTypeInfoProcVar);

    // member kinds
    rtl.tTypeMember = {};
    function newMember(name,kind){
      var m = Object.create(rtl.tTypeMember);
      m.name = name;
      m.kind = kind;
      rtl[name] = m;
    };
    newMember("tTypeMemberField",1); // tmkField
    newMember("tTypeMemberMethod",2); // tmkMethod
    newMember("tTypeMemberProperty",3); // tmkProperty

    // base object for storing members: a simple object
    rtl.tTypeMembers = {};

    // tTypeInfoStruct - base object for tTypeInfoClass, tTypeInfoRecord, tTypeInfoInterface
    var tis = newBaseTI("tTypeInfoStruct",0);
    tis.$addMember = function(name,ancestor,options){
      if (rtl.debug_rtti){
        if (!rtl.hasString(name) || (name.charAt()==='$')) throw 'invalid member "'+name+'", this="'+this.name+'"';
        if (!rtl.is(ancestor,rtl.tTypeMember)) throw 'invalid ancestor "'+ancestor+':'+ancestor.name+'", "'+this.name+'.'+name+'"';
        if ((options!=undefined) && (typeof(options)!='object')) throw 'invalid options "'+options+'", "'+this.name+'.'+name+'"';
      };
      var t = Object.create(ancestor);
      t.name = name;
      this.members[name] = t;
      this.names.push(name);
      if (rtl.isObject(options)){
        for (var key in options) if (options.hasOwnProperty(key)) t[key] = options[key];
      };
      return t;
    };
    tis.addField = function(name,type,options){
      var t = this.$addMember(name,rtl.tTypeMemberField,options);
      if (rtl.debug_rtti){
        if (!rtl.is(type,rtl.tTypeInfo)) throw 'invalid type "'+type+'", "'+this.name+'.'+name+'"';
      };
      t.typeinfo = type;
      this.fields.push(name);
      return t;
    };
    tis.addFields = function(){
      var i=0;
      while(i<arguments.length){
        var name = arguments[i++];
        var type = arguments[i++];
        if ((i<arguments.length) && (typeof(arguments[i])==='object')){
          this.addField(name,type,arguments[i++]);
        } else {
          this.addField(name,type);
        };
      };
    };
    tis.addMethod = function(name,methodkind,params,result,options){
      var t = this.$addMember(name,rtl.tTypeMemberMethod,options);
      t.methodkind = methodkind;
      t.procsig = rtl.newTIProcSig(params);
      t.procsig.resulttype = result?result:null;
      this.methods.push(name);
      return t;
    };
    tis.addProperty = function(name,flags,result,getter,setter,options){
      var t = this.$addMember(name,rtl.tTypeMemberProperty,options);
      t.flags = flags;
      t.typeinfo = result;
      t.getter = getter;
      t.setter = setter;
      // Note: in options: params, stored, defaultvalue
      if (rtl.isArray(t.params)) t.params = rtl.newTIParams(t.params);
      this.properties.push(name);
      if (!rtl.isString(t.stored)) t.stored = "";
      return t;
    };
    tis.getField = function(index){
      return this.members[this.fields[index]];
    };
    tis.getMethod = function(index){
      return this.members[this.methods[index]];
    };
    tis.getProperty = function(index){
      return this.members[this.properties[index]];
    };

    newBaseTI("tTypeInfoRecord",12 /* tkRecord */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoClass",13 /* tkClass */,rtl.tTypeInfoStruct);
    newBaseTI("tTypeInfoClassRef",14 /* tkClassRef */);
    newBaseTI("tTypeInfoInterface",15 /* tkInterface */,rtl.tTypeInfoStruct);
  },

  tSectionRTTI: {
    $module: null,
    $inherited: function(name,ancestor,o){
      if (rtl.debug_rtti){
        rtl.debug('tSectionRTTI.newTI "'+(this.$module?this.$module.$name:"(no module)")
          +'"."'+name+'" ('+ancestor.name+') '+(o?'init':'forward'));
      };
      var t = this[name];
      if (t){
        if (!t.$forward) throw 'duplicate type "'+name+'"';
        if (!ancestor.isPrototypeOf(t)) throw 'typeinfo ancestor mismatch "'+name+'" ancestor="'+ancestor.name+'" t.name="'+t.name+'"';
      } else {
        t = Object.create(ancestor);
        t.name = name;
        t.$module = this.$module;
        this[name] = t;
      }
      if (o){
        delete t.$forward;
        for (var key in o) if (o.hasOwnProperty(key)) t[key]=o[key];
      } else {
        t.$forward = true;
      }
      return t;
    },
    $Scope: function(name,ancestor,o){
      var t=this.$inherited(name,ancestor,o);
      t.members = {};
      t.names = [];
      t.fields = [];
      t.methods = [];
      t.properties = [];
      return t;
    },
    $TI: function(name,kind,o){ var t=this.$inherited(name,rtl.tTypeInfo,o); t.kind = kind; return t; },
    $Int: function(name,o){ return this.$inherited(name,rtl.tTypeInfoInteger,o); },
    $Enum: function(name,o){ return this.$inherited(name,rtl.tTypeInfoEnum,o); },
    $Set: function(name,o){ return this.$inherited(name,rtl.tTypeInfoSet,o); },
    $StaticArray: function(name,o){ return this.$inherited(name,rtl.tTypeInfoArray,o); },
    $DynArray: function(name,o){ return this.$inherited(name,rtl.tTypeInfoDynArray,o); },
    $ProcVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoProcVar,o); },
    $RefToProcVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoRefToProcVar,o); },
    $MethodVar: function(name,o){ return this.$inherited(name,rtl.tTypeInfoMethodVar,o); },
    $Record: function(name,o){ return this.$Scope(name,rtl.tTypeInfoRecord,o); },
    $Class: function(name,o){ return this.$Scope(name,rtl.tTypeInfoClass,o); },
    $ClassRef: function(name,o){ return this.$inherited(name,rtl.tTypeInfoClassRef,o); },
    $Pointer: function(name,o){ return this.$inherited(name,rtl.tTypeInfoPointer,o); },
    $Interface: function(name,o){ return this.$Scope(name,rtl.tTypeInfoInterface,o); }
  },

  newTIParam: function(param){
    // param is an array, 0=name, 1=type, 2=optional flags
    var t = {
      name: param[0],
      typeinfo: param[1],
      flags: (rtl.isNumber(param[2]) ? param[2] : 0)
    };
    return t;
  },

  newTIParams: function(list){
    // list: optional array of [paramname,typeinfo,optional flags]
    var params = [];
    if (rtl.isArray(list)){
      for (var i=0; i<list.length; i++) params.push(rtl.newTIParam(list[i]));
    };
    return params;
  },

  newTIProcSig: function(params,result,flags){
    var s = {
      params: rtl.newTIParams(params),
      resulttype: result,
      flags: flags
    };
    return s;
  }
}
rtl.module("System",[],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"TObject",null,function () {
    this.$init = function () {
    };
    this.$final = function () {
    };
    this.Create = function () {
    };
    this.AfterConstruction = function () {
    };
    this.BeforeDestruction = function () {
    };
  });
  this.Trunc = function (A) {
    if (!Math.trunc) {
      Math.trunc = function(v) {
        v = +v;
        if (!isFinite(v)) return v;
        return (v - v % 1) || (v < 0 ? -0 : v === 0 ? v : 0);
      };
    }
    $mod.Trunc = Math.trunc;
    return Math.trunc(A);
  };
  this.Int = function (A) {
    var Result = 0.0;
    Result = Math.trunc(A);
    return Result;
  };
  this.Copy = function (S, Index, Size) {
    if (Index<1) Index = 1;
    return (Size>0) ? S.substring(Index-1,Index+Size-1) : "";
  };
  this.Copy$1 = function (S, Index) {
    if (Index<1) Index = 1;
    return S.substr(Index-1);
  };
  this.Delete = function (S, Index, Size) {
    var h = "";
    if (((Index < 1) || (Index > S.get().length)) || (Size <= 0)) return;
    h = S.get();
    S.set($mod.Copy(h,1,Index - 1) + $mod.Copy$1(h,Index + Size));
  };
  this.Pos = function (Search, InString) {
    return InString.indexOf(Search)+1;
  };
  this.Insert = function (Insertion, Target, Index) {
    var t = "";
    if (Insertion === "") return;
    t = Target.get();
    if (Index < 1) {
      Target.set(Insertion + t)}
     else if (Index > t.length) {
      Target.set(t + Insertion)}
     else Target.set(($mod.Copy(t,1,Index - 1) + Insertion) + $mod.Copy(t,Index,t.length));
  };
  this.upcase = function (c) {
    return c.toUpperCase();
  };
  this.val = function (S, NI, Code) {
    var x = 0.0;
    Code.set(0);
    x = Number(S);
    if (isNaN(x) || (x !== $mod.Int(x))) {
      Code.set(1)}
     else NI.set($mod.Trunc(x));
  };
  this.StringOfChar = function (c, l) {
    var Result = "";
    var i = 0;
    Result = "";
    for (var $l1 = 1, $end2 = l; $l1 <= $end2; $l1++) {
      i = $l1;
      Result = Result + c;
    };
    return Result;
  };
  $mod.$init = function () {
    rtl.exitcode = 0;
  };
});
rtl.module("RTLConsts",["System"],function () {
  "use strict";
  var $mod = this;
  this.SArgumentMissing = 'Missing argument in format "%s"';
  this.SInvalidFormat = 'Invalid format specifier : "%s"';
  this.SInvalidArgIndex = 'Invalid argument index in format: "%s"';
  this.SErrInvalidInteger = 'Invalid integer value: "%s"';
});
rtl.module("Types",["System"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("JS",["System","Types"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"EJS",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.FMessage = "";
    };
    this.Create$1 = function (Msg) {
      this.FMessage = Msg;
    };
  });
  this.New = function (aElements) {
    var Result = null;
    var L = 0;
    var I = 0;
    var S = "";
    L = rtl.length(aElements);
    if ((L % 2) === 1) throw $mod.EJS.$create("Create$1",["Number of arguments must be even"]);
    I = 0;
    while (I < L) {
      if (!rtl.isString(aElements[I])) {
        S = String(I);
        throw $mod.EJS.$create("Create$1",[("Argument " + S) + " must be a string."]);
      };
      I += 2;
    };
    I = 0;
    Result = new Object();
    while (I < L) {
      S = "" + aElements[I];
      Result[S] = aElements[I + 1];
      I += 2;
    };
    return Result;
  };
  this.isInteger = function (v) {
    return Math.floor(v)===v;
  };
  this.isNull = function (v) {
    return v === null;
  };
  this.TJSValueType = {"0": "jvtNull", jvtNull: 0, "1": "jvtBoolean", jvtBoolean: 1, "2": "jvtInteger", jvtInteger: 2, "3": "jvtFloat", jvtFloat: 3, "4": "jvtString", jvtString: 4, "5": "jvtObject", jvtObject: 5, "6": "jvtArray", jvtArray: 6};
  this.GetValueType = function (JS) {
    var Result = 0;
    var t = "";
    if ($mod.isNull(JS)) {
      Result = $mod.TJSValueType.jvtNull}
     else {
      t = typeof(JS);
      if (t === "string") {
        Result = $mod.TJSValueType.jvtString}
       else if (t === "boolean") {
        Result = $mod.TJSValueType.jvtBoolean}
       else if (t === "object") {
        if (rtl.isArray(JS)) {
          Result = $mod.TJSValueType.jvtArray}
         else Result = $mod.TJSValueType.jvtObject;
      } else if (t === "number") if ($mod.isInteger(JS)) {
        Result = $mod.TJSValueType.jvtInteger}
       else Result = $mod.TJSValueType.jvtFloat;
    };
    return Result;
  };
});
rtl.module("SysUtils",["System","RTLConsts","JS"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  rtl.createClass($mod,"Exception",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.fMessage = "";
    };
    this.CreateFmt = function (Msg, Args) {
      this.fMessage = $mod.Format(Msg,Args);
    };
  });
  rtl.createClass($mod,"EConvertError",$mod.Exception,function () {
  });
  this.TrimLeft = function (S) {
    return S.replace(/^[\s\uFEFF\xA0\x00-\x1f]+/,'');
  };
  this.Format = function (Fmt, Args) {
    var Result = "";
    var ChPos = 0;
    var OldPos = 0;
    var ArgPos = 0;
    var DoArg = 0;
    var Len = 0;
    var Hs = "";
    var ToAdd = "";
    var Index = 0;
    var Width = 0;
    var Prec = 0;
    var Left = false;
    var Fchar = "";
    var vq = 0;
    function ReadFormat() {
      var Result = "";
      var Value = 0;
      function ReadInteger() {
        var Code = 0;
        var ArgN = 0;
        if (Value !== -1) return;
        OldPos = ChPos;
        while (((ChPos <= Len) && (Fmt.charAt(ChPos - 1) <= "9")) && (Fmt.charAt(ChPos - 1) >= "0")) ChPos += 1;
        if (ChPos > Len) $impl.DoFormatError(1,Fmt);
        if (Fmt.charAt(ChPos - 1) === "*") {
          if (Index === -1) {
            ArgN = ArgPos}
           else {
            ArgN = Index;
            Index += 1;
          };
          if ((ChPos > OldPos) || (ArgN > (rtl.length(Args) - 1))) $impl.DoFormatError(1,Fmt);
          ArgPos = ArgN + 1;
          if (rtl.isNumber(Args[ArgN]) && pas.JS.isInteger(Args[ArgN])) {
            Value = Math.floor(Args[ArgN])}
           else $impl.DoFormatError(1,Fmt);
          ChPos += 1;
        } else {
          if (OldPos < ChPos) {
            pas.System.val(pas.System.Copy(Fmt,OldPos,ChPos - OldPos),{get: function () {
                return Value;
              }, set: function (v) {
                Value = v;
              }},{get: function () {
                return Code;
              }, set: function (v) {
                Code = v;
              }});
            if (Code > 0) $impl.DoFormatError(1,Fmt);
          } else Value = -1;
        };
      };
      function ReadIndex() {
        if (Fmt.charAt(ChPos - 1) !== ":") {
          ReadInteger()}
         else Value = 0;
        if (Fmt.charAt(ChPos - 1) === ":") {
          if (Value === -1) $impl.DoFormatError(2,Fmt);
          Index = Value;
          Value = -1;
          ChPos += 1;
        };
      };
      function ReadLeft() {
        if (Fmt.charAt(ChPos - 1) === "-") {
          Left = true;
          ChPos += 1;
        } else Left = false;
      };
      function ReadWidth() {
        ReadInteger();
        if (Value !== -1) {
          Width = Value;
          Value = -1;
        };
      };
      function ReadPrec() {
        if (Fmt.charAt(ChPos - 1) === ".") {
          ChPos += 1;
          ReadInteger();
          if (Value === -1) Value = 0;
          Prec = Value;
        };
      };
      Index = -1;
      Width = -1;
      Prec = -1;
      Value = -1;
      ChPos += 1;
      if (Fmt.charAt(ChPos - 1) === "%") {
        Result = "%";
        return Result;
      };
      ReadIndex();
      ReadLeft();
      ReadWidth();
      ReadPrec();
      Result = pas.System.upcase(Fmt.charAt(ChPos - 1));
      return Result;
    };
    function Checkarg(AT, err) {
      var Result = false;
      Result = false;
      if (Index === -1) {
        DoArg = ArgPos}
       else DoArg = Index;
      ArgPos = DoArg + 1;
      if ((DoArg > (rtl.length(Args) - 1)) || (pas.JS.GetValueType(Args[DoArg]) !== AT)) {
        if (err) $impl.DoFormatError(3,Fmt);
        ArgPos -= 1;
        return Result;
      };
      Result = true;
      return Result;
    };
    Result = "";
    Len = Fmt.length;
    ChPos = 1;
    OldPos = 1;
    ArgPos = 0;
    while (ChPos <= Len) {
      while ((ChPos <= Len) && (Fmt.charAt(ChPos - 1) !== "%")) ChPos += 1;
      if (ChPos > OldPos) Result = Result + pas.System.Copy(Fmt,OldPos,ChPos - OldPos);
      if (ChPos < Len) {
        Fchar = ReadFormat();
        var $tmp1 = Fchar;
        if ($tmp1 === "D") {
          Checkarg(pas.JS.TJSValueType.jvtInteger,true);
          ToAdd = $mod.IntToStr(Math.floor(Args[DoArg]));
          Width = Math.abs(Width);
          Index = Prec - ToAdd.length;
          if (ToAdd.charAt(0) !== "-") {
            ToAdd = pas.System.StringOfChar("0",Index) + ToAdd}
           else pas.System.Insert(pas.System.StringOfChar("0",Index + 1),{get: function () {
              return ToAdd;
            }, set: function (v) {
              ToAdd = v;
            }},2);
        } else if ($tmp1 === "U") {
          Checkarg(pas.JS.TJSValueType.jvtInteger,true);
          if (Math.floor(Args[DoArg]) < 0) $impl.DoFormatError(3,Fmt);
          ToAdd = $mod.IntToStr(Math.floor(Args[DoArg]));
          Width = Math.abs(Width);
          Index = Prec - ToAdd.length;
          ToAdd = pas.System.StringOfChar("0",Index) + ToAdd;
        } else if ($tmp1 === "E") {
          if (Checkarg(pas.JS.TJSValueType.jvtFloat,false) || Checkarg(pas.JS.TJSValueType.jvtInteger,true)) ToAdd = $mod.FloatToStrF(rtl.getNumber(Args[DoArg]),$mod.TFloatFormat.ffFixed,9999,Prec);
        } else if ($tmp1 === "F") {
          if (Checkarg(pas.JS.TJSValueType.jvtFloat,false) || Checkarg(pas.JS.TJSValueType.jvtInteger,true)) ToAdd = $mod.FloatToStrF(rtl.getNumber(Args[DoArg]),$mod.TFloatFormat.ffFixed,9999,Prec);
        } else if ($tmp1 === "G") {
          if (Checkarg(pas.JS.TJSValueType.jvtFloat,false) || Checkarg(pas.JS.TJSValueType.jvtInteger,true)) ToAdd = $mod.FloatToStrF(rtl.getNumber(Args[DoArg]),$mod.TFloatFormat.ffGeneral,Prec,3);
        } else if ($tmp1 === "N") {
          if (Checkarg(pas.JS.TJSValueType.jvtFloat,false) || Checkarg(pas.JS.TJSValueType.jvtInteger,true)) ToAdd = $mod.FloatToStrF(rtl.getNumber(Args[DoArg]),$mod.TFloatFormat.ffNumber,9999,Prec);
        } else if ($tmp1 === "M") {
          if (Checkarg(pas.JS.TJSValueType.jvtFloat,false) || Checkarg(pas.JS.TJSValueType.jvtInteger,true)) ToAdd = $mod.FloatToStrF(rtl.getNumber(Args[DoArg]),$mod.TFloatFormat.ffCurrency,9999,Prec);
        } else if ($tmp1 === "S") {
          Checkarg(pas.JS.TJSValueType.jvtString,true);
          Hs = "" + Args[DoArg];
          Index = Hs.length;
          if ((Prec !== -1) && (Index > Prec)) Index = Prec;
          ToAdd = pas.System.Copy(Hs,1,Index);
        } else if ($tmp1 === "P") {
          Checkarg(pas.JS.TJSValueType.jvtInteger,true);
          ToAdd = $mod.IntToHex(Math.floor(Args[DoArg]),31);
        } else if ($tmp1 === "X") {
          Checkarg(pas.JS.TJSValueType.jvtInteger,true);
          vq = Math.floor(Args[DoArg]);
          Index = 31;
          if (Prec > Index) {
            ToAdd = $mod.IntToHex(vq,Index)}
           else {
            Index = 1;
            while (((1 << (Index * 4)) <= vq) && (Index < 16)) Index += 1;
            if (Index > Prec) Prec = Index;
            ToAdd = $mod.IntToHex(vq,Prec);
          };
        } else if ($tmp1 === "%") ToAdd = "%";
        if (Width !== -1) if (ToAdd.length < Width) if (!Left) {
          ToAdd = pas.System.StringOfChar(" ",Width - ToAdd.length) + ToAdd}
         else ToAdd = ToAdd + pas.System.StringOfChar(" ",Width - ToAdd.length);
        Result = Result + ToAdd;
      };
      ChPos += 1;
      OldPos = ChPos;
    };
    return Result;
  };
  this.IntToStr = function (Value) {
    var Result = "";
    Result = "" + Value;
    return Result;
  };
  this.TryStrToInt$1 = function (S, res) {
    var Result = false;
    var Radix = 10;
    var F = "";
    var N = "";
    var J = undefined;
    N = S;
    F = pas.System.Copy(N,1,1);
    if (F === "$") {
      Radix = 16}
     else if (F === "&") {
      Radix = 8}
     else if (F === "%") Radix = 2;
    if (Radix !== 10) pas.System.Delete({get: function () {
        return N;
      }, set: function (v) {
        N = v;
      }},1,1);
    J = parseInt(N,Radix);
    Result = !isNaN(J);
    if (Result) res.set(Math.floor(J));
    return Result;
  };
  this.StrToInt = function (S) {
    var Result = 0;
    var R = 0;
    if (!$mod.TryStrToInt$1(S,{get: function () {
        return R;
      }, set: function (v) {
        R = v;
      }})) throw $mod.EConvertError.$create("CreateFmt",[pas.RTLConsts.SErrInvalidInteger,[S]]);
    Result = R;
    return Result;
  };
  var HexDigits = "0123456789ABCDEF";
  this.IntToHex = function (Value, Digits) {
    var Result = "";
    if (Digits === 0) Digits = 1;
    Result = "";
    while (Value > 0) {
      Result = HexDigits.charAt(((Value & 15) + 1) - 1) + Result;
      Value = Value >>> 4;
    };
    while (Result.length < Digits) Result = "0" + Result;
    return Result;
  };
  this.TFloatFormat = {"0": "ffFixed", ffFixed: 0, "1": "ffGeneral", ffGeneral: 1, "2": "ffExponent", ffExponent: 2, "3": "ffNumber", ffNumber: 3, "4": "ffCurrency", ffCurrency: 4};
  this.FloatToStr = function (Value) {
    var Result = "";
    Result = $mod.FloatToStrF(Value,$mod.TFloatFormat.ffGeneral,15,0);
    return Result;
  };
  this.FloatToStrF = function (Value, format, Precision, Digits) {
    var Result = "";
    var DS = "";
    DS = $mod.DecimalSeparator;
    var $tmp1 = format;
    if ($tmp1 === $mod.TFloatFormat.ffGeneral) {
      Result = $impl.FormatGeneralFloat(Value,Precision,DS)}
     else if ($tmp1 === $mod.TFloatFormat.ffExponent) {
      Result = $impl.FormatExponentFloat(Value,Precision,Digits,DS)}
     else if ($tmp1 === $mod.TFloatFormat.ffFixed) {
      Result = $impl.FormatFixedFloat(Value,Digits,DS)}
     else if ($tmp1 === $mod.TFloatFormat.ffNumber) {
      Result = $impl.FormatNumberFloat(Value,Digits,DS,$mod.ThousandSeparator)}
     else if ($tmp1 === $mod.TFloatFormat.ffCurrency) Result = $impl.FormatNumberCurrency(Value * 10000,Digits,DS,$mod.ThousandSeparator);
    if (((format !== $mod.TFloatFormat.ffCurrency) && (Result.length > 1)) && (Result.charAt(0) === "-")) $impl.RemoveLeadingNegativeSign({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},DS);
    return Result;
  };
  this.DecimalSeparator = ".";
  this.ThousandSeparator = "";
  rtl.createClass($mod,"TFormatSettings",pas.System.TObject,function () {
    this.GetThousandSeparator = function () {
      var Result = "";
      Result = $mod.ThousandSeparator;
      return Result;
    };
  });
  this.FormatSettings = null;
  this.CurrencyFormat = 0;
  this.NegCurrFormat = 0;
  this.CurrencyDecimals = 2;
  this.CurrencyString = "$";
  $mod.$init = function () {
    $mod.FormatSettings = $mod.TFormatSettings.$create("Create");
  };
},null,function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  $impl.feInvalidFormat = 1;
  $impl.feMissingArgument = 2;
  $impl.feInvalidArgIndex = 3;
  $impl.DoFormatError = function (ErrCode, fmt) {
    var $tmp1 = ErrCode;
    if ($tmp1 === 1) {
      throw $mod.EConvertError.$create("CreateFmt",[pas.RTLConsts.SInvalidFormat,[fmt]])}
     else if ($tmp1 === 2) {
      throw $mod.EConvertError.$create("CreateFmt",[pas.RTLConsts.SArgumentMissing,[fmt]])}
     else if ($tmp1 === 3) throw $mod.EConvertError.$create("CreateFmt",[pas.RTLConsts.SInvalidArgIndex,[fmt]]);
  };
  $impl.maxdigits = 15;
  $impl.ReplaceDecimalSep = function (S, DS) {
    var Result = "";
    var P = 0;
    P = pas.System.Pos(".",S);
    if (P > 0) {
      Result = (pas.System.Copy(S,1,P - 1) + DS) + pas.System.Copy(S,P + 1,S.length - P)}
     else Result = S;
    return Result;
  };
  $impl.FormatGeneralFloat = function (Value, Precision, DS) {
    var Result = "";
    var P = 0;
    var PE = 0;
    var Q = 0;
    var Exponent = 0;
    if ((Precision === -1) || (Precision > 15)) Precision = 15;
    Result = rtl.floatToStr(Value,Precision + 7);
    Result = $mod.TrimLeft(Result);
    P = pas.System.Pos(".",Result);
    if (P === 0) return Result;
    PE = pas.System.Pos("E",Result);
    if (PE === 0) {
      Result = $impl.ReplaceDecimalSep(Result,DS);
      return Result;
    };
    Q = PE + 2;
    Exponent = 0;
    while (Q <= Result.length) {
      Exponent = ((Exponent * 10) + Result.charCodeAt(Q - 1)) - "0".charCodeAt();
      Q += 1;
    };
    if (Result.charAt((PE + 1) - 1) === "-") Exponent = -Exponent;
    if (((P + Exponent) < PE) && (Exponent > -6)) {
      Result = rtl.strSetLength(Result,PE - 1);
      if (Exponent >= 0) {
        for (var $l1 = 0, $end2 = Exponent - 1; $l1 <= $end2; $l1++) {
          Q = $l1;
          Result = rtl.setCharAt(Result,P - 1,Result.charAt((P + 1) - 1));
          P += 1;
        };
        Result = rtl.setCharAt(Result,P - 1,".");
        P = 1;
        if (Result.charAt(P - 1) === "-") P += 1;
        while (((Result.charAt(P - 1) === "0") && (P < Result.length)) && (pas.System.Copy(Result,P + 1,DS.length) !== DS)) pas.System.Delete({get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},P,1);
      } else {
        pas.System.Insert(pas.System.Copy("00000",1,-Exponent),{get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},P - 1);
        Result = rtl.setCharAt(Result,(P - Exponent) - 1,Result.charAt(((P - Exponent) - 1) - 1));
        Result = rtl.setCharAt(Result,P - 1,".");
        if (Exponent !== -1) Result = rtl.setCharAt(Result,((P - Exponent) - 1) - 1,"0");
      };
      Q = Result.length;
      while ((Q > 0) && (Result.charAt(Q - 1) === "0")) Q -= 1;
      if (Result.charAt(Q - 1) === ".") Q -= 1;
      if ((Q === 0) || ((Q === 1) && (Result.charAt(0) === "-"))) {
        Result = "0"}
       else Result = rtl.strSetLength(Result,Q);
    } else {
      while (Result.charAt((PE - 1) - 1) === "0") {
        pas.System.Delete({get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},PE - 1,1);
        PE -= 1;
      };
      if (Result.charAt((PE - 1) - 1) === DS) {
        pas.System.Delete({get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},PE - 1,1);
        PE -= 1;
      };
      if (Result.charAt((PE + 1) - 1) === "+") {
        pas.System.Delete({get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},PE + 1,1)}
       else PE += 1;
      while (Result.charAt((PE + 1) - 1) === "0") pas.System.Delete({get: function () {
          return Result;
        }, set: function (v) {
          Result = v;
        }},PE + 1,1);
    };
    Result = $impl.ReplaceDecimalSep(Result,DS);
    return Result;
  };
  $impl.FormatExponentFloat = function (Value, Precision, Digits, DS) {
    var Result = "";
    var P = 0;
    DS = $mod.DecimalSeparator;
    if ((Precision === -1) || (Precision > 15)) Precision = 15;
    Result = rtl.floatToStr(Value,Precision + 7);
    while (Result.charAt(0) === " ") pas.System.Delete({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},1,1);
    P = pas.System.Pos("E",Result);
    if (P === 0) {
      Result = $impl.ReplaceDecimalSep(Result,DS);
      return Result;
    };
    P += 2;
    if (Digits > 4) Digits = 4;
    Digits = ((Result.length - P) - Digits) + 1;
    if (Digits < 0) {
      pas.System.Insert(pas.System.Copy("0000",1,-Digits),{get: function () {
          return Result;
        }, set: function (v) {
          Result = v;
        }},P)}
     else while ((Digits > 0) && (Result.charAt(P - 1) === "0")) {
      pas.System.Delete({get: function () {
          return Result;
        }, set: function (v) {
          Result = v;
        }},P,1);
      if (P > Result.length) {
        pas.System.Delete({get: function () {
            return Result;
          }, set: function (v) {
            Result = v;
          }},P - 2,2);
        break;
      };
      Digits -= 1;
    };
    Result = $impl.ReplaceDecimalSep(Result,DS);
    return Result;
  };
  $impl.FormatFixedFloat = function (Value, Digits, DS) {
    var Result = "";
    if (Digits === -1) {
      Digits = 2}
     else if (Digits > 18) Digits = 18;
    Result = rtl.floatToStr(Value,0,Digits);
    if ((Result !== "") && (Result.charAt(0) === " ")) pas.System.Delete({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},1,1);
    Result = $impl.ReplaceDecimalSep(Result,DS);
    return Result;
  };
  $impl.FormatNumberFloat = function (Value, Digits, DS, TS) {
    var Result = "";
    var P = 0;
    if (Digits === -1) {
      Digits = 2}
     else if (Digits > 15) Digits = 15;
    Result = rtl.floatToStr(Value,0,Digits);
    if ((Result !== "") && (Result.charAt(0) === " ")) pas.System.Delete({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},1,1);
    P = pas.System.Pos(".",Result);
    Result = $impl.ReplaceDecimalSep(Result,DS);
    P -= 3;
    if ((TS !== "") && (TS !== "\x00")) while (P > 1) {
      if (Result.charAt((P - 1) - 1) !== "-") pas.System.Insert(TS,{get: function () {
          return Result;
        }, set: function (v) {
          Result = v;
        }},P);
      P -= 3;
    };
    return Result;
  };
  $impl.RemoveLeadingNegativeSign = function (AValue, DS) {
    var Result = false;
    var i = 0;
    var TS = "";
    var StartPos = 0;
    Result = false;
    StartPos = 2;
    TS = $mod.ThousandSeparator;
    for (var $l1 = StartPos, $end2 = AValue.get().length; $l1 <= $end2; $l1++) {
      i = $l1;
      Result = (AValue.get().charCodeAt(i - 1) in rtl.createSet(48,DS.charCodeAt(),69,43)) || (AValue.get() === TS);
      if (!Result) break;
    };
    if (Result) pas.System.Delete(AValue,1,1);
    return Result;
  };
  $impl.FormatNumberCurrency = function (Value, Digits, DS, TS) {
    var Result = "";
    var Negative = false;
    var P = 0;
    if (Digits === -1) {
      Digits = $mod.CurrencyDecimals}
     else if (Digits > 18) Digits = 18;
    Result = rtl.spaceLeft("" + Value,0);
    Negative = Result.charAt(0) === "-";
    if (Negative) pas.System.Delete({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},1,1);
    P = pas.System.Pos(".",Result);
    if (P !== 0) {
      Result = $impl.ReplaceDecimalSep(Result,DS)}
     else P = Result.length + 1;
    P -= 3;
    while (P > 1) {
      if ($mod.ThousandSeparator !== "\x00") pas.System.Insert($mod.FormatSettings.GetThousandSeparator(),{get: function () {
          return Result;
        }, set: function (v) {
          Result = v;
        }},P);
      P -= 3;
    };
    if ((Result.length > 1) && Negative) Negative = !$impl.RemoveLeadingNegativeSign({get: function () {
        return Result;
      }, set: function (v) {
        Result = v;
      }},DS);
    if (!Negative) {
      var $tmp1 = $mod.CurrencyFormat;
      if ($tmp1 === 0) {
        Result = $mod.CurrencyString + Result}
       else if ($tmp1 === 1) {
        Result = Result + $mod.CurrencyString}
       else if ($tmp1 === 2) {
        Result = ($mod.CurrencyString + " ") + Result}
       else if ($tmp1 === 3) Result = (Result + " ") + $mod.CurrencyString;
    } else {
      var $tmp2 = $mod.NegCurrFormat;
      if ($tmp2 === 0) {
        Result = (("(" + $mod.CurrencyString) + Result) + ")"}
       else if ($tmp2 === 1) {
        Result = ("-" + $mod.CurrencyString) + Result}
       else if ($tmp2 === 2) {
        Result = ($mod.CurrencyString + "-") + Result}
       else if ($tmp2 === 3) {
        Result = ($mod.CurrencyString + Result) + "-"}
       else if ($tmp2 === 4) {
        Result = (("(" + Result) + $mod.CurrencyString) + ")"}
       else if ($tmp2 === 5) {
        Result = ("-" + Result) + $mod.CurrencyString}
       else if ($tmp2 === 6) {
        Result = (Result + "-") + $mod.CurrencyString}
       else if ($tmp2 === 7) {
        Result = (Result + $mod.CurrencyString) + "-"}
       else if ($tmp2 === 8) {
        Result = (("-" + Result) + " ") + $mod.CurrencyString}
       else if ($tmp2 === 9) {
        Result = (("-" + $mod.CurrencyString) + " ") + Result}
       else if ($tmp2 === 10) {
        Result = ((Result + " ") + $mod.CurrencyString) + "-"}
       else if ($tmp2 === 11) {
        Result = (($mod.CurrencyString + " ") + Result) + "-"}
       else if ($tmp2 === 12) {
        Result = (($mod.CurrencyString + " ") + "-") + Result}
       else if ($tmp2 === 13) {
        Result = ((Result + "-") + " ") + $mod.CurrencyString}
       else if ($tmp2 === 14) {
        Result = ((("(" + $mod.CurrencyString) + " ") + Result) + ")"}
       else if ($tmp2 === 15) Result = ((("(" + Result) + " ") + $mod.CurrencyString) + ")";
    };
    if (TS === "") ;
    return Result;
  };
});
rtl.module("Classes",["System","RTLConsts","Types","SysUtils"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  $mod.$init = function () {
    $impl.ClassList = Object.create(null);
  };
},["JS"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  $impl.ClassList = null;
});
rtl.module("Web",["System","Types","JS"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("uMutationObserver",["System","Classes","SysUtils","JS","Web"],function () {
  "use strict";
  var $mod = this;
});
rtl.module("jElement",["System","Classes","SysUtils","Types","JS","Web","uMutationObserver"],function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  rtl.createClass($mod,"TW3CustomControl",pas.System.TObject,function () {
  });
  rtl.createClass($mod,"TElement",$mod.TW3CustomControl,function () {
    this.$init = function () {
      $mod.TW3CustomControl.$init.call(this);
      this.FOnClick = null;
      this.FOnResize = null;
      this.FOnReadyExecute = null;
      this.FElement = null;
      this.Handle = undefined;
      this.tag = "";
    };
    this.$final = function () {
      this.FOnClick = undefined;
      this.FOnResize = undefined;
      this.FOnReadyExecute = undefined;
      this.FElement = undefined;
      $mod.TW3CustomControl.$final.call(this);
    };
    this.SetLeft = function (aLeft) {
      var FElementStyle = null;
      FElementStyle = this.FElement.style;
      FElementStyle.setProperty("left",pas.SysUtils.IntToStr(aLeft) + "px");
    };
    this.GetLeft = function () {
      var Result = 0;
      var FElementStyle = null;
      var S = "";
      FElementStyle = this.FElement.style;
      S = FElementStyle.getPropertyValue("left");
      if ($impl.StrEndsWith(S,"px")) S = rtl.strSetLength(S,S.length - 2);
      Result = pas.SysUtils.StrToInt(S);
      return Result;
    };
    this.SetTop = function (aTop) {
      var FElementStyle = null;
      FElementStyle = this.FElement.style;
      FElementStyle.setProperty("top",pas.SysUtils.IntToStr(aTop) + "px");
    };
    this.GetTop = function () {
      var Result = 0;
      var FElementStyle = null;
      var S = "";
      FElementStyle = this.FElement.style;
      S = FElementStyle.getPropertyValue("top");
      if ($impl.StrEndsWith(S,"px")) S = rtl.strSetLength(S,S.length - 2);
      Result = pas.SysUtils.StrToInt(S);
      return Result;
    };
    this.SetWidth = function (aWidth) {
      var FElementStyle = null;
      FElementStyle = this.FElement.style;
      if (aWidth === $mod.ScreenWidth) {
        FElementStyle.setProperty("width","calc(100%)")}
       else FElementStyle.setProperty("width",pas.SysUtils.IntToStr(aWidth) + "px");
    };
    this.GetWidth = function () {
      var Result = 0;
      var FElementStyle = null;
      var S = "";
      FElementStyle = this.FElement.style;
      S = FElementStyle.getPropertyValue("width");
      if ($impl.StrEndsWith(S,"px")) S = rtl.strSetLength(S,S.length - 2);
      Result = pas.SysUtils.StrToInt(S);
      return Result;
    };
    this.SetHeight = function (aHeight) {
      var FElementStyle = null;
      FElementStyle = this.FElement.style;
      FElementStyle.setProperty("height",pas.SysUtils.IntToStr(aHeight) + "px");
    };
    this.GetHeight = function () {
      var Result = 0;
      var FElementStyle = null;
      var S = "";
      FElementStyle = this.FElement.style;
      S = FElementStyle.getPropertyValue("height");
      if ($impl.StrEndsWith(S,"px")) S = rtl.strSetLength(S,S.length - 2);
      Result = pas.SysUtils.StrToInt(S);
      return Result;
    };
    this._setMouseClick = function (aValue) {
      this.FOnClick = aValue;
    };
    this._setOnResize = function (aValue) {
      this.FOnResize = aValue;
    };
    this._setOnReadyExecute = function (aValue) {
      this.FOnReadyExecute = aValue;
    };
    this.Create$1 = function (element, parent) {
      var FElementStyle = null;
      this.FElement = document.createElement(element);
      this.FElement.className = element;
      this.FElement.id = $impl.w3_getUniqueObjId();
      FElementStyle = this.FElement.style;
      FElementStyle.setProperty("visibility","visible");
      FElementStyle.setProperty("display","inline-block");
      FElementStyle.setProperty("position","absolute");
      FElementStyle.setProperty("overflow","auto");
      if (parent === null) {
        this.Handle = document.body.appendChild(this.FElement)}
       else this.Handle = parent.FElement.appendChild(this.FElement);
      this.SetBounds(0,0,0,0);
      this.FElement.addEventListener("click",rtl.createCallback(this,"CBClick"));
      window.addEventListener("resize",rtl.createCallback(this,"CBResize"));
      this.FElement.addEventListener("readyexecute",rtl.createCallback(this,"CBReadyExecute"));
      this.Observe();
    };
    this.SetProperty = function (S1, S2) {
      var FElementStyle = null;
      FElementStyle = this.FElement.style;
      FElementStyle.setProperty(S1,S2);
    };
    this.SetAttribute = function (S1, S2) {
      this.FElement.setAttribute(S1,S2);
    };
    this.SetBounds = function (aleft, atop, awidth, aheight) {
      this.SetLeft(aleft);
      this.SetTop(atop);
      this.SetWidth(awidth);
      this.SetHeight(aheight);
    };
    this.SetinnerHTML = function (S1) {
      this.FElement.innerHTML = S1;
    };
    this.CBClick = function (eventObj) {
      eventObj.stopPropagation();
      if (this.FOnClick != null) this.FOnClick(this);
    };
    this.CBResize = function (eventObj) {
      if (this.FOnResize != null) this.FOnResize(this);
    };
    this.CBReadyExecute = function (eventObj) {
      if (this.FOnReadyExecute != null) this.FOnReadyExecute(this);
    };
    this.Observe = function () {
      var MyObserver = null;
      MyObserver = $impl.TMutationObserver.$create("Create$1");
      rtl.getObject(MyObserver.FHandle).observe(rtl.getObject(this.Handle),$impl.observerConfig());
    };
    this.Clear = function () {
      while (this.FElement.firstChild != null) this.FElement.removeChild(this.FElement.firstChild);
    };
    this.touch2Mouse = function (e) {
      var theTouch = null;
      var mouseEv = "";
      var mouseEvent = null;
      theTouch = e.changedTouches.item(0);
      var $tmp1 = e.type;
      if ($tmp1 === "touchstart") {
        mouseEv = "mousedown"}
       else if ($tmp1 === "touchend") {
        mouseEv = "mouseup"}
       else if ($tmp1 === "touchmove") {
        mouseEv = "mousemove"}
       else {
        return;
      };
      mouseEvent = document.createEvent("MouseEvent");
      mouseEvent.initMouseEvent(mouseEv,true,true,window,1,theTouch.screenX,theTouch.screenY,theTouch.clientX,theTouch.clientY,false,false,false,false,0,null);
      theTouch.target.dispatchEvent(mouseEvent);
      e.preventDefault();
    };
  });
  this.ScreenWidth = 0;
  $mod.$init = function () {
    $mod.ScreenWidth = window.innerWidth;
  };
},null,function () {
  "use strict";
  var $mod = this;
  var $impl = $mod.$impl;
  $impl.vUniqueNumber = 0;
  $impl.w3_getUniqueObjId = function () {
    var Result = "";
    $impl.vUniqueNumber += 1;
    Result = "OBJ" + pas.SysUtils.IntToStr($impl.vUniqueNumber);
    return Result;
  };
  $impl.StrEndsWith = function (s, e) {
    var Result = undefined;
    { return s.substr(s.length-e.length)==e };
    return Result;
  };
  rtl.createClass($impl,"TMutationObserver",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.FHandle = undefined;
    };
    this.Create$1 = function () {
      var Self = this;
      var mRef = null;
      var mhandle = null;
      function subscribe(mutationRecordsList) {
        mRef(mutationRecordsList);
      };
      pas.System.TObject.Create.call(Self);
      mRef = rtl.createCallback(Self,"CBMutationChange");
      mhandle = new MutationObserver(subscribe);
      Self.FHandle = mhandle;
    };
    this.CBMutationChange = function (mutationRecordsList) {
      var LEvent = undefined;
      rtl.getObject(this.FHandle).disconnect();
      LEvent = new Event('readyexecute');
      mutationRecordsList[mutationRecordsList.length - 1].target.dispatchEvent(LEvent);
    };
  });
  $impl.observerConfig = function () {
    var Result = null;
    Result = pas.JS.New(["attributes",true,"attributeOldValue",true]);
    return Result;
  };
});
rtl.module("jForm",["System","Classes","SysUtils","JS","Web","jElement"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"TW3Form",pas.jElement.TElement,function () {
    this.InitializeForm = function () {
      this.Clear();
    };
    this.InitializeObject = function () {
    };
    this.ReSize = function () {
    };
    this.Create$2 = function (parent) {
      var Self = this;
      function doOnResize(sender) {
        pas.jElement.ScreenWidth = window.innerWidth;
        Self.ReSize();
      };
      pas.jElement.TElement.Create$1.call(Self,"div",parent);
      Self.SetProperty("border","1px double #2196f3");
      Self.SetLeft(5);
      Self.SetTop(5);
      Self.SetProperty("width","calc(100% - 12px)");
      Self.SetProperty("height","calc(100% - 12px)");
      Self.SetProperty("background-color","white");
      Self.SetProperty("will-change","transform");
      Self.SetProperty("-webkit-transform","translateZ(0px)");
      Self.SetProperty("-moz-transform","translateZ(0px)");
      Self.SetProperty("-ms-transform","translateZ(0px)");
      Self.SetProperty("-o-transform","translateZ(0px)");
      Self.SetProperty("transform","translateZ(0px)");
      Self._setOnResize(doOnResize);
    };
  });
},["jGlobals"]);
rtl.module("jApplication",["System","Classes","SysUtils","Types","JS","Web","jElement","jForm"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Application",pas.jElement.TElement,function () {
    this.$init = function () {
      pas.jElement.TElement.$init.call(this);
      this.FormNames = [];
      this.FormsClasses = [];
      this.FormsInstances = [];
    };
    this.$final = function () {
      this.FormNames = undefined;
      this.FormsClasses = undefined;
      this.FormsInstances = undefined;
      pas.jElement.TElement.$final.call(this);
    };
    this.Create$2 = function (parent) {
      pas.jElement.TElement.Create$1.call(this,"div",parent);
      this.SetProperty("width","100%");
      this.SetProperty("height","100%");
      this.SetProperty("background-color","white");
    };
    this.CreateForm = function (FormName, aClassType) {
      this.FormNames.push(FormName);
      this.FormsClasses.push(aClassType);
      this.FormsInstances.push(null);
    };
    this.GoToForm = function (FormName) {
      var i = 0;
      for (var $l1 = 0, $end2 = this.FormNames.length - 1; $l1 <= $end2; $l1++) {
        i = $l1;
        if (this.FormsInstances[i] !== null) this.FormsInstances[i].SetProperty("display","none");
        if (this.FormNames[i] === FormName) {
          if (this.FormsInstances[i] === null) {
            this.FormsInstances[i] = this.FormsClasses[i].$create("Create$2",[this])}
           else this.FormsInstances[i].SetProperty("display","inline-block");
          this.FormsInstances[i].InitializeForm();
          this.FormsInstances[i].InitializeObject();
        };
      };
    };
  });
},["jGlobals"]);
rtl.module("jGlobals",["System","Classes","SysUtils","JS","Web","jElement","jApplication","jForm"],function () {
  "use strict";
  var $mod = this;
  this.Application = null;
  this.StrBefore = function (s, d) {
    var Result = "";
    if(!d)return s;var p=s.indexOf(d);return(p<0)?s:s.substr(0,p);
    return Result;
  };
  $mod.$init = function () {
    $mod.Application = pas.jApplication.JW3Application.$create("Create$2",[null]);
  };
});
rtl.module("jPanel",["System","Classes","SysUtils","JS","Web","jElement"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Panel",pas.jElement.TElement,function () {
    this.Create$2 = function (parent) {
      pas.jElement.TElement.Create$1.call(this,"div",parent);
    };
  });
});
rtl.module("jListBox",["System","Classes","SysUtils","JS","Web","jElement","jPanel"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3ListBox",pas.jElement.TElement,function () {
    this.$init = function () {
      pas.jElement.TElement.$init.call(this);
      this.ItemCount = 0;
    };
    this.Create$2 = function (parent) {
      var Self = this;
      var atop = 0;
      var aheight = 0;
      function doListBox(event) {
        var Result = false;
        var i = 0;
        var c = null;
        c = rtl.getObject(Self.Handle).children;
        for (var $l1 = 0, $end2 = c.length - 1; $l1 <= $end2; $l1++) {
          i = $l1;
          atop = pas.SysUtils.StrToInt(pas.jGlobals.StrBefore(c.item(i).style.getPropertyValue("top"),"px"));
          aheight = pas.SysUtils.StrToInt(pas.jGlobals.StrBefore(c.item(i).style.getPropertyValue("height"),"px"));
          c.item(c.length - 1).style.setProperty("display","inline-block");
          if (((atop + aheight) < rtl.getObject(Self.Handle).scrollTop) && (c.item(i).style.getPropertyValue("display") === "inline-block")) c.item(i).style.setProperty("display","none");
          if (((atop + aheight) >= rtl.getObject(Self.Handle).scrollTop) && (atop <= ((rtl.getObject(Self.Handle).scrollTop + Self.GetHeight()) + 2))) {
            c.item(i).style.setProperty("display","inline-block");
          };
          if (((atop > ((rtl.getObject(Self.Handle).scrollTop + Self.GetHeight()) + 2)) && (c.item(i).style.getPropertyValue("display") === "inline-block")) && (i < (c.length - 1))) c.item(i).style.setProperty("display","none");
        };
        return Result;
      };
      pas.jElement.TElement.Create$1.call(Self,"div",parent);
      Self.ItemCount = 0;
      rtl.getObject(Self.Handle).setAttribute("will-change","transform");
      rtl.getObject(Self.Handle).onscroll = doListBox;
    };
    this.Add = function (item) {
      rtl.getObject(item.Handle).style.setProperty("width","calc(100%-10px)");
      this.FElement.appendChild(item.FElement);
      item.SetBounds(2,(2 + (this.ItemCount * item.GetHeight())) + (this.ItemCount * 2),item.GetWidth(),item.GetHeight());
      item.SetProperty("cursor","pointer");
      if ((item.GetTop() > this.GetHeight()) && (this.GetHeight() > 0)) item.SetProperty("display","none");
      this.ItemCount += 1;
    };
  });
},["jGlobals"]);
rtl.module("jButton",["System","Classes","SysUtils","JS","Web","jElement"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Button",pas.jElement.TElement,function () {
    this.Create$2 = function (parent) {
      pas.jElement.TElement.Create$1.call(this,"button",parent);
      this.SetProperty("color","white");
      this.SetProperty("border-radius","4px");
      this.SetProperty("background","#699BCE");
      this.SetProperty("cursor","pointer");
      this.SetProperty("box-shadow","0 -1px 1px 0 rgba(0, 0, 0, 0.25) inset, 0 1px 1px 0 rgba(0, 0, 0, 0.10) inset;)");
    };
  });
});
rtl.module("jImage",["System","Classes","SysUtils","JS","Web","jElement"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Image",pas.jElement.TElement,function () {
    this.Create$2 = function (parent) {
      pas.jElement.TElement.Create$1.call(this,"img",parent);
    };
  });
});
rtl.module("jToolBar",["System","Classes","SysUtils","Types","JS","Web","jElement","jPanel"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3ToolBar",pas.jElement.TElement,function () {
    this.$init = function () {
      pas.jElement.TElement.$init.call(this);
      this.ToolBarItems = [];
    };
    this.$final = function () {
      this.ToolBarItems = undefined;
      pas.jElement.TElement.$final.call(this);
    };
    this.Create$2 = function (parent) {
      pas.jElement.TElement.Create$1.call(this,"div",parent);
    };
    this.AddMenu = function (menuText, GotoForm, color) {
      var Self = this;
      var Panel0 = null;
      function Panel0Click(Sender) {
        if (pas.jGlobals.Application.FormNames.indexOf(rtl.as(Sender,pas.jPanel.JW3Panel).tag) > -1) {
          pas.jGlobals.Application.GoToForm(rtl.as(Sender,pas.jPanel.JW3Panel).tag)}
         else window.postMessage([rtl.getObject(Self.Handle).id,"click",GotoForm],"*");
      };
      Panel0 = pas.jPanel.JW3Panel.$create("Create$2",[Self]);
      Panel0.SetBounds(20 + (Self.ToolBarItems.length * 100),14,90,26);
      Panel0.SetinnerHTML(menuText);
      Panel0.SetProperty("color",color);
      Panel0.SetProperty("cursor","pointer");
      Panel0.SetProperty("font-size","0.9em");
      Self.ToolBarItems.push(Panel0);
      Panel0.tag = GotoForm;
      Panel0._setMouseClick(Panel0Click);
    };
    this.SetActiveMenu = function (formname) {
      var i = 0;
      for (var $l1 = 0, $end2 = this.ToolBarItems.length - 1; $l1 <= $end2; $l1++) {
        i = $l1;
        this.ToolBarItems[i].SetProperty("font-weight","normal");
        this.ToolBarItems[i].SetProperty("text-decoration","none");
        if (this.ToolBarItems[i].tag === formname) {
          this.ToolBarItems[i].SetProperty("font-weight","bold");
          this.ToolBarItems[i].SetProperty("text-decoration","underline");
        };
      };
    };
  });
},["jGlobals"]);
rtl.module("jProgressBar",["System","Classes","SysUtils","JS","Web","jElement","jPanel"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Progress",pas.jElement.TElement,function () {
    this.$init = function () {
      pas.jElement.TElement.$init.call(this);
      this.Light = null;
      this.timer = 0;
      this.ProgressBar = null;
    };
    this.$final = function () {
      this.Light = undefined;
      this.ProgressBar = undefined;
      pas.jElement.TElement.$final.call(this);
    };
    this.SetPerc = function (aPerc) {
      var f = 0.0;
      if (aPerc > 100) aPerc = 100;
      if (aPerc < 0) aPerc = 0;
      f = (this.GetWidth() * aPerc) / 100;
      this.ProgressBar.SetProperty("width",pas.SysUtils.FloatToStr(f) + "px");
      this.ProgressBar.SetBounds(0,0,this.ProgressBar.GetWidth(),this.GetHeight());
      this.ProgressBar.SetProperty("overflow","hidden");
      this.Light.SetWidth(this.ProgressBar.GetHeight() * 2);
      this.Light.SetHeight(this.ProgressBar.GetHeight() - 4);
      this.Light.SetTop(2);
    };
    this.GetPerc = function () {
      var Result = 0.0;
      var f = 0.0;
      f = (this.ProgressBar.GetWidth() / this.GetWidth()) * 100;
      Result = f;
      return Result;
    };
    this.Create$2 = function (parent) {
      var Self = this;
      function doOnTimer() {
        Self.Light.SetLeft(Self.Light.GetLeft() + 4);
        if ((Self.Light.GetLeft() + Self.Light.GetWidth()) > Self.ProgressBar.GetWidth()) Self.Light.SetLeft(0);
        if (((Self.Light.GetLeft() + Self.Light.GetWidth()) + 2) >= Self.GetWidth()) {
          Self.Light.SetLeft(-Self.Light.GetWidth());
          window.clearInterval(Self.timer);
        };
      };
      pas.jElement.TElement.Create$1.call(Self,"div",parent);
      Self.ProgressBar = pas.jPanel.JW3Panel.$create("Create$2",[Self]);
      Self.Light = pas.jPanel.JW3Panel.$create("Create$2",[Self.ProgressBar]);
      Self.Light.SetProperty("border-radius","2px");
      Self.Light.SetProperty("background-color","white");
      Self.Light.SetProperty("opacity","0.5");
      Self.Light.SetLeft(0);
      Self.timer = window.setInterval(doOnTimer,20);
    };
  });
},["jGlobals"]);
rtl.module("JSplitter",["System","Classes","SysUtils","JS","Web","jElement","jPanel"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"JW3Splitter",pas.jElement.TElement,function () {
    this.$init = function () {
      pas.jElement.TElement.$init.call(this);
      this.PanelLeft = null;
      this.PanelRight = null;
      this.ReSizer = null;
    };
    this.$final = function () {
      this.PanelLeft = undefined;
      this.PanelRight = undefined;
      this.ReSizer = undefined;
      pas.jElement.TElement.$final.call(this);
    };
    this.Create$2 = function (parent) {
      var Self = this;
      function doSplitterOnReadyExecute(sender) {
        function doReSizerOnTouchStart(event) {
          var Result = false;
          Self.touch2Mouse(event);
          return Result;
        };
        function doReSizerOnMouseDown(e) {
          var Result = false;
          var saveX = 0;
          function doOnMouseMove(e) {
            var Result = false;
            Self.PanelRight.SetLeft(Self.PanelRight.GetLeft() - pas.System.Trunc(saveX - e.clientX));
            saveX = pas.System.Trunc(e.clientX);
            Self.PanelRight.SetWidth(Self.GetWidth() - Self.PanelRight.GetLeft());
            Self.PanelLeft.SetProperty("cursor","w-resize");
            Self.PanelRight.SetProperty("cursor","w-resize");
            return Result;
          };
          saveX = pas.System.Trunc(e.clientX);
          rtl.getObject(Self.Handle).onmousemove = doOnMouseMove;
          return Result;
        };
        function doSplitterOnMouseUp(event) {
          var Result = false;
          function doOnMouseMove(e) {
            var Result = false;
            return Result;
          };
          Self.PanelLeft.SetProperty("cursor","default");
          Self.PanelRight.SetProperty("cursor","default");
          rtl.getObject(Self.Handle).onmousemove = doOnMouseMove;
          return Result;
        };
        window.console.log("OnReadyExecute");
        Self.PanelLeft.SetProperty("height","100%");
        Self.PanelLeft.SetProperty("width","100%");
        Self.PanelRight.SetProperty("height","100%");
        Self.PanelRight.SetWidth(pas.System.Trunc(Self.GetWidth() / 2));
        Self.PanelRight.SetLeft(pas.System.Trunc(Self.GetWidth() / 2));
        Self.ReSizer.SetProperty("height","100%");
        rtl.getObject(Self.ReSizer.Handle).ontouchstart = doReSizerOnTouchStart;
        rtl.getObject(Self.ReSizer.Handle).ontouchmove = rtl.getObject(Self.ReSizer.Handle).ontouchstart;
        rtl.getObject(Self.ReSizer.Handle).ontouchend = rtl.getObject(Self.ReSizer.Handle).ontouchstart;
        rtl.getObject(Self.ReSizer.Handle).onmousedown = doReSizerOnMouseDown;
        rtl.getObject(Self.Handle).onmouseup = doSplitterOnMouseUp;
      };
      pas.jElement.TElement.Create$1.call(Self,"div",parent);
      Self.PanelLeft = pas.jPanel.JW3Panel.$create("Create$2",[Self]);
      Self.PanelRight = pas.jPanel.JW3Panel.$create("Create$2",[Self]);
      Self.ReSizer = pas.jPanel.JW3Panel.$create("Create$2",[Self.PanelRight]);
      Self.ReSizer.SetProperty("background-color","#ccc");
      Self.ReSizer.SetProperty("cursor","w-resize");
      Self.ReSizer.SetWidth(4);
      Self._setOnReadyExecute(doSplitterOnReadyExecute);
    };
  });
},["jGlobals"]);
rtl.module("Form1",["System","Classes","SysUtils","Types","JS","Web","jElement","jForm","jListBox","jPanel","jButton","jImage","jToolBar","jProgressBar","JSplitter"],function () {
  "use strict";
  var $mod = this;
  rtl.createClass($mod,"TComponentRec",pas.System.TObject,function () {
    this.$init = function () {
      pas.System.TObject.$init.call(this);
      this.name = "";
      this.ShowIt = null;
    };
    this.$final = function () {
      this.ShowIt = undefined;
      pas.System.TObject.$final.call(this);
    };
  });
  rtl.createClass($mod,"TForm1",pas.jForm.TW3Form,function () {
    this.$init = function () {
      pas.jForm.TW3Form.$init.call(this);
      this.ToolBar = null;
      this.ListBox1 = null;
      this.Components = [];
      this.DisplayDiv = null;
      this.ComponentRec = null;
    };
    this.$final = function () {
      this.ToolBar = undefined;
      this.ListBox1 = undefined;
      this.Components = undefined;
      this.DisplayDiv = undefined;
      this.ComponentRec = undefined;
      pas.jForm.TW3Form.$final.call(this);
    };
    this.populateListBox = function () {
      var Self = this;
      var i = 0;
      var Panel0 = null;
      function doPanel0OnClick(Sender) {
        var disp = null;
        while (Self.DisplayDiv.FElement.firstChild != null) Self.DisplayDiv.FElement.removeChild(Self.DisplayDiv.FElement.firstChild);
        if (document.getElementById(rtl.getObject(Self.Handle).getAttribute("data-select")) != null) document.getElementById(rtl.getObject(Self.Handle).getAttribute("data-select")).style.setProperty("display","none");
        Self.Components[pas.SysUtils.StrToInt(rtl.as(Sender,pas.jPanel.JW3Panel).tag)].ShowIt();
        disp = rtl.getObject(Self.DisplayDiv.Handle).children.item(0).style;
        disp.setProperty("height","px");
        Self.DisplayDiv.SetHeight(pas.SysUtils.StrToInt(pas.jGlobals.StrBefore(rtl.getObject(Self.DisplayDiv.Handle).children.item(0).style.getPropertyValue("height"),"px")) + 30);
        Self.DisplayDiv.SetWidth(pas.SysUtils.StrToInt(pas.jGlobals.StrBefore(rtl.getObject(Self.DisplayDiv.Handle).children.item(0).style.getPropertyValue("width"),"px")) + 30);
      };
      Self.ListBox1 = pas.jListBox.JW3ListBox.$create("Create$2",[Self]);
      Self.ListBox1.SetBounds(17,85,200,200);
      Self.ListBox1.SetProperty("background-color","white");
      Self.ListBox1.SetProperty("border","2px double whitesmoke");
      for (var $l1 = 0, $end2 = Self.Components.length - 1; $l1 <= $end2; $l1++) {
        i = $l1;
        Panel0 = pas.jPanel.JW3Panel.$create("Create$2",[Self.ListBox1]);
        Panel0.SetProperty("background-color","whitesmoke");
        Panel0.SetBounds(2,2,170,22);
        Panel0.SetinnerHTML(Self.Components[i].name);
        Panel0.SetProperty("font-size","0.85em");
        Panel0.tag = pas.SysUtils.IntToStr(i);
        Panel0._setMouseClick(doPanel0OnClick);
        Self.ListBox1.Add(Panel0);
      };
    };
    this.InitializeForm = function () {
      pas.jForm.TW3Form.InitializeForm.apply(this,arguments);
    };
    this.InitializeObject = function () {
      var Self = this;
      var Image0 = null;
      function doPanel1() {
        var Panel1 = null;
        Panel1 = pas.jPanel.JW3Panel.$create("Create$2",[Self.DisplayDiv]);
        Panel1.SetBounds(0,0,100,100);
        Panel1.SetProperty("background-color","gold");
        Panel1.SetProperty("border","1px double grey");
      };
      function doButton1() {
        var Button1 = null;
        function Button1OnClick(sender) {
          window.alert("clicked");
        };
        Button1 = pas.jButton.JW3Button.$create("Create$2",[Self.DisplayDiv]);
        Button1.SetBounds(0,0,100,50);
        Button1.SetinnerHTML("Button");
        Button1._setMouseClick(Button1OnClick);
      };
      function doProgress1() {
        var Progress1 = null;
        var id = 0;
        function ProgressIt() {
          Progress1.SetPerc(Progress1.GetPerc() + 1);
          if (Progress1.GetPerc() > 100) window.clearInterval(id);
        };
        Progress1 = pas.jProgressBar.JW3Progress.$create("Create$2",[Self.DisplayDiv]);
        Progress1.SetBounds(0,0,300,12);
        Progress1.SetProperty("background-color","lightgrey");
        Progress1.ProgressBar.SetProperty("background-color","salmon");
        Progress1.SetPerc(25);
        id = window.setInterval(ProgressIt,30);
      };
      function doImage1() {
        var Image1 = null;
        Image1 = pas.jImage.JW3Image.$create("Create$2",[Self.DisplayDiv]);
        Image1.SetBounds(0,0,194,45);
        Image1.SetAttribute("src","images\/logo.png");
      };
      function doSplitter1() {
        var Splitter1 = null;
        var Button1 = null;
        var Button2 = null;
        Splitter1 = pas.JSplitter.JW3Splitter.$create("Create$2",[Self.DisplayDiv]);
        Splitter1.SetBounds(0,0,300,200);
        Splitter1.PanelLeft.SetProperty("background-color","white");
        Splitter1.PanelRight.SetProperty("background-color","whitesmoke");
        Splitter1.SetProperty("border","1px solid silver");
        Button1 = pas.jButton.JW3Button.$create("Create$2",[Splitter1.PanelLeft]);
        Button1.SetinnerHTML("Left");
        Button1.SetBounds(20,20,60,30);
        Button2 = pas.jButton.JW3Button.$create("Create$2",[Splitter1.PanelRight]);
        Button2.SetinnerHTML("Right");
        Button2.SetBounds(20,20,60,30);
      };
      pas.jForm.TW3Form.InitializeObject.apply(Self,arguments);
      Image0 = pas.jImage.JW3Image.$create("Create$2",[Self]);
      Image0.SetBounds(0,0,194,45);
      Image0.SetAttribute("src","images\/logo.png");
      Self.ToolBar = pas.jToolBar.JW3ToolBar.$create("Create$2",[Self]);
      Self.ToolBar.SetBounds(0,45,0,40);
      Self.ToolBar.SetProperty("min-width","100%");
      Self.ToolBar.SetProperty("background-color","#699BCE");
      Self.ToolBar.AddMenu("Components","Form1","white");
      Self.ToolBar.AddMenu("Projects","Form2","white");
      Self.ToolBar.SetActiveMenu("Form1");
      Self.Components.length = 0;
      Self.DisplayDiv = pas.jPanel.JW3Panel.$create("Create$2",[Self]);
      Self.DisplayDiv.SetBounds(20,300,0,0);
      Self.ComponentRec = $mod.TComponentRec.$create("Create");
      Self.ComponentRec.name = "JPanel";
      Self.ComponentRec.ShowIt = doPanel1;
      Self.Components.push(Self.ComponentRec);
      Self.ComponentRec = $mod.TComponentRec.$create("Create");
      Self.ComponentRec.name = "JButton";
      Self.ComponentRec.ShowIt = doButton1;
      Self.Components.push(Self.ComponentRec);
      Self.ComponentRec = $mod.TComponentRec.$create("Create");
      Self.ComponentRec.name = "JProgress";
      Self.ComponentRec.ShowIt = doProgress1;
      Self.Components.push(Self.ComponentRec);
      Self.ComponentRec = $mod.TComponentRec.$create("Create");
      Self.ComponentRec.name = "JImage";
      Self.ComponentRec.ShowIt = doImage1;
      Self.Components.push(Self.ComponentRec);
      Self.ComponentRec = $mod.TComponentRec.$create("Create");
      Self.ComponentRec.name = "JSplitter";
      Self.ComponentRec.ShowIt = doSplitter1;
      Self.Components.push(Self.ComponentRec);
      Self.populateListBox();
    };
    this.ReSize = function () {
      pas.jForm.TW3Form.ReSize.apply(this,arguments);
    };
  });
},["jGlobals"]);
rtl.module("program",["System","Classes","SysUtils","JS","Web","jGlobals","jApplication","Form1","JSplitter"],function () {
  "use strict";
  var $mod = this;
  $mod.$main = function () {
    pas.jGlobals.Application.CreateForm("Form1",pas.Form1.TForm1);
    pas.jGlobals.Application.GoToForm("Form1");
  };
});
//# sourceMappingURL=project1.js.map
