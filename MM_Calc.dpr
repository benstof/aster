program MM_Calc;

uses
  Forms,
 // irricalc in 'irricalc.pas' {calcbox},
  Plotunit in 'Plotunit.pas' {PlotForm};

{$R *.res}

begin
  Application.Initialize;
//  Application.CreateForm(Tcalcbox, calcbox);
  Application.CreateForm(TPlotForm, PlotForm);
  Application.Run;
end.
