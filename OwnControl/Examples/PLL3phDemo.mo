within OwnControl.Examples;

model PLL3phDemo"Single phase PLLs demo"
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
  Filters.SRFPLL3ph pll(f0 = f0, kp = kp, Ti = kp/ki, kr = kr)  "PLL under test" annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase(y_start = phi, y(unit="rad", displayUnit="deg"))  "true phase" annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback phase_err(y(unit="rad", displayUnit="deg")) "estimate - true phase" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed3ph v_abc(amplitude = V, f = f0, phase_a = phi)  "perturbed three phase cosine voltage to be tracked" annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(phase.u, w0.y) annotation(
    Line(points = {{-22, -70}, {-39, -70}}, color = {0, 0, 127}));
  connect(pll.ph, phase_err.u1) annotation(
    Line(points = {{21, -6}, {31.5, -6}, {31.5, 0}, {42, 0}}, color = {0, 0, 127}));
  connect(phase.y, phase_err.u2) annotation(
    Line(points = {{2, -70}, {50, -70}, {50, -8}}, color = {0, 0, 127}));
  connect(v_abc.abc, pll.abc) annotation(
    Line(points = {{-38, 0}, {-2, 0}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Three phase PLL demo"), Text(origin = {-50, 30}, extent = {{-50, 10}, {50, -10}}, textString = "perturbed three phase voltage to be tracked")}),
    experiment(StartTime = 0, StopTime = 0.2, Tolerance = 1e-06, Interval = 5e-05),
  Documentation);
end PLL3phDemo;