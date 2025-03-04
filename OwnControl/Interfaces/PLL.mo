within OwnControl.Interfaces;

partial model PLL "PLL interface with PI loop filter"
  extends Modelica.Blocks.Icons.Block;
  parameter Frequency f0=50 "nominal frequency";
  parameter Real kp "PI proportional gain";
  parameter Duration Ti "PI integrator time constant";
  final parameter AngularFrequency w0 = 2*pi*f0 "nominal angular frequency";
  
  Modelica.Blocks.Interfaces.RealOutput f(final unit="Hz") "frequency estimate"annotation(
    Placement(transformation(origin = {210, 30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput w(final unit="rad/s") "angular frequency estimate" annotation(
    Placement(transformation(origin = {210, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput ph(final unit="rad", displayUnit="deg") "phase estimate" annotation(
    Placement(transformation(origin = {210, -30}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain w2f(k = 1/(2*pi))  annotation(
    Placement(transformation(origin = {170, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator int_w "w integrator to generate phase" annotation(
    Placement(transformation(origin = {170, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant w_ff(final k = w0)  "w feedforward" annotation(
    Placement(transformation(origin = {50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add_ff "add frequency feedforward" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.PI loopFilterPI(k = kp, T = Ti, initType = Modelica.Blocks.Types.Init.InitialState, x_start = 0)  "phase error filter" annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(w2f.y, f) annotation(
    Line(points = {{181, 30}, {210, 30}}, color = {0, 0, 127}));
  connect(w_ff.y, add_ff.u2) annotation(
    Line(points = {{61, -50}, {80, -50}, {80, -6}, {98, -6}}, color = {0, 0, 127}));
  connect(add_ff.y, w) annotation(
    Line(points = {{121, 0}, {210, 0}}, color = {0, 0, 127}));
  connect(w2f.u, add_ff.y) annotation(
    Line(points = {{158, 30}, {140, 30}, {140, 0}, {121, 0}}, color = {0, 0, 127}));
  connect(int_w.y, ph) annotation(
    Line(points = {{181, -30}, {209, -30}}, color = {0, 0, 127}));
  connect(int_w.u, add_ff.y) annotation(
    Line(points = {{158, -30}, {140, -30}, {140, 0}, {121, 0}}, color = {0, 0, 127}));
  connect(loopFilterPI.y, add_ff.u1) annotation(
    Line(points = {{61, 0}, {79, 0}, {79, 6}, {97, 6}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {Text(origin = {0, 50}, extent = {{-100, 50}, {100, -50}}, textString = "PLL"), Text(origin = {0, -50}, extent = {{-100, 50}, {100, -50}}, textString = "f0=%f0")}, coordinateSystem(extent = {{-100, -100}, {100, 100}})),
  Diagram(coordinateSystem(extent = {{-200, -100}, {200, 100}})));
end PLL;