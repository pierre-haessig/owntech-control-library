within OwnControl.Examples;

model PLL1phDemo "Single phase PLLs demo"
  extends Modelica.Icons.Example;
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = pi/6 "initial grid phase";
  parameter Real V = 100 "grid amplitude";
  parameter Frequency fnoise = 1e3 "noise frequency";
  parameter Real Vnoise_rel = 0.01 "relative noise amplitude";
  /*PLL control tuning by pole placement*/
  parameter Duration rise_time = 0.10;
  parameter AngularFrequency wn = 3.0 / rise_time;
  parameter Real xsi = 0.7;
  parameter Real kp = 2 * wn * xsi / V;
  parameter Real ki = (wn * wn) /V;
  parameter Real kr = 1;
  Modelica.Blocks.Sources.Constant w0(k = 2*pi*f0) "nominal angular frequency" annotation(
    Placement(transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}})));
  Filters.SOGIPLL1ph pll(f0 = f0, kp = kp, Ti = kp/ki, kr = kr)  "PLL under test" annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase(y_start = phi, y(unit="rad", displayUnit="deg"))  "true phase" annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback phase_err(y(unit="rad", displayUnit="deg")) "estimate - true phase" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed v(amplitude = V, f = f0, phase = phi, amplitude_hf_rel = Vnoise_rel, f_hf = fnoise, n_odd = 2, amplitudes_odd_rel = {0.03, 0.03}, phases_odd = {3.141592653589793, 3.141592653589793}, harmonics = true) "perturberd cosine voltage to be tracked by PLL" annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(phase.u, w0.y) annotation(
    Line(points = {{-22, -70}, {-39, -70}}, color = {0, 0, 127}));
  connect(pll.ph, phase_err.u1) annotation(
    Line(points = {{21, -6}, {31.5, -6}, {31.5, 0}, {42, 0}}, color = {0, 0, 127}));
  connect(phase.y, phase_err.u2) annotation(
    Line(points = {{2, -70}, {50, -70}, {50, -8}}, color = {0, 0, 127}));
  connect(v.y, pll.u) annotation(
    Line(points = {{-39, 0}, {-2, 0}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Single-phase PLL demo"), Text(origin = {-50, 30}, textColor = {26, 95, 180}, extent = {{-50, 10}, {50, -10}}, textString = "Single-phase voltage to be tracked
(with perturbation)")}),
    experiment(StartTime = 0, StopTime = 0.2, Tolerance = 1e-06, Interval = 5e-05));
end PLL1phDemo;