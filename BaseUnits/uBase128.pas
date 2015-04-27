unit uBase128;

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

Const
  DefaultAlphabet: Array [0 .. 127] of String = ('!', '#', '$', '%', '(', ')',
    '*', ',', '.', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', ':', ';',
    '-', '@', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', ']',
    '^', '_', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|',
    '}', '~', '¡', '¢', '£', '¤', '¥', '¦', '§', '¨', '©', 'ª', '«', '¬', '®',
    '¯', '°', '±', '²', '³', '´', 'µ', '¶', '·', '¸', '¹', 'º', '»', '¼', '½',
    '¾', '¿', 'À', 'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì',
    'Í', 'Î');

  DefaultSpecial = '=';

implementation

function Encode(data: TBytes): String;
var
  dataLength, i, length7, tempInt: Integer;
  tempResult: TStringBuilder;
  x1, x2: Byte;

begin
  dataLength := Length(data);
  tempResult := TStringBuilder.Create;
  tempResult.Clear;
  try

    length7 := (dataLength div 7) * 7;

    i := 0;
    while i < length7 do
    begin

      x1 := data[i];
      tempResult.Append(DefaultAlphabet[x1 shr 1]);

      x2 := data[i + 1];
      tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or (x2 shr 2)]);

      x1 := data[i + 2];
      tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60) or (x1 shr 3)]);

      x2 := data[i + 3];
      tempResult.Append(DefaultAlphabet[((x1 shl 4) and $70) or (x2 shr 4)]);

      x1 := data[i + 4];
      tempResult.Append(DefaultAlphabet[((x2 shl 3) and $78) or (x1 shr 5)]);

      x2 := data[i + 5];
      tempResult.Append(DefaultAlphabet[((x1 shl 2) and $7C) or (x2 shr 6)]);

      x1 := data[i + 6];
      tempResult.Append(DefaultAlphabet[((x2 shl 1) and $7E) or (x1 shr 7)]);
      tempResult.Append(DefaultAlphabet[x1 and $7F]);
      inc(i, 7);
    end;

    tempInt := dataLength - length7;

    Case tempInt of

      1:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          tempResult.Append(DefaultAlphabet[(x1 shl 6) and $40]);

          tempResult.Append(DefaultSpecial, 6);

        end;
      2:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or
            (x2 shr 2)]);
          tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60)]);

          tempResult.Append(DefaultSpecial, 5);

        end;
      3:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or
            (x2 shr 2)]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60) or
            (x1 shr 3)]);
          tempResult.Append(DefaultAlphabet[(x1 shl 4) and $70]);

          tempResult.Append(DefaultSpecial, 4);

        end;
      4:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or
            (x2 shr 2)]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60) or
            (x1 shr 3)]);
          x2 := data[i + 3];
          tempResult.Append(DefaultAlphabet[((x1 shl 4) and $70) or
            (x2 shr 4)]);
          tempResult.Append(DefaultAlphabet[(x2 shl 3) and $78]);

          tempResult.Append(DefaultSpecial, 3);

        end;
      5:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or
            (x2 shr 2)]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60) or
            (x1 shr 3)]);
          x2 := data[i + 3];
          tempResult.Append(DefaultAlphabet[((x1 shl 4) and $70) or
            (x2 shr 4)]);
          x1 := data[i + 4];
          tempResult.Append(DefaultAlphabet[((x2 shl 3) and $78) or
            (x1 shr 5)]);
          tempResult.Append(DefaultAlphabet[(x1 shl 2) and $7C]);

          tempResult.Append(DefaultSpecial, 2);

        end;
      6:
        begin
          x1 := data[i];
          tempResult.Append(DefaultAlphabet[x1 shr 1]);
          x2 := data[i + 1];
          tempResult.Append(DefaultAlphabet[((x1 shl 6) and $40) or
            (x2 shr 2)]);
          x1 := data[i + 2];
          tempResult.Append(DefaultAlphabet[((x2 shl 5) and $60) or
            (x1 shr 3)]);
          x2 := data[i + 3];
          tempResult.Append(DefaultAlphabet[((x1 shl 4) and $70) or
            (x2 shr 4)]);
          x1 := data[i + 4];
          tempResult.Append(DefaultAlphabet[((x2 shl 3) and $78) or
            (x1 shr 5)]);
          x2 := data[i + 5];
          tempResult.Append(DefaultAlphabet[((x1 shl 2) and $7C) or
            (x2 shr 6)]);
          tempResult.Append(DefaultAlphabet[(x2 shl 1) and $7E]);

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
  lastSpecialInd, tailLength, x1, x2, length7, i, srcInd: Integer;
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
  SetLength(result, (Length(data) + 7) div 8 * 7 - tailLength);
  length7 := Length(result) div 7 * 7;
  i := 0;
  srcInd := 0;
  Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
  while i < length7 do
  begin
    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];

    result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));

    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];

    result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));

    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    result[i + 2] := Byte((x1 shl 3) or ((x2 shr 4) and $07));

    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    result[i + 3] := Byte((x2 shl 4) or ((x1 shr 3) and $0F));

    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    result[i + 4] := Byte((x1 shl 5) or ((x2 shr 2) and $1F));

    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    result[i + 5] := Byte((x2 shl 6) or ((x1 shr 1) and $3F));

    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    result[i + 6] := Byte((x1 shl 7) or (x2 and $7F));
    inc(i, 7);
  end;
  case tailLength of
    6:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));
      end;
    5:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));

        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));
      end;
    4:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 2] := Byte((x1 shl 3) or ((x2 shr 4) and $07));
      end;
    3:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 2] := Byte((x1 shl 3) or ((x2 shr 4) and $07));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 3] := Byte((x2 shl 4) or ((x1 shr 3) and $0F));
      end;
    2:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 2] := Byte((x1 shl 3) or ((x2 shr 4) and $07));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 3] := Byte((x2 shl 4) or ((x1 shr 3) and $0F));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 4] := Byte((x1 shl 5) or ((x2 shr 2) and $1F));
      end;
    1:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i] := Byte((x1 shl 1) or ((x2 shr 6) and $01));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 1] := Byte((x2 shl 2) or ((x1 shr 5) and $03));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 2] := Byte((x1 shl 3) or ((x2 shr 4) and $07));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 3] := Byte((x2 shl 4) or ((x1 shr 3) and $0F));
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        result[i + 4] := Byte((x1 shl 5) or ((x2 shr 2) and $1F));
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        result[i + 5] := Byte((x2 shl 6) or ((x1 shr 1) and $3F));
      end;
  end;
  result := result;
end;

end.
