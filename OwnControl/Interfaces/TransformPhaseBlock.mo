within OwnControl.Interfaces;

model TransformPhaseBlock  "Signal transform block, with phase input (for Park transforms)"
  extends OwnControl.Interfaces.TransformBlock;
  Modelica.Blocks.Interfaces.RealInput ph "phase" annotation(
    Placement(transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));

protected
  Real cos_theta, sin_theta;
equation
  cos_theta = cos(ph);
  sin_theta = sin(ph);

end TransformPhaseBlock;