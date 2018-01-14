unit SampleTestUnit;

interface

uses TestFramework, System.Encoding;

type
   TSampleTest = class (TTestCase)
      private
         FField : Integer;
      public
         procedure Setup; override;
         procedure Teardown; override;

      published
         procedure CheckField;
         procedure ThisOneFails;
         procedure CheckSetupisOK;
   end;

type
   TBase64Test = class (TTestCase)
      private

      public

      published
         procedure Empty;
         procedure AlphaOmega;
         procedure Uniform;
         procedure WarleyIsHuman;
   end;

   THTMLTextTest = class (TTestCase)
      private

      public

      published
         procedure BasicEncode;
   end;

Type
   TNumbers = array[1..13] of Integer;
   TRomans = array[1..13] of string;
var
   number: TNumbers;
   roman: TRomans;

type
   TTest001 = class (TTestCase)
      private
      { private declarations }
        FField: String;
        procedure Setup; override;
        procedure Teardown; override;
      public
      { public declarations }
      published
         procedure CheckRomanNumber;
   end;

implementation

procedure TSampleTest.Setup;
begin
   FField:=123;
end;

procedure TSampleTest.Teardown;
begin
   FField:=0;
end;

procedure TSampleTest.CheckField;
begin
   Equal(123, FField, 'my field');
end;

procedure TSampleTest.ThisOneFails;
begin
   Equal(456, FField, 'kaboom');
end;

procedure TSampleTest.CheckSetupisOK;
begin
 CheckNoException(Setup, 'Setup failed');
end;

procedure TBase64Test.Empty;
begin
   Equal('', Base64Encoder.Encode(''), 'Encode');
   Equal('', Base64Encoder.Decode(''), 'Decode');
end;

procedure TBase64Test.AlphaOmega;
begin
   Equal('YWxwaGEJb21lZ2E=', Base64Encoder.Encode('alpha'#9'omega'), 'Encode');
   Equal('alpha'#9'omega', Base64Encoder.Decode('YWxwaGEJb21lZ2E='), 'Decode');
end;

procedure TBase64Test.Uniform;
begin
   for var i:=0 to 16 do begin
      var s := StringOfChar('a', i);
      var e := Base64Encoder.Encode(s);
      Equal(s, Base64Encoder.Decode(e), i.ToString);
   end;
end;

procedure TBase64Test.WarleyIsHuman;
begin
 var warleyx := 'On';
 Check(warleyx='ON', 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%} );
 Check(warleyx='On', 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%});
end;

procedure THTMLTextTest.BasicEncode;
begin
   Equal('', HTMLTextEncoder.Encode(''));
   Equal('&lt;a&gt;', HTMLTextEncoder.Encode('<a>'));
   Equal('&amp;gt;', HTMLTextEncoder.Encode('&gt;'));
end;

procedure SetSigns;
begin
   number[1]:= 1;
   number[2]:= 4;
   number[3]:= 5;
   number[4]:= 9;
   number[5]:= 10;
   number[6]:= 40;
   number[7]:= 50;
   number[8]:= 90;
   number[9]:= 100;
   number[10]:= 400;
   number[11]:= 500;
   number[12]:= 900;
   number[13]:= 1000;
  {Romans: array[1..13] of string =
    ('I', 'IV', 'V', 'IX', 'X', 'XL',
    'L', 'XC', 'C', 'CD', 'D', 'CM', 'M');}
   roman[1]:= 'I';
   roman[2]:= 'IV';
   roman[3]:= 'V';
   roman[4]:= 'IX';
   roman[5]:= 'X';
   roman[6]:= 'XL';
   roman[7]:= 'L';
   roman[8]:= 'XC';
   roman[9]:= 'C';
   roman[10]:= 'CD';
   roman[11]:= 'D';
   roman[12]:= 'CM';
   roman[13]:= 'M';
end;

  function DecToRoman(Decimal: Integer): string;
  var
    i: Integer;
  begin
    Result:= '';
    for i:= 13 downto 1 do
      while (Decimal >= Number[i]) do begin
        Decimal:= Decimal - Number[i];
        Result:= Result + Roman[i];
      end;
  end;

procedure TTest001.Setup;
begin
   SetSigns;
   FField := DecToRoman(666);
end;

procedure TTest001.Teardown;
begin
   FField:='III'
end;

procedure TTest001.CheckRomanNumber;
begin
  Equal('DCLXVI', FField, 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%});
  Equal('L', DecToRoman(50), 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%});
  Equal('D', DecToRoman(500), 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%});
  Equal(DecToRoman(1976), 'MCMLXXV1', 'an error has occurred at '+{$I %FUNCTION%} + ' line: '+{$I %LINE%});
end;

initialization
TTestFrameWork.Register({$I %file%}, TBase64Test);
TTestFrameWork.Register({$I %file%}, THTMLTextTest);
TTestFrameWork.Register({$I %file%}, TTest001);
TTestFrameWork.Register({$I %file%}, TSampleTest);
