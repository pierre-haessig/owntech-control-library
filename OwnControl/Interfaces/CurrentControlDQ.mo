within OwnControl.Interfaces;

partial model CurrentControlDQ "Interface for AC current controller using PIs in DQ reference frame"
extends Modelica.Blocks.Icons.Block;
  Modelica.Blocks.Interfaces.RealInput idq_sp[2](each final unit="A") "dq current set point"annotation(
    Placement(transformation(origin = {-170, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput idq_m[2](each final unit="A") "dq current current measurement" annotation(
    Placement(transformation(origin = {-170, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput vdq[2](each final unit="V") "dq inverter voltage set point" annotation(
    Placement(transformation(origin = {160, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));

equation

  annotation(
    Icon(graphics = {Text(extent = {{-100, 50}, {100, -50}}, textString = "I dq
ctrl")}),
  Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end CurrentControlDQ;