object Form1: TForm1
  Left = 192
  Top = 107
  Width = 531
  Height = 926
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 8
    Width = 497
    Height = 481
    Lines.Strings = (
      'Memo1')
    TabOrder = 0
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 736
    Width = 273
    Height = 21
    ItemHeight = 13
    TabOrder = 1
    Text = 'ComboBox1'
    OnChange = ComboBox1Change
  end
end