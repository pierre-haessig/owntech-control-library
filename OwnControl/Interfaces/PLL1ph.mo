within OwnControl.Interfaces;

partial model PLL1ph "Single-phase PLL interface with PI loop filter"
  extends PLL;
  Modelica.Blocks.Interfaces.RealInput u "single phase AC signal" annotation(
    Placement(transformation(origin = {-220, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
equation

annotation(
    Icon(graphics = {Text(origin = {-120, 40}, textColor = {0, 0, 127}, extent = {{-20, 20}, {20, -20}}, textString = "1φ", horizontalAlignment = TextAlignment.Left)}));
end PLL1ph;