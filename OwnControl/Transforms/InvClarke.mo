within OwnControl.Transforms;

model InvClarke "Alpha-Beta to rhree phase to transform (inverse Clarke)"
  extends OwnControl.Interfaces.TransformBlock;
  Modelica.Blocks.Interfaces.RealInput ab[2] "alpha-beta signal" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput abc[3] "three phase AC signal" annotation(
    Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  
equation
  abc[1] =      ab[1]                   "a = alpha";
  abc[2] = -0.5*ab[1] + sqrt(3)/2*ab[2] "b = -1/2.alpha + sqrt(3)/2.beta";
  abc[3] = -0.5*ab[1] - sqrt(3)/2*ab[2] "c = -1/2.alpha - sqrt(3)/2.beta";
annotation(
    Icon(graphics = {Text(origin = {-40, 60}, extent = {{-50, 20}, {50, -20}}, textString = "αβ"), Text(origin = {30, -60}, extent = {{-50, 20}, {50, -20}}, textString = "abc")}));
end InvClarke;