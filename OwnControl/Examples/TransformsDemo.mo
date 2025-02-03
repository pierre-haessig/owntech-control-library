within OwnControl.Examples;

model TransformsDemo "Three-phase to Clarke/Park demo"
  extends Modelica.Icons.Example;
  
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  Transforms.Clarke clarke annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.ClarkeDQ clarkeDQ annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant f(k = f0)  annotation(
    Placement(transformation(origin = {-50, -90}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k = 2*pi)  annotation(
    Placement(transformation(origin = {-10, -90}, extent = {{-10, -10}, {10, 10}})));
  Transforms.Park park annotation(
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed3ph v_abc(phase_a = phi, amplitude = V, f = f0, n_odd = 2, harmonics = false, amplitudes_odd_rel = {0.03, 0.03}, phases_odd = {3.141592653589793, 3.141592653589793})  annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(clarke.ab, clarkeDQ.ab) annotation(
    Line(points = {{22, 0}, {38, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(f.y, integrator.u) annotation(
    Line(points = {{-39, -90}, {-23, -90}}, color = {0, 0, 127}));
  connect(park.ph, integrator.y) annotation(
    Line(points = {{30, -42}, {30, -90}, {2, -90}}, color = {0, 0, 127}));
  connect(integrator.y, clarkeDQ.ph) annotation(
    Line(points = {{2, -90}, {50, -90}, {50, -12}}, color = {0, 0, 127}));
  connect(v_abc.abc, clarke.abc) annotation(
    Line(points = {{-58, 0}, {-2, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(v_abc.abc, park.abc) annotation(
    Line(points = {{-58, 0}, {-20, 0}, {-20, -30}, {18, -30}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 8.01603e-05),
  Diagram(graphics = {Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "Three-phase to Clarke/Park demo"), Text(origin = {-50, 30}, extent = {{-50, 10}, {50, -10}}, textString = "set harmonics=true to activate harmonic perturbation
(by default: 3% 3rd and 5th harmonics)", textStyle = {TextStyle.Italic})}));
end TransformsDemo;