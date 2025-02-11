within OwnControl.Controllers;

model VoltDuty3ph "Convert three-phase voltages to inverter duty cycles (d = v/vdc + 1/2)"
extends Modelica.Blocks.Icons.Block;
  parameter Boolean useVdcInput = false "true to use external Vdc signal";
  parameter Voltage vdc_const(start=1) "constant DC bus voltage";
  Modelica.Blocks.Interfaces.RealInput vabc[3](each final unit="V") "three-phase voltage" annotation(
    Placement(transformation(origin = {-112, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput vdc(final unit="V") "DC bus voltage" annotation(
    Placement(transformation(origin = {-164, -88}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput duty_abc[3] "three-phase duty cycles" annotation(
    Placement(transformation(origin = {114, -2}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  equation

annotation(
    Icon(graphics = {Line(points = {{100, 100}, {-100, -100}}, color = {0, 0, 127}), Text(origin = {-49, 60}, extent = {{-51, 20}, {51, -20}}, textString = "Vabc"), Text(origin = {30, -60}, extent = {{-70, 20}, {70, -20}}, textString = "duty abc")}));
end VoltDuty3ph;