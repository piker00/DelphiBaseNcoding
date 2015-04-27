object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize, biHelp]
  BorderStyle = bsSingle
  Caption = 'BaseNCoder'
  ClientHeight = 652
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Comic Sans MS'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 15
  object Label4: TLabel
    Left = 597
    Top = 29
    Width = 59
    Height = 15
    Caption = 'Base to Use'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 597
    Top = 64
    Width = 24
    Height = 15
    Caption = 'Base'
  end
  object Label6: TLabel
    Left = 596
    Top = 94
    Width = 66
    Height = 15
    Caption = 'Special Char'
  end
  object Alphabet: TLabel
    Left = 597
    Top = 128
    Width = 45
    Height = 15
    Caption = 'Alphabet'
  end
  object Label7: TLabel
    Left = 596
    Top = 347
    Width = 67
    Height = 15
    Caption = 'Bit Per Chars'
  end
  object Label8: TLabel
    Left = 597
    Top = 375
    Width = 27
    Height = 15
    Caption = 'Ratio'
  end
  object Label9: TLabel
    Left = 596
    Top = 424
    Width = 74
    Height = 15
    Caption = 'Text Encoding'
  end
  object Label10: TLabel
    Left = 597
    Top = 553
    Width = 65
    Height = 15
    Caption = 'Input Length'
  end
  object Label11: TLabel
    Left = 597
    Top = 582
    Width = 72
    Height = 15
    Caption = 'Output Length'
  end
  object Label13: TLabel
    Left = 541
    Top = 611
    Width = 101
    Height = 15
    Caption = 'Time (hh:mm:ss:zzz)'
  end
  object GroupBox1: TGroupBox
    Left = 16
    Top = 8
    Width = 575
    Height = 593
    Caption = 'BaseNCoder'
    TabOrder = 0
    object Label1: TLabel
      Left = 3
      Top = 37
      Width = 38
      Height = 18
      Caption = 'Input'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 3
      Top = 336
      Width = 41
      Height = 18
      Caption = 'Output'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 324
      Top = 35
      Width = 62
      Height = 18
      Caption = 'CharCount'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ParentFont = False
    end
    object Memo1: TMemo
      Left = 0
      Top = 96
      Width = 574
      Height = 233
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 0
      OnChange = Memo1Change
      OnKeyPress = Memo1KeyPress
    end
    object Memo2: TMemo
      Left = 0
      Top = 360
      Width = 574
      Height = 233
      Lines.Strings = (
        'Memo2')
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 1
      OnChange = Memo2Change
      OnKeyPress = Memo2KeyPress
    end
    object ComboBox1: TComboBox
      Left = 47
      Top = 34
      Width = 145
      Height = 23
      Style = csDropDownList
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Base64SampleString'
      OnChange = ComboBox1Change
      Items.Strings = (
        'Base64SampleString'
        'RusString'
        'GreekString')
    end
    object SpinEdit1: TSpinEdit
      Left = 392
      Top = 32
      Width = 73
      Height = 24
      MaxValue = 10000000
      MinValue = 0
      TabOrder = 3
      Value = 3000
    end
    object CheckBox1: TCheckBox
      Left = 324
      Top = 73
      Width = 141
      Height = 17
      Caption = 'Only Letters and Digits'
      Checked = True
      State = cbChecked
      TabOrder = 4
    end
    object Button1: TButton
      Left = 471
      Top = 56
      Width = 89
      Height = 34
      Caption = 'Generate Input Text'
      TabOrder = 5
      WordWrap = True
      OnClick = Button1Click
    end
  end
  object ComboBox2: TComboBox
    Left = 672
    Top = 24
    Width = 108
    Height = 23
    Style = csDropDownList
    DropDownCount = 12
    ItemIndex = 0
    TabOrder = 1
    Text = 'Base32'
    OnChange = ComboBox2Change
    Items.Strings = (
      'Base32'
      'Base64'
      'Base85'
      'Base91'
      'Base128'
      'Base256'
      'Base1024'
      'Base4096'
      'ZBase32')
  end
  object SpinEdit2: TSpinEdit
    Left = 672
    Top = 61
    Width = 108
    Height = 24
    Enabled = False
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 0
  end
  object Edit1: TEdit
    Left = 672
    Top = 91
    Width = 108
    Height = 23
    ReadOnly = True
    TabOrder = 3
  end
  object Memo3: TMemo
    Left = 597
    Top = 149
    Width = 185
    Height = 185
    Lines.Strings = (
      'Memo3')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 4
    OnKeyPress = Memo3KeyPress
  end
  object Edit2: TEdit
    Left = 672
    Top = 343
    Width = 108
    Height = 23
    ReadOnly = True
    TabOrder = 5
  end
  object Edit3: TEdit
    Left = 672
    Top = 372
    Width = 108
    Height = 23
    ReadOnly = True
    TabOrder = 6
  end
  object CheckBox2: TCheckBox
    Left = 653
    Top = 401
    Width = 97
    Height = 17
    Caption = 'PrefixPostfix'
    Enabled = False
    TabOrder = 7
  end
  object ComboBox3: TComboBox
    Left = 597
    Top = 445
    Width = 191
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 8
    Text = 'ANSI'
    Items.Strings = (
      'ANSI'
      'ASCII'
      'BigEndianUnicode'
      'Default'
      'Unicode'
      'UTF7'
      'UTF8')
  end
  object Button2: TButton
    Left = 672
    Top = 480
    Width = 116
    Height = 25
    Caption = 'Encode'
    TabOrder = 9
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 672
    Top = 511
    Width = 116
    Height = 25
    Caption = 'Decode'
    TabOrder = 10
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 608
    Top = 496
    Width = 48
    Height = 25
    Hint = 'Swap Input/Output'
    Caption = #8593#8595
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    OnClick = Button4Click
  end
  object Edit4: TEdit
    Left = 672
    Top = 550
    Width = 110
    Height = 23
    ReadOnly = True
    TabOrder = 12
  end
  object Edit5: TEdit
    Left = 672
    Top = 579
    Width = 110
    Height = 23
    ReadOnly = True
    TabOrder = 13
  end
  object Edit6: TEdit
    Left = 648
    Top = 608
    Width = 134
    Height = 23
    ReadOnly = True
    TabOrder = 14
  end
end
