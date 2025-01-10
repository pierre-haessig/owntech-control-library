within OwnControl.Filters;

model PLLSOGI "Single phase SOGI-SRF PLL"
  extends Interfaces.PLL1ph;
  parameter Real kr=sqrt(2) "SOGI filter resonance damping factor";
  
  Modelica.Blocks.Math.Gain flip(k = +1) "Vq sign flip. However, it seems that the sign should not be flipped!" annotation(
    Placement(transformation(origin = {10, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.ClarkeDQ clarkeDQ annotation(
    Placement(transformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex2 deMux annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  SOGI sogi(final kr = kr)  annotation(
    Placement(transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}})));

equation
  connect(flip.y, loopFilterPI.u) annotation(
    Line(points = {{21, 0}, {38, 0}}, color = {0, 0, 127}));
  connect(ph, clarkeDQ.ph) annotation(
    Line(points = {{210, -30}, {200, -30}, {200, -82}, {-70, -82}, {-70, -12}}, color = {0, 0, 127}));
  connect(clarkeDQ.dq, deMux.u) annotation(
    Line(points = {{-58, 0}, {-42, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(deMux.y2[1], flip.u) annotation(
    Line(points = {{-18, -6}, {-10, -6}, {-10, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(sogi.ab, clarkeDQ.ab) annotation(
    Line(points = {{-98, 0}, {-82, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(add.y, sogi.w) annotation(
    Line(points = {{122, 0}, {132, 0}, {132, -70}, {-110, -70}, {-110, -12}}, color = {0, 0, 127}));
  connect(u, sogi.u) annotation(
    Line(points = {{-220, 0}, {-122, 0}}, color = {0, 0, 127}));
annotation(
    Diagram(graphics = {Rectangle(origin = {-75, 0}, lineColor = {38, 162, 105}, pattern = LinePattern.Dash, extent = {{-65, 40}, {65, -40}}), Text(origin = {-87, 33}, textColor = {38, 162, 105}, extent = {{-49, 5}, {49, -5}}, textString = "SOGI-SRF phase detector", horizontalAlignment = TextAlignment.Left), Text(origin = {0, 70}, extent = {{-120, 10}, {120, -10}}, textString = "SOGI-SRF PLL"), Text(origin = {-7, -15}, textColor = {38, 162, 105}, extent = {{-9, 5}, {9, -5}}, textString = "Vq", horizontalAlignment = TextAlignment.Left)}));
end PLLSOGI;