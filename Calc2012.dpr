program Calc2012;

uses
  Forms,
  main_unt in 'main_unt.pas' {calcbox},
  Plotunit in 'Plotunit.pas' {PlotForm},
  units_unt in 'units_unt.pas',
  taal_unt in 'taal_unt.pas',
  emitter_mng_unt in 'emitter_mng_unt.pas' {emitter_mng},
  login_unt in 'login_unt.pas' {login_form},
  admin_unt in 'admin_unt.pas' {admin_form},
  pipe_mng_unt in 'pipe_mng_unt.pas' {pipe_mng},
  drip_line_mng_unt in 'drip_line_mng_unt.pas' {drip_line_mng},
  pressures_mng_unt in 'pressures_mng_unt.pas' {pressures_mng},
  admin_menu_unt in 'admin_menu_unt.pas' {admin_menu};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tcalcbox, calcbox);
  Application.CreateForm(TPlotForm, PlotForm);
  Application.CreateForm(Temitter_mng, emitter_mng);
  Application.CreateForm(Tlogin_form, login_form);
  Application.CreateForm(Tadmin_form, admin_form);
  Application.CreateForm(Tpipe_mng, pipe_mng);
  Application.CreateForm(Tdrip_line_mng, drip_line_mng);
  Application.CreateForm(Tpressures_mng, pressures_mng);
  Application.CreateForm(Tadmin_menu, admin_menu);
  Application.Run;
end.
