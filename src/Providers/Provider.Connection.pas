unit Provider.Connection;

interface

uses
  System.SysUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.Phys.FB,
  FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI,
  FireDAC.Phys.IBBase,
  Data.DB,
  Dialogs,
  forms,
  dxMessageDialog,
  FireDAC.Comp.Client,
  dxShellDialogs,
  dxSkinsCore,
  dxSkinOffice2019Black,
  dxCore,
  cxClasses,
  cxLookAndFeels,
  dxSkinsForm;

type
  TProviderConnection = class(TDataModule)
    Conn: TFDConnection;
    FBDriver: TFDPhysFBDriverLink;
    DBCursor: TFDGUIxWaitCursor;
    dlgBancoNFE: TdxOpenFileDialog;
    dlgFBClient: TdxOpenFileDialog;
    SkinController: TdxSkinController;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    procedure CarregarConfiguracoes;
    function ValidarConfiguracoes: boolean;
    procedure Desconectar;
    procedure Conectar;
  public
    procedure Reconectar;
    constructor Create; reintroduce;
    class procedure LimparConexoesBancoNFE;
  end;

var
  ProviderConnection: TProviderConnection;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


uses
  Helpers.Ini;

{$R *.dfm}


procedure TProviderConnection.CarregarConfiguracoes;
begin
 var
  Params := TFDPhysFBConnectionDefParams(Conn.Params);
  Params.Database := TIniHelper.GetValue('dfe-monitor', 'banco',
    '\ecosis\dados\econfe.eco');
  Params.Server := TIniHelper.GetValue('dfe-monitor', 'server',
    '127.0.0.1');

  FBDriver.VendorLib := TIniHelper.GetValue('firebird', 'driver',
    'c:\ecosis\windows\fbclient.dll');
end;

procedure TProviderConnection.Conectar;
begin
  if ValidarConfiguracoes then
  begin
    CarregarConfiguracoes;
    Conn.Connected := true;
  end
  else
  begin
    dxMessageBox('Aplicativo não configurado, por favor verifique!',
      'Configuração', 0);
    Application.Terminate
  end;
end;

constructor TProviderConnection.Create;
begin
  inherited Create(nil)
end;

procedure TProviderConnection.DataModuleCreate(Sender: TObject);
begin
  Conectar
end;

procedure TProviderConnection.DataModuleDestroy(Sender: TObject);
begin
  Desconectar
end;

procedure TProviderConnection.Desconectar;
begin
  Conn.Connected := False
end;

class procedure TProviderConnection.LimparConexoesBancoNFE;
begin
  try
    var
    LProviderConnection := TProviderConnection.Create;
    try
      LProviderConnection.Conn.ExecSQL('delete from MON$ATTACHMENTS');
    finally
      LProviderConnection.Free;
    end;
  except

  end;
end;

procedure TProviderConnection.Reconectar;
begin
  Desconectar;
  Conectar
end;

function TProviderConnection.ValidarConfiguracoes: boolean;
begin

  if not FileExists(TIniHelper.GetValue('firebird', 'driver',
    'c:\ecosis\windows\fbclient.dll')) then
  begin
    dxMessageBox
      (Format('Driver Firebird "%s" não encontrado, especifique o caminho:',
      [TIniHelper.GetValue('firebird', 'driver',
      'c:\ecosis\windows\fbclient.dll')]), 'Configuração', 0);

    if dlgFBClient.Execute then
      TIniHelper.SetValue('firebird', 'driver', dlgFBClient.FileName)
  end;

  Result := FileExists(TIniHelper.GetValue('firebird', 'driver',
    'c:\ecosis\windows\fbclient.dll'))
end;

end.
