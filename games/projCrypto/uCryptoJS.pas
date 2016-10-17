unit uCryptoJS;

interface

uses W3C.TypedArray;

{ fowards declarations }
type
  JC = variant;
  JLibStatic = class;
  JEncStatic = class;
  JKdfStatic = class;
  JFormatStatic = class;
  JAlgoStatic = class;
  JModeStatic = class;
  JPadStatic = class;
  JX64Static = class;
  JICipherHelper = class;
  JHasherHelper = class;
  JCipherHelper = class;
  JIHasherHmacHelper = class;
  JIHasherHelper = class;
  JIEvpKDFHelper = class;
  JIEncoder = class;
  JHasher = class;
  JCipher = class;
  JIBlockCipherEncryptor = class;
  JIBlockCipherDecryptor = class;
  JIBlockCipherModeImpl = class;
  JIPaddingImpl = class;
  JWordArray = class;
  JIFormatter = class;
  JIKdfImpl = class;
  JCipherParamsData = class;
  JAES = class;
  JDES = class;
  JTripleDES = class;
  JRabbitLegacy = class;
  JRabbit = class;
  JRC4 = class;
  JMD5 = class;
  JRIPEMD160 = class;
  JSHA1 = class;
  JSHA256 = class;
  JSHA224 = class;
  JSHA384 = class;
  JSHA512 = class;
  JSHA3 = class;
  JHMAC = class;
  JEvpKDF = class;
  JPBKDF2 = class;
  JRC4Drop = class;
  JIEvpKDFCfg = class;
  JCBC = class;
  JCFB = class;
  JCTR = class;
  JCTRGladman = class;
  JECB = class;
  JOFB = class;
  JPkcs7 = class;
  JAnsiX923 = class;
  JIso10126 = class;
  JIso97971 = class;
  JZeroPadding = class;
  JNoPadding = class;
  JIEncoderDecoder = class;
  JWord = class;

type
  JCryptoJS = class external  'CryptoJS'
    lib: JLibStatic;
    enc: JEncStatic;
    kdf: JKdfStatic;
    format: JFormatStatic;
    algo: JAlgoStatic;
    mode: JModeStatic;
    pad: JPadStatic;
    x64: JX64Static;
    AES: JICipherHelper;
    DES:  JICipherHelper;
    TripleDES: JICipherHelper;
    RabbitLegacy: JCipherHelper;
    Rabbit: JCipherHelper;
    RC4: JCipherHelper;
    RC4Drop: JICipherHelper{<JObject>};
    MD5: JHasherHelper;
    HmacMD5: JIHasherHmacHelper;
    RIPEMD160: JHasherHelper;
    HmacRIPEMD160: JIHasherHmacHelper;
    SHA1: JHasherHelper;
    HmacSHA1: JIHasherHmacHelper;
    SHA256: JHasherHelper;
    HmacSHA256: JIHasherHmacHelper;
    SHA224: JHasherHelper;
    HmacSHA224: JIHasherHmacHelper;
    SHA512: JHasherHelper;
    HmacSHA512: JIHasherHmacHelper;
    SHA384: JHasherHelper;
    HmacSHA384: JIHasherHmacHelper;
    SHA3: JIHasherHelper;
    HmacSHA3: JIHasherHmacHelper;
    EvpKDF: JIEvpKDFHelper;
    PBKDF2: JIEvpKDFHelper;
  end;

/* ### lib ### */

type
  JBase = class external
    function extend(overrides: JObject): JObject;
    procedure init(args: array of Variant);
    function create(args: array of Variant): JBase;
    procedure mixIn(properties: JObject);
    function clone: JBase;
  end;

  JWordArray = class external(JBase)
    words: array of Float;
    sigBytes: Float;
    procedure init; overload;
    procedure init(words: array of Float); overload;
    procedure init(words: array of Float; sigBytes: Float); overload;
    function create: JWordArray; overload;
    function create(words: array of Float): JWordArray; overload;
    function create(words: array of Float; sigBytes: Float): JWordArray; overload;
    procedure init(typedArray: JArrayBuffer); overload;
    procedure init(typedArray: JInt8Array); overload;
    function create(typedArray: JArrayBuffer): JWordArray; overload;
    function create(typedArray: JInt8Array): JWordArray; overload;
    function toString: String; overload;
    function toString(encoder: JIEncoderDecoder): String; overload;
    function concat(wordArray: JWordArray): JWordArray;
    procedure clamp;
    function clone: JWordArray;
    function random(nBytes: Float): JWordArray;
  end;

/*
  JWordArray = class external(JBase)
    words: array of JWord;
    sigBytes: Float;
    procedure init; overload;
    procedure init(words: array of JWord); overload;
    procedure init(words: array of JWord; sigBytes: Float); overload;
    function create: JWordArray; overload;
    function create(words: array of JWord): JWordArray; overload;
    function create(words: array of JWord; sigBytes: Float): JWordArray; overload;
    function toX32: JWordArray;
    function clone: JWordArray;
  end;
*/

  JBufferedBlockAlgorithm = class external(JBase)
    procedure reset;
    function clone: JBufferedBlockAlgorithm;
  end;

  JIHasher = class external(JBufferedBlockAlgorithm)
    cfg: JC;
    procedure init; overload;
    procedure init(cfg: JC); overload;
    function create: JIHasher; overload;
    function create(cfg: JC): JIHasher; overload;
    function update(messageUpdate: String):  JHasher; overload;
    function update(messageUpdate: JWordArray): JHasher; overload;
    function finalize: JWordArray; overload;
    function finalize(messageUpdate: String): JWordArray; overload;
    function finalize(messageUpdate: JWordArray): JWordArray; overload;
    blockSize: Float;
    function _createHelper(hasher: JHasher): JIHasherHelper;
    function _createHmacHelper(hasher: JHasher): JIHasherHmacHelper;
    function clone: JIHasher;
  end;

  JHasher = class external(JIHasher {JObject} )
  end;

  JIHasherHelper = class external
    //function(message: String; cfg: JC): JWordArray;;
    //function(message: JWordArray; cfg: JC): JWordArray;;
  end;

  JHasherHelper = class external(JIHasherHelper {JObject} )
  end;

  JIHasherHmacHelper = class external
    //function(message: String; key: String): JWordArray;;
    //function(message: String; key: JWordArray): JWordArray;;
    //function(message: JWordArray; key: String): JWordArray;;
    //function(message: JWordArray; key: JWordArray): JWordArray;;
  end;

  JICipher = class external(JBufferedBlockAlgorithm)
    cfg: JC;
    function createEncryptor(key: JWordArray): JICipher; overload;
    function createEncryptor(key: JWordArray; cfg: JC): JICipher; overload;
    function createDecryptor(key: JWordArray): JICipher; overload;
    function createDecryptor(key: JWordArray; cfg: JC): JICipher; overload;
    function create: JICipher; overload;
    function create(xformMode: Float): JICipher; overload;
    function create(xformMode: Float; key: JWordArray): JICipher; overload;
    function create(xformMode: Float; key: JWordArray; cfg: JC): JICipher; overload;
    procedure init; overload;
    procedure init(xformMode: Float); overload;
    procedure init(xformMode: Float; key: JWordArray); overload;
    procedure init(xformMode: Float; key: JWordArray; cfg: JC); overload;
    function process(dataUpdate: String): JWordArray; overload;
    function process(dataUpdate: JWordArray): JWordArray; overload;
    function finalize: JWordArray; overload;
    function finalize(dataUpdate: String): JWordArray; overload;
    function finalize(dataUpdate: JWordArray): JWordArray; overload;
    keySize: Float;
    ivSize: Float;
    function _createHelper(cipher: JCipher): JICipherHelper;
    function clone: JICipher;
  end;

  JCipher = class external(JICipher {JObject} )
  end;

  JIStreamCipher = class external(JICipher)
    drop: Float; // nullable
    function createEncryptor(key: JWordArray): JIStreamCipher; overload;
    function createEncryptor(key: JWordArray; cfg: JC): JIStreamCipher; overload;
    function createDecryptor(key: JWordArray): JIStreamCipher; overload;
    function createDecryptor(key: JWordArray; cfg: JC): JIStreamCipher; overload;
    function create: JIStreamCipher; overload;
    function create(xformMode: Float): JIStreamCipher; overload;
    function create(xformMode: Float; key: JWordArray): JIStreamCipher; overload;
    function create(xformMode: Float; key: JWordArray; cfg: JC): JIStreamCipher; overload;
    blockSize: Float;
  end;

  JStreamCipher = class external(JIStreamCipher {JObject} )
  end;

  JBlockCipherMode = class external(JBase)
    function createEncryptor(cipher: JCipher; iv: array of Float): JIBlockCipherEncryptor;
    function createDecryptor(cipher: JCipher; iv: array of Float): JIBlockCipherDecryptor;
    procedure init; overload;
    procedure init(cipher: JCipher); overload;
    procedure init(cipher: JCipher; iv: array of Float); overload;
    function create: JBlockCipherMode; overload;
    function create(cipher: JCipher): JBlockCipherMode; overload;
    function create(cipher: JCipher; iv: array of Float): JBlockCipherMode; overload;
  end;

  JBlockCipher = class external(JIStreamCipher)
  end;

  JIBlockCipherCfg = class external
    iv: JWordArray; // nullable
    mode: JIBlockCipherModeImpl; // nullable
    padding: JIPaddingImpl; // nullable
  end;

  JCipherParamsData = class external
    ciphertext: JWordArray; // nullable
    key: JWordArray; // nullable
    iv: JWordArray; // nullable
    salt: JWordArray; // nullable
    algorithm: JCipher; // nullable
    mode: JIBlockCipherModeImpl; // nullable
    padding: JIPaddingImpl; // nullable
    blockSize: Float; // nullable
    formatter: JIFormatter; // nullable
  end;

  JCipherParams = class external(JBase)
    ciphertext: JWordArray; // nullable
    key: JWordArray; // nullable
    iv: JWordArray; // nullable
    salt: JWordArray; // nullable
    algorithm: JCipher; // nullable
    mode: JIBlockCipherModeImpl; // nullable
    padding: JIPaddingImpl; // nullable
    blockSize: Float; // nullable
    formatter: JIFormatter; // nullable
    procedure init; overload;
    procedure init(cipherParams: JCipherParamsData); overload;
    function create: JCipherParams; overload;
    function create(cipherParams: JCipherParamsData): JCipherParams; overload;
    function toString: String; overload;
    function toString(formatter: JIFormatter): String; overload;
  end;

  JISerializableCipher = class external(JBase)
    cfg: JC;
    function encrypt(cipher: JCipher; message: JWordArray; key: JWordArray): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: JWordArray; key: JWordArray; cfg: JC): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: String; key: JWordArray): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: String; key: JWordArray; cfg: JC): JCipherParams; overload;
    function decrypt(cipher: JCipher; ciphertext: JCipherParamsData; key: JWordArray): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: JCipherParamsData; key: JWordArray; cfg: JC): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: String; key: JWordArray): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: String; key: JWordArray; cfg: JC): JWordArray; overload;
  end;

  JSerializableCipher = class external(JISerializableCipher)
  end;

  JISerializableCipherCfg = class external
    format: JIFormatter; // nullable
    iv: JWordArray; // nullable
    mode: JIBlockCipherModeImpl; // nullable
    padding: JIPaddingImpl; // nullable
  end;

  JIPasswordBasedCipher = class external(JBase)
    cfg: JC;
    function encrypt(cipher: JCipher; message: JWordArray; password: String): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: JWordArray; password: String; cfg: JC): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: String; password: String): JCipherParams; overload;
    function encrypt(cipher: JCipher; message: String; password: String; cfg: JC): JCipherParams; overload;
    function decrypt(cipher: JCipher; ciphertext: JCipherParamsData; password: String): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: JCipherParamsData; password: String; cfg: JC): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: String; password: String): JWordArray; overload;
    function decrypt(cipher: JCipher; ciphertext: String; password: String; cfg: JC): JWordArray; overload;
  end;

  JPasswordBasedCipher = class external(JIPasswordBasedCipher)
  end;

  JIPasswordBasedCipherCfg = class external(JISerializableCipherCfg)
    kdf: JIKdfImpl; // nullable
    mode: JIBlockCipherModeImpl; // nullable
    padding: JIPaddingImpl; // nullable
  end;

  JICipherHelper = class external
    function encrypt(message: String; password: String): JCipherParams; overload;
    function encrypt(message: String; password: String; cfg: JC): JCipherParams; overload;
    function encrypt(message: String; key: JWordArray): JCipherParams; overload;
    function encrypt(message: String; key: JWordArray; cfg: JC): JCipherParams; overload;
    function encrypt(message: JWordArray; password: String): JCipherParams; overload;
    function encrypt(message: JWordArray; password: String; cfg: JC): JCipherParams; overload;
    function encrypt(message: JWordArray; key: JWordArray): JCipherParams; overload;
    function encrypt(message: JWordArray; key: JWordArray; cfg: JC): JCipherParams; overload;
    function decrypt(ciphertext: variant; password: String): JWordArray; overload;
    function decrypt(ciphertext: variant; password: String; cfg: JC): JWordArray; overload;
    function decrypt(ciphertext: variant; key: JWordArray): JWordArray; overload;
    function decrypt(ciphertext: variant; key: JWordArray; cfg: JC): JWordArray; overload;
    function decrypt(ciphertext: JCipherParamsData; password: String): JWordArray; overload;
    function decrypt(ciphertext: JCipherParamsData; password: String; cfg: JC): JWordArray; overload;
    function decrypt(ciphertext: JCipherParamsData; key: JWordArray): JWordArray; overload;
    function decrypt(ciphertext: JCipherParamsData; key: JWordArray; cfg: JC): JWordArray; overload;
  end;

  JCipherHelper = class external(JICipherHelper {JObject} )
  end;

  JLibStatic = class external
    Base: JBase;
    WordArray: JWordArray;
    CipherParams: JCipherParams;
    SerializableCipher: JSerializableCipher;
    PasswordBasedCipher: JPasswordBasedCipher;
  end;

/* ### enc ### */

type
  JIEncoder = class external
    function stringify(wordArray: JWordArray): String;
  end;

  JIDecoder = class external
    function parse(s: String): JWordArray;
  end;

type
  JIEncoderDecoder = class external
    function stringify(wordArray: JWordArray): String;
    function parse(s: String): JWordArray;
  end;

  JICoder = class external(JIEncoderDecoder)
  end;

  JEncStatic = class external
    Hex: JICoder;
    Latin1: JICoder;
    Utf8: JICoder;
    Base64: JICoder;
    Utf16: JICoder;
    Utf16BE: JICoder;
    Utf16LE: JICoder;
  end;

/* ### kdf ### */

type
  JKdfStatic = class external
    OpenSSL: JIKdfImpl;
  end;

  JIKdfImpl = class external
    function execute(password: String; keySize: Float; ivSize: Float): JCipherParams; overload;
    function execute(password: String; keySize: Float; ivSize: Float; salt: String): JCipherParams; overload;
    function execute(password: String; keySize: Float; ivSize: Float; salt: JWordArray): JCipherParams; overload;
  end;


/* ### format ### */
type
  JFormatStatic = class external
    OpenSSL: JIFormatter;
    Hex: JIFormatter;
  end;

  JIFormatter = class external
    function stringify(cipherParams: JCipherParamsData): String;
    function parse(s: String): JCipherParams;
  end;


/* ### algo ### */
type
  JAlgoStatic = class external
    AES: JAES;
    DES: JDES;
    TripleDES: JTripleDES;
    RabbitLegacy: JRabbitLegacy;
    Rabbit: JRabbit;
    RC4: JRC4;
    MD5: JMD5;
    RIPEMD160: JRIPEMD160;
    SHA1: JSHA1;
    SHA256: JSHA256;
    SHA224: JSHA224;
    SHA384: JSHA384;
    SHA512: JSHA512;
    SHA3: JSHA3;
    HMAC: JHMAC;
    EvpKDF: JEvpKDF;
    PBKDF2: JPBKDF2;
    RC4Drop: JRC4Drop;
  end;

  JIBlockCipherImpl = class external(JBlockCipher)
    procedure encryptBlock(M: array of Float; offset: Float);
    procedure decryptBlock(M: array of Float; offset: Float);
    function createEncryptor(key: JWordArray): JIBlockCipherImpl; overload;
    function createEncryptor(key: JWordArray; cfg: JCipherParamsData): JIBlockCipherImpl; overload;
    function createDecryptor(key: JWordArray): JIBlockCipherImpl; overload;
    function createDecryptor(key: JWordArray; cfg: JCipherParamsData): JIBlockCipherImpl; overload;
    function create: JIBlockCipherImpl; overload;
    function create(xformMode: Float): JIBlockCipherImpl; overload;
    function create(xformMode: Float; key: JWordArray): JIBlockCipherImpl; overload;
    function create(xformMode: Float; key: JWordArray; cfg: JIBlockCipherCfg): JIBlockCipherImpl; overload;
  end;

  JAES = class external(JIBlockCipherImpl)
  end;

  JDES = class external(JIBlockCipherImpl)
  end;

  JTripleDES = class external(JIBlockCipherImpl)
  end;

  JRabbitLegacy = class external(JStreamCipher)
  end;

  JRabbit = class external(JStreamCipher)
  end;

  JRC4 = class external(JStreamCipher)
  end;

  JMD5 = class external(JHasher)
  end;

  JRIPEMD160 = class external(JHasher)
  end;

  JSHA1 = class external(JHasher)
  end;

  JSHA256 = class external(JHasher)
  end;

  JSHA224 = class external(JHasher)
  end;

  JSHA384 = class external(JHasher)
  end;

  JSHA512 = class external(JHasher)
  end;

  JSHA3 = class external(JIHasher)
  end;

  JISHA3Cfg = class external
    outputLength: Float; // nullable
  end;

  JHMAC = class external(JBase)
    procedure init; overload;
    procedure init(hasher: JHasher); overload;
    procedure init(hasher: JHasher; key: String); overload;
    procedure init(hasher: JHasher; key: JWordArray); overload;
    function create: JHMAC; overload;
    function create(hasher: JHasher): JHMAC; overload;
    function create(hasher: JHasher; key: String): JHMAC; overload;
    function create(hasher: JHasher; key: JWordArray): JHMAC; overload;
    function update(messageUpdate: String): JHMAC; overload;
    function update(messageUpdate: JWordArray): JHMAC; overload;
    function finalize: JWordArray; overload;
    function finalize(messageUpdate: String): JWordArray; overload;
    function finalize(messageUpdate: JWordArray): JWordArray; overload;
  end;

  JEvpKDF = class external(JBase)
    cfg: JIEvpKDFCfg;
    procedure init; overload;
    procedure init(cfg: JIEvpKDFCfg); overload;
    function create: JEvpKDF; overload;
    function create(cfg: JIEvpKDFCfg): JEvpKDF; overload;
    function compute(password: String; salt: String): JWordArray; overload;
    function compute(password: String; salt: JWordArray): JWordArray; overload;
    function compute(password: JWordArray; salt: String): JWordArray; overload;
    function compute(password: JWordArray; salt: JWordArray): JWordArray; overload;
  end;

  JIEvpKDFCfg = class external
    keySize: Float; // nullable
    hasher: JHasher; // nullable
    iterations: Float; // nullable
  end;

  JIEvpKDFHelper = class external
    //function(password: String; salt: String; cfg: JIEvpKDFCfg): JWordArray;
    //function(password: String; salt: JWordArray; cfg: JIEvpKDFCfg): JWordArray;
    //function(password: JWordArray; salt: String; cfg: JIEvpKDFCfg): JWordArray;
    //function(password: JWordArray; salt: JWordArray; cfg: JIEvpKDFCfg): JWordArray;
  end;

  JPBKDF2 = class external(JEvpKDF)
  end;

  JRC4Drop = class external(JRC4)
  end;

/* ### mode ### */

type
  JModeStatic = class external
    CBC: JCBC;
    CFB: JCFB;
    CTR: JCTR;
    CTRGladman: JCTRGladman;
    ECB: JECB;
    OFB: JOFB;
  end;

  JIBlockCipherEncryptor = class external(JBlockCipherMode)
    procedure processBlock(words: array of Float; offset: Float);
  end;

  JIBlockCipherDecryptor = class external(JBlockCipherMode)
    procedure processBlock(words: array of Float; offset: Float);
  end;

  JIBlockCipherModeImpl = class external(JBlockCipherMode)
    Encryptor: JIBlockCipherEncryptor;
    Decryptor: JIBlockCipherDecryptor;
  end;

  JCBC = class external(JIBlockCipherModeImpl)
  end;

  JCFB = class external(JIBlockCipherModeImpl)
  end;

  JCTR = class external(JIBlockCipherModeImpl)
  end;

  JCTRGladman = class external(JIBlockCipherModeImpl)
  end;

  JECB = class external(JIBlockCipherModeImpl)
  end;

  JOFB = class external(JIBlockCipherModeImpl)
  end;

/* ### pad ### */

type
  JPadStatic = class external
    Pkcs7: JPkcs7;
    AnsiX923: JAnsiX923;
    Iso10126: JIso10126;
    Iso97971: JIso97971;
    ZeroPadding: JZeroPadding;
    NoPadding: JNoPadding;
  end;

  JIPaddingImpl = class external
    procedure pad(data: JWordArray; blockSize: Float);
    procedure unpad(data: JWordArray);
  end;

  JPkcs7 = class external(JIPaddingImpl)
  end;

  JAnsiX923 = class external(JIPaddingImpl)
  end;

  JIso10126 = class external(JIPaddingImpl)
  end;

  JIso97971 = class external(JIPaddingImpl)
  end;

  JZeroPadding = class external(JIPaddingImpl)
  end;

  JNoPadding = class external(JIPaddingImpl)
  end;


//x64

type
  JX64Static = class external
    Word: JWord;
    WordArray: JWordArray;
  end;

  JWord = class external(JBase)
    &high: Float;
    &low: Float;
    procedure init; overload;
    procedure init(highvar: Float); overload;
    procedure init(highvar: Float; lowvar: Float); overload;
    function create: JWord; overload;
    function create(highvar: Float): JWord; overload;
    function create(highvar: Float; lowvar: Float): JWord; overload;
  end;

function cryptoJS: JCryptoJS; external 'CryptoJS' property;

implementation

end.
