program DelphiBaseNcoding;

uses
  Vcl.Forms,
  uMain in 'Sources\uMain.pas' {Form1} ,
  uBase32 in 'BaseUnits\uBase32.pas',
  uBase in 'BaseUnits\uBase.pas',
  uBase64 in 'BaseUnits\uBase64.pas',
  uBase128 in 'BaseUnits\uBase128.pas',
  uBase256 in 'BaseUnits\uBase256.pas',
  uBase1024 in 'BaseUnits\uBase1024.pas',
  uBase4096 in 'BaseUnits\uBase4096.pas',
  uBase91 in 'BaseUnits\uBase91.pas',
  uBase85 in 'BaseUnits\uBase85.pas',
  uZBase32 in 'BaseUnits\uZBase32.pas',
  uStringGenerator in 'StringGenerator\uStringGenerator.pas',
  uStopWatch in 'StopWatch\uStopWatch.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
