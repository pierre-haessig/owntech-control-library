within OwnControl.Filters;

model PLLSOGI "Single phase SOGI PLL"
  extends Interfaces.PLLSinglePhaseDQ;
  parameter Real kr=sqrt(2) "SOGI filter resonance damping factor";
  SOGI sogi(kr = kr)  annotation(
    Placement(transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(sogi.ab, clarkeDQ.ab) annotation(
    Line(points = {{-98, 0}, {-82, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(add.y, sogi.w) annotation(
    Line(points = {{122, 0}, {132, 0}, {132, -70}, {-110, -70}, {-110, -12}}, color = {0, 0, 127}));
  connect(u, sogi.u) annotation(
    Line(points = {{-220, 0}, {-122, 0}}, color = {0, 0, 127}));
end PLLSOGI;