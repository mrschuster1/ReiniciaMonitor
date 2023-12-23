program ReiniciaMonitor;



{$R *.dres}

uses
  Vcl.Forms,
  View.Main in 'src\View\View.Main.pas' {formMain},
  Helpers.Ini in 'src\Helpers\Helpers.Ini.pas',
  Provider.Connection in 'src\Providers\Provider.Connection.pas' {ProviderConnection: TDataModule},
  Helper.UI in 'src\Helpers\Helper.UI.pas';

{$R *.res}


begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.MainFormOnTaskbar := true;
  Application.Title := 'Reiniciar Monitor';
  Application.CreateForm(TformMain, formMain);
  Application.Run;

end.
