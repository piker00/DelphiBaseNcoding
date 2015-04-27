unit uBase91;

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
  System.SysUtils, System.Classes, Generics.Collections, uBase;

function Encode(data: TBytes): String;
function Decode(data: String): TBytes;

Const
  DefaultAlphabet: Array [0 .. 90] of String = ('A', 'B', 'C', 'D', 'E', 'F',
    'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U',
    'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j',
    'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y',
    'z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '!', '#', '$', '%',
    '&', '(', ')', '*', '+', ',', '.', '/', ':', ';', '<', '=', '>', '?', '@',
    '[', ']', '^', '_', '`', '{', '|', '}', '~', '"');

  DefaultSpecial = Char(0);

implementation

function Encode(data: TBytes): String;
var
  ebq, en, ev, i, dataLength: Integer;
  tempResult: TStringBuilder;
begin
  dataLength := Length(data);
  tempResult := TStringBuilder.Create;
  tempResult.Clear;

  try
    ebq := 0;
    en := 0;
    for i := 0 to Pred(dataLength) do
    begin
      ebq := ebq or ((data[i] and 255) shl en);
      en := en + 8;
      if (en > 13) then
      begin
        ev := ebq and 8191;
        if (ev > 88) then
        begin
          ebq := ebq shr 13;
          en := en - 13;
        end
        else

        begin
          ev := ebq and 16383;
          ebq := ebq shr 14;
          en := en - 14;
        end;
        tempResult.Append(DefaultAlphabet[ev mod 91]);
        tempResult.Append(DefaultAlphabet[ev div 91]);

      end

    end;

    if (en > 0) then
    begin
      tempResult.Append(DefaultAlphabet[ebq mod 91]);
      if ((en > 7) or (ebq > 90)) then

      begin
        tempResult.Append(DefaultAlphabet[ebq div 91]);
      end;
    end;
    result := tempResult.ToString;
  finally
    tempResult.Free;
  end;
end;

function Decode(data: String): TBytes;
var
  dbq, dn, dv, i: Integer;
  tempResult: TList<Byte>;
begin

  if isNullOrEmpty(data) then

  begin
    SetLength(result, 1);
    result := [0];
    Exit;
  end;

  dbq := 0;
  dn := 0;
  dv := -1;
  tempResult := TList<Byte>.Create;
  tempResult.Capacity := Length(data);

  try
    Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
    tempResult.Clear;
    for i := 0 to (Length(data)) do

    begin

      if (InvAlphabet[Ord(data[i])] = -1) then
        continue;

      if (dv = -1) then
        dv := InvAlphabet[Ord(data[i])]

      else
      begin

        dv := dv + InvAlphabet[Ord(data[i])] * 91;
        dbq := dbq or dv shl dn;

        if (dv and 8191) > 88 then
        begin
          dn := dn + 13;
        end
        else
        begin
          dn := dn + 14;
        end;

        while (dn > 7) do
        begin
          tempResult.Add(Byte(dbq));
          dbq := dbq shr 8;
          dn := dn - 8;
        end;
        dv := -1;

      end;

    end;

    if (dv <> -1) then
    begin
      tempResult.Add(Byte(dbq or dv shl dn));
    end;
    result := tempResult.ToArray;

  finally
    tempResult.Free;
  end;

end;

end.
