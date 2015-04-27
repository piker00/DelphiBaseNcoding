unit uStringGenerator;

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

  System.SysUtils, System.Math;

function IsWhiteSpace(const Ch: Char): Boolean;
function IsControl(const Ch: Char): Boolean;
function GetAlphabet(charsCount: Integer): String;
function GetRandom(size: Integer; onlyLettersAndDigits: Boolean): String;

implementation

// replicated from 'cUnicode.pas' in 'Fundamentals Library 4.0.0 v4.12' with some
// additions.

function IsWhiteSpace(const Ch: Char): Boolean;
begin
  case Ch of
    #$0009 .. #$000D, // ASCII CONTROL
    #$0020, // SPACE
    #$0085, // <control>
    #$00A0, // NO-BREAK SPACE
    #$1680, // OGHAM SPACE MARK
    #$2000 .. #$200A, // EN QUAD..HAIR SPACE
    #$202F, // NO-BREAK SPACE
    #$2028, // LINE SEPARATOR
    #$2029, // PARAGRAPH SEPARATOR
    #$205F, // MATHEMATICAL SPACE
    #$3000: // IDEOGRAPHIC SPACE
      Result := True;
  else
    Result := False;
  end;
end;

// replicated from 'cUnicode.pas' in 'Fundamentals Library 4.0.0 v4.12' with additions.

function IsControl(const Ch: Char): Boolean;
begin
  case Ch of
    #$0000 .. #$001F, #$007F .. #$009F:
      Result := True;
  else
    Result := False;
  end;
end;

function GetAlphabet(charsCount: Integer): String;
var
  i, count: Integer;
  c: Char;
  tempResult: TStringBuilder;

begin
  tempResult := TStringBuilder.Create;
  tempResult.Clear;
  try
    i := 0;
    count := 0;

    while (count < charsCount) do
    begin

      c := Char(i);

      if (not IsControl(c)) and (not IsWhiteSpace(c)) then

      begin

        tempResult.Append(c);
        Inc(count);
      end;
      Inc(i);
    end;
    Result := tempResult.ToString;
  finally
    tempResult.Free;
  end;
end;

function GetRandom(size: Integer; onlyLettersAndDigits: Boolean): String;
var
  i: Integer;
  lettersAndDigits: String;
  tempResult: TStringBuilder;
  data: TBytes;

begin
  Result := '';
  tempResult := TStringBuilder.Create;
  try
    Randomize;
    if (onlyLettersAndDigits) then
    begin
      lettersAndDigits :=
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
      for i := 0 to Pred(size) do
      begin
        tempResult.Append(lettersAndDigits
          [Random(Length(lettersAndDigits)) + 1]);
        Result := tempResult.ToString;
      end
    end
    else
    begin
      SetLength(data, size);
      i := 0;

      while i < (size) do

      begin
        data[i] := Byte(RandomRange(32, 127));

        Result := TEncoding.ASCII.GetString(data);

        Inc(i);
      end;
      data := nil;
    end;

  finally
    tempResult.Free;

  end;

end;

end.
