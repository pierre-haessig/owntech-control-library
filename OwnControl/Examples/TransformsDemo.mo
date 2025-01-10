within OwnControl.Examples;

model TransformsDemo "Three-phase to Clarke/Park demo"
  extends Modelica.Icons.Example;
  
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  
  Modelica.Blocks.Sources.Cosine va(amplitude = V, f = f0, phase = phi) annotation(
    Placement(transformation(origin = {-90, 50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine vb(amplitude = V, f = f0, phase = phi-2/3*pi) annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine vc(amplitude = V, f = f0, phase = phi-4/3*pi) annotation(
    Placement(transformation(origin = {-90, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex3 multiplex3 annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
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
equation
  connect(va.y, multiplex3.u1[1]) annotation(
    Line(points = {{-78, 50}, {-60, 50}, {-60, 8}, {-42, 8}}, color = {0, 0, 127}));
  connect(vb.y, multiplex3.u2[1]) annotation(
    Line(points = {{-78, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(vc.y, multiplex3.u3[1]) annotation(
    Line(points = {{-78, -50}, {-60, -50}, {-60, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(multiplex3.y, clarke.abc) annotation(
    Line(points = {{-18, 0}, {-2, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(clarke.ab, clarkeDQ.ab) annotation(
    Line(points = {{22, 0}, {38, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(f.y, integrator.u) annotation(
    Line(points = {{-39, -90}, {-23, -90}}, color = {0, 0, 127}));
  connect(park.ph, integrator.y) annotation(
    Line(points = {{30, -42}, {30, -90}, {2, -90}}, color = {0, 0, 127}));
  connect(integrator.y, clarkeDQ.ph) annotation(
    Line(points = {{2, -90}, {50, -90}, {50, -12}}, color = {0, 0, 127}));
  connect(park.abc, multiplex3.y) annotation(
    Line(points = {{18, -30}, {-10, -30}, {-10, 0}, {-18, 0}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 8.01603e-05),
  Diagram(graphics = {Text(origin = {0, 90}, extent = {{-100, 10}, {100, -10}}, textString = "Three-phase to Clarke/Park demo")}));
end TransformsDemo;
