unit uBase32;

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

function Encode(data: TBytes): String;
function Decode(data: String): TBytes;

const

  DefaultAlphabet: Array [0 .. 31] of String = ('A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z', '2', '3', '4', '5', '6', '7');

  DefaultSpecial = '=';

implementation

function Encode(data: TBytes): String;
var
  dataLength, i, length5, tempInt: Integer;
  tempResult: TStringBuilder;
  x1, x2: byte;
begin
  dataLength := Length(data);
  tempResult := TStringBuilder.Create;
  tempResult.Clear;
  try

    length5 := (dataLength div 5) * 5;
    i := 0;
    while i < length5 do
    begin
      x1 := data[i];
      tempResult.Append(DefaultAlphabet[x1 shr 3]);

      x2 := data[i + 1];
      tempResult.Append(DefaultAlphabet[((x1 shl 2) and $1C) or (x2 shr 6)]);
      tempResult.Append(DefaultAlphabet[(x2 shr 1) and $1F]);

      x1 := data[i + 2];
      tempResult.Append(DefaultAlphabet[((x2 shl 4) and $10) or (x1 shr 4)]);

      x2 := data[i + 3];
      tempResult.Append(DefaultAlphabet[((x1 shl 1) and $1E) or (x2 shr 7)]);
      tempResult.Append(DefaultAlphabet[(x2 shr 2) and $1F]);

      x1 := data[i + 4];
      tempResult.Append(DefaultAlphabet[((x2 shl 3) and $18) or (x1 shr 5)]);
      tempResult.Append(DefaultAlphabet[x1 and $1F]);
      Inc(i, 5);

    end;

    tempInt := dataLength - length5;

    Case tempInt of
      1:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 3]);
          tempResult.Append(DefaultAlphabet[(x1 shl 2) and $1C]);

          tempResult.Append(DefaultSpecial, 4);

        end;

      2:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 3]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 2) and $1C) or
            (x2 shr 6)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 1) and $1F]);
          tempResult.Append(DefaultAlphabet[(x2 shl 4) and $10]);

          tempResult.Append(DefaultSpecial, 3);

        end;
      3:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 3]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 2) and $1C) or
            (x2 shr 6)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 1) and $1F]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 4) and $10) or
            (x1 shr 4)]);
          tempResult.Append(DefaultAlphabet[(x1 shl 1) and $1E]);

          tempResult.Append(DefaultSpecial, 2);

        end;
      4:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 3]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 2) and $1C) or
            (x2 shr 6)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 1) and $1F]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 4) and $10) or
            (x1 shr 4)]);
          x2 := data[i + 3];
          tempResult.Append(DefaultAlphabet[((x1 shl 1) and $1E) or
            (x2 shr 7)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 2) and $1F]);
          tempResult.Append(DefaultAlphabet[(x2 shl 3) and $18]);

          tempResult.Append(DefaultSpecial);

        end;
    end;
    result := tempResult.ToString;
  finally
    tempResult.Free;
  end;

end;

function Decode(data: String): TBytes;
var
  lastSpecialInd, tailLength, length5, i, srcInd, x1, x2, x3, x4, x5, x6, x7,
    x8: Integer;

begin
  if isNullOrEmpty(data) then

  begin
    SetLength(result, 1);
    result := Nil;
    Exit;
  end;
  lastSpecialInd := Length(data);
  while (data[lastSpecialInd] = DefaultSpecial) do
  begin
    dec(lastSpecialInd);
  end;
  tailLength := Length(data) - lastSpecialInd;
  SetLength(result, (((Length(data)) + 7) div 8 * 5 - tailLength));
  length5 := Length(result) div 5 * 5;
  i := 0;
  srcInd := 0;
  Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
  while i < length5 do
  begin
    Inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x3 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x4 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x5 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x6 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x7 := InvAlphabet[Ord(data[srcInd])];
    Inc(srcInd);
    x8 := InvAlphabet[Ord(data[srcInd])];

    result[i] := byte((x1 shl 3) or ((x2 shr 2) and $07));
    result[i + 1] := byte((x2 shl 6) or ((x3 shl 1) and $3E) or
      ((x4 shr 4) and $01));
    result[i + 2] := byte((x4 shl 4) or ((x5 shr 1) and $F));
    result[i + 3] := byte((x5 shl 7) or ((x6 shl 2) and $7C) or
      ((x7 shr 3) and $03));
    result[i + 4] := byte((x7 shl 5) or (x8 and $1F));
    Inc(i, 5);
  end;

  case tailLength of
    4:
      begin
        Inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := byte((x1 shl 3) or ((x2 shr 2) and $07));
      end;
    3:
      begin
        Inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x3 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x4 := InvAlphabet[Ord(data[srcInd])];

        result[i] := byte((x1 shl 3) or ((x2 shr 2) and $07));
        result[i + 1] := byte((x2 shl 6) or ((x3 shl 1) and $3E) or
          ((x4 shr 4) and $01));
      end;
    2:
      begin
        Inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x3 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x4 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x5 := InvAlphabet[Ord(data[srcInd])];

        result[i] := byte((x1 shl 3) or ((x2 shr 2) and $07));
        result[i + 1] := byte((x2 shl 6) or ((x3 shl 1) and $3E) or
          ((x4 shr 4) and $01));
        result[i + 2] := byte((x4 shl 4) or ((x5 shr 1) and $F));
      end;
    1:
      begin
        Inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x3 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x4 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x5 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x6 := InvAlphabet[Ord(data[srcInd])];
        Inc(srcInd);
        x7 := InvAlphabet[Ord(data[srcInd])];

        result[i] := byte((x1 shl 3) or ((x2 shr 2) and $07));
        result[i + 1] := byte((x2 shl 6) or ((x3 shl 1) and $3E) or
          ((x4 shr 4) and $01));
        result[i + 2] := byte((x4 shl 4) or ((x5 shr 1) and $F));
        result[i + 3] := byte((x5 shl 7) or ((x6 shl 2) and $7C) or
          ((x7 shr 3) and $03));
      end;
  end;
  result := result;

end;

end.
