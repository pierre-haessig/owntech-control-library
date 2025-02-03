within OwnControl.Transforms;

model Clarke "Three phase to Alpha-Beta (Clarke) transform"
  extends OwnControl.Interfaces.TransformBlock;
  Modelica.Blocks.Interfaces.RealInput abc[3] "three phase AC signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput ab[2] "alpha-beta" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  
equation
  ab[1] = 2.0 / 3.0 * (abc[1] - 0.5 * (abc[2] + abc[3])); 
  ab[2] = (abc[2] - abc[3])/sqrt(3);
annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "abc"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "αβ")}));
end Clarke;