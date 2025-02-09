within OwnControl.Transforms;

model InvPark "DQ to three phase to transform (inverse Park)"
  extends Interfaces.TransformPhaseBlock;
  Modelica.Blocks.Interfaces.RealInput dq[2] "dq signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput abc[3] "three phase AC signal" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  InvClarkeDQ invClarkeDQ annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  InvClarke invClarke annotation(
    Placement(transformation(origin = {50, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ph, invClarkeDQ.ph) annotation(
    Line(points = {{0, -120}, {0, -12}}, color = {0, 0, 127}));
  connect(dq, invClarkeDQ.dq) annotation(
    Line(points = {{-120, 0}, {-12, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(invClarkeDQ.ab, invClarke.ab) annotation(
    Line(points = {{12, 0}, {38, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(invClarke.abc, abc) annotation(
    Line(points = {{62, 0}, {120, 0}}, color = {0, 0, 127}, thickness = 0.5));

annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "dq"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "abc")}));
end InvPark;