var spadding="Pkcs7";var block="CBC";function get_json(){var b=getUserAgent();var e=new Object();var d=document.getElementById("txtPlaintext").value;var a=d.length;if(a==0){return false}
e=[{id:"0",libreria:"cryptojs-v3",algoritmo:"aes",user_agent:b,keySizeInBits:_keySizeInBits,block_modes:block,padding_schemes:spadding,message_length:a,encrypt:en_time,decrypt:de_time}];var c=JSON.stringify(e);return(c)}
var json_tmp;function _encrypt(l,p){var z,d;var g="",b="",A,r="",a,t;var n,m,k;var B;var y="success",o=0;if(o==0){d=document.getElementById("selKeySize");var q=selKeySizeChange(d.value);if(q==false){alert("Can't encrypt: CORRUPT: invalid 'keySize'");o=1}
d=document.getElementById("selPad");var x=selPadChange(d.value);if(x==null){alert("Can't encrypt: INVALID: padding: invalid parameters");o=1}
var r=getMode();if(r==null){alert("Can't encrypt: INVALID: mode block: "+r);o=1}}
if(o==0){var C=CryptoJS.enc.Hex.parse(document.getElementById("passphrase").value);var c=CryptoJS.enc.Utf8.parse(document.getElementById("iv").value);try{n=new Date().getTime();var f={iv:c,mode:r,padding:x};var u=CryptoJS.AES.encrypt(CryptoJS.enc.Utf8.parse(l),C,f);B=u.toString();json_tmp=u;m=new Date().getTime();k=(m-n)}catch(w){alert("Can't encrypt (cryptojs v3): CryptoJS.AES.encrypt: "+w.message);o=1}}
g=u.iv.toString();if(B==undefined){o=1}
if(k==undefined){k=0}
if(o!=0){y="failure"}
var v;v={iv:g,mode:block,padding:spadding,ciphertext:B,status:y};var h=document.getElementById("txtPlaintext").value;var j;j={passphrase:p,iv:"",ivInBytes:"",ivInHex:g,ivInBase64:"",salt:"",saltInBytes:"",saltInHex:b,saltInBase64:"",key:"",keyInBytes:"",keyInHex:C,keyInBase64:"",plaintext:h.trim(),ciphertext:B,};log_encrypt(v,j);return v}
function _decrypt(json_ciphertext,passphrase){var jsObject;var iv="",salt="",keySize,mode="",cipher,status;var t1,t2,time;var plaintext,ciphertext;var msg_status="success",flag_status=0;try{jsObject=eval("("+json_ciphertext+")");if(jsObject==null){alert("Can't decrypt: INVALID: json decrypt: invalid object");flag_status=1}}catch(e){alert("Can't decrypt: INVALID: json decrypt: "+e.message);flag_status=1}
if(flag_status==0){status=jsObject.status;iv=CryptoJS.enc.Hex.parse(jsObject.iv);mode=jsObject.mode;if(status!="success"){alert("Can't decrypt: INVALID: json decrypt: invalid parameters");flag_status=1}
var pad=selPadChange(jsObject.padding);if(pad==null){alert("Can't decrypt: INVALID: padding: invalid parameters");flag_status=1}
var mode=getMode();if(mode==null){alert("Can't encrypt: INVALID: mode block: "+mode);flag_status=1}}
if(flag_status==0){var keyObj=CryptoJS.PBKDF2(passphrase,salt,{keySize:keySize/32});var key=CryptoJS.enc.Hex.parse(document.getElementById("passphrase").value);try{t1=new Date().getTime();var options={iv:iv,mode:mode,padding:pad};var decrypted=CryptoJS.AES.decrypt(json_tmp,key,options);plaintext=decrypted.toString(CryptoJS.enc.Utf8);t2=new Date().getTime();time=(t2-t1)}catch(e){alert("Can't decrypt (cryptojs v3): CryptoJS.AES.decrypt: "+e.message);flag_status=1}}
if(plaintext==undefined){flag_status=1}
if(time==undefined){time=0}
if(flag_status!=0){msg_status="failure"}
var str="<br/><label style='font-weight:bold'>* Decrypt: </label><br/>";str+="decryption took "+time+" milliseconds.<br/>";str+="length plaintext: "+plaintext.length+"<br/>";$("#ldec").html(str);var json;json={iv:iv,mode:block,padding:spadding,keySize:keySize,cipher:"aes",salt:salt,plaintext:plaintext,time:time,status:msg_status};return json}
function generate_salt(b){var c=Crypto.util.randomBytes(b);var a=Crypto.util.bytesToHex(c);return a}
function generate_iv(c){var b=Crypto.util.randomBytes(c);var a=Crypto.util.bytesToHex(b);return a}
function getMode(){var a=null;if(block==="CBC"){a=CryptoJS.mode.CBC}else{if(block==="ECB"){a=CryptoJS.mode.ECB}else{if(block==="CFB"){a=CryptoJS.mode.CFB}else{if(block==="OFB"){a=CryptoJS.mode.OFB}else{if(block==="CTR"){a=CryptoJS.mode.CTR}}}}}
return a}
function cmdResetFormClick(){if((document.getElementById("txtPlaintext")==null)||(document.getElementById("txtCiphertext")==null)||(document.getElementById("txtVerification")==null)||(document.getElementById("txtMessages")==null)||(document.getElementById("passphrase")==null)){alert("form non valid!");return false}
document.getElementById("txtPlaintext").value=_text;document.getElementById("lenPlaintext").innerHTML=_text.length;document.getElementById("txtCiphertext").value="";document.getElementById("iv").value="";document.getElementById("txtVerification").value="";document.getElementById("txtMessages").value="";document.getElementById("passphrase").value="";if((document.getElementById("selKeySize")==null)||(document.getElementById("selMode")==null)||(document.getElementById("selPad")==null)){alert("select invalid!");return false}
objK=document.getElementById("selKeySize");objK.value=128;objM=document.getElementById("selMode");objM.value="CBC";objP=document.getElementById("selPad");objP.value="Pkcs7";spadding="Pkcs7";block="CBC";_keySizeInBits=128;_keySize=_keySizeInBits/8;en_time="";de_time="";resetDivAndButton()}
function selBlockChange(a){if((a==="OFB")||(a==="CBC")||(a==="CFB")||(a==="CTR")||(a==="ECB")){block=a;return true}
return false}
function selPadChange(b){spadding=b;var a=null;if(b==="Iso97971"){a=CryptoJS.pad.Iso97971}else{if(b==="AnsiX923"){a=CryptoJS.pad.AnsiX923}else{if(b==="Iso10126"){a=CryptoJS.pad.Iso10126}else{if(b==="Pkcs7"){a=CryptoJS.pad.Pkcs7}else{if(b==="ZeroPadding"){a=CryptoJS.pad.ZeroPadding}else{if(b==="NoPadding"){a=CryptoJS.pad.NoPadding}}}}}}
return a};