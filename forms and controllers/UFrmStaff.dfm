object FrmStaff: TFrmStaff
  Left = 0
  Top = 0
  Caption = 'FrmStaff'
  ClientHeight = 123
  ClientWidth = 464
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object LblUserId: TLabel
    Left = 8
    Top = 32
    Width = 40
    Height = 15
    Caption = 'User ID:'
  end
  object LblResult: TLabel
    Left = 312
    Top = 32
    Width = 32
    Height = 15
    Caption = 'Result'
  end
  object EdtUserID: TEdit
    Left = 54
    Top = 29
    Width = 121
    Height = 23
    CharCase = ecUpperCase
    TabOrder = 0
    TextHint = 'User Id'
  end
  object BtnUserID: TButton
    Left = 181
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Submit'
    TabOrder = 1
    OnClick = BtnUserIDClick
  end
end
