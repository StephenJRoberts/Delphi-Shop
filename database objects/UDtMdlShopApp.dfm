object DtMdlShopApp: TDtMdlShopApp
  OnCreate = DataModuleCreate
  Height = 97
  Width = 185
  object DtBsShop: TADOConnection
    LoginPrompt = False
    Left = 24
    Top = 24
  end
  object StrdPrcShop: TADOStoredProc
    Connection = DtBsShop
    LockType = ltReadOnly
    Parameters = <>
    Left = 104
    Top = 24
  end
end
