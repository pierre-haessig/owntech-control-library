within OwnControl.Transforms;

model InvClarkeDQ "DQ (Park) to Alpha-Beta (Clarke) transform"
extends Interfaces.TransformPhaseBlock;

Modelica.Blocks.Interfaces.RealInput dq[2] "dq signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput ab[2] "alpha-beta signal" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
equation
  ab[1] = dq[1]*cos_theta - dq[2]*sin_theta;
  ab[2] = dq[1]*sin_theta + dq[2]*cos_theta;
annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "dq"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "αβ")}));
end InvClarkeDQ;