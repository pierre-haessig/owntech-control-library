within OwnControl.Utilities;

model VCO "Voltage controlled oscillator (cosine type: y=1 for phase=0)"
  extends Modelica.Blocks.Icons.Block;
  
  parameter Real a = 1.0 "amplitude";
  parameter Angle phi0 = 0 "initial phase";
  
  Angle phase "oscillator phase";
  
  Modelica.Blocks.Interfaces.RealInput w(final unit="rad/s") "instantaneous angular frequency" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput y "cosine" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  
initial equation
  phase = phi0;

equation
  der(phase) = w;
  y = a*cos(phase);
  
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), Line(points = {{-80, -80}, {-80, 68}}, color = {192, 192, 192}), Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}), Line(points = {{-80, 80}, {-74.4, 78.1}, {-68.7, 72.3}, {-63.1, 63}, {-56.7, 48.7}, {-48.6, 26.6}, {-29.3, -32.5}, {-22.1, -51.7}, {-15.7, -65.3}, {-10.1, -73.8}, {-4.42, -78.8}, {1.21, -79.9}, {6.83, -77.1}, {12.5, -70.6}, {18.1, -60.6}, {24.5, -45.7}, {32.6, -23}, {50.3, 31.3}, {57.5, 50.7}, {63.9, 64.6}, {69.5, 73.4}, {75.2, 78.6}, {80, 80}}, smooth = Smooth.Bezier), Text(textColor = {192, 192, 192}, extent = {{-36, 82}, {36, 34}}, textString = "VCO"), Text(origin = {-61, -70}, extent = {{-39, 30}, {39, -30}}, textString = "%phi0"), Text(origin = {60, -70}, extent = {{-40, 30}, {40, -30}}, textString = "%a")}));
end VCO;