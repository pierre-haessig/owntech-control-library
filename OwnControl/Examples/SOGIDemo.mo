within OwnControl.Examples;

model SOGIDemo "SOGI filter and PLL demo"
  extends Modelica.Icons.Example;
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  parameter Frequency fnoise = 1e3 "noise frequency";
  parameter Real Vnoise = 10 "noise amplitude";
  
  parameter Duration rise_time = 1/f0;
  parameter AngularFrequency wn = 3.0 / rise_time;
  parameter Real xsi = 0.7;
  parameter Real kp = 2 * wn * xsi / V;
  parameter Real ki = (wn * wn) /V;
  parameter Real kr = 500.0;
  
  Filters.SOGI sogi(kr = kr)  annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine v(amplitude = V, f = f0, phase = phi) "single phase voltage" annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant w0(k = 2*pi*f0) "nominal angular frequency" annotation(
    Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine noise(amplitude = Vnoise, f = fnoise, phase = phi) annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Filters.PLLSOGI pllsogi(f0 = f0, kp = kp, Ti = kp/ki, kr = 500)  annotation(
    Placement(transformation(origin = {10, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase(y_start = phi, y(unit="rad", displayUnit="deg"))  "true phase" annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback phase_err(y(unit="rad", displayUnit="deg")) "estimate - true phase" annotation(
    Placement(transformation(origin = {54, -50}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(w0.y, sogi.w) annotation(
    Line(points = {{-38, -50}, {10, -50}, {10, -12}}, color = {0, 0, 127}));
  connect(add.y, sogi.u) annotation(
    Line(points = {{-18, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(v.y, add.u1) annotation(
    Line(points = {{-79, 30}, {-60.5, 30}, {-60.5, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(noise.y, add.u2) annotation(
    Line(points = {{-78, -30}, {-60, -30}, {-60, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(pllsogi.u, add.y) annotation(
    Line(points = {{-2, 50}, {-12, 50}, {-12, 0}, {-18, 0}}, color = {0, 0, 127}));
  connect(phase.u, w0.y) annotation(
    Line(points = {{-22, -70}, {-28, -70}, {-28, -50}, {-38, -50}}, color = {0, 0, 127}));
  connect(phase.y, phase_err.u2) annotation(
    Line(points = {{2, -70}, {54, -70}, {54, -58}}, color = {0, 0, 127}));
  connect(pllsogi.ph, phase_err.u1) annotation(
    Line(points = {{22, 44}, {30, 44}, {30, -50}, {46, -50}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "SOGI filter and PLL demo")}),
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 8.01603e-05));
end SOGIDemo;