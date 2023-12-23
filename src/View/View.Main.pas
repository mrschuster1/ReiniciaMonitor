unit View.Main;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  UCL.Classes,
  UCL.QuickButton,
  UCL.CaptionBar,
  Vcl.ExtCtrls,
  UCL.Panel,
  UCL.form,
  UCL.ListButton,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxContainer,
  cxEdit,
  cxImage,
  dxGDIPlusClasses,
  Vcl.StdCtrls,
  UCL.Text,
  UCL.ThemeManager,
  System.Actions,
  Vcl.ActnList,
  dxSkinsCore,
  dxSkinOffice2019Black,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Param,
  FireDAC.Stan.Error,
  FireDAC.DatS,
  FireDAC.Phys.Intf,
  FireDAC.DApt.Intf,
  FireDAC.Stan.Async,
  FireDAC.DApt,
  Data.DB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  ioutils,
  shellapi;

type
  TformMain = class(TuForm)
    pnlMain: TUPanel;
    cBar: TUCaptionBar;
    btnFechar: TUQuickButton;
    btnMinimizar: TUQuickButton;
    btnReiniciar: TUListButton;
    imgIcon: TcxImage;
    lblCaption: TUText;
    ActionList: TActionList;
    actReiniciar: TAction;
    procedure actReiniciarExecute(Sender: TObject);
    procedure btnReiniciarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    CaminhoMonitor: string;
    ExecutavelMonitor: string;
    procedure SetTheme;
    procedure ReiniciarMonitor;
    procedure FecharMonitor;
    procedure AbrirMonitor;
  public
  end;

var
  formMain: TformMain;

implementation

{$R *.dfm}


uses
  Provider.Connection,
  Helpers.Ini;

procedure TformMain.actReiniciarExecute(Sender: TObject);
begin
  ReiniciarMonitor
end;

procedure TformMain.btnReiniciarClick(Sender: TObject);
begin
  ReiniciarMonitor
end;

procedure TformMain.ReiniciarMonitor;
begin
  FecharMonitor;
  TProviderConnection.LimparConexoesBancoNFE;
  Sleep(1000);
  AbrirMonitor;
end;

procedure TformMain.FecharMonitor;
begin
  ShellExecute(Handle, 'runas', 'cmd.exe',
    PChar(Format('/c taskkill -im %s /f /t', [ExecutavelMonitor])), nil, 0);
end;

procedure TformMain.FormCreate(Sender: TObject);
begin
  CaminhoMonitor := TIniHelper.Getvalue('dfe-monitor', 'executavel',
    'c:\ecosis\nfe\dfemonitor.exe');
  ExecutavelMonitor := TPath.GetFileName(CaminhoMonitor);
  SetTheme;
end;

procedure TformMain.AbrirMonitor;
begin
  ShellExecute(Application.Handle, 'open', PChar(CaminhoMonitor), '',
    nil, SW_SHOWNORMAL);
end;

procedure TformMain.SetTheme;
begin
  ThemeManager.ThemeType := ttDark
end;

end.
