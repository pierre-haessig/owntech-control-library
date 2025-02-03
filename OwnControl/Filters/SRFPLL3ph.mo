within OwnControl.Filters;

model SRFPLL3ph "Three phase SRF-PLL"
  extends Interfaces.PLL3ph;
  parameter Real kr=sqrt(2) "SOGI filter resonance damping factor";
  Modelica.Blocks.Routing.DeMultiplex2 deMuxDQ annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.Park park annotation(
    Placement(transformation(origin = {-90, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(deMuxDQ.y2[1], loopFilterPI.u) annotation(
    Line(points = {{-18, -6}, {-10, -6}, {-10, 0}, {38, 0}}, color = {0, 0, 127}));
  connect(park.dq, deMuxDQ.u) annotation(
    Line(points = {{-78, 0}, {-42, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(ph, park.ph) annotation(
    Line(points = {{210, -30}, {200, -30}, {200, -80}, {-90, -80}, {-90, -12}}, color = {0, 0, 127}));
  connect(abc, park.abc) annotation(
    Line(points = {{-220, 0}, {-102, 0}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Rectangle(origin = {-65, 0}, lineColor = {38, 162, 105}, pattern = LinePattern.Dash, extent = {{-55, 40}, {55, -40}}), Text(origin = {-67, 33}, textColor = {38, 162, 105}, extent = {{-49, 5}, {49, -5}}, textString = "SRF phase detector", horizontalAlignment = TextAlignment.Left), Text(origin = {0, 70}, extent = {{-120, 10}, {120, -10}}, textString = "Three phase SRF PLL"), Text(origin = {-7, -15}, textColor = {38, 162, 105}, extent = {{-9, 5}, {9, -5}}, textString = "Vq", horizontalAlignment = TextAlignment.Left)}));
end SRFPLL3ph;