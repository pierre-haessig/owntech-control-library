within OwnControl.Examples;

model PLL1phDemo "Single phase PLLs demo"
  extends Modelica.Icons.Example;
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  parameter Frequency fnoise = 1e3 "noise frequency";
  parameter Real Vnoise = 10 "noise amplitude";
  
  parameter Duration rise_time = 0.10;
  parameter AngularFrequency wn = 3.0 / rise_time;
  parameter Real xsi = 0.7;
  parameter Real kp = 2 * wn * xsi / V;
  parameter Real ki = (wn * wn) /V;
  parameter Real kr = 1;
  Modelica.Blocks.Sources.Cosine v(amplitude = V, f = f0, phase = phi) "single phase voltage" annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant w0(k = 2*pi*f0) "nominal angular frequency" annotation(
    Placement(transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine noise(amplitude = Vnoise, f = fnoise, phase = phi) annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Filters.PLLSOGI pllsogi(f0 = f0, kp = kp, Ti = kp/ki, kr = kr)  annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase(y_start = phi, y(unit="rad", displayUnit="deg"))  "true phase" annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback phase_err(y(unit="rad", displayUnit="deg")) "estimate - true phase" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(v.y, add.u1) annotation(
    Line(points = {{-79, 30}, {-60.5, 30}, {-60.5, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(noise.y, add.u2) annotation(
    Line(points = {{-78, -30}, {-60, -30}, {-60, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(pllsogi.u, add.y) annotation(
    Line(points = {{-2, 0}, {-18, 0}}, color = {0, 0, 127}));
  connect(phase.u, w0.y) annotation(
    Line(points = {{-22, -70}, {-39, -70}}, color = {0, 0, 127}));
  connect(pllsogi.ph, phase_err.u1) annotation(
    Line(points = {{21, -6}, {31.5, -6}, {31.5, 0}, {42, 0}}, color = {0, 0, 127}));
  connect(phase.y, phase_err.u2) annotation(
    Line(points = {{2, -70}, {50, -70}, {50, -8}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "Single-phase PLL demo")}),
    experiment(StartTime = 0, StopTime = 0.1, Tolerance = 1e-06, Interval = 5e-05));
end PLL1phDemo;