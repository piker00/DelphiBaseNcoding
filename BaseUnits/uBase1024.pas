unit uBase1024;

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

  DefaultAlphabet: Array [0 .. 1023] of string = ('0', '1', '2', '3', '4', '5',
    '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
    'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'ª', 'µ', 'º', 'À',
    'Á', 'Â', 'Ã', 'Ä', 'Å', 'Æ', 'Ç', 'È', 'É', 'Ê', 'Ë', 'Ì', 'Í', 'Î', 'Ï',
    'Ð', 'Ñ', 'Ò', 'Ó', 'Ô', 'Õ', 'Ö', 'Ø', 'Ù', 'Ú', 'Û', 'Ü', 'Ý', 'Þ', 'ß',
    'à', 'á', 'â', 'ã', 'ä', 'å', 'æ', 'ç', 'è', 'é', 'ê', 'ë', 'ì', 'í', 'î',
    'ï', 'ð', 'ñ', 'ò', 'ó', 'ô', 'õ', 'ö', 'ø', 'ù', 'ú', 'û', 'ü', 'ý', 'þ',
    'ÿ', 'Ā', 'ā', 'Ă', 'ă', 'Ą', 'ą', 'Ć', 'ć', 'Ĉ', 'ĉ', 'Ċ', 'ċ', 'Č', 'č',
    'Ď', 'ď', 'Đ', 'đ', 'Ē', 'ē', 'Ĕ', 'ĕ', 'Ė', 'ė', 'Ę', 'ę', 'Ě', 'ě', 'Ĝ',
    'ĝ', 'Ğ', 'ğ', 'Ġ', 'ġ', 'Ģ', 'ģ', 'Ĥ', 'ĥ', 'Ħ', 'ħ', 'Ĩ', 'ĩ', 'Ī', 'ī',
    'Ĭ', 'ĭ', 'Į', 'į', 'İ', 'ı', 'Ĳ', 'ĳ', 'Ĵ', 'ĵ', 'Ķ', 'ķ', 'ĸ', 'Ĺ', 'ĺ',
    'Ļ', 'ļ', 'Ľ', 'ľ', 'Ŀ', 'ŀ', 'Ł', 'ł', 'Ń', 'ń', 'Ņ', 'ņ', 'Ň', 'ň', 'ŉ',
    'Ŋ', 'ŋ', 'Ō', 'ō', 'Ŏ', 'ŏ', 'Ő', 'ő', 'Œ', 'œ', 'Ŕ', 'ŕ', 'Ŗ', 'ŗ', 'Ř',
    'ř', 'Ś', 'ś', 'Ŝ', 'ŝ', 'Ş', 'ş', 'Š', 'š', 'Ţ', 'ţ', 'Ť', 'ť', 'Ŧ', 'ŧ',
    'Ũ', 'ũ', 'Ū', 'ū', 'Ŭ', 'ŭ', 'Ů', 'ů', 'Ű', 'ű', 'Ų', 'ų', 'Ŵ', 'ŵ', 'Ŷ',
    'ŷ', 'Ÿ', 'Ź', 'ź', 'Ż', 'ż', 'Ž', 'ž', 'ſ', 'ƀ', 'Ɓ', 'Ƃ', 'ƃ', 'Ƅ', 'ƅ',
    'Ɔ', 'Ƈ', 'ƈ', 'Ɖ', 'Ɗ', 'Ƌ', 'ƌ', 'ƍ', 'Ǝ', 'Ə', 'Ɛ', 'Ƒ', 'ƒ', 'Ɠ', 'Ɣ',
    'ƕ', 'Ɩ', 'Ɨ', 'Ƙ', 'ƙ', 'ƚ', 'ƛ', 'Ɯ', 'Ɲ', 'ƞ', 'Ɵ', 'Ơ', 'ơ', 'Ƣ', 'ƣ',
    'Ƥ', 'ƥ', 'Ʀ', 'Ƨ', 'ƨ', 'Ʃ', 'ƪ', 'ƫ', 'Ƭ', 'ƭ', 'Ʈ', 'Ư', 'ư', 'Ʊ', 'Ʋ',
    'Ƴ', 'ƴ', 'Ƶ', 'ƶ', 'Ʒ', 'Ƹ', 'ƹ', 'ƺ', 'ƻ', 'Ƽ', 'ƽ', 'ƾ', 'ƿ', 'ǀ', 'ǁ',
    'ǂ', 'ǃ', 'Ǆ', 'ǅ', 'ǆ', 'Ǉ', 'ǈ', 'ǉ', 'Ǌ', 'ǋ', 'ǌ', 'Ǎ', 'ǎ', 'Ǐ', 'ǐ',
    'Ǒ', 'ǒ', 'Ǔ', 'ǔ', 'Ǖ', 'ǖ', 'Ǘ', 'ǘ', 'Ǚ', 'ǚ', 'Ǜ', 'ǜ', 'ǝ', 'Ǟ', 'ǟ',
    'Ǡ', 'ǡ', 'Ǣ', 'ǣ', 'Ǥ', 'ǥ', 'Ǧ', 'ǧ', 'Ǩ', 'ǩ', 'Ǫ', 'ǫ', 'Ǭ', 'ǭ', 'Ǯ',
    'ǯ', 'ǰ', 'Ǳ', 'ǲ', 'ǳ', 'Ǵ', 'ǵ', 'Ƕ', 'Ƿ', 'Ǹ', 'ǹ', 'Ǻ', 'ǻ', 'Ǽ', 'ǽ',
    'Ǿ', 'ǿ', 'Ȁ', 'ȁ', 'Ȃ', 'ȃ', 'Ȅ', 'ȅ', 'Ȇ', 'ȇ', 'Ȉ', 'ȉ', 'Ȋ', 'ȋ', 'Ȍ',
    'ȍ', 'Ȏ', 'ȏ', 'Ȑ', 'ȑ', 'Ȓ', 'ȓ', 'Ȕ', 'ȕ', 'Ȗ', 'ȗ', 'Ș', 'ș', 'Ț', 'ț',
    'Ȝ', 'ȝ', 'Ȟ', 'ȟ', 'Ƞ', 'ȡ', 'Ȣ', 'ȣ', 'Ȥ', 'ȥ', 'Ȧ', 'ȧ', 'Ȩ', 'ȩ', 'Ȫ',
    'ȫ', 'Ȭ', 'ȭ', 'Ȯ', 'ȯ', 'Ȱ', 'ȱ', 'Ȳ', 'ȳ', 'ȴ', 'ȵ', 'ȶ', 'ȸ', 'ȹ', 'Ⱥ',
    'Ȼ', 'ȼ', 'Ƚ', 'Ⱦ', 'ȿ', 'ɀ', 'Ɂ', 'ɂ', 'Ƀ', 'Ʉ', 'Ʌ', 'Ɇ', 'ɇ', 'Ɉ', 'ɉ',
    'Ɋ', 'ɋ', 'Ɍ', 'ɍ', 'Ɏ', 'ɏ', 'ɐ', 'ɑ', 'ɒ', 'ɓ', 'ɔ', 'ɕ', 'ɖ', 'ɗ', 'ɘ',
    'ə', 'ɚ', 'ɛ', 'ɜ', 'ɝ', 'ɞ', 'ɟ', 'ɠ', 'ɡ', 'ɢ', 'ɣ', 'ɤ', 'ɥ', 'ɦ', 'ɧ',
    'ɨ', 'ɩ', 'ɪ', 'ɫ', 'ɬ', 'ɭ', 'ɮ', 'ɯ', 'ɰ', 'ɱ', 'ɲ', 'ɳ', 'ɴ', 'ɵ', 'ɶ',
    'ɷ', 'ɸ', 'ɹ', 'ɺ', 'ɻ', 'ɼ', 'ɽ', 'ɾ', 'ɿ', 'ʀ', 'ʁ', 'ʂ', 'ʃ', 'ʄ', 'ʅ',
    'ʆ', 'ʇ', 'ʈ', 'ʉ', 'ʊ', 'ʋ', 'ʌ', 'ʍ', 'ʎ', 'ʏ', 'ʐ', 'ʑ', 'ʒ', 'ʓ', 'ʔ',
    'ʕ', 'ʖ', 'ʗ', 'ʘ', 'ʙ', 'ʚ', 'ʛ', 'ʜ', 'ʝ', 'ʞ', 'ʟ', 'ʠ', 'ʡ', 'ʢ', 'ʣ',
    'ʤ', 'ʥ', 'ʦ', 'ʧ', 'ʨ', 'ʩ', 'ʪ', 'ʫ', 'ʬ', 'ʭ', 'ʮ', 'ʯ', 'ʰ', 'ʱ', 'ʲ',
    'ʳ', 'ʴ', 'ʵ', 'ʶ', 'ʷ', 'ʸ', 'ʹ', 'ʺ', 'ʻ', 'ʼ', 'ʽ', 'ʾ', 'ʿ', 'ˀ', 'ˁ',
    'ˆ', 'ˇ', 'ˈ', 'ˉ', 'ˊ', 'ˋ', 'ˌ', 'ˍ', 'ˎ', 'ˏ', 'ː', 'ˑ', 'ˠ', 'ˡ', 'ˢ',
    'ˣ', 'ˤ', 'ˬ', 'ˮ', 'ʹ', 'ͺ', 'ͻ', 'ͼ', 'ͽ', 'Ά', 'Έ', 'Ή', 'Ί', 'Ό', 'Ύ',
    'Ώ', 'ΐ', 'Α', 'Β', 'Γ', 'Δ', 'Ε', 'Ζ', 'Η', 'Θ', 'Ι', 'Κ', 'Λ', 'Μ', 'Ν',
    'Ξ', 'Ο', 'Π', 'Ρ', 'Σ', 'Τ', 'Υ', 'Φ', 'Χ', 'Ψ', 'Ω', 'Ϊ', 'Ϋ', 'ά', 'έ',
    'ή', 'ί', 'ΰ', 'α', 'β', 'γ', 'δ', 'ε', 'ζ', 'η', 'θ', 'ι', 'κ', 'λ', 'μ',
    'ν', 'ξ', 'ο', 'π', 'ρ', 'ς', 'σ', 'τ', 'υ', 'φ', 'χ', 'ψ', 'ω', 'ϊ', 'ϋ',
    'ό', 'ύ', 'ώ', 'ϐ', 'ϑ', 'ϒ', 'ϓ', 'ϔ', 'ϕ', 'ϖ', 'ϗ', 'Ϙ', 'ϙ', 'Ϛ', 'ϛ',
    'Ϝ', 'ϝ', 'Ϟ', 'ϟ', 'Ϡ', 'ϡ', 'Ϣ', 'ϣ', 'Ϥ', 'ϥ', 'Ϧ', 'ϧ', 'Ϩ', 'ϩ', 'Ϫ',
    'ϫ', 'Ϭ', 'ϭ', 'Ϯ', 'ϯ', 'ϰ', 'ϱ', 'ϲ', 'ϳ', 'ϴ', 'ϵ', 'Ϸ', 'ϸ', 'Ϲ', 'Ϻ',
    'ϻ', 'ϼ', 'Ͻ', 'Ͼ', 'Ͽ', 'Ѐ', 'Ё', 'Ђ', 'Ѓ', 'Є', 'Ѕ', 'І', 'Ї', 'Ј', 'Љ',
    'Њ', 'Ћ', 'Ќ', 'Ѝ', 'Ў', 'Џ', 'А', 'Б', 'В', 'Г', 'Д', 'Е', 'Ж', 'З', 'И',
    'Й', 'К', 'Л', 'М', 'Н', 'О', 'П', 'Р', 'С', 'Т', 'У', 'Ф', 'Х', 'Ц', 'Ч',
    'Ш', 'Щ', 'Ъ', 'Ы', 'Ь', 'Э', 'Ю', 'Я', 'а', 'б', 'в', 'г', 'д', 'е', 'ж',
    'з', 'и', 'й', 'к', 'л', 'м', 'н', 'о', 'п', 'р', 'с', 'т', 'у', 'ф', 'х',
    'ц', 'ч', 'ш', 'щ', 'ъ', 'ы', 'ь', 'э', 'ю', 'я', 'ѐ', 'ё', 'ђ', 'ѓ', 'є',
    'ѕ', 'і', 'ї', 'ј', 'љ', 'њ', 'ћ', 'ќ', 'ѝ', 'ў', 'џ', 'Ѡ', 'ѡ', 'Ѣ', 'ѣ',
    'Ѥ', 'ѥ', 'Ѧ', 'ѧ', 'Ѩ', 'ѩ', 'Ѫ', 'ѫ', 'Ѭ', 'ѭ', 'Ѯ', 'ѯ', 'Ѱ', 'ѱ', 'Ѳ',
    'ѳ', 'Ѵ', 'ѵ', 'Ѷ', 'ѷ', 'Ѹ', 'ѹ', 'Ѻ', 'ѻ', 'Ѽ', 'ѽ', 'Ѿ', 'ѿ', 'Ҁ', 'ҁ',
    'Ҋ', 'ҋ', 'Ҍ', 'ҍ', 'Ҏ', 'ҏ', 'Ґ', 'ґ', 'Ғ', 'ғ', 'Ҕ', 'ҕ', 'Җ', 'җ', 'Ҙ',
    'ҙ', 'Қ', 'қ', 'Ҝ', 'ҝ', 'Ҟ', 'ҟ', 'Ҡ', 'ҡ', 'Ң', 'ң', 'Ҥ', 'ҥ', 'Ҧ', 'ҧ',
    'Ҩ', 'ҩ', 'Ҫ', 'ҫ', 'Ҭ', 'ҭ', 'Ү', 'ү', 'Ұ', 'ұ', 'Ҳ', 'ҳ', 'Ҵ', 'ҵ', 'Ҷ',
    'ҷ', 'Ҹ', 'ҹ', 'Һ', 'һ', 'Ҽ', 'ҽ', 'Ҿ', 'ҿ', 'Ӏ', 'Ӂ', 'ӂ', 'Ӄ', 'ӄ', 'Ӆ',
    'ӆ', 'Ӈ', 'ӈ', 'Ӊ', 'ӊ', 'Ӌ', 'ӌ', 'Ӎ', 'ӎ', 'ӏ', 'Ӑ', 'ӑ', 'Ӓ', 'ӓ', 'Ӕ',
    'ӕ', 'Ӗ', 'ӗ', 'Ә', 'ә', 'Ӛ', 'ӛ', 'Ӝ', 'ӝ', 'Ӟ', 'ӟ', 'Ӡ', 'ӡ', 'Ӣ', 'ӣ',
    'Ӥ', 'ӥ', 'Ӧ', 'ӧ', 'Ө', 'ө', 'Ӫ', 'ӫ', 'Ӭ', 'ӭ', 'Ӯ', 'ӯ', 'Ӱ', 'ӱ', 'Ӳ',
    'ӳ', 'Ӵ', 'ӵ', 'Ӷ', 'ӷ', 'Ӹ', 'ӹ', 'Ӻ', 'ӻ', 'Ӽ', 'ӽ', 'Ӿ', 'ӿ', 'Ԁ', 'ԁ',
    'Ԃ', 'ԃ', 'Ԅ', 'ԅ', 'Ԇ', 'ԇ', 'Ԉ', 'ԉ', 'Ԋ', 'ԋ', 'Ԍ', 'ԍ', 'Ԏ', 'ԏ', 'Ԑ',
    'ԑ', 'Ԓ', 'ԓ', 'Ԛ', 'ԛ', 'Ԝ', 'ԝ', 'Ա', 'Բ', 'Գ', 'Դ', 'Ե', 'Զ', 'Է', 'Ը',
    'Թ', 'Ժ', 'Ի', 'Լ', 'Խ', 'Ծ', 'Կ', 'Հ', 'Ձ', 'Ղ', 'Ճ', 'Մ', 'Յ', 'Ն', 'Շ',
    'Ո', 'Չ', 'Պ', 'Ջ', 'Ռ', 'Ս', 'Վ', 'Տ', 'Ր', 'Ց', 'Ւ', 'Փ', 'Ք');

  DefaultSpecial = '=';

implementation

function Encode(data: TBytes): String;
var
  dataLength, i, x1, x2, x3, x4, x5, length5, tempInt: Integer;
  tempResult: TStringBuilder;

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
      x2 := data[i + 1];
      x3 := data[i + 2];
      x4 := data[i + 3];
      x5 := data[i + 4];

      tempResult.Append(DefaultAlphabet[x1 or ((x2 and $03) shl 8)]);
      tempResult.Append(DefaultAlphabet[(x2 shr 2) or ((x3 and $0F) shl 6)]);
      tempResult.Append(DefaultAlphabet[(x3 shr 4) or ((x4 and $3F) shl 4)]);
      tempResult.Append(DefaultAlphabet[(x4 shr 6) or (x5 shl 2)]);

      inc(i, 5);
    end;

    tempInt := dataLength - length5;

    Case tempInt of
      1:
        begin
          x1 := data[i];

          tempResult.Append(DefaultAlphabet[x1]);
          tempResult.Append(DefaultSpecial, 4);

        end;
      2:
        begin
          x1 := data[i];
          x2 := data[i + 1];

          tempResult.Append(DefaultAlphabet[x1 or ((x2 and $03) shl 8)]);
          tempResult.Append(DefaultAlphabet[x2 shr 2]);
          tempResult.Append(DefaultSpecial, 3);

        end;
      3:
        begin
          x1 := data[i];
          x2 := data[i + 1];
          x3 := data[i + 2];

          tempResult.Append(DefaultAlphabet[x1 or ((x2 and $03) shl 8)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 2) or
            ((x3 and $0F) shl 6)]);
          tempResult.Append(DefaultAlphabet[x3 shr 4]);
          tempResult.Append(DefaultSpecial, 2);

        end;
      4:
        begin
          x1 := data[i];
          x2 := data[i + 1];
          x3 := data[i + 2];
          x4 := data[i + 3];

          tempResult.Append(DefaultAlphabet[x1 or ((x2 and $03) shl 8)]);
          tempResult.Append(DefaultAlphabet[(x2 shr 2) or
            ((x3 and $0F) shl 6)]);
          tempResult.Append(DefaultAlphabet[(x3 shr 4) or
            ((x4 and $3F) shl 4)]);
          tempResult.Append(DefaultAlphabet[x4 shr 6]);
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
  lastSpecialInd, tailLength, i, srcInd, x1, x2, x3, x4, length5: Integer;

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
  SetLength(result, Length(data) div 4 * 5 - tailLength);
  i := 0;
  srcInd := 0;
  length5 := (Length(data) div 4 - 1) * 5;
  Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);
  while i < length5 do
  begin
    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x3 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x4 := InvAlphabet[Ord(data[srcInd])];

    result[i] := Byte(x1);
    result[i + 1] := Byte((x1 shr 8) and $03 or (x2 shl 2));
    result[i + 2] := Byte((x2 shr 6) and $0F or (x3 shl 4));
    result[i + 3] := Byte((x3 shr 4) and $3F or (x4 shl 6));
    result[i + 4] := Byte(x4 shr 2);
    inc(i, 5);
  end;

  if (tailLength = 0) then
  begin
    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x3 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x4 := InvAlphabet[Ord(data[srcInd])];

    result[i] := Byte(x1);
    result[i + 1] := Byte((x1 shr 8) and $03 or (x2 shl 2));
    result[i + 2] := Byte((x2 shr 6) and $0F or (x3 shl 4));
    result[i + 3] := Byte((x3 shr 4) and $3F or (x4 shl 6));
    result[i + 4] := Byte(x4 shr 2);
  end;

  Case (tailLength) of
    4:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
      end;
    3:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
        result[i + 1] := Byte((x1 shr 8) and $03 or (x2 shl 2));

      end;
    2:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x3 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
        result[i + 1] := Byte((x1 shr 8) and $03 or (x2 shl 2));
        result[i + 2] := Byte((x2 shr 6) and $0F or (x3 shl 4));
      end;
    1:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x3 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x4 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
        result[i + 1] := Byte((x1 shr 8) and $03 or (x2 shl 2));
        result[i + 2] := Byte((x2 shr 6) and $0F or (x3 shl 4));
        result[i + 3] := Byte((x3 shr 4) and $3F or (x4 shl 6));
      end;

  end;
  result := result;

end;

end.
