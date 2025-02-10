within OwnControl.Controllers;

model CurrentControlDQ3ph "three phase AC current controller using PIs in DQ reference frame"
  extends Interfaces.CurrentControlDQ3ph;
     
  parameter Real kp "PI proportional gain";
  parameter Duration Ti "PI integrator time constant";
  parameter Voltage Vmax(min=Vg) "Maximum inverter voltage amplitude (for PI saturation)";
  parameter Voltage Vg "Grid voltage amplitude estimate (for Vd feedforward)";
  parameter Frequency f0 "Grid frequency estimate (for L.w decoupling)";
  parameter Inductance L=0 "Grid inductance estimate (for L.w decoupling)";
  Current id_m "Id current measurement";
  Current iq_m "Iq current measurement";
  
  Transforms.Park park_imes annotation(
    Placement(transformation(origin = {-130, -40}, extent = {{-10, -10}, {10, 10}})));
  Transforms.InvPark invPark_v annotation(
    Placement(transformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}})));
  CurrentControlDQ currentControlDQ(final kp = kp, final Ti = Ti, final Vmax = Vmax, final Vg = Vg, final f0 = f0, final L = L)  annotation(
    Placement(transformation(extent = {{-10, -10}, {10, 10}})));

equation
  id_m = park_imes.dq[1];
  iq_m = park_imes.dq[2];
  connect(ph, park_imes.ph) annotation(
    Line(points = {{0, -120}, {0, -80}, {-130, -80}, {-130, -52}}, color = {0, 0, 127}));
  connect(iabc_m, park_imes.abc) annotation(
    Line(points = {{-170, -40}, {-142, -40}}, color = {0, 0, 127}));
  connect(ph, invPark_v.ph) annotation(
    Line(points = {{0, -120}, {0, -80}, {130, -80}, {130, 28}}, color = {0, 0, 127}));
  connect(invPark_v.abc, vabc) annotation(
    Line(points = {{142, 40}, {160, 40}}, color = {0, 0, 127}));
  connect(currentControlDQ.vdq, vdq) annotation(
    Line(points = {{12, 0}, {60, 0}, {60, -40}, {160, -40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(currentControlDQ.vdq, invPark_v.dq) annotation(
    Line(points = {{12, 0}, {60, 0}, {60, 40}, {118, 40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(idq_sp, currentControlDQ.idq_sp) annotation(
    Line(points = {{-170, 40}, {-40, 40}, {-40, 4}, {-12, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(park_imes.dq, currentControlDQ.idq_m) annotation(
    Line(points = {{-118, -40}, {-40, -40}, {-40, -4}, {-12, -4}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Diagram(graphics = {Text(origin = {-92, -52}, extent = {{-6, 8}, {6, -8}}, textString = "id_m
iq_m"), Rectangle(origin = {-90, -52}, extent = {{-10, 10}, {10, -10}}), Text(origin = {0, 80}, extent = {{-140, 20}, {140, -20}}, textString = "AC current controller in DQ reference frame
with three phase interfacing")}));
end CurrentControlDQ3ph;