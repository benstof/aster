program Calc2011;

uses
  Forms,
  irricalc in 'irricalc.pas' {calcbox},
  Plotunit in 'Plotunit.pas' {PlotForm},
  units_unt in 'units_unt.pas',
  taal_unt in 'taal_unt.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tcalcbox, calcbox);
  Application.CreateForm(TPlotForm, PlotForm);
  Application.Run;
end.
