within OwnControl.Examples;

model TransformsDemo "Three-phase to Clarke/Park demo"
  extends Modelica.Icons.Example;
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  Transforms.Clarke clarke annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.ClarkeDQ clarkeDQ annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant f(k = f0) annotation(
    Placement(transformation(origin = {-90, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k = 2*pi) annotation(
    Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
  Transforms.Park park annotation(
    Placement(transformation(origin = {-10, -30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed3ph v_abc(phase_a = phi, amplitude = V, f = f0, n_odd = 2, harmonics = false, amplitudes_odd_rel = {0.03, 0.03}, phases_odd = {3.141592653589793, 3.141592653589793}) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.InvClarke invClarke annotation(
    Placement(transformation(origin = {30, 50}, extent = {{-10, -10}, {10, 10}})));
  Transforms.InvClarkeDQ invClarkeDQ annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.InvPark invPark annotation(
    Placement(transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(clarke.ab, clarkeDQ.ab) annotation(
    Line(points = {{-18, 0}, {18, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(f.y, integrator.u) annotation(
    Line(points = {{-79, -90}, {-63, -90}}, color = {0, 0, 127}));
  connect(park.ph, integrator.y) annotation(
    Line(points = {{-10, -42}, {-10, -90}, {-39, -90}}, color = {0, 0, 127}));
  connect(integrator.y, clarkeDQ.ph) annotation(
    Line(points = {{-39, -90}, {30, -90}, {30, -12}}, color = {0, 0, 127}));
  connect(v_abc.abc, clarke.abc) annotation(
    Line(points = {{-79, 0}, {-42, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(v_abc.abc, park.abc) annotation(
    Line(points = {{-79, 0}, {-59, 0}, {-59, -30}, {-22, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(invClarke.ab, clarke.ab) annotation(
    Line(points = {{18, 50}, {0, 50}, {0, 0}, {-18, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(clarkeDQ.dq, invClarkeDQ.dq) annotation(
    Line(points = {{42, 0}, {58, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(park.dq, invPark.dq) annotation(
    Line(points = {{2, -30}, {38, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(integrator.y, invClarkeDQ.ph) annotation(
    Line(points = {{-38, -90}, {70, -90}, {70, -12}}, color = {0, 0, 127}));
  connect(integrator.y, invPark.ph) annotation(
    Line(points = {{-38, -90}, {50, -90}, {50, -42}}, color = {0, 0, 127}));
  annotation(
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 8.01603e-05),
    Diagram(graphics = {Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "Three-phase to Clarke/Park demo"), Text(origin = {-50, 30}, extent = {{-50, 10}, {50, -10}}, textString = "set harmonics=true
to activate harmonic perturbation
(by default: 3% 3rd and 5th harmonics)", textStyle = {TextStyle.Italic}, horizontalAlignment = TextAlignment.Left)}));
end TransformsDemo;