object FrmEditShop: TFrmEditShop
  Left = 0
  Top = 0
  Caption = 'Edit Shop'
  ClientHeight = 255
  ClientWidth = 356
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object LblShopName: TLabel
    Left = 46
    Top = 32
    Width = 65
    Height = 15
    Caption = 'Shop Name:'
  end
  object LblAddrLn1: TLabel
    Left = 32
    Top = 64
    Width = 79
    Height = 15
    Caption = 'Address Line 1:'
  end
  object LblAddrLn2: TLabel
    Left = 32
    Top = 96
    Width = 79
    Height = 15
    Caption = 'Address Line 2:'
  end
  object LblAddrLn3: TLabel
    Left = 32
    Top = 128
    Width = 79
    Height = 15
    Caption = 'Address Line 3:'
  end
  object LblAddrPostcode: TLabel
    Left = 57
    Top = 160
    Width = 52
    Height = 15
    Caption = 'Postcode:'
  end
  object BtnUpdate: TButton
    Left = 144
    Top = 208
    Width = 75
    Height = 25
    Caption = 'Update'
    TabOrder = 0
    OnClick = BtnUpdateClick
  end
  object EdtShopName: TEdit
    Left = 122
    Top = 29
    Width = 207
    Height = 23
    TabOrder = 1
    TextHint = 'Shop Name'
  end
  object EdtAddrLn1: TEdit
    Left = 122
    Top = 61
    Width = 207
    Height = 23
    TabOrder = 2
    TextHint = 'Address Line 1'
  end
  object EdtAddrLn2: TEdit
    Left = 122
    Top = 93
    Width = 207
    Height = 23
    TabOrder = 3
    TextHint = 'Address Line 2'
  end
  object EdtAddrLn3: TEdit
    Left = 122
    Top = 125
    Width = 207
    Height = 23
    TabOrder = 4
    TextHint = 'Address Line 3'
  end
  object EdtAddrPostcode: TEdit
    Left = 122
    Top = 157
    Width = 207
    Height = 23
    MaxLength = 8
    TabOrder = 5
    TextHint = 'Postcode'
    OnChange = EdtAddrPostcodeChange
  end
end
