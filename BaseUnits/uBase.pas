unit uBase;

{
  Copyright (c) 2015 Ugochukwu Mmaduekwe ugo4brain@gmail.com

  This software is provided 'as-is', without any express or implied
  warranty. In no event will the authors be held liable for any damages
  arising from the use of this software.
  Permission is granted to anyone to use this software for any purpose,
  including commercial applications, and to alter it and redistribute it
  freely, subject to the following restrictions:

  1. The origin of this software must not be misrepresented; you must not
  claim that you wrote the original software. If you use this software
  in a product, an acknowledgment in the product documentation would be
  appreciated but is not required.

  2. Altered source versions must be plainly marked as such, and must not be
  misrepresented as being the original software.

  3. This notice may not be removed or altered from any source distribution.

}

interface

uses
  System.Math, System.SysUtils;

var
  InvAlphabet: array of Integer;
  bitsPerChar, BlockBitsCount, BlockCharsCount: Integer;

function IsPowerOf2(x: LongWord): Boolean;
function LCM(a, b: Integer): Integer;
function NextPowOf2(x: LongWord): LongWord;
function IntPow(x: UInt64; exp: Integer): UInt64;
function LogBase2(x: LongWord): Integer; overload;
function LogBase2(x: UInt64): Integer; overload;
function LogBaseN(x, n: LongWord): Integer; overload;
function LogBaseN(x: UInt64; n: LongWord): Integer; overload;
function GetOptimalBitsCount(charsCount: LongWord;
  out charsCountInBits: LongWord; maxBitsCount: LongWord;
  radix: LongWord): Integer;
function GetOptimalBitsCount2(charsCount: LongWord;
  out charsCountInBits: LongWord; maxBitsCount: LongWord;
  base2BitsCount: Boolean): Integer;
procedure Base(charsCount: LongWord; alphabet: array of string; special: char);
function CustomMatchStr(InChar: char; InArray: array of String): Boolean;
function RetreiveMax(InArray: array of String): Integer;
function StartsWith(InStringOne, InStringTwo: String): Boolean;
function EndsWith(InStringOne, InStringTwo: String): Boolean;
function IsNullOrEmpty(const InValue: string): Boolean;
function ArraytoString(InArray: array of String): String;

Const
  EncodingArray: array [0 .. 6] of String = ('ANSI', 'ASCII',
    'BigEndianUnicode', 'Default', 'Unicode', 'UTF7', 'UTF8');

  BasetoUseArray: array [0 .. 8] of String = ('Base32', 'Base64', 'Base85',
    'Base91', 'Base128', 'Base256', 'Base1024', 'Base4096', 'ZBase32');

implementation

function ArraytoString(InArray: array of String): String;
var
  i: Integer;
  tempSList: TStringBuilder;
begin
  tempSList := TStringBuilder.Create;
  tempSList.Clear;
  try
    for i := Low(InArray) to High(InArray) do
    begin
      tempSList.Append(InArray[i])
    end;
    result := tempSList.ToString;
  finally
    tempSList.Free;
  end;

end;

function IsNullOrEmpty(const InValue: string): Boolean;

const
  Empty = '';

begin
  result := InValue = Empty;
end;

function StartsWith(InStringOne, InStringTwo: String): Boolean;
var
  tempStr: String;
begin

  tempStr := Copy(InStringOne, 1, 2);

  result := SameText(tempStr, InStringTwo);

end;

function EndsWith(InStringOne, InStringTwo: String): Boolean;
var
  tempStr: string;
begin

  tempStr := Copy(InStringOne, Length(InStringOne) - 1, 2);

  result := SameText(tempStr, InStringTwo);

end;

function RetreiveMax(InArray: array of String): Integer;
var
  i, MaxOrdinal, te: Integer;
begin
  MaxOrdinal := -1;
  for i := Low(InArray) to High(InArray) do
  begin
    te := Ord(InArray[i][1]);
    MaxOrdinal := Max(MaxOrdinal, te);
  end;
  if MaxOrdinal = -1 then
  begin
    raise Exception.Create('A Strange Error Occurred');
  end
  else
    result := MaxOrdinal;
end;

function IsPowerOf2(x: LongWord): Boolean;
var
  xint: LongWord;
begin
  xint := LongWord(x);

  if (x - xint <> 0) then

    result := False
  else

    result := (xint and (xint - 1)) = 0;
end;

function LCM(a, b: Integer): Integer;
var
  num1, num2, i: Integer;

begin

  if (a > b) then
  begin
    num1 := a;
    num2 := b;
  end

  else
  begin
    num1 := b;
    num2 := a;
  end;

  for i := 1 to (num2) do

  begin
    if ((num1 * i) mod num2 = 0) then
    begin
      result := i * num1;
      exit;
    end;

  end;
  result := num2;

end;

function NextPowOf2(x: LongWord): LongWord;

begin
  dec(x);
  x := x or (x shr 1);
  x := x or (x shr 2);
  x := x or (x shr 4);
  x := x or (x shr 8);
  x := x or (x shr 16);
  inc(x);
  result := x;

end;

function IntPow(x: UInt64; exp: Integer): UInt64;
var
  tempResult: UInt64;
  i: Integer;
begin
  tempResult := 1;
  for i := 0 to Pred(exp) do
  begin
    tempResult := tempResult * x;
  end;
  result := tempResult;

end;

function LogBase2(x: LongWord): Integer; overload;
var
  r: Integer;
begin
  r := 0;
  x := x shr 1;
  while ((x) <> 0) do
  begin
    inc(r);
    x := x shr 1;
  end;
  result := r;

end;

function LogBase2(x: UInt64): Integer; overload;
var
  r: Integer;
begin
  r := 0;
  x := x shr 1;
  while ((x) <> 0) do
  begin
    inc(r);
    x := x shr 1;
  end;
  result := r;

end;

function LogBaseN(x, n: LongWord): Integer; overload;
var
  r: Integer;
begin
  r := 0;
  x := x div n;
  while ((x) <> 0) do
  begin
    inc(r);
    x := x div n;
  end;
  result := r;
end;

function LogBaseN(x: UInt64; n: LongWord): Integer; overload;
var
  r: Integer;
begin
  r := 0;
  x := x div n;
  while ((x) <> 0) do
  begin
    inc(r);
    x := x div n;
  end;
  result := r;
end;

function GetOptimalBitsCount(charsCount: LongWord;
  out charsCountInBits: LongWord; maxBitsCount: LongWord;
  radix: LongWord): Integer;
var
  charsCountLog, maxRatio, ratio: Double;
  n, n1: Integer;
  l1: LongWord;

begin
  result := 0;
  charsCountInBits := 0;
  n1 := LogBaseN(charsCount, radix);
  charsCountLog := LogN(charsCount, radix);
  maxRatio := 0;

  n := n1;
  while (UInt32(n) <= maxBitsCount) do
  begin
    l1 := UInt32(Ceil(n * charsCountLog));
    ratio := (n) / l1;
    if (ratio > maxRatio) then
    begin
      maxRatio := ratio;
      result := n;
      charsCountInBits := l1;
    end;
    inc(n);
  end;

  result := result;
end;

function GetOptimalBitsCount2(charsCount: LongWord;
  out charsCountInBits: LongWord; maxBitsCount: LongWord;
  base2BitsCount: Boolean): Integer;

var
  n, n1: Integer;
  charsCountLog, ratio, maxRatio: Double;
  l1: LongWord;
begin
  result := 0;
  charsCountInBits := 0;
  n1 := LogBase2(charsCount);
  charsCountLog := LogN(charsCount, 2);
  maxRatio := 0;

  for n := n1 to maxBitsCount do

  begin

    if ((Ord(base2BitsCount) and (n mod 8)) <> 0) then
      continue;
    l1 := UInt32(Ceil(n * charsCountLog));

    ratio := (n) / l1;

    if (ratio > maxRatio) then
    begin
      maxRatio := ratio;
      result := n;
      charsCountInBits := l1;
    end;

  end;

  result := result;

end;

procedure Base(charsCount: LongWord; alphabet: array of string; special: char);
var
  i, j, alphabetMax: Integer;

begin
  if ((UInt32(Length(alphabet))) <> charsCount) then
    raise Exception.Create('Base array should contain ' + InttoStr(charsCount) +
      ' chars');

  for i := 0 to Pred(charsCount) do
  begin
    for j := Succ(i) to Pred(charsCount) do
    begin
      if (alphabet[i] = alphabet[j]) then
        raise Exception.Create

          ('Base array should contain should contain distinct chars');

    end;

  end;

  if CustomMatchStr(special, alphabet) then
    raise Exception.Create('Base array should not contain special char');

  if (charsCount = 85) then
  begin
    BlockBitsCount := 32;
    BlockCharsCount := 5;
  end;

  if (charsCount = 91) then
  begin
    BlockBitsCount := 13;
    BlockCharsCount := 2;
  end;

  if (charsCount <> 85) and (charsCount <> 91) then

  begin
    bitsPerChar := LogBase2(charsCount);
    BlockBitsCount := LCM(bitsPerChar, 8);
    BlockCharsCount := BlockBitsCount div bitsPerChar;
  end;

  alphabetMax := RetreiveMax(alphabet);
  SetLength(InvAlphabet, alphabetMax + 1);

  for i := 0 to Pred(Length(InvAlphabet)) do
  begin
    InvAlphabet[i] := -1;
  end;

  for i := 0 to Pred(charsCount) do
  begin
    InvAlphabet[Ord(alphabet[i][1])] := i;
  end;

end;

function CustomMatchStr(InChar: char; InArray: array of String): Boolean;
var
  i: Integer;

begin
  result := False;
  for i := Low(InArray) to High(InArray) do

  begin
    if InArray[i] = InChar then
    begin
      exit(True);
    end;
  end;

end;

end.
