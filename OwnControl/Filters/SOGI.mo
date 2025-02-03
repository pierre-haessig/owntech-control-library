within OwnControl.Filters;

model SOGI "SOGI-QSG filter (Quadrature Signal Generator)"
  extends Interfaces.TransformBlock;
  parameter Real kr=sqrt(2) "resonance damping factor";
  Modelica.Blocks.Interfaces.RealInput u "single phase AC signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput w "angular frequency" annotation(
    Placement(transformation(origin = {-60, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput ab[2] "alpha-beta" annotation(
    Placement(transformation(origin = {180, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
    
  Modelica.Blocks.Continuous.Integrator int_alpha annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator int_beta annotation(
    Placement(transformation(origin = {30, -80}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain(k = kr) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback fb_alpha annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Math.Feedback fb_beta annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product prod_alpha annotation(
    Placement(transformation(origin = {32, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Product prod_beta annotation(
    Placement(transformation(origin = {-10, -80}, extent = {{-10, 10}, {10, -10}}, rotation = -0)));
  Modelica.Blocks.Routing.Multiplex2 mux annotation(
    Placement(transformation(origin = {130, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(u, fb_alpha.u1) annotation(
    Line(points = {{-120, 0}, {-78, 0}}, color = {0, 0, 127}));
  connect(fb_alpha.y, gain.u) annotation(
    Line(points = {{-60, 0}, {-42, 0}}, color = {0, 0, 127}));
  connect(gain.y, fb_beta.u1) annotation(
    Line(points = {{-18, 0}, {-8, 0}}, color = {0, 0, 127}));
  connect(fb_beta.y, prod_alpha.u1) annotation(
    Line(points = {{10, 0}, {14, 0}, {14, 6}, {20, 6}}, color = {0, 0, 127}));
  connect(prod_alpha.y, int_alpha.u) annotation(
    Line(points = {{44, 0}, {58, 0}}, color = {0, 0, 127}));
  connect(int_alpha.y, fb_alpha.u2) annotation(
    Line(points = {{82, 0}, {88, 0}, {88, 40}, {-70, 40}, {-70, 8}}, color = {0, 0, 127}));
  connect(mux.y, ab) annotation(
    Line(points = {{142, 0}, {180, 0}}, color = {0, 0, 127}));
  connect(prod_beta.y, int_beta.u) annotation(
    Line(points = {{1, -80}, {17, -80}}, color = {0, 0, 127}));
  connect(int_beta.y, fb_beta.u2) annotation(
    Line(points = {{41, -80}, {60, -80}, {60, -26}, {0, -26}, {0, -8}}, color = {0, 0, 127}));
  connect(int_alpha.y, prod_beta.u1) annotation(
    Line(points = {{82, 0}, {88, 0}, {88, 40}, {-90, 40}, {-90, -86}, {-22, -86}}, color = {0, 0, 127}));
  connect(w, prod_beta.u2) annotation(
    Line(points = {{-60, -40}, {-34, -40}, {-34, -74}, {-22, -74}}, color = {0, 0, 127}));
  connect(w, prod_alpha.u2) annotation(
    Line(points = {{-60, -40}, {12, -40}, {12, -6}, {20, -6}}, color = {0, 0, 127}));
  connect(int_beta.y, mux.u2[1]) annotation(
    Line(points = {{42, -80}, {100, -80}, {100, -6}, {118, -6}}, color = {0, 0, 127}));
  connect(int_alpha.y, mux.u1[1]) annotation(
    Line(points = {{82, 0}, {100, 0}, {100, 6}, {118, 6}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "1φ"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "αβ"), Text(extent = {{-100, 20}, {100, -20}}, textString = "kr=%kr")}),
  Diagram(coordinateSystem(extent = {{-100, -100}, {160, 100}})),
  Documentation(info = "<html><head></head><body>See <a href=\"modelica://OwnControl/Examples/SOGIFilterDemo.mo\">Examples/SOGIFilterDemo</a> example. Effect of kr gain:<div><img src=\"modelica://OwnControl/Resources/Images/sogi_kr_anim-0.5-50.gif\"></div></body>
  </html>"));
end SOGI;