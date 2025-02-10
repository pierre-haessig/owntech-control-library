within OwnControl.Controllers;

model CurrentControlDQ3ph "three phase AC current controller usng PIs in DQ reference frame"
  extends Interfaces.CurrentControl3ph;
     
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
  Modelica.Blocks.Routing.DeMultiplex2 demux_idq_sp annotation(
    Placement(transformation(origin = {-110, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_vdq annotation(
    Placement(transformation(origin = {90, 0}, extent = {{-10, -10}, {10, 10}})));
  Transforms.InvPark invPark_v annotation(
    Placement(transformation(origin = {130, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID_d(Td = 0, initType = Modelica.Blocks.Types.Init.InitialState, k = kp, Ti = Ti, withFeedForward = true, yMax = Vmax)  annotation(
    Placement(transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID_q(Td = 0, Ti = Ti, initType = Modelica.Blocks.Types.Init.InitialState, k = kp, yMax = Vmax) annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add_Lwd annotation(
    Placement(transformation(origin = {50, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add_Lwq annotation(
    Placement(transformation(origin = {50, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain_Lwd(k(final unit="Ohm") = -L*w0)  annotation(
    Placement(transformation(origin = {10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain_Lwq(k(final unit="Ohm") = +L*w0) annotation(
    Placement(transformation(origin = {10, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression id_expr1(y = id_m)  annotation(
    Placement(transformation(origin = {-70, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression id_expr2(y = id_m) annotation(
    Placement(transformation(origin = {-30, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression iq_expr1(y = iq_m) annotation(
    Placement(transformation(origin = {-70, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression iq_expr2(y = iq_m) annotation(
    Placement(transformation(origin = {-30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant Vg_ff(k = Vg)  annotation(
    Placement(transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}})));
protected
  parameter AngularFrequency w0=2*pi*f0;
equation
  id_m = park_imes.dq[1];
  iq_m = park_imes.dq[2];
  connect(ph, park_imes.ph) annotation(
    Line(points = {{0, -120}, {0, -80}, {-130, -80}, {-130, -52}}, color = {0, 0, 127}));
  connect(iabc_m, park_imes.abc) annotation(
    Line(points = {{-170, -40}, {-142, -40}}, color = {0, 0, 127}));
  connect(demux_idq_sp.u, idq_sp) annotation(
    Line(points = {{-122, 40}, {-170, 40}}, color = {0, 0, 127}));
  connect(mux_vdq.y, vdq) annotation(
    Line(points = {{101, 0}, {110, 0}, {110, -40}, {160, -40}}, color = {0, 0, 127}));
  connect(ph, invPark_v.ph) annotation(
    Line(points = {{0, -120}, {0, -80}, {130, -80}, {130, 28}}, color = {0, 0, 127}));
  connect(invPark_v.abc, vabc) annotation(
    Line(points = {{142, 40}, {160, 40}}, color = {0, 0, 127}));
  connect(mux_vdq.y, invPark_v.dq) annotation(
    Line(points = {{101, 0}, {110, 0}, {110, 40}, {118, 40}}, color = {0, 0, 127}, thickness = 0.5));
  connect(id_expr1.y, PID_d.u_m) annotation(
    Line(points = {{-59, 10}, {-50, 10}, {-50, 28}}, color = {0, 0, 127}));
  connect(iq_expr1.y, PID_q.u_m) annotation(
    Line(points = {{-59, -70}, {-50, -70}, {-50, -52}}, color = {0, 0, 127}));
  connect(PID_d.y, add_Lwd.u1) annotation(
    Line(points = {{-39, 40}, {19.5, 40}, {19.5, 36}, {38, 36}}, color = {0, 0, 127}));
  connect(gain_Lwd.y, add_Lwd.u2) annotation(
    Line(points = {{22, 10}, {28, 10}, {28, 24}, {38, 24}}, color = {0, 0, 127}));
  connect(iq_expr2.y, gain_Lwd.u) annotation(
    Line(points = {{-19, 0}, {-12, 0}, {-12, 10}, {-2, 10}}, color = {0, 0, 127}));
  connect(PID_q.y, add_Lwq.u2) annotation(
    Line(points = {{-39, -40}, {21.5, -40}, {21.5, -36}, {38, -36}}, color = {0, 0, 127}));
  connect(gain_Lwq.y, add_Lwq.u1) annotation(
    Line(points = {{22, -20}, {30, -20}, {30, -24}, {38, -24}}, color = {0, 0, 127}));
  connect(id_expr2.y, gain_Lwq.u) annotation(
    Line(points = {{-19, -20}, {-2, -20}}, color = {0, 0, 127}));
  connect(demux_idq_sp.y2[1], PID_q.u_s) annotation(
    Line(points = {{-98, 34}, {-90, 34}, {-90, -40}, {-62, -40}}, color = {0, 0, 127}));
  connect(demux_idq_sp.y1[1], PID_d.u_s) annotation(
    Line(points = {{-98, 46}, {-90, 46}, {-90, 40}, {-62, 40}}, color = {0, 0, 127}));
  connect(add_Lwd.y, mux_vdq.u1[1]) annotation(
    Line(points = {{62, 30}, {70, 30}, {70, 6}, {78, 6}}, color = {0, 0, 127}));
  connect(add_Lwq.y, mux_vdq.u2[1]) annotation(
    Line(points = {{62, -30}, {70, -30}, {70, -6}, {78, -6}}, color = {0, 0, 127}));
  connect(Vg_ff.y, PID_d.u_ff) annotation(
    Line(points = {{-58, -10}, {-44, -10}, {-44, 28}}, color = {0, 0, 127}));

annotation(
    Diagram(graphics = {Text(origin = {-108, -40}, extent = {{-6, 8}, {6, -8}}, textString = "id_m
iq_m"), Rectangle(origin = {-106, -40}, extent = {{-10, 10}, {10, -10}})}));
end CurrentControlDQ3ph;