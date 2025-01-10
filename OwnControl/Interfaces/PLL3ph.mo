within OwnControl.Interfaces;

partial model PLL3ph "Three phase PLL interface with PI loop filter"
  extends PLL;
  Modelica.Blocks.Interfaces.RealInput abc[3] "three phase abc signal" annotation(
    Placement(transformation(origin = {-220, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
end PLL3ph;