object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Shop Menu'
  ClientHeight = 215
  ClientWidth = 414
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  TextHeight = 15
  object BtnStaff: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Staff'
    TabOrder = 0
    OnClick = BtnStaffClick
  end
  object BtnShops: TButton
    Left = 89
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Shops'
    TabOrder = 1
    OnClick = BtnShopsClick
  end
end
