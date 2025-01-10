within OwnControl.Examples;

model SOGIFilterDemo "SOGI filter demo"
  extends Modelica.Icons.Example;
  parameter Frequency f0 = 50 "grid frequency";
  parameter Angle phi = 0 "grid phase";
  parameter Real V = 100 "grid amplitude";
  parameter Frequency fnoise = 1e3 "noise frequency";
  parameter Real Vnoise = 10 "noise amplitude";
  
  parameter Real kr = sqrt(2) "resonance damping factor of SOGI filter";
  
  Filters.SOGI sogi(kr = kr)  annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine v(amplitude = V, f = f0, phase = phi) "single phase voltage" annotation(
    Placement(transformation(origin = {-90, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant w0(k = 2*pi*f0) "nominal angular frequency" annotation(
    Placement(transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Cosine noise(amplitude = Vnoise, f = fnoise, phase = phi) annotation(
    Placement(transformation(origin = {-90, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Sine v_quad(amplitude = V, f = f0, phase = phi) "actual quadrature voltage (to be compared with β signal)" annotation(
    Placement(transformation(origin = {10, -90}, extent = {{-10, -10}, {10, 10}})));
  Transforms.ClarkeDQ clarkeDQ annotation(
    Placement(transformation(origin = {60, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase annotation(
    Placement(transformation(origin = {30, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback cmp_alpha "in phase voltage error" annotation(
    Placement(transformation(origin = {90, 10}, extent = {{-10, 10}, {10, -10}})));
  Modelica.Blocks.Math.Feedback cmp_beta "quadrature voltage error" annotation(
    Placement(transformation(origin = {90, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex2 demux_ab annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(w0.y, sogi.w) annotation(
    Line(points = {{-19, -50}, {11, -50}, {11, -12}, {10, -12}}, color = {0, 0, 127}));
  connect(add.y, sogi.u) annotation(
    Line(points = {{-18, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(v.y, add.u1) annotation(
    Line(points = {{-79, 30}, {-60.5, 30}, {-60.5, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(noise.y, add.u2) annotation(
    Line(points = {{-78, -30}, {-60, -30}, {-60, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(sogi.ab, clarkeDQ.ab) annotation(
    Line(points = {{22, 0}, {30, 0}, {30, -30}, {48, -30}}, color = {0, 0, 127}, thickness = 0.5));
  connect(w0.y, phase.u) annotation(
    Line(points = {{-19, -50}, {18, -50}}, color = {0, 0, 127}));
  connect(sogi.ab, demux_ab.u) annotation(
    Line(points = {{22, 0}, {38, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(phase.y, clarkeDQ.ph) annotation(
    Line(points = {{42, -50}, {60, -50}, {60, -42}}, color = {0, 0, 127}));
  connect(demux_ab.y1[1], cmp_alpha.u1) annotation(
    Line(points = {{62, 6}, {70, 6}, {70, 10}, {82, 10}}, color = {0, 0, 127}));
  connect(demux_ab.y2[1], cmp_beta.u1) annotation(
    Line(points = {{62, -6}, {70, -6}, {70, -10}, {82, -10}}, color = {0, 0, 127}));
  connect(v.y, cmp_alpha.u2) annotation(
    Line(points = {{-78, 30}, {90, 30}, {90, 18}}, color = {0, 0, 127}));
  connect(v_quad.y, cmp_beta.u2) annotation(
    Line(points = {{22, -90}, {90, -90}, {90, -18}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "SOGI filter demo
(prefilter in the SOGI-PLL)")}),
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 8.01603e-05));
end SOGIFilterDemo;