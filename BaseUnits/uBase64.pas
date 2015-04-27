unit uBase64;

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
  System.SysUtils, uBase;

var
  tempResult: array of String;
  tempResultDecode: TBytes;

function Encode(data: TBytes): String;
function Decode(data: String): TBytes;
procedure EncodeBlock(src: TBytes; beginInd, endInd: Integer);
procedure DecodeBlock(src: String; beginInd, endInd: Integer);

Const

  DefaultAlphabet: Array [0 .. 63] of String = ('A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
    'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '+', '/');

  DefaultSpecial = '=';

implementation

procedure EncodeBlock(src: TBytes; beginInd, endInd: Integer);
var
  ind, srcInd, dstInd: Integer;
  x1, x2, x3: byte;

begin
  for ind := beginInd to Pred(endInd) do
  begin
    srcInd := ind * 3;
    dstInd := ind * 4;
    x1 := src[srcInd];
    x2 := src[srcInd + 1];
    x3 := src[srcInd + 2];

    tempResult[dstInd] := DefaultAlphabet[x1 shr 2];
    tempResult[dstInd + 1] := DefaultAlphabet[((x1 shl 4) and $30) or
      (x2 shr 4)];
    tempResult[dstInd + 2] := DefaultAlphabet[((x2 shl 2) and $3C) or
      (x3 shr 6)];
    tempResult[dstInd + 3] := DefaultAlphabet[x3 and $3F];
  end;
end;

procedure DecodeBlock(src: String; beginInd, endInd: Integer);
var
  ind, srcInd, dstInd, x1, x2, x3, x4: Integer;

begin

  for ind := beginInd to endInd do

  begin
    srcInd := ind * 4;
    dstInd := ind * 3;

    x1 := InvAlphabet[Ord(src[srcInd + 1])];
    x2 := InvAlphabet[Ord(src[srcInd + 2])];
    x3 := InvAlphabet[Ord(src[srcInd + 3])];
    x4 := InvAlphabet[Ord(src[srcInd + 4])];

    tempResultDecode[dstInd] := byte((x1 shl 2) or ((x2 shr 4) and $3));
    tempResultDecode[dstInd + 1] := byte((x2 shl 4) or ((x3 shr 2) and $F));
    tempResultDecode[dstInd + 2] := byte((x3 shl 6) or (x4 and $3F));

  end;
end;

function Encode(data: TBytes): String;
var
  resultLength, dataLength, tempInt, length3, ind, x1, x2, srcInd,
    dstInd: Integer;
begin
  dataLength := Length(data);
  resultLength := (dataLength + 2) div 3 * 4;
  SetLength(tempResult, resultLength);
  length3 := Length(data) div 3;
  EncodeBlock(data, 0, length3);

  tempInt := (dataLength - length3 * 3);

  case tempInt of
    1:
      begin
        ind := length3;
        srcInd := ind * 3;
        dstInd := ind * 4;
        x1 := data[srcInd];
        tempResult[dstInd] := DefaultAlphabet[x1 shr 2];
        tempResult[dstInd + 1] := DefaultAlphabet[(x1 shl 4) and $30];
        tempResult[dstInd + 2] := DefaultSpecial;
        tempResult[dstInd + 3] := DefaultSpecial;

      end;
    2:
      begin
        ind := length3;
        srcInd := ind * 3;
        dstInd := ind * 4;
        x1 := data[srcInd];
        x2 := data[srcInd + 1];
        tempResult[dstInd] := DefaultAlphabet[x1 shr 2];
        tempResult[dstInd + 1] := DefaultAlphabet
          [((x1 shl 4) and $30) or (x2 shr 4)];
        tempResult[dstInd + 2] := DefaultAlphabet[(x2 shl 2) and $3C];
        tempResult[dstInd + 3] := DefaultSpecial;

      end;
  end;
  result := ArraytoString(tempResult);
  tempResult := nil;
end;

function Decode(data: String): TBytes;
var
  lastSpecialInd, tailLength, resultLength, length4, ind, x1, x2, x3, srcInd,
    dstInd: Integer;

begin
  if isNullOrEmpty(data) then

  begin
    SetLength(result, 1);
    result := [0];
    Exit;
  end;
  lastSpecialInd := Length(data);

  while (data[lastSpecialInd] = DefaultSpecial) do
  begin
    dec(lastSpecialInd);
  end;
  tailLength := Length(data) - lastSpecialInd;
  resultLength := (Length(data) + 3) div 4 * 3 - tailLength;
  SetLength(tempResultDecode, resultLength);
  length4 := (Length(data) - tailLength) div 4;
  Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
  DecodeBlock(data, 0, length4);
  Case tailLength of
    2:
      begin
        ind := length4;
        srcInd := ind * 4;
        dstInd := ind * 3;
        x1 := InvAlphabet[Ord(data[srcInd + 1])];
        x2 := InvAlphabet[Ord(data[srcInd + 2])];
        tempResultDecode[dstInd] := byte((x1 shl 2) or ((x2 shr 4) and $3));
      end;
    1:
      begin
        ind := length4;
        srcInd := ind * 4;
        dstInd := ind * 3;
        x1 := InvAlphabet[Ord(data[srcInd + 1])];
        x2 := InvAlphabet[Ord(data[srcInd + 2])];
        x3 := InvAlphabet[Ord(data[srcInd + 3])];
        tempResultDecode[dstInd] := byte((x1 shl 2) or ((x2 shr 4) and $3));
        tempResultDecode[dstInd + 1] := byte((x2 shl 4) or ((x3 shr 2) and $F));
      end;
  end;
  result := tempResultDecode;
  tempResultDecode := nil;
end;

end.
