within OwnControl.Transforms;

model ClarkeDQ "Alpha-Beta (Clarke) to DQ (Park) transform"
extends Interfaces.TransformPhaseBlock;
  Modelica.Blocks.Interfaces.RealInput ab[2] "alpha-beta input" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput dq[2] "dq output" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
equation
  dq[1] =  ab[1] * cos_theta + ab[2] * sin_theta;
  dq[2] = -ab[1] * sin_theta + ab[2] * cos_theta;
annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "αβ"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "dq")}));
end ClarkeDQ;