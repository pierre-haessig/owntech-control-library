within OwnControl.Transforms;

model Park "Three phase to DQ (Park) transform"
extends Interfaces.TransformPhaseBlock;
  Modelica.Blocks.Interfaces.RealInput abc[3] "three phase AC signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput dq[2] "dq signal" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  Clarke clarke annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  ClarkeDQ clarkeDQ annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
equation
 connect(clarke.ab, clarkeDQ.ab) annotation(
    Line(points = {{-38, 0}, {-12, 0}}, color = {0, 0, 127}, thickness = 0.5));
 connect(abc, clarke.abc) annotation(
    Line(points = {{-120, 0}, {-62, 0}}, color = {0, 0, 127}, thickness = 0.5));
 connect(clarkeDQ.dq, dq) annotation(
    Line(points = {{12, 0}, {120, 0}}, color = {0, 0, 127}, thickness = 0.5));
 connect(ph, clarkeDQ.ph) annotation(
    Line(points = {{0, -120}, {0, -12}}, color = {0, 0, 127}));
annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "abc"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "dq")}));
end Park;