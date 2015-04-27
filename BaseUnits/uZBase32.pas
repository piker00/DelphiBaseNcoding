unit uZBase32;

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
  System.SysUtils, System.Math, Generics.Collections, uBase;

function Encode(data: TBytes): String;
function Decode(data: String): TBytes;
function CreateIndexByOctetAndMovePosition(data: String;
  currentPosition: Integer; index: array of Integer): Integer;

Const
  DefaultAlphabet: Array [0 .. 31] of String = ('y', 'b', 'n', 'd', 'r', 'f',
    'g', '8', 'e', 'j', 'k', 'm', 'c', 'p', 'q', 'x', 'o', 't', '1', 'u', 'w',
    'i', 's', 'z', 'a', '3', '4', '5', 'h', '7', '6', '9');

  DefaultSpecial = Char(0);

var
  tempIndex: array of Integer;

implementation

function Encode(data: TBytes): String;
var
  encodedResult: TStringBuilder;
  i, j, byteCount, bitCount, dataLength, index: Integer;
  buffer: UInt64;

begin
  dataLength := Length(data);
  encodedResult := TStringBuilder.Create;
  encodedResult.Clear;
  try
    i := 0;
    while i < dataLength do
    begin
      byteCount := Min(5, dataLength - i);
      buffer := 0;
      j := 0;
      while j < byteCount do
      begin
        buffer := (buffer shl 8) or data[i + j];
        inc(j);
      end;
      bitCount := byteCount * 8;
      while (bitCount > 0) do

      begin
        if bitCount >= 5 then
        begin

          index := Int32(buffer shr (bitCount - 5)) and $1F;
        end
        else
        begin

          index := Int32(buffer) and UInt64($1F shr (5 - bitCount))
            shl (5 - bitCount);

        end;
        encodedResult.Append(DefaultAlphabet[index]);

        dec(bitCount, 5);
      end;

      inc(i, 5);
    end;
    result := encodedResult.ToString;
  finally
    encodedResult.Free;
  end;
end;

function CreateIndexByOctetAndMovePosition(data: String;
  currentPosition: Integer; index: array of Integer): Integer;
var
  j: Integer;
  tempdata: String;

begin

  j := 0;
  SetLength(tempIndex, Length(index));
  tempdata := data;
  while (j < 8) do
  begin
    if (currentPosition >= Length(tempdata)) then
    begin
      inc(j);
      tempIndex[j] := -1;
      continue;
    end;

    if (InvAlphabet[Ord(tempdata[currentPosition + 1])] = -1) then
    begin
      inc(currentPosition);
      continue;
    end;

    tempIndex[j] := Ord(tempdata[currentPosition + 1]);
    inc(j);
    inc(currentPosition);
  end;

  result := currentPosition;

end;

function Decode(data: String): TBytes;
var
  tempResult: TList<Byte>;
  index: array of Integer;
  i, j, shortByteCount, bitCount: Integer;
  buffer: UInt64;
begin
  if isNullOrEmpty(data) then

  begin
    SetLength(result, 1);
    result := Nil;
    Exit;
  end;
  tempResult := TList<Byte>.Create;
  tempResult.Capacity := Int32(Ceil((Length(data)) * 5.0 / 8.0));
  try
    Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
    SetLength(index, 8);
    i := 0;
    tempResult.Clear;
    while i < (Length(data)) do

    begin
      i := CreateIndexByOctetAndMovePosition(data, i, index);

      shortByteCount := 0;

      buffer := 0;
      j := 0;

      while j < 8 do
      begin
        if tempIndex[j] <> -1 then

        begin
          buffer := UInt64(buffer shl 5) or
            UInt64(InvAlphabet[tempIndex[j]] and $1F);
          inc(shortByteCount);
        end;
        inc(j);
      end;

      bitCount := shortByteCount * 5;
      while (bitCount >= 8) do
      begin
        tempResult.Add(Byte((buffer shr (bitCount - 8)) and $FF));
        bitCount := bitCount - 8;
      end;

    end;
    result := tempResult.ToArray;
  finally
    tempResult.Free;
    tempIndex := nil;

  end;

end;

end.
