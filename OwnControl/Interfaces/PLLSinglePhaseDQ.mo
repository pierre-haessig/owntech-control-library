within OwnControl.Interfaces;

partial model PLLSinglePhaseDQ "Single phase PLL interface, using DQ (Park) transform as phase detector"
extends PLL;
  Modelica.Blocks.Interfaces.RealInput u "single phase AC signal" annotation(
    Placement(transformation(origin = {-220, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Math.Gain flip(k = -1) "Vq sign flip" annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.ClarkeDQ clarkeDQ annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex2 deMux annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(flip.y, loopFilterPI.u) annotation(
    Line(points = {{21, 0}, {38, 0}}, color = {0, 0, 127}));
  connect(ph, clarkeDQ.ph) annotation(
    Line(points = {{210, -30}, {200, -30}, {200, -82}, {-70, -82}, {-70, -12}}, color = {0, 0, 127}));
  connect(clarkeDQ.dq, deMux.u) annotation(
    Line(points = {{-58, 0}, {-42, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(deMux.y2[1], flip.u) annotation(
    Line(points = {{-18, -6}, {-10, -6}, {-10, 0}, {-2, 0}}, color = {0, 0, 127}));
annotation(
    Icon(coordinateSystem(extent = {{-100, -100}, {100, 100}})));
end PLLSinglePhaseDQ;