within OwnControl.Interfaces;

partial model CurrentControlDQ3ph "Interface for three phase AC current controller with dq references"
extends Modelica.Blocks.Icons.Block;

  Modelica.Blocks.Interfaces.RealInput ph "phase" annotation(
    Placement(transformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealInput idq_sp[2](each final unit="A") "dq current set point"annotation(
    Placement(transformation(origin = {-170, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput iabc_m[3](each final unit="A") "three phase current measurement" annotation(
    Placement(transformation(origin = {-170, -40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealOutput vdq[2](each final unit="V") "dq inverter voltage set point" annotation(
    Placement(transformation(origin = {160, -40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput vabc[3](each final unit="V") "three phase inverter voltage set point" annotation(
    Placement(transformation(origin = {160, 40}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 40}, extent = {{-10, -10}, {10, 10}})));
equation

  annotation(
    Icon(graphics = {Text(extent = {{-100, 70}, {100, -70}}, textString = "I dq
ctrl
3φ")}),
  Diagram(coordinateSystem(extent = {{-150, -100}, {150, 100}})));
end CurrentControlDQ3ph;