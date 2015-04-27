﻿unit uBase4096;

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

  DefaultAlphabet: Array [0 .. 4095] of string = ('0', '1', '2', '3', '4', '5',
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
    'Ո', 'Չ', 'Պ', 'Ջ', 'Ռ', 'Ս', 'Վ', 'Տ', 'Ր', 'Ց', 'Ւ', 'Փ', 'Ք', 'ՙ', 'ա',
    'բ', 'գ', 'դ', 'ե', 'զ', 'է', 'ը', 'թ', 'ժ', 'ի', 'լ', 'խ', 'ծ', 'կ', 'հ',
    'ձ', 'ղ', 'ճ', 'մ', 'յ', 'ն', 'շ', 'ո', 'չ', 'պ', 'ջ', 'ռ', 'ս', 'վ', 'տ',
    'ր', 'ց', 'ւ', 'փ', 'ք', 'օ', 'ֆ', 'և', 'א', 'ב', 'ג', 'ד', 'ה', 'ו', 'ז',
    'ח', 'ט', 'י', 'ך', 'כ', 'ל', 'ם', 'מ', 'ן', 'נ', 'ס', 'ע', 'ף', 'פ', 'ץ',
    'צ', 'ק', 'ר', 'ש', 'ת', 'װ', 'ױ', 'ײ', 'ء', 'آ', 'أ', 'ؤ', 'إ', 'ئ', 'ا',
    'ب', 'ة', 'ت', 'ث', 'ج', 'ح', 'خ', 'د', 'ذ', 'ر', 'ز', 'س', 'ش', 'ص', 'ض',
    'ط', 'ظ', 'ع', 'غ', 'ػ', 'ؼ', 'ؽ', 'ؾ', 'ؿ', 'ـ', 'ف', 'ق', 'ك', 'ل', 'م',
    'ن', 'ه', 'و', 'ى', 'ي', '٠', '١', '٢', '٣', '٤', '٥', '٦', '٧', '٨', '٩',
    'ٮ', 'ٯ', 'ٱ', 'ٲ', 'ٳ', 'ٴ', 'ٵ', 'ٶ', 'ٷ', 'ٸ', 'ٹ', 'ٺ', 'ٻ', 'ټ', 'ٽ',
    'پ', 'ٿ', 'ڀ', 'ځ', 'ڂ', 'ڃ', 'ڄ', 'څ', 'چ', 'ڇ', 'ڈ', 'ډ', 'ڊ', 'ڋ', 'ڌ',
    'ڍ', 'ڎ', 'ڏ', 'ڐ', 'ڑ', 'ڒ', 'ړ', 'ڔ', 'ڕ', 'ږ', 'ڗ', 'ژ', 'ڙ', 'ښ', 'ڛ',
    'ڜ', 'ڝ', 'ڞ', 'ڟ', 'ڠ', 'ڡ', 'ڢ', 'ڣ', 'ڤ', 'ڥ', 'ڦ', 'ڧ', 'ڨ', 'ک', 'ڪ',
    'ګ', 'ڬ', 'ڭ', 'ڮ', 'گ', 'ڰ', 'ڱ', 'ڲ', 'ڳ', 'ڴ', 'ڵ', 'ڶ', 'ڷ', 'ڸ', 'ڹ',
    'ں', 'ڻ', 'ڼ', 'ڽ', 'ھ', 'ڿ', 'ۀ', 'ہ', 'ۂ', 'ۃ', 'ۄ', 'ۅ', 'ۆ', 'ۇ', 'ۈ',
    'ۉ', 'ۊ', 'ۋ', 'ی', 'ۍ', 'ێ', 'ۏ', 'ې', 'ۑ', 'ے', 'ۓ', 'ە', 'ۥ', 'ۦ', 'ۮ',
    'ۯ', '۰', '۱', '۲', '۳', '۴', '۵', '۶', '۷', '۸', '۹', 'ۺ', 'ۻ', 'ۼ', 'ۿ',
    'ܐ', 'ܒ', 'ܓ', 'ܔ', 'ܕ', 'ܖ', 'ܗ', 'ܘ', 'ܙ', 'ܚ', 'ܛ', 'ܜ', 'ܝ', 'ܞ', 'ܟ',
    'ܠ', 'ܡ', 'ܢ', 'ܣ', 'ܤ', 'ܥ', 'ܦ', 'ܧ', 'ܨ', 'ܩ', 'ܪ', 'ܫ', 'ܬ', 'ܭ', 'ܮ',
    'ܯ', 'ݍ', 'ݎ', 'ݏ', 'ݐ', 'ݑ', 'ݒ', 'ݓ', 'ݔ', 'ݕ', 'ݖ', 'ݗ', 'ݘ', 'ݙ', 'ݚ',
    'ݛ', 'ݜ', 'ݝ', 'ݞ', 'ݟ', 'ݠ', 'ݡ', 'ݢ', 'ݣ', 'ݤ', 'ݥ', 'ݦ', 'ݧ', 'ݨ', 'ݩ',
    'ݪ', 'ݫ', 'ݬ', 'ݭ', 'ݮ', 'ݯ', 'ݰ', 'ݱ', 'ݲ', 'ݳ', 'ݴ', 'ݵ', 'ݶ', 'ݷ', 'ݸ',
    'ݹ', 'ݺ', 'ݻ', 'ݼ', 'ݽ', 'ݾ', 'ݿ', 'ހ', 'ށ', 'ނ', 'ރ', 'ބ', 'ޅ', 'ކ', 'އ',
    'ވ', 'މ', 'ފ', 'ދ', 'ތ', 'ލ', 'ގ', 'ޏ', 'ސ', 'ޑ', 'ޒ', 'ޓ', 'ޔ', 'ޕ', 'ޖ',
    'ޗ', 'ޘ', 'ޙ', 'ޚ', 'ޛ', 'ޜ', 'ޝ', 'ޞ', 'ޟ', 'ޠ', 'ޡ', 'ޢ', 'ޣ', 'ޤ', 'ޥ',
    'ޱ', '߀', '߁', '߂', '߃', '߄', '߅', '߆', '߇', '߈', '߉', 'ߊ', 'ߋ', 'ߌ', 'ߍ',
    'ߎ', 'ߏ', 'ߐ', 'ߑ', 'ߒ', 'ߓ', 'ߔ', 'ߕ', 'ߖ', 'ߗ', 'ߘ', 'ߙ', 'ߚ', 'ߛ', 'ߜ',
    'ߝ', 'ߞ', 'ߟ', 'ߠ', 'ߡ', 'ߢ', 'ߣ', 'ߤ', 'ߥ', 'ߦ', 'ߧ', 'ߨ', 'ߩ', 'ߪ', 'ߴ',
    'ߵ', 'ߺ', 'ऄ', 'अ', 'आ', 'इ', 'ई', 'उ', 'ऊ', 'ऋ', 'ऌ', 'ऍ', 'ऎ', 'ए', 'ऐ',
    'ऑ', 'ऒ', 'ओ', 'औ', 'क', 'ख', 'ग', 'घ', 'ङ', 'च', 'छ', 'ज', 'झ', 'ञ', 'ट',
    'ठ', 'ड', 'ढ', 'ण', 'त', 'थ', 'द', 'ध', 'न', 'ऩ', 'प', 'फ', 'ब', 'भ', 'म',
    'य', 'र', 'ऱ', 'ल', 'ळ', 'ऴ', 'व', 'श', 'ष', 'स', 'ह', 'ऽ', 'ॐ', 'क़', 'ख़',
    'ग़', 'ज़', 'ड़', 'ढ़', 'फ़', 'य़', 'ॠ', 'ॡ', '०', '१', '२', '३', '४', '५', '६',
    '७', '८', '९', 'ॱ', 'ॲ', 'ॻ', 'ॼ', 'ॽ', 'ॾ', 'ॿ', 'অ', 'আ', 'ই', 'ঈ', 'উ',
    'ঊ', 'ঋ', 'ঌ', 'এ', 'ঐ', 'ও', 'ঔ', 'ক', 'খ', 'গ', 'ঘ', 'ঙ', 'চ', 'ছ', 'জ',
    'ঝ', 'ঞ', 'ট', 'ঠ', 'ড', 'ঢ', 'ণ', 'ত', 'থ', 'দ', 'ধ', 'ন', 'প', 'ফ', 'ব',
    'ভ', 'ম', 'য', 'র', 'ল', 'শ', 'ষ', 'স', 'হ', 'ঽ', 'ৎ', 'ড়', 'ঢ়', 'য়', 'ৠ',
    'ৡ', '০', '১', '২', '৩', '৪', '৫', '৬', '৭', '৮', '৯', 'ৰ', 'ৱ', 'ਅ', 'ਆ',
    'ਇ', 'ਈ', 'ਉ', 'ਊ', 'ਏ', 'ਐ', 'ਓ', 'ਔ', 'ਕ', 'ਖ', 'ਗ', 'ਘ', 'ਙ', 'ਚ', 'ਛ',
    'ਜ', 'ਝ', 'ਞ', 'ਟ', 'ਠ', 'ਡ', 'ਢ', 'ਣ', 'ਤ', 'ਥ', 'ਦ', 'ਧ', 'ਨ', 'ਪ', 'ਫ',
    'ਬ', 'ਭ', 'ਮ', 'ਯ', 'ਰ', 'ਲ', 'ਲ਼', 'ਵ', 'ਸ਼', 'ਸ', 'ਹ', 'ਖ਼', 'ਗ਼', 'ਜ਼', 'ੜ',
    'ਫ਼', '੦', '੧', '੨', '੩', '੪', '੫', '੬', '੭', '੮', '੯', 'ੲ', 'ੳ', 'ੴ', 'અ',
    'આ', 'ઇ', 'ઈ', 'ઉ', 'ઊ', 'ઋ', 'ઌ', 'ઍ', 'એ', 'ઐ', 'ઑ', 'ઓ', 'ઔ', 'ક', 'ખ',
    'ગ', 'ઘ', 'ઙ', 'ચ', 'છ', 'જ', 'ઝ', 'ઞ', 'ટ', 'ઠ', 'ડ', 'ઢ', 'ણ', 'ત', 'થ',
    'દ', 'ધ', 'ન', 'પ', 'ફ', 'બ', 'ભ', 'મ', 'ય', 'ર', 'લ', 'ળ', 'વ', 'શ', 'ષ',
    'સ', 'હ', 'ઽ', 'ૐ', 'ૠ', 'ૡ', '૦', '૧', '૨', '૩', '૪', '૫', '૬', '૭', '૮',
    '૯', 'ଅ', 'ଆ', 'ଇ', 'ଈ', 'ଉ', 'ଊ', 'ଋ', 'ଌ', 'ଏ', 'ଐ', 'ଓ', 'ଔ', 'କ', 'ଖ',
    'ଗ', 'ଘ', 'ଙ', 'ଚ', 'ଛ', 'ଜ', 'ଝ', 'ଞ', 'ଟ', 'ଠ', 'ଡ', 'ଢ', 'ଣ', 'ତ', 'ଥ',
    'ଦ', 'ଧ', 'ନ', 'ପ', 'ଫ', 'ବ', 'ଭ', 'ମ', 'ଯ', 'ର', 'ଲ', 'ଳ', 'ଵ', 'ଶ', 'ଷ',
    'ସ', 'ହ', 'ଽ', 'ଡ଼', 'ଢ଼', 'ୟ', 'ୠ', 'ୡ', '୦', '୧', '୨', '୩', '୪', '୫', '୬',
    '୭', '୮', '୯', 'ୱ', 'ஃ', 'அ', 'ஆ', 'இ', 'ஈ', 'உ', 'ஊ', 'எ', 'ஏ', 'ஐ', 'ஒ',
    'ஓ', 'ஔ', 'க', 'ங', 'ச', 'ஜ', 'ஞ', 'ட', 'ண', 'த', 'ந', 'ன', 'ப', 'ம', 'ய',
    'ர', 'ற', 'ல', 'ள', 'ழ', 'வ', 'ஶ', 'ஷ', 'ஸ', 'ஹ', 'ௐ', '௦', '௧', '௨', '௩',
    '௪', '௫', '௬', '௭', '௮', '௯', 'అ', 'ఆ', 'ఇ', 'ఈ', 'ఉ', 'ఊ', 'ఋ', 'ఌ', 'ఎ',
    'ఏ', 'ఐ', 'ఒ', 'ఓ', 'ఔ', 'క', 'ఖ', 'గ', 'ఘ', 'ఙ', 'చ', 'ఛ', 'జ', 'ఝ', 'ఞ',
    'ట', 'ఠ', 'డ', 'ఢ', 'ణ', 'త', 'థ', 'ద', 'ధ', 'న', 'ప', 'ఫ', 'బ', 'భ', 'మ',
    'య', 'ర', 'ఱ', 'ల', 'ళ', 'వ', 'శ', 'ష', 'స', 'హ', 'ఽ', 'ౘ', 'ౙ', 'ౠ', 'ౡ',
    '౦', '౧', '౨', '౩', '౪', '౫', '౬', '౭', '౮', '౯', 'ಅ', 'ಆ', 'ಇ', 'ಈ', 'ಉ',
    'ಊ', 'ಋ', 'ಌ', 'ಎ', 'ಏ', 'ಐ', 'ಒ', 'ಓ', 'ಔ', 'ಕ', 'ಖ', 'ಗ', 'ಘ', 'ಙ', 'ಚ',
    'ಛ', 'ಜ', 'ಝ', 'ಞ', 'ಟ', 'ಠ', 'ಡ', 'ಢ', 'ಣ', 'ತ', 'ಥ', 'ದ', 'ಧ', 'ನ', 'ಪ',
    'ಫ', 'ಬ', 'ಭ', 'ಮ', 'ಯ', 'ರ', 'ಱ', 'ಲ', 'ಳ', 'ವ', 'ಶ', 'ಷ', 'ಸ', 'ಹ', 'ಽ',
    'ೞ', 'ೠ', 'ೡ', '೦', '೧', '೨', '೩', '೪', '೫', '೬', '೭', '೮', '೯', 'അ', 'ആ',
    'ഇ', 'ഈ', 'ഉ', 'ഊ', 'ഋ', 'ഌ', 'എ', 'ഏ', 'ഐ', 'ഒ', 'ഓ', 'ഔ', 'ക', 'ഖ', 'ഗ',
    'ഘ', 'ങ', 'ച', 'ഛ', 'ജ', 'ഝ', 'ഞ', 'ട', 'ഠ', 'ഡ', 'ഢ', 'ണ', 'ത', 'ഥ', 'ദ',
    'ധ', 'ന', 'പ', 'ഫ', 'ബ', 'ഭ', 'മ', 'യ', 'ര', 'റ', 'ല', 'ള', 'ഴ', 'വ', 'ശ',
    'ഷ', 'സ', 'ഹ', 'ഽ', 'ൠ', 'ൡ', '൦', '൧', '൨', '൩', '൪', '൫', '൬', '൭', '൮',
    '൯', 'ൺ', 'ൻ', 'ർ', 'ൽ', 'ൾ', 'ൿ', 'අ', 'ආ', 'ඇ', 'ඈ', 'ඉ', 'ඊ', 'උ', 'ඌ',
    'ඍ', 'ඎ', 'ඏ', 'ඐ', 'එ', 'ඒ', 'ඓ', 'ඔ', 'ඕ', 'ඖ', 'ක', 'ඛ', 'ග', 'ඝ', 'ඞ',
    'ඟ', 'ච', 'ඡ', 'ජ', 'ඣ', 'ඤ', 'ඥ', 'ඦ', 'ට', 'ඨ', 'ඩ', 'ඪ', 'ණ', 'ඬ', 'ත',
    'ථ', 'ද', 'ධ', 'න', 'ඳ', 'ප', 'ඵ', 'බ', 'භ', 'ම', 'ඹ', 'ය', 'ර', 'ල', 'ව',
    'ශ', 'ෂ', 'ස', 'හ', 'ළ', 'ෆ', 'ก', 'ข', 'ฃ', 'ค', 'ฅ', 'ฆ', 'ง', 'จ', 'ฉ',
    'ช', 'ซ', 'ฌ', 'ญ', 'ฎ', 'ฏ', 'ฐ', 'ฑ', 'ฒ', 'ณ', 'ด', 'ต', 'ถ', 'ท', 'ธ',
    'น', 'บ', 'ป', 'ผ', 'ฝ', 'พ', 'ฟ', 'ภ', 'ม', 'ย', 'ร', 'ฤ', 'ล', 'ฦ', 'ว',
    'ศ', 'ษ', 'ส', 'ห', 'ฬ', 'อ', 'ฮ', 'ฯ', 'ะ', 'า', 'ำ', 'เ', 'แ', 'โ', 'ใ',
    'ไ', 'ๅ', 'ๆ', '๐', '๑', '๒', '๓', '๔', '๕', '๖', '๗', '๘', '๙', 'ກ', 'ຂ',
    'ຄ', 'ງ', 'ຈ', 'ຊ', 'ຍ', 'ດ', 'ຕ', 'ຖ', 'ທ', 'ນ', 'ບ', 'ປ', 'ຜ', 'ຝ', 'ພ',
    'ຟ', 'ມ', 'ຢ', 'ຣ', 'ລ', 'ວ', 'ສ', 'ຫ', 'ອ', 'ຮ', 'ຯ', 'ະ', 'າ', 'ຳ', 'ຽ',
    'ເ', 'ແ', 'ໂ', 'ໃ', 'ໄ', 'ໆ', '໐', '໑', '໒', '໓', '໔', '໕', '໖', '໗', '໘',
    '໙', 'ໜ', 'ໝ', 'ༀ', '༠', '༡', '༢', '༣', '༤', '༥', '༦', '༧', '༨', '༩', 'ཀ',
    'ཁ', 'ག', 'གྷ', 'ང', 'ཅ', 'ཆ', 'ཇ', 'ཉ', 'ཊ', 'ཋ', 'ཌ', 'ཌྷ', 'ཎ', 'ཏ', 'ཐ',
    'ད', 'དྷ', 'ན', 'པ', 'ཕ', 'བ', 'བྷ', 'མ', 'ཙ', 'ཚ', 'ཛ', 'ཛྷ', 'ཝ', 'ཞ', 'ཟ',
    'འ', 'ཡ', 'ར', 'ལ', 'ཤ', 'ཥ', 'ས', 'ཧ', 'ཨ', 'ཀྵ', 'ཪ', 'ྈ', 'ྉ', 'ྊ', 'ྋ',
    'ჺ', 'ჼ', 'ᄀ', 'ᄁ', 'ᄂ', 'ᄃ', 'ᄄ', 'ᄅ', 'ᄆ', 'ᄇ', 'ᄈ', 'ᄉ', 'ᄊ', 'ᄋ', 'ᄌ',
    'ᄍ', 'ᄎ', 'ᄏ', 'ᄐ', 'ᄑ', 'ᄒ', 'ᄓ', 'ᄔ', 'ᄕ', 'ᄖ', 'ᄗ', 'ᄘ', 'ᄙ', 'ᄚ', 'ᄛ',
    'ᄜ', 'ᄝ', 'ᄞ', 'ᄟ', 'ᄠ', 'ᄡ', 'ᄢ', 'ᄣ', 'ᄤ', 'ᄥ', 'ᄦ', 'ᄧ', 'ᄨ', 'ᄩ', 'ᄪ',
    'ᄫ', 'ᄬ', 'ᄭ', 'ᄮ', 'ᄯ', 'ᄰ', 'ᄱ', 'ᄲ', 'ᄳ', 'ᄴ', 'ᄵ', 'ᄶ', 'ᄷ', 'ᄸ', 'ᄹ',
    'ᄺ', 'ᄻ', 'ᄼ', 'ᄽ', 'ᄾ', 'ᄿ', 'ᅀ', 'ᅁ', 'ᅂ', 'ᅃ', 'ᅄ', 'ᅅ', 'ᅆ', 'ᅇ', 'ᅈ',
    'ᅉ', 'ᅊ', 'ᅋ', 'ᅌ', 'ᅍ', 'ᅎ', 'ᅏ', 'ᅐ', 'ᅑ', 'ᅒ', 'ᅓ', 'ᅔ', 'ᅕ', 'ᅖ', 'ᅗ',
    'ᅘ', 'ᅙ', 'ᅟ', 'ᅠ', 'ᅡ', 'ᅢ', 'ᅣ', 'ᅤ', 'ᅥ', 'ᅦ', 'ᅧ', 'ᅨ', 'ᅩ', 'ᅪ', 'ᅫ',
    'ᅬ', 'ᅭ', 'ᅮ', 'ᅯ', 'ᅰ', 'ᅱ', 'ᅲ', 'ᅳ', 'ᅴ', 'ᅵ', 'ᅶ', 'ᅷ', 'ᅸ', 'ᅹ', 'ᅺ',
    'ᅻ', 'ᅼ', 'ᅽ', 'ᅾ', 'ᅿ', 'ᆀ', 'ᆁ', 'ᆂ', 'ᆃ', 'ᆄ', 'ᆅ', 'ᆆ', 'ᆇ', 'ᆈ', 'ᆉ',
    'ᆊ', 'ᆋ', 'ᆌ', 'ᆍ', 'ᆎ', 'ᆏ', 'ᆐ', 'ᆑ', 'ᆒ', 'ᆓ', 'ᆔ', 'ᆕ', 'ᆖ', 'ᆗ', 'ᆘ',
    'ᆙ', 'ᆚ', 'ᆛ', 'ᆜ', 'ᆝ', 'ᆞ', 'ᆟ', 'ᆠ', 'ᆡ', 'ᆢ', 'ᆨ', 'ᆩ', 'ᆪ', 'ᆫ', 'ᆬ',
    'ᆭ', 'ᆮ', 'ᆯ', 'ᆰ', 'ᆱ', 'ᆲ', 'ᆳ', 'ᆴ', 'ᆵ', 'ᆶ', 'ᆷ', 'ᆸ', 'ᆹ', 'ᆺ', 'ᆻ',
    'ᆼ', 'ᆽ', 'ᆾ', 'ᆿ', 'ᇀ', 'ᇁ', 'ᇂ', 'ᇃ', 'ᇄ', 'ᇅ', 'ᇆ', 'ᇇ', 'ᇈ', 'ᇉ', 'ᇊ',
    'ᇋ', 'ᇌ', 'ᇍ', 'ᇎ', 'ᇏ', 'ᇐ', 'ᇑ', 'ᇒ', 'ᇓ', 'ᇔ', 'ᇕ', 'ᇖ', 'ᇗ', 'ᇘ', 'ᇙ',
    'ᇚ', 'ᇛ', 'ᇜ', 'ᇝ', 'ᇞ', 'ᇟ', 'ᇠ', 'ᇡ', 'ᇢ', 'ᇣ', 'ᇤ', 'ᇥ', 'ᇦ', 'ᇧ', 'ᇨ',
    'ᇩ', 'ᇪ', 'ᇫ', 'ᇬ', 'ᇭ', 'ᇮ', 'ᇯ', 'ᇰ', 'ᇱ', 'ᇲ', 'ᇳ', 'ᇴ', 'ᇵ', 'ᇶ', 'ᇷ',
    'ᇸ', 'ᇹ', 'ሀ', 'ሁ', 'ሂ', 'ሃ', 'ሄ', 'ህ', 'ሆ', 'ሇ', 'ለ', 'ሉ', 'ሊ', 'ላ', 'ሌ',
    'ል', 'ሎ', 'ሏ', 'ሐ', 'ሑ', 'ሒ', 'ሓ', 'ሔ', 'ሕ', 'ሖ', 'ሗ', 'መ', 'ሙ', 'ሚ', 'ማ',
    'ሜ', 'ም', 'ሞ', 'ሟ', 'ሠ', 'ሡ', 'ሢ', 'ሣ', 'ሤ', 'ሥ', 'ሦ', 'ሧ', 'ረ', 'ሩ', 'ሪ',
    'ራ', 'ሬ', 'ር', 'ሮ', 'ሯ', 'ሰ', 'ሱ', 'ሲ', 'ሳ', 'ሴ', 'ስ', 'ሶ', 'ሷ', 'ሸ', 'ሹ',
    'ሺ', 'ሻ', 'ሼ', 'ሽ', 'ሾ', 'ሿ', 'ቀ', 'ቁ', 'ቂ', 'ቃ', 'ቄ', 'ቅ', 'ቆ', 'ቇ', 'ቈ',
    'ቊ', 'ቋ', 'ቌ', 'ቍ', 'ቐ', 'ቑ', 'ቒ', 'ቓ', 'ቔ', 'ቕ', 'ቖ', 'ቘ', 'ቚ', 'ቛ', 'ቜ',
    'ቝ', 'በ', 'ቡ', 'ቢ', 'ባ', 'ቤ', 'ብ', 'ቦ', 'ቧ', 'ቨ', 'ቩ', 'ቪ', 'ቫ', 'ቬ', 'ቭ',
    'ቮ', 'ቯ', 'ተ', 'ቱ', 'ቲ', 'ታ', 'ቴ', 'ት', 'ቶ', 'ቷ', 'ቸ', 'ቹ', 'ቺ', 'ቻ', 'ቼ',
    'ች', 'ቾ', 'ቿ', 'ኀ', 'ኁ', 'ኂ', 'ኃ', 'ኄ', 'ኅ', 'ኆ', 'ኇ', 'ኈ', 'ኊ', 'ኋ', 'ኌ',
    'ኍ', 'ነ', 'ኑ', 'ኒ', 'ና', 'ኔ', 'ን', 'ኖ', 'ኗ', 'ኘ', 'ኙ', 'ኚ', 'ኛ', 'ኜ', 'ኝ',
    'ኞ', 'ኟ', 'አ', 'ኡ', 'ኢ', 'ኣ', 'ኤ', 'እ', 'ኦ', 'ኧ', 'ከ', 'ኩ', 'ኪ', 'ካ', 'ኬ',
    'ክ', 'ኮ', 'ኯ', 'ኰ', 'ኲ', 'ኳ', 'ኴ', 'ኵ', 'ኸ', 'ኹ', 'ኺ', 'ኻ', 'ኼ', 'ኽ', 'ኾ',
    'ዀ', 'ዂ', 'ዃ', 'ዄ', 'ዅ', 'ወ', 'ዉ', 'ዊ', 'ዋ', 'ዌ', 'ው', 'ዎ', 'ዏ', 'ዐ', 'ዑ',
    'ዒ', 'ዓ', 'ዔ', 'ዕ', 'ዖ', 'ዘ', 'ዙ', 'ዚ', 'ዛ', 'ዜ', 'ዝ', 'ዞ', 'ዟ', 'ዠ', 'ዡ',
    'ዢ', 'ዣ', 'ዤ', 'ዥ', 'ዦ', 'ዧ', 'የ', 'ዩ', 'ዪ', 'ያ', 'ዬ', 'ይ', 'ዮ', 'ዯ', 'ደ',
    'ዱ', 'ዲ', 'ዳ', 'ዴ', 'ድ', 'ዶ', 'ዷ', 'ዸ', 'ዹ', 'ዺ', 'ዻ', 'ዼ', 'ዽ', 'ዾ', 'ዿ',
    'ጀ', 'ጁ', 'ጂ', 'ጃ', 'ጄ', 'ጅ', 'ጆ', 'ጇ', 'ገ', 'ጉ', 'ጊ', 'ጋ', 'ጌ', 'ግ', 'ጎ',
    'ጏ', 'ጐ', 'ጒ', 'ጓ', 'ጔ', 'ጕ', 'ጘ', 'ጙ', 'ጚ', 'ጛ', 'ጜ', 'ጝ', 'ጞ', 'ጟ', 'ጠ',
    'ጡ', 'ጢ', 'ጣ', 'ጤ', 'ጥ', 'ጦ', 'ጧ', 'ጨ', 'ጩ', 'ጪ', 'ጫ', 'ጬ', 'ጭ', 'ጮ', 'ጯ',
    'ጰ', 'ጱ', 'ጲ', 'ጳ', 'ጴ', 'ጵ', 'ጶ', 'ጷ', 'ጸ', 'ጹ', 'ጺ', 'ጻ', 'ጼ', 'ጽ', 'ጾ',
    'ጿ', 'ፀ', 'ፁ', 'ፂ', 'ፃ', 'ፄ', 'ፅ', 'ፆ', 'ፇ', 'ፈ', 'ፉ', 'ፊ', 'ፋ', 'ፌ', 'ፍ',
    'ፎ', 'ፏ', 'ፐ', 'ፑ', 'ፒ', 'ፓ', 'ፔ', 'ፕ', 'ፖ', 'ፗ', 'ፘ', 'ፙ', 'ፚ', 'ᎀ', 'ᎁ',
    'ᎂ', 'ᎃ', 'ᎄ', 'ᎅ', 'ᎆ', 'ᎇ', 'ᎈ', 'ᎉ', 'ᎊ', 'ᎋ', 'ᎌ', 'ᎍ', 'ᎎ', 'ᎏ', 'Ꭰ',
    'Ꭱ', 'Ꭲ', 'Ꭳ', 'Ꭴ', 'Ꭵ', 'Ꭶ', 'Ꭷ', 'Ꭸ', 'Ꭹ', 'Ꭺ', 'Ꭻ', 'Ꭼ', 'Ꭽ', 'Ꭾ', 'Ꭿ',
    'Ꮀ', 'Ꮁ', 'Ꮂ', 'Ꮃ', 'Ꮄ', 'Ꮅ', 'Ꮆ', 'Ꮇ', 'Ꮈ', 'Ꮉ', 'Ꮊ', 'Ꮋ', 'Ꮌ', 'Ꮍ', 'Ꮎ',
    'Ꮏ', 'Ꮐ', 'Ꮑ', 'Ꮒ', 'Ꮓ', 'Ꮔ', 'Ꮕ', 'Ꮖ', 'Ꮗ', 'Ꮘ', 'Ꮙ', 'Ꮚ', 'Ꮛ', 'Ꮜ', 'Ꮝ',
    'Ꮞ', 'Ꮟ', 'Ꮠ', 'Ꮡ', 'Ꮢ', 'Ꮣ', 'Ꮤ', 'Ꮥ', 'Ꮦ', 'Ꮧ', 'Ꮨ', 'Ꮩ', 'Ꮪ', 'Ꮫ', 'Ꮬ',
    'Ꮭ', 'Ꮮ', 'Ꮯ', 'Ꮰ', 'Ꮱ', 'Ꮲ', 'Ꮳ', 'Ꮴ', 'Ꮵ', 'Ꮶ', 'Ꮷ', 'Ꮸ', 'Ꮹ', 'Ꮺ', 'Ꮻ',
    'Ꮼ', 'Ꮽ', 'Ꮾ', 'Ꮿ', 'Ᏸ', 'Ᏹ', 'Ᏺ', 'Ᏻ', 'Ᏼ', 'ᐁ', 'ᐂ', 'ᐃ', 'ᐄ', 'ᐅ', 'ᐆ',
    'ᐇ', 'ᐈ', 'ᐉ', 'ᐊ', 'ᐋ', 'ᐌ', 'ᐍ', 'ᐎ', 'ᐏ', 'ᐐ', 'ᐑ', 'ᐒ', 'ᐓ', 'ᐔ', 'ᐕ',
    'ᐖ', 'ᐗ', 'ᐘ', 'ᐙ', 'ᐚ', 'ᐛ', 'ᐜ', 'ᐝ', 'ᐞ', 'ᐟ', 'ᐠ', 'ᐡ', 'ᐢ', 'ᐣ', 'ᐤ',
    'ᐥ', 'ᐦ', 'ᐧ', 'ᐨ', 'ᐩ', 'ᐪ', 'ᐫ', 'ᐬ', 'ᐭ', 'ᐮ', 'ᐯ', 'ᐰ', 'ᐱ', 'ᐲ', 'ᐳ',
    'ᐴ', 'ᐵ', 'ᐶ', 'ᐷ', 'ᐸ', 'ᐹ', 'ᐺ', 'ᐻ', 'ᐼ', 'ᐽ', 'ᐾ', 'ᐿ', 'ᑀ', 'ᑁ', 'ᑂ',
    'ᑃ', 'ᑄ', 'ᑅ', 'ᑆ', 'ᑇ', 'ᑈ', 'ᑉ', 'ᑊ', 'ᑋ', 'ᑌ', 'ᑍ', 'ᑎ', 'ᑏ', 'ᑐ', 'ᑑ',
    'ᑒ', 'ᑓ', 'ᑔ', 'ᑕ', 'ᑖ', 'ᑗ', 'ᑘ', 'ᑙ', 'ᑚ', 'ᑛ', 'ᑜ', 'ᑝ', 'ᑞ', 'ᑟ', 'ᑠ',
    'ᑡ', 'ᑢ', 'ᑣ', 'ᑤ', 'ᑥ', 'ᑦ', 'ᑧ', 'ᑨ', 'ᑩ', 'ᑪ', 'ᑫ', 'ᑬ', 'ᑭ', 'ᑮ', 'ᑯ',
    'ᑰ', 'ᑱ', 'ᑲ', 'ᑳ', 'ᑴ', 'ᑵ', 'ᑶ', 'ᑷ', 'ᑸ', 'ᑹ', 'ᑺ', 'ᑻ', 'ᑼ', 'ᑽ', 'ᑾ',
    'ᑿ', 'ᒀ', 'ᒁ', 'ᒂ', 'ᒃ', 'ᒄ', 'ᒅ', 'ᒆ', 'ᒇ', 'ᒈ', 'ᒉ', 'ᒊ', 'ᒋ', 'ᒌ', 'ᒍ',
    'ᒎ', 'ᒏ', 'ᒐ', 'ᒑ', 'ᒒ', 'ᒓ', 'ᒔ', 'ᒕ', 'ᒖ', 'ᒗ', 'ᒘ', 'ᒙ', 'ᒚ', 'ᒛ', 'ᒜ',
    'ᒝ', 'ᒞ', 'ᒟ', 'ᒠ', 'ᒡ', 'ᒢ', 'ᒣ', 'ᒤ', 'ᒥ', 'ᒦ', 'ᒧ', 'ᒨ', 'ᒩ', 'ᒪ', 'ᒫ',
    'ᒬ', 'ᒭ', 'ᒮ', 'ᒯ', 'ᒰ', 'ᒱ', 'ᒲ', 'ᒳ', 'ᒴ', 'ᒵ', 'ᒶ', 'ᒷ', 'ᒸ', 'ᒹ', 'ᒺ',
    'ᒻ', 'ᒼ', 'ᒽ', 'ᒾ', 'ᒿ', 'ᓀ', 'ᓁ', 'ᓂ', 'ᓃ', 'ᓄ', 'ᓅ', 'ᓆ', 'ᓇ', 'ᓈ', 'ᓉ',
    'ᓊ', 'ᓋ', 'ᓌ', 'ᓍ', 'ᓎ', 'ᓏ', 'ᓐ', 'ᓑ', 'ᓒ', 'ᓓ', 'ᓔ', 'ᓕ', 'ᓖ', 'ᓗ', 'ᓘ',
    'ᓙ', 'ᓚ', 'ᓛ', 'ᓜ', 'ᓝ', 'ᓞ', 'ᓟ', 'ᓠ', 'ᓡ', 'ᓢ', 'ᓣ', 'ᓤ', 'ᓥ', 'ᓦ', 'ᓧ',
    'ᓨ', 'ᓩ', 'ᓪ', 'ᓫ', 'ᓬ', 'ᓭ', 'ᓮ', 'ᓯ', 'ᓰ', 'ᓱ', 'ᓲ', 'ᓳ', 'ᓴ', 'ᓵ', 'ᓶ',
    'ᓷ', 'ᓸ', 'ᓹ', 'ᓺ', 'ᓻ', 'ᓼ', 'ᓽ', 'ᓾ', 'ᓿ', 'ᔀ', 'ᔁ', 'ᔂ', 'ᔃ', 'ᔄ', 'ᔅ',
    'ᔆ', 'ᔇ', 'ᔈ', 'ᔉ', 'ᔊ', 'ᔋ', 'ᔌ', 'ᔍ', 'ᔎ', 'ᔏ', 'ᔐ', 'ᔑ', 'ᔒ', 'ᔓ', 'ᔔ',
    'ᔕ', 'ᔖ', 'ᔗ', 'ᔘ', 'ᔙ', 'ᔚ', 'ᔛ', 'ᔜ', 'ᔝ', 'ᔞ', 'ᔟ', 'ᔠ', 'ᔡ', 'ᔢ', 'ᔣ',
    'ᔤ', 'ᔥ', 'ᔦ', 'ᔧ', 'ᔨ', 'ᔩ', 'ᔪ', 'ᔫ', 'ᔬ', 'ᔭ', 'ᔮ', 'ᔯ', 'ᔰ', 'ᔱ', 'ᔲ',
    'ᔳ', 'ᔴ', 'ᔵ', 'ᔶ', 'ᔷ', 'ᔸ', 'ᔹ', 'ᔺ', 'ᔻ', 'ᔼ', 'ᔽ', 'ᔾ', 'ᔿ', 'ᕀ', 'ᕁ',
    'ᕂ', 'ᕃ', 'ᕄ', 'ᕅ', 'ᕆ', 'ᕇ', 'ᕈ', 'ᕉ', 'ᕊ', 'ᕋ', 'ᕌ', 'ᕍ', 'ᕎ', 'ᕏ', 'ᕐ',
    'ᕑ', 'ᕒ', 'ᕓ', 'ᕔ', 'ᕕ', 'ᕖ', 'ᕗ', 'ᕘ', 'ᕙ', 'ᕚ', 'ᕛ', 'ᕜ', 'ᕝ', 'ᕞ', 'ᕟ',
    'ᕠ', 'ᕡ', 'ᕢ', 'ᕣ', 'ᕤ', 'ᕥ', 'ᕦ', 'ᕧ', 'ᕨ', 'ᕩ', 'ᕪ', 'ᕫ', 'ᕬ', 'ᕭ', 'ᕮ',
    'ᕯ', 'ᕰ', 'ᕱ', 'ᕲ', 'ᕳ', 'ᕴ', 'ᕵ', 'ᕶ', 'ᕷ', 'ᕸ', 'ᕹ', 'ᕺ', 'ᕻ', 'ᕼ', 'ᕽ',
    'ᕾ', 'ᕿ', 'ᖀ', 'ᖁ', 'ᖂ', 'ᖃ', 'ᖄ', 'ᖅ', 'ᖆ', 'ᖇ', 'ᖈ', 'ᖉ', 'ᖊ', 'ᖋ', 'ᖌ',
    'ᖍ', 'ᖎ', 'ᖏ', 'ᖐ', 'ᖑ', 'ᖒ', 'ᖓ', 'ᖔ', 'ᖕ', 'ᖖ', 'ᖗ', 'ᖘ', 'ᖙ', 'ᖚ', 'ᖛ',
    'ᖜ', 'ᖝ', 'ᖞ', 'ᖟ', 'ᖠ', 'ᖡ', 'ᖢ', 'ᖣ', 'ᖤ', 'ᖥ', 'ᖦ', 'ᖧ', 'ᖨ', 'ᖩ', 'ᖪ',
    'ᖫ', 'ᖬ', 'ᖭ', 'ᖮ', 'ᖯ', 'ᖰ', 'ᖱ', 'ᖲ', 'ᖳ', 'ᖴ', 'ᖵ', 'ᖶ', 'ᖷ', 'ᖸ', 'ᖹ',
    'ᖺ', 'ᖻ', 'ᖼ', 'ᖽ', 'ᖾ', 'ᖿ', 'ᗀ', 'ᗁ', 'ᗂ', 'ᗃ', 'ᗄ', 'ᗅ', 'ᗆ', 'ᗇ', 'ᗈ',
    'ᗉ', 'ᗊ', 'ᗋ', 'ᗌ', 'ᗍ', 'ᗎ', 'ᗏ', 'ᗐ', 'ᗑ', 'ᗒ', 'ᗓ', 'ᗔ', 'ᗕ', 'ᗖ', 'ᗗ',
    'ᗘ', 'ᗙ', 'ᗚ', 'ᗛ', 'ᗜ', 'ᗝ', 'ᗞ', 'ᗟ', 'ᗠ', 'ᗡ', 'ᗢ', 'ᗣ', 'ᗤ', 'ᗥ', 'ᗦ',
    'ᗧ', 'ᗨ', 'ᗩ', 'ᗪ', 'ᗫ', 'ᗬ', 'ᗭ', 'ᗮ', 'ᗯ', 'ᗰ', 'ᗱ', 'ᗲ', 'ᗳ', 'ᗴ', 'ᗵ',
    'ᗶ', 'ᗷ', 'ᗸ', 'ᗹ', 'ᗺ', 'ᗻ', 'ᗼ', 'ᗽ', 'ᗾ', 'ᗿ', 'ᘀ', 'ᘁ', 'ᘂ', 'ᘃ', 'ᘄ',
    'ᘅ', 'ᘆ', 'ᘇ', 'ᘈ', 'ᘉ', 'ᘊ', 'ᘋ', 'ᘌ', 'ᘍ', 'ᘎ', 'ᘏ', 'ᘐ', 'ᘑ', 'ᘒ', 'ᘓ',
    'ᘔ', 'ᘕ', 'ᘖ', 'ᘗ', 'ᘘ', 'ᘙ', 'ᘚ', 'ᘛ', 'ᘜ', 'ᘝ', 'ᘞ', 'ᘟ', 'ᘠ', 'ᘡ', 'ᘢ',
    'ᘣ', 'ᘤ', 'ᘥ', 'ᘦ', 'ᘧ', 'ᘨ', 'ᘩ', 'ᘪ', 'ᘫ', 'ᘬ', 'ᘭ', 'ᘮ', 'ᘯ', 'ᘰ', 'ᘱ',
    'ᘲ', 'ᘳ', 'ᘴ', 'ᘵ', 'ᘶ', 'ᘷ', 'ᘸ', 'ᘹ', 'ᘺ', 'ᘻ', 'ᘼ', 'ᘽ', 'ᘾ', 'ᘿ', 'ᙀ',
    'ᙁ', 'ᙂ', 'ᙃ', 'ᙄ', 'ᙅ', 'ᙆ', 'ᙇ', 'ᙈ', 'ᙉ', 'ᙊ', 'ᙋ', 'ᙌ', 'ᙍ', 'ᙎ', 'ᙏ',
    'ᙐ', 'ᙑ', 'ᙒ', 'ᙓ', 'ᙔ', 'ᙕ', 'ᙖ', 'ᙗ', 'ᙘ', 'ᙙ', 'ᙚ', 'ᙛ', 'ᙜ', 'ᙝ', 'ᙞ',
    'ᙟ', 'ᙠ', 'ᙡ', 'ᙢ', 'ᙣ', 'ᙤ', 'ᙥ', 'ᙦ', 'ᙧ', 'ᙨ', 'ᙩ', 'ᙪ', 'ᙫ', 'ᙬ', 'ᙯ',
    'ᙰ', 'ᙱ', 'ᙲ', 'ᙳ', 'ᙴ', 'ᙵ', 'ᙶ', 'ᚁ', 'ᚂ', 'ᚃ', 'ᚄ', 'ᚅ', 'ᚆ', 'ᚇ', 'ᚈ',
    'ᚉ', 'ᚊ', 'ᚋ', 'ᚌ', 'ᚍ', 'ᚎ', 'ᚏ', 'ᚐ', 'ᚑ', 'ᚒ', 'ᚓ', 'ᚔ', 'ᚕ', 'ᚖ', 'ᚗ',
    'ᚘ', 'ᚙ', 'ᚚ', 'ᚠ', 'ᚡ', 'ᚢ', 'ᚣ', 'ᚤ', 'ᚥ', 'ᚦ', 'ᚧ', 'ᚨ', 'ᚩ', 'ᚪ', 'ᚫ',
    'ᚬ', 'ᚭ', 'ᚮ', 'ᚯ', 'ᚰ', 'ᚱ', 'ᚲ', 'ᚳ', 'ᚴ', 'ᚵ', 'ᚶ', 'ᚷ', 'ᚸ', 'ᚹ', 'ᚺ',
    'ᚻ', 'ᚼ', 'ᚽ', 'ᚾ', 'ᚿ', 'ᛀ', 'ᛁ', 'ᛂ', 'ᛃ', 'ᛄ', 'ᛅ', 'ᛆ', 'ᛇ', 'ᛈ', 'ᛉ',
    'ᛊ', 'ᛋ', 'ᛌ', 'ᛍ', 'ᛎ', 'ᛏ', 'ᛐ', 'ᛑ', 'ᛒ', 'ᛓ', 'ᛔ', 'ᛕ', 'ᛖ', 'ᛗ', 'ᛘ',
    'ᛙ', 'ᛚ', 'ᛛ', 'ᛜ', 'ᛝ', 'ᛞ', 'ᛟ', 'ᛠ', 'ᛡ', 'ᛢ', 'ᛣ', 'ᛤ', 'ᛥ', 'ᛦ', 'ᛧ',
    'ᛨ', 'ᛩ', 'ᛪ', 'ក', 'ខ', 'គ', 'ឃ', 'ង', 'ច', 'ឆ', 'ជ', 'ឈ', 'ញ', 'ដ', 'ឋ',
    'ឌ', 'ឍ', 'ណ', 'ត', 'ថ', 'ទ', 'ធ', 'ន', 'ប', 'ផ', 'ព', 'ភ', 'ម', 'យ', 'រ',
    'ល', 'វ', 'ឝ', 'ឞ', 'ស', 'ហ', 'ឡ', 'អ', 'ឣ', 'ឤ', 'ឥ', 'ឦ', 'ឧ', 'ឨ', 'ឩ',
    'ឪ', 'ឫ', 'ឬ', 'ឭ', 'ឮ', 'ឯ', 'ឰ', 'ឱ', 'ឲ', 'ឳ', 'ៗ', 'ៜ', '០', '១', '២',
    '៣', '៤', '៥', '៦', '៧', '៨', '៩', '᠐', '᠑', '᠒', '᠓', '᠔', '᠕', '᠖', '᠗',
    '᠘', '᠙', 'ᠠ', 'ᠡ', 'ᠢ', 'ᠣ', 'ᠤ', 'ᠥ', 'ᠦ', 'ᠧ', 'ᠨ', 'ᠩ', 'ᠪ', 'ᠫ', 'ᠬ',
    'ᠭ', 'ᠮ', 'ᠯ', 'ᠰ', 'ᠱ', 'ᠲ', 'ᠳ', 'ᠴ', 'ᠵ', 'ᠶ', 'ᠷ', 'ᠸ', 'ᠹ', 'ᠺ', 'ᠻ',
    'ᠼ', 'ᠽ', 'ᠾ', 'ᠿ', 'ᡀ', 'ᡁ', 'ᡂ', 'ᡃ', 'ᡄ', 'ᡅ', 'ᡆ', 'ᡇ', 'ᡈ', 'ᡉ', 'ᡊ',
    'ᡋ', 'ᡌ', 'ᡍ', 'ᡎ', 'ᡏ', 'ᡐ', 'ᡑ', 'ᡒ', 'ᡓ', 'ᡔ', 'ᡕ', 'ᡖ', 'ᡗ', 'ᡘ', 'ᡙ',
    'ᡚ', 'ᡛ', 'ᡜ', 'ᡝ', 'ᡞ', 'ᡟ', 'ᡠ', 'ᡡ', 'ᡢ', 'ᡣ', 'ᡤ', 'ᡥ', 'ᡦ', 'ᡧ', 'ᡨ',
    'ᡩ', 'ᡪ', 'ᡫ', 'ᡬ', 'ᡭ', 'ᡮ', 'ᡯ', 'ᡰ', 'ᡱ', 'ᡲ', 'ᡳ', 'ᡴ', 'ᡵ', 'ᡶ', 'ᡷ',
    'ᢀ', 'ᢁ', 'ᢂ', 'ᢃ', 'ᢄ', 'ᢅ', 'ᢆ', 'ᢇ', 'ᢈ', 'ᢉ', 'ᢊ', 'ᢋ', 'ᢌ', 'ᢍ', 'ᢎ',
    'ᢏ', 'ᢐ', 'ᢑ', 'ᢒ', 'ᢓ', 'ᢔ', 'ᢕ', 'ᢖ', 'ᢗ', 'ᢘ', 'ᢙ', 'ᢚ', 'ᢛ', 'ᢜ', 'ᢝ',
    'ᢞ', 'ᢟ', 'ᢠ', 'ᢡ', 'ᢢ', 'ᢣ', 'ᢤ', 'ᢥ', 'ᢦ', 'ᢧ', 'ᢨ', 'ᥐ', 'ᥑ', 'ᥒ', 'ᥓ',
    'ᥔ', 'ᥕ', 'ᥖ', 'ᥗ', 'ᥘ', 'ᥙ', 'ᥚ', 'ᥛ', 'ᥜ', 'ᥝ', 'ᥞ', 'ᥟ', 'ᥠ', 'ᥡ', 'ᥢ',
    'ᥣ', 'ᥤ', 'ᥥ', 'ᥦ', 'ᥧ', 'ᥨ', 'ᥩ', 'ᥪ', 'ᥫ', 'ᥬ', 'ᥭ', 'ᥰ', 'ᥱ', 'ᥲ', 'ᥳ',
    'ᥴ', 'ᦀ', 'ᦁ', 'ᦂ', 'ᦃ', 'ᦄ', 'ᦅ', 'ᦆ', 'ᦇ', 'ᦈ', 'ᦉ', 'ᦊ', 'ᦋ', 'ᦌ', 'ᦍ',
    'ᦎ', 'ᦏ', 'ᦐ', 'ᦑ', 'ᦒ', 'ᦓ', 'ᦔ', 'ᦕ', 'ᦖ', 'ᦗ', 'ᦘ', 'ᦙ', 'ᦚ', 'ᦛ', 'ᦜ',
    'ᦝ', 'ᦞ', 'ᦟ', 'ᦠ', 'ᦡ', 'ᦢ', 'ᦣ', 'ᦤ', 'ᦥ', 'ᦦ', 'ᦧ', 'ᦨ', 'ᦩ', 'ᧁ', 'ᧂ',
    'ᧃ', 'ᧄ', 'ᧅ', 'ᧆ', 'ᧇ', '᧐', '᧑', '᧒', '᧓', '᧔', '᧕', '᧖', '᧗', '᧘', '᧙',
    'ᴀ', 'ᴁ', 'ᴂ', 'ᴃ', 'ᴄ', 'ᴅ', 'ᴆ', 'ᴇ', 'ᴈ', 'ᴉ', 'ᴊ', 'ᴋ', 'ᴌ', 'ᴍ', 'ᴎ',
    'ᴏ', 'ᴐ', 'ᴑ', 'ᴒ', 'ᴓ', 'ᴔ', 'ᴕ', 'ᴖ', 'ᴗ', 'ᴘ', 'ᴙ', 'ᴚ', 'ᴛ', 'ᴜ', 'ᴝ',
    'ᴞ', 'ᴟ', 'ᴠ', 'ᴡ', 'ᴢ', 'ᴣ', 'ᴤ', 'ᴥ', 'ᴦ', 'ᴧ', 'ᴨ', 'ᴩ', 'ᴪ', 'ᴫ', 'ᴬ',
    'ᴭ', 'ᴮ', 'ᴯ', 'ᴰ', 'ᴱ', 'ᴲ', 'ᴳ', 'ᴴ', 'ᴵ', 'ᴶ', 'ᴷ', 'ᴸ', 'ᴹ', 'ᴺ', 'ᴻ',
    'ᴼ', 'ᴽ', 'ᴾ', 'ᴿ', 'ᵀ', 'ᵁ', 'ᵂ', 'ᵃ', 'ᵄ', 'ᵅ', 'ᵆ', 'ᵇ', 'ᵈ', 'ᵉ', 'ᵊ',
    'ᵋ', 'ᵌ', 'ᵍ', 'ᵎ', 'ᵏ', 'ᵐ', 'ᵑ', 'ᵒ', 'ᵓ', 'ᵔ', 'ᵕ', 'ᵖ', 'ᵗ', 'ᵘ', 'ᵙ',
    'ᵚ', 'ᵛ', 'ᵜ', 'ᵝ', 'ᵞ', 'ᵟ', 'ᵠ', 'ᵡ', 'ᵢ', 'ᵣ', 'ᵤ', 'ᵥ', 'ᵦ', 'ᵧ', 'ᵨ',
    'ᵩ', 'ᵪ', 'ᵫ', 'ᵬ', 'ᵭ', 'ᵮ', 'ᵯ', 'ᵰ', 'ᵱ', 'ᵲ', 'ᵳ', 'ᵴ', 'ᵵ', 'ᵶ', 'ᵷ',
    'ᵸ', 'ᵹ', 'ᵺ', 'ᵻ', 'ᵼ', 'ᵽ', 'ᵾ', 'ᵿ', 'ᶀ', 'ᶁ', 'ᶂ', 'ᶃ', 'ᶄ', 'ᶅ', 'ᶆ',
    'ᶇ', 'ᶈ', 'ᶉ', 'ᶊ', 'ᶋ', 'ᶌ', 'ᶍ', 'ᶎ', 'ᶏ', 'ᶐ', 'ᶑ', 'ᶒ', 'ᶓ', 'ᶔ', 'ᶕ',
    'ᶖ', 'ᶗ', 'ᶘ', 'ᶙ', 'ᶚ', 'ᶛ', 'ᶜ', 'ᶝ', 'ᶞ', 'ᶟ');

  DefaultSpecial = '=';

implementation

function Encode(data: TBytes): String;
var
  dataLength, i, x1, x2, x3, length3, tempInt: Integer;
  tempResult: TStringBuilder;

begin
  dataLength := Length(data);
  tempResult := TStringBuilder.Create;
  tempResult.Clear;
  try
    length3 := (dataLength div 3) * 3;
    i := 0;
    while i < length3 do
    begin
      x1 := data[i];
      x2 := data[i + 1];
      x3 := data[i + 2];

      tempResult.Append(DefaultAlphabet[x1 or ((x2 and $0F) shl 8)]);
      tempResult.Append(DefaultAlphabet[(x2 shr 4) or (x3 shl 4)]);
      inc(i, 3);
    end;
    tempInt := (dataLength - length3);
    case tempInt of
      1:
        begin
          x1 := data[i];

          tempResult.Append(DefaultAlphabet[x1]);
          tempResult.Append(DefaultSpecial, 2);
        end;
      2:
        begin
          x1 := data[i];
          x2 := data[i + 1];

          tempResult.Append(DefaultAlphabet[x1 or ((x2 and $0F) shl 8)]);
          tempResult.Append(DefaultAlphabet[x2 shr 4]);
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
  lastSpecialInd, tailLength, i, srcInd, x1, x2, length5: Integer;

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

  SetLength(result, Length(data) div 2 * 3 - tailLength);

  i := 0;
  srcInd := 0;

  length5 := (Length(data) div 2 - 1) * 3;
  Base(Length(DefaultAlphabet), DefaultAlphabet, DefaultSpecial);

  while i < length5 do
  begin
    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];

    result[i] := Byte(x1);
    result[i + 1] := Byte((x1 shr 8) and $0F or (x2 shl 4));
    result[i + 2] := Byte(x2 shr 4);
    inc(i, 3);
  end;

  if (tailLength = 0) then
  begin
    inc(srcInd);
    x1 := InvAlphabet[Ord(data[srcInd])];
    inc(srcInd);
    x2 := InvAlphabet[Ord(data[srcInd])];

    result[i] := Byte(x1);
    result[i + 1] := Byte((x1 shr 8) and $0F or (x2 shl 4));
    result[i + 2] := Byte(x2 shr 4);
  end;

  Case (tailLength) of

    2:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
      end;

    1:
      begin
        inc(srcInd);
        x1 := InvAlphabet[Ord(data[srcInd])];
        inc(srcInd);
        x2 := InvAlphabet[Ord(data[srcInd])];

        result[i] := Byte(x1);
        result[i + 1] := Byte((x1 shr 8) and $0F or (x2 shl 4));
      end;
  end;

  result := result;

end;

end.
