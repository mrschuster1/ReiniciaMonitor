object ProviderConnection: TProviderConnection
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 455
  Width = 625
  PixelsPerInch = 120
  object Conn: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Protocol=TCPIP'
      'DriverID=FB')
    LoginPrompt = False
    Left = 96
    Top = 72
  end
  object FBDriver: TFDPhysFBDriverLink
    Left = 208
    Top = 72
  end
  object DBCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 352
    Top = 72
  end
  object dlgBancoNFE: TdxOpenFileDialog
    FileName = 'c:\ecosis\dados\econfe.eco'
    Filter = 'Banco de dados|*.eco;*.fdb|Todos os arquivos|*'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 104
    Top = 168
  end
  object dlgFBClient: TdxOpenFileDialog
    FileName = 'c:\ecosis\windows\fbclient.dll'
    Filter = 'DLL|*.dll'
    Options = [ofPathMustExist, ofFileMustExist, ofEnableSizing]
    Left = 208
    Top = 168
  end
  object SkinController: TdxSkinController
    NativeStyle = False
    ScrollbarMode = sbmHybrid
    SkinName = 'Office2019Black'
    FormCorners = fcRounded
    ShowFormShadow = bTrue
    Left = 352
    Top = 176
  end
end
