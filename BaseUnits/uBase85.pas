unit uBase85;

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
  System.SysUtils, System.Classes, System.StrUtils, uBase;

function Encode(data: TBytes; PrefixPostfix: Boolean): String;
procedure EncodeBlock(count: Integer; sb: TStringBuilder;
  encodedBlock: array of byte; tuple: UInt32);
function Decode(data: String; PrefixPostfix: Boolean): TBytes;
procedure DecodeBlock(bytes: Integer; decodedBlock: TBytes; tuple: LongWord);

Const
  DefaultAlphabet: Array [0 .. 84] of String = ('!', '"', '#', '$', '%', '&',
    '''', '(', ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5',
    '6', '7', '8', '9', ':', ';', '<', '=', '>', '?', '@', 'A', 'B', 'C', 'D',
    'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
    'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '[', '\', ']', '^', '_', '`', 'a', 'b',
    'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q',
    'r', 's', 't', 'u');

  DefaultSpecial = Char(0);
  Pow85: Array [0 .. 4] of UInt32 = (85 * 85 * 85 * 85, 85 * 85 * 85,
    85 * 85, 85, 1);

  Prefix = '<~';
  Postfix = '~>';

implementation

function Encode(data: TBytes; PrefixPostfix: Boolean): String;

var
  encodedBlock: array of byte;
  decodedBlockLength, count: Integer;
  sb: TStringBuilder;
  tuple: UInt32;
  b: byte;

begin
  SetLength(encodedBlock, 5);
  decodedBlockLength := 4;

  sb := TStringBuilder.Create;
  sb.Clear;
  try
    if (PrefixPostfix) then
    begin
      sb.Append(Prefix);
    end;
    count := 0;
    tuple := 0;
    for b in data do
    begin
      if (count >= (decodedBlockLength - 1)) then
      begin
        tuple := tuple or b;
        if (tuple = 0) then
        begin
          sb.Append('z')
        end
        else
        begin
          EncodeBlock(Length(encodedBlock), sb, encodedBlock, tuple);
          tuple := 0;
          count := 0;
        end;
      end

      else
      begin

        tuple := tuple or (UInt32(b shl (24 - (count * 8))));
        inc(count);

      end;

    end;
    if (count > 0) then
    begin
      EncodeBlock(count + 1, sb, encodedBlock, tuple);
    end;
    if (PrefixPostfix) then
    begin
      sb.Append(Postfix);
    end;
    result := sb.ToString;
  finally
    sb.Free;
  end;

end;

procedure EncodeBlock(count: Integer; sb: TStringBuilder;
  encodedBlock: array of byte; tuple: UInt32);
var
  i: Integer;

begin

  i := Pred(Length(encodedBlock));
  while i >= 0 do
  begin

    encodedBlock[i] := byte(tuple mod 85);
    tuple := tuple div 85;
    dec(i);

  end;

  i := 0;

  while i < count do
  begin
    sb.Append(DefaultAlphabet[encodedBlock[i]]);
    inc(i);
  end;

end;

function Decode(data: String; PrefixPostfix: Boolean): TBytes;
var
  dataWithoutPrefixPostfix: String;
  ms: TMemoryStream;
  count, encodedBlockLength, i: Integer;
  processChar: Boolean;
  tuple: LongWord;
  decodedBlock: TBytes;
  c: Char;

begin

  if isNullOrEmpty(data) then

  begin
    SetLength(result, 1);
    result := [0];
    Exit;
  end;
  dataWithoutPrefixPostfix := data;
  if (PrefixPostfix) then
  begin
    if not(StartsWith(dataWithoutPrefixPostfix, Prefix) or
      EndsWith(dataWithoutPrefixPostfix, Postfix)) then
    begin
      raise Exception.Create('ASCII85 encoded data should begin with "' + Prefix
        + '" and end with "' + Postfix + '"');
    end;

    dataWithoutPrefixPostfix := Copy(dataWithoutPrefixPostfix, 3,
      Length(dataWithoutPrefixPostfix) - 4);

  end;
  ms := TMemoryStream.Create;
  try
    count := 0;

    tuple := UInt32(0);
    encodedBlockLength := 5;
    SetLength(decodedBlock, 4);
    for c in dataWithoutPrefixPostfix do

    begin

      Case IndexStr(c, ['z']) of
        // 'z':
        0:
          begin
            if (count <> 0) then
            begin
              raise Exception.Create
                ('The character z is invalid inside an ASCII85 block.');
            end;
            decodedBlock[0] := 0;
            decodedBlock[1] := 0;
            decodedBlock[2] := 0;
            decodedBlock[3] := 0;
            ms.Write(decodedBlock, 0, Length(decodedBlock));
            // ms.Write()
            processChar := False;
          end

      else
        begin
          processChar := True;
        end;
      end;
      if (processChar) then
      begin
        Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
        tuple := tuple + UInt32(InvAlphabet[Ord(c)]) * Pow85[count];
        inc(count);
        if (count = encodedBlockLength) then
        begin
          DecodeBlock(Length(decodedBlock), decodedBlock, tuple);
          ms.Write(decodedBlock, 0, Length(decodedBlock));
          tuple := 0;
          count := 0;
        end;
      end;
    end;

    if (count <> 0) then
    begin

      if (count = 1) then
      begin
        raise Exception.Create
          ('The last block of ASCII85 data cannot be a single byte.');
      end;
      dec(count);
      tuple := tuple + Pow85[count];
      DecodeBlock(count, decodedBlock, tuple);
      for i := 0 to Pred(count) do
      begin
        // ms.WriteByte(decodedBlock[i]);
        ms.Write(decodedBlock[i], 1);
      end;
      // ms.ToArray();
      ms.Position := 0;
      SetLength(result, ms.Size);
      ms.Read(result[0], ms.Size);
    end;
  finally
    ms.Free;
  end;

end;

procedure DecodeBlock(bytes: Integer; decodedBlock: TBytes; tuple: LongWord);
var
  i: Integer;

begin
  for i := 0 to Pred(bytes) do
  begin
    // decodedBlock[i] := byte(UInt32(tuple shr 24) - (UInt32(i * 8)));
    // decodedBlock[i] := Byte((tuple shr 24) - (i * 8));
    decodedBlock[i] := byte(tuple shr (24 - (i * 8)));
  end;
end;

end.
