unit uMain;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.ExtCtrls, Vcl.Samples.Spin,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.Dialogs, uStringGenerator,
  uStopWatch, uBase, uBase32, uBase64, uBase85, uBase91, uBase128, uBase256,
  uBase1024, uBase4096, uZBase32;

function MillisecondstoTDateTime(Milliseconds: Extended): TDateTime;
procedure DisplayCalculations;
function returnBitsPerCharsandRatio(ItemIndex: Integer;
  out ratio: String): String;
function AlphabetParse(InArray: array of String): String;
function AlphabetDisplay(ItemIndex: Integer; out CustomChar: String): String;
procedure SwapInputOuput;
function BaseDeriver(ItemIndex: Integer): Integer;
procedure ClearMemo;
procedure ValuestoDisplay;
procedure GenerateInputText;
function ComboOneChange(ItemIndex: Integer): String;
procedure ComboTwoChange;
function EncodeString(data: String; Encoding, BasetoUse: Integer;
  PrefixPostfix: Boolean): String;
function DecodeToString(data: String; Encoding, BasetoUse: Integer;
  PrefixPostfix: Boolean): String;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    Memo1: TMemo;
    Memo2: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    Button1: TButton;
    ComboBox2: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    SpinEdit2: TSpinEdit;
    Edit1: TEdit;
    Label6: TLabel;
    Memo3: TMemo;
    Alphabet: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    CheckBox2: TCheckBox;
    Label7: TLabel;
    Label8: TLabel;
    ComboBox3: TComboBox;
    Label9: TLabel;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Memo1Change(Sender: TObject);
    procedure Memo1KeyPress(Sender: TObject; var Key: Char);
    procedure Memo2KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Memo2Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Memo3KeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function MillisecondstoTDateTime(Milliseconds: Extended): TDateTime;

begin
  result := Milliseconds / (SecsPerDay * 1000.0);
end;

procedure DisplayCalculations;
var
  ratioValue: String;
  CustomChar: String;
begin
  Form1.Edit2.Text := returnBitsPerCharsandRatio(Form1.ComboBox2.ItemIndex,
    ratioValue);
  Form1.Edit3.Text := ratioValue;
  Form1.Memo3.Text := AlphabetDisplay(Form1.ComboBox2.ItemIndex, CustomChar);
  Form1.Edit1.Text := CustomChar;

end;

function returnBitsPerCharsandRatio(ItemIndex: Integer;
  out ratio: String): String;
var
  FormatSetting: TFormatSettings;

begin
  result := '';
  ratio := '';
  FormatSetting := TFormatSettings.Create;
  case ItemIndex of
    0:
      begin
        Base(Length(uBase32.DefaultAlphabet), uBase32.DefaultAlphabet,
          uBase32.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    1:
      begin
        Base(Length(uBase64.DefaultAlphabet), uBase64.DefaultAlphabet,
          uBase64.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    2:
      begin
        Base(Length(uBase85.DefaultAlphabet), uBase85.DefaultAlphabet,
          uBase85.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    3:
      begin
        Base(Length(uBase91.DefaultAlphabet), uBase91.DefaultAlphabet,
          uBase91.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    4:
      begin
        Base(Length(uBase128.DefaultAlphabet), uBase128.DefaultAlphabet,
          uBase128.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    5:
      begin
        Base(Length(uBase256.DefaultAlphabet), uBase256.DefaultAlphabet,
          uBase256.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    6:
      begin
        Base(Length(uBase1024.DefaultAlphabet), uBase1024.DefaultAlphabet,
          uBase1024.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    7:
      begin
        Base(Length(uBase4096.DefaultAlphabet), uBase4096.DefaultAlphabet,
          uBase4096.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;

    8:
      begin
        Base(Length(uZBase32.DefaultAlphabet), uZBase32.DefaultAlphabet,
          uZBase32.DefaultSpecial);
        result := InttoStr(BlockBitsCount) + '/' + InttoStr(BlockCharsCount);
        ratio := FormatFloat('0.000000', (BlockBitsCount) / BlockCharsCount,
          FormatSetting);
      end;
  end;
end;

function AlphabetParse(InArray: array of String): String;

begin
  result := ArraytoString(InArray);
end;

procedure SwapInputOuput;
var
  tempString: String;
begin

  tempString := Form1.Memo1.Text;
  Form1.Memo1.Text := Form1.Memo2.Text;;
  Form1.Memo2.Text := tempString;

end;

function BaseDeriver(ItemIndex: Integer): Integer;
begin
  result := 0;
  case ItemIndex of
    0:
      begin
        result := Length(uBase32.DefaultAlphabet);
      end;
    1:
      begin
        result := Length(uBase64.DefaultAlphabet);
      end;
    2:
      begin
        result := Length(uBase85.DefaultAlphabet);
      end;
    3:
      begin
        result := Length(uBase91.DefaultAlphabet);
      end;
    4:
      begin
        result := Length(uBase128.DefaultAlphabet);
      end;
    5:
      begin
        result := Length(uBase256.DefaultAlphabet);
      end;
    6:
      begin
        result := Length(uBase1024.DefaultAlphabet);
      end;
    7:
      begin
        result := Length(uBase4096.DefaultAlphabet);
      end;
    8:
      begin
        result := Length(uZBase32.DefaultAlphabet);
      end;
  end;
end;

function ComboOneChange(ItemIndex: Integer): String;
begin

  case ItemIndex of
    0:
      begin
        result := 'Man is distinguished, not only by his reason, but by this singular passion from '
          + 'other animals, which is a lust of the mind, that by a perseverance of delight '
          + 'in the continued and indefatigable generation of knowledge, exceeds the short '
          + 'vehemence of any carnal pleasure.';

      end;
    1:

      begin
        result := 'Зарегистрируйтесь сейчас на Десятую Международную Конференцию по '
          + 'Unicode, которая состоится 10-12 марта 1997 года в Майнце в Германии. '
          + 'Конференция соберет широкий круг экспертов по  вопросам глобального '
          + 'Интернета и Unicode, локализации и интернационализации, воплощению и '
          + 'применению Unicode в различных операционных системах и программных '
          + 'приложениях, шрифтах, верстке и многоязычных компьютерных системах.';

      end;
    2:
      begin
        result := 'Σὲ γνωρίζω ἀπὸ τὴν κόψη ' + 'τοῦ σπαθιοῦ τὴν τρομερή, ' +
          'σὲ γνωρίζω ἀπὸ τὴν ὄψη ' + 'ποὺ μὲ βία μετράει τὴ γῆ. ' +
          '᾿Απ᾿ τὰ κόκκαλα βγαλμένη ' + 'τῶν ῾Ελλήνων τὰ ἱερά ' +
          'καὶ σὰν πρῶτα ἀνδρειωμένη ' + 'χαῖρε, ὦ χαῖρε, ᾿Ελευθεριά!';

      end;

  end;

end;

procedure ComboTwoChange;
begin
  Form1.Memo2.Clear;
  ValuestoDisplay;
  Form1.SpinEdit2.Value := BaseDeriver(Form1.ComboBox2.ItemIndex);
  DisplayCalculations;
  if Form1.ComboBox2.ItemIndex = 2 then
    Form1.CheckBox2.Enabled := True
  else
  begin
    Form1.CheckBox2.Enabled := False;
    Form1.CheckBox2.Checked := False;
  end;

end;

function AlphabetDisplay(ItemIndex: Integer; out CustomChar: String): String;
begin
  result := '';
  CustomChar := '';

  case ItemIndex of
    0:
      begin
        result := AlphabetParse(uBase32.DefaultAlphabet);
        CustomChar := uBase32.DefaultSpecial;
      end;
    1:
      begin
        result := AlphabetParse(uBase64.DefaultAlphabet);
        CustomChar := uBase64.DefaultSpecial;
      end;
    2:
      begin
        result := AlphabetParse(uBase85.DefaultAlphabet);
      end;
    3:
      begin
        result := AlphabetParse(uBase91.DefaultAlphabet);
        CustomChar := uBase91.DefaultSpecial;
      end;
    4:
      begin
        result := AlphabetParse(uBase128.DefaultAlphabet);
        CustomChar := uBase128.DefaultSpecial;
      end;
    5:
      begin
        result := AlphabetParse(uBase256.DefaultAlphabet);
        CustomChar := uBase256.DefaultSpecial;
      end;
    6:
      begin
        result := AlphabetParse(uBase1024.DefaultAlphabet);
        CustomChar := uBase1024.DefaultSpecial;
      end;
    7:
      begin
        result := AlphabetParse(uBase4096.DefaultAlphabet);
        CustomChar := uBase4096.DefaultSpecial;
      end;
    8:
      begin
        result := AlphabetParse(uZBase32.DefaultAlphabet);
        CustomChar := uZBase32.DefaultSpecial;
      end;
  end;

end;

procedure ClearMemo;
begin
  Form1.Memo1.Clear;
  Form1.Memo2.Clear;
  Form1.Memo3.Clear;
end;

procedure ValuestoDisplay;
begin

  Form1.Edit4.Text := InttoStr(Length(Form1.Memo1.Text));
  Form1.Edit5.Text := InttoStr(Length(Form1.Memo2.Text));
  Form1.Edit6.Text := 'Not Measured';
end;

procedure GenerateInputText;
begin

  Form1.Memo1.Text := GetRandom(Form1.SpinEdit1.Value, Form1.CheckBox1.Checked);
  ValuestoDisplay;

end;

function EncodeString(data: String; Encoding, BasetoUse: Integer;
  PrefixPostfix: Boolean): String;

begin

  case Encoding of
    0:
      begin
        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.ANSI.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.ANSI.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.ANSI.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;

      end;
    1:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.ASCII.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.ASCII.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.ASCII.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    2:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data), PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode
                (TEncoding.BigEndianUnicode.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    3:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.Default.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.Default.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.Default.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.Default.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.Default.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.Default.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.Default.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.Default.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.Default.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    4:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.Unicode.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.Unicode.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.Unicode.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    5:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.UTF7.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.UTF7.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.UTF7.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    6:
      begin

        case BasetoUse of
          0:
            begin
              result := uBase32.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          1:
            begin
              result := uBase64.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          2:
            begin
              result := uBase85.Encode(TEncoding.UTF8.GetBytes(data),
                PrefixPostfix);
            end;
          3:
            begin
              result := uBase91.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          4:
            begin
              result := uBase128.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          5:
            begin
              result := uBase256.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          6:
            begin
              result := uBase1024.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          7:
            begin
              result := uBase4096.Encode(TEncoding.UTF8.GetBytes(data));
            end;
          8:
            begin
              result := uZBase32.Encode(TEncoding.UTF8.GetBytes(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
  else
    begin
      raise Exception.Create('Invalid Encoding Selection');
    end;
  end;
end;

function DecodeToString(data: String; Encoding, BasetoUse: Integer;
  PrefixPostfix: Boolean): String;

begin
  data := StringReplace(data, sLineBreak, '', [rfReplaceAll]);

  case Encoding of
    0:
      begin
        case BasetoUse of
          0:
            begin
              result := TEncoding.ANSI.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.ANSI.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.ANSI.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.ANSI.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.ANSI.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.ANSI.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.ANSI.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.ANSI.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.ANSI.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;

      end;
    1:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.ASCII.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.ASCII.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.ASCII.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.ASCII.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.ASCII.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.ASCII.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.ASCII.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.ASCII.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.ASCII.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    2:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.BigEndianUnicode.GetString
                (uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    3:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.Default.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.Default.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.
                Default.GetString(uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.Default.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.Default.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.Default.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.Default.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.Default.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.Default.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    4:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.Unicode.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.Unicode.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.Unicode.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.Unicode.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.Unicode.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.Unicode.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.Unicode.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.Unicode.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.Unicode.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    5:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.UTF7.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.UTF7.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.UTF7.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.UTF7.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.UTF7.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.UTF7.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.UTF7.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.UTF7.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.UTF7.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
    6:
      begin

        case BasetoUse of
          0:
            begin
              result := TEncoding.UTF8.GetString(uBase32.Decode(data));
            end;
          1:
            begin
              result := TEncoding.UTF8.GetString(uBase64.Decode(data));
            end;
          2:
            begin
              result := TEncoding.UTF8.GetString
                (uBase85.Decode(data, PrefixPostfix));
            end;
          3:
            begin
              result := TEncoding.UTF8.GetString(uBase91.Decode(data));
            end;
          4:
            begin
              result := TEncoding.UTF8.GetString(uBase128.Decode(data));
            end;
          5:
            begin
              result := TEncoding.UTF8.GetString(uBase256.Decode(data));
            end;
          6:
            begin
              result := TEncoding.UTF8.GetString(uBase1024.Decode(data));
            end;
          7:
            begin
              result := TEncoding.UTF8.GetString(uBase4096.Decode(data));
            end;
          8:
            begin
              result := TEncoding.UTF8.GetString(uZBase32.Decode(data));
            end;
        else
          begin
            raise Exception.Create('Invalid Base Selection');
          end;
        end;
      end;
  else
    begin
      raise Exception.Create('Invalid Encoding Selection');
    end;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);

begin
  GenerateInputText;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  stopwatch: TStopwatch;
  FormatSettings: TFormatSettings;
  InString, Value: String;
  elapsedMilliseconds: Int64;
begin
  try
    Form1.Memo2.Clear;
    InString := Form1.Memo1.Text;
    FormatSettings := TFormatSettings.Create;
    stopwatch := TStopwatch.Create;
    try
      stopwatch.Start;

      Value := EncodeString(InString, Form1.ComboBox3.ItemIndex,
        Form1.ComboBox2.ItemIndex, Form1.CheckBox2.Checked);
      stopwatch.Stop;
      elapsedMilliseconds := stopwatch.elapsedMilliseconds;
    finally
      stopwatch.Free;
    end;

    Form1.Memo2.Text := Value;

    Form1.Edit6.Text := FormatDateTime('hh:nn:ss:zzz',
      MillisecondstoTDateTime(elapsedMilliseconds), FormatSettings);
  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Error', MB_OK);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  stopwatch: TStopwatch;
  FormatSettings: TFormatSettings;
  InString, Value: String;
  elapsedMilliseconds: Int64;

begin
  try
    Form1.Memo2.Clear;
    InString := Form1.Memo1.Text;
    FormatSettings := TFormatSettings.Create;
    stopwatch := TStopwatch.Create;
    try
      stopwatch.Start;

      Value := DecodeToString(InString, Form1.ComboBox3.ItemIndex,
        Form1.ComboBox2.ItemIndex, Form1.CheckBox2.Checked);
      stopwatch.Stop;
      elapsedMilliseconds := stopwatch.elapsedMilliseconds;
    finally
      stopwatch.Free;
    end;

    Form1.Memo2.Text := Value;

    Form1.Edit6.Text := FormatDateTime('hh:nn:ss:zzz',
      MillisecondstoTDateTime(elapsedMilliseconds), FormatSettings);
  except
    on E: Exception do
      Application.MessageBox(PChar(E.Message), 'Error', MB_OK);
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  SwapInputOuput;
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  Form1.Memo1.Text := ComboOneChange(Form1.ComboBox1.ItemIndex);
  ValuestoDisplay;
  Form1.Memo2.Clear;
end;

procedure TForm1.ComboBox2Change(Sender: TObject);
begin
  ComboTwoChange;
  ValuestoDisplay;
  Form1.Memo1.Text := ComboOneChange(Form1.ComboBox1.ItemIndex);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ClearMemo;
  Form1.Memo1.Text := ComboOneChange(Form1.ComboBox1.ItemIndex);
  Form1.SpinEdit2.Value := BaseDeriver(Form1.ComboBox2.ItemIndex);
  DisplayCalculations;
end;

procedure TForm1.Memo1Change(Sender: TObject);
begin
  ValuestoDisplay;
end;

procedure TForm1.Memo1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ^A then
    Form1.Memo1.SelectAll;
end;

procedure TForm1.Memo2Change(Sender: TObject);
begin
  ValuestoDisplay;
end;

procedure TForm1.Memo2KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ^A then
    Form1.Memo2.SelectAll;
end;

procedure TForm1.Memo3KeyPress(Sender: TObject; var Key: Char);
begin
  if Key = ^A then
    Form1.Memo3.SelectAll;
end;

end.
