within OwnControl.Controllers;

model CurrentControlDQ "AC current controller using PIs in DQ reference frame"
  extends Interfaces.CurrentControlDQ;
  
  parameter Real kp "PI proportional gain";
  parameter Duration Ti "PI integrator time constant";
  parameter Voltage Vmax(min=Vg) "Maximum inverter voltage amplitude (for PI saturation)";
  parameter Voltage Vg "Grid voltage amplitude estimate (for Vd feedforward)";
  parameter Frequency f0 "Grid frequency estimate (for L.w decoupling)";
  parameter Inductance L=0 "Grid inductance estimate (for L.w decoupling)";
  Current id_m "Id current measurement";
  Current iq_m "Iq current measurement";
  Modelica.Blocks.Routing.DeMultiplex2 demux_idq_sp annotation(
    Placement(transformation(origin = {-130, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_vdq annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID_d(Td = 0, initType = Modelica.Blocks.Types.Init.InitialState, k = kp, Ti = Ti, withFeedForward = true, yMax = Vmax)  annotation(
    Placement(transformation(origin = {-50, 40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.LimPID PID_q(Td = 0, Ti = Ti, initType = Modelica.Blocks.Types.Init.InitialState, k = kp, yMax = Vmax) annotation(
    Placement(transformation(origin = {-50, -40}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add_Lwd annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Add add_Lwq annotation(
    Placement(transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain_Lwd(k(final unit="Ohm") = -L*w0)  annotation(
    Placement(transformation(origin = {30, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Gain gain_Lwq(k(final unit="Ohm") = +L*w0) annotation(
    Placement(transformation(origin = {30, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression id_expr1(y = id_m)  annotation(
    Placement(transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression id_expr2(y = id_m) annotation(
    Placement(transformation(origin = {-10, -20}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression iq_expr1(y = iq_m) annotation(
    Placement(transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.RealExpression iq_expr2(y = iq_m) annotation(
    Placement(transformation(origin = {-10, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant Vg_ff(k = Vg)  "grid voltage feedforward in Vd channel" annotation(
    Placement(transformation(origin = {-70, -10}, extent = {{-10, -10}, {10, 10}})));
protected
  parameter AngularFrequency w0=2*pi*f0;
equation
  id_m = idq_m[1];
  iq_m = idq_m[2];
  connect(demux_idq_sp.u, idq_sp) annotation(
    Line(points = {{-142, 40}, {-170, 40}}, color = {0, 0, 127}));
  connect(gain_Lwd.y, add_Lwd.u2) annotation(
    Line(points = {{41, 10}, {48, 10}, {48, 24}, {58, 24}}, color = {0, 0, 127}));
  connect(iq_expr2.y, gain_Lwd.u) annotation(
    Line(points = {{1, 10}, {18, 10}}, color = {0, 0, 127}));
  connect(gain_Lwq.y, add_Lwq.u1) annotation(
    Line(points = {{41, -20}, {48, -20}, {48, -24}, {58, -24}}, color = {0, 0, 127}));
  connect(id_expr2.y, gain_Lwq.u) annotation(
    Line(points = {{1, -20}, {18, -20}}, color = {0, 0, 127}));
  connect(demux_idq_sp.y2[1], PID_q.u_s) annotation(
    Line(points = {{-119, 34}, {-110, 34}, {-110, -40}, {-62, -40}}, color = {0, 0, 127}));
  connect(demux_idq_sp.y1[1], PID_d.u_s) annotation(
    Line(points = {{-119, 46}, {-110, 46}, {-110, 40}, {-62, 40}}, color = {0, 0, 127}));
  connect(add_Lwd.y, mux_vdq.u1[1]) annotation(
    Line(points = {{81, 30}, {89, 30}, {89, 6}, {97, 6}}, color = {0, 0, 127}));
  connect(add_Lwq.y, mux_vdq.u2[1]) annotation(
    Line(points = {{81, -30}, {89, -30}, {89, -6}, {97, -6}}, color = {0, 0, 127}));
  connect(Vg_ff.y, PID_d.u_ff) annotation(
    Line(points = {{-58, -10}, {-44, -10}, {-44, 28}}, color = {0, 0, 127}));
  connect(mux_vdq.y, vdq) annotation(
    Line(points = {{121, 0}, {160, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(iq_expr1.y, PID_q.u_m) annotation(
    Line(points = {{-79, -70}, {-50, -70}, {-50, -52}}, color = {0, 0, 127}));
  connect(id_expr1.y, PID_d.u_m) annotation(
    Line(points = {{-79, 10}, {-50, 10}, {-50, 28}}, color = {0, 0, 127}));
  connect(PID_d.y, add_Lwd.u1) annotation(
    Line(points = {{-38, 40}, {40, 40}, {40, 36}, {58, 36}}, color = {0, 0, 127}));
  connect(PID_q.y, add_Lwq.u2) annotation(
    Line(points = {{-38, -40}, {40, -40}, {40, -36}, {58, -36}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {-142, -40}, extent = {{-6, 8}, {6, -8}}, textString = "id_m
iq_m"), Rectangle(origin = {-140, -40}, extent = {{-10, 10}, {10, -10}}), Text(origin = {10, 90}, extent = {{-110, 10}, {110, -10}}, textString = "AC current controller in DQ reference frame"), Rectangle(origin = {10, -1}, lineColor = {38, 162, 105}, pattern = LinePattern.Dash, extent = {{-34, 33}, {34, -33}}), Text(origin = {10, 27}, textColor = {38, 162, 105}, extent = {{-34, 5}, {34, -5}}, textString = "dq channels Lw decoupling")}));


end CurrentControlDQ;