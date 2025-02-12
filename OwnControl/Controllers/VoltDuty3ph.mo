within OwnControl.Controllers;

model VoltDuty3ph "Convert three-phase voltages to inverter duty cycles (d = v/vdc + 1/2). DRAFT!!!!"
extends Modelica.Blocks.Icons.Block;
  parameter Boolean useVdcInput = false "true to use external Vdc signal";
  parameter Voltage vdc_const "constant DC bus voltage (used if useVdcInput=false)";
  Modelica.Blocks.Interfaces.RealInput vabc[3](each final unit="V") "three-phase voltage" annotation(
    Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  Modelica.Blocks.Interfaces.RealInput vdc_in(final unit="V") if useVdcInput "DC bus voltage input" annotation(
    Placement(transformation(origin = {-120, -60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {0, -120}, extent = {{-20, -20}, {20, 20}}, rotation = 90)));
  Modelica.Blocks.Interfaces.RealOutput duty_abc[3] "three-phase duty cycles" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  
    
  protected
  Modelica.Blocks.Sources.Constant vdc_const_source(final k = vdc_const) if not useVdcInput annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Interfaces.RealOutput vdc "actual Vdc" annotation(
    Placement(transformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, -60}, extent = {{-10, -10}, {10, 10}})));
  
  function saturate_01 "saturate x in [0,1]"
    input Real x;
    output Real y;
  algorithm
    y := max(min(x, 1), 0);
  end saturate_01;
  
  equation
  
  for i in 1:3 loop
    duty_abc[i] = saturate_01(vabc[i]/vdc + 0.5);
  end for;
  
  connect(vdc_const_source.y, vdc) annotation(
    Line(points = {{22, 0}, {40, 0}, {40, -60}, {110, -60}}, color = {0, 0, 127}));
  connect(vdc_in, vdc) annotation(
    Line(points = {{-120, -60}, {110, -60}}, color = {0, 0, 127}));

annotation(
    Icon(graphics = {Line(points = {{100, 100}, {-100, -100}}, color = {0, 0, 127}), Text(origin = {-49, 60}, extent = {{-51, 20}, {51, -20}}, textString = "Vabc"), Text(origin = {30, -60}, extent = {{-70, 20}, {70, -20}}, textString = "duty abc")}));
end VoltDuty3ph;