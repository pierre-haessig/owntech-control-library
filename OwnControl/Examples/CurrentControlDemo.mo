within OwnControl.Examples;

model CurrentControlDemo
  extends Modelica.Icons.Example;
  /*Physical parameters (e.g. grid voltage and impedance) */
  parameter Voltage Vmax = 150 "Maximum inverter voltage amplitude (for PI saturation), related to DC voltage";
  parameter Frequency f0 = 50 "grid frequency estimate";
  parameter Voltage Vg = 100 "Grid voltage amplitude";
  parameter Resistance R = 1e-3 "grid resistance";
  parameter Inductance L = 1e-3 "grid inductance";
  /*Controller parameters */
  parameter Duration Tci(displayUnit = "ms") = 3e-3 "closed loop current control time constant (Skogestad-IMC PI tuning)";
  parameter Real kp = L/Tci "PI proportional gain (unit: Ohms)";
  parameter Duration Ti(displayUnit = "ms") = min(4*Tci, L/R) "PI integrator time constant";
  /*Set point parameters */
  parameter Duration Tstep(displayUnit = "ms") = 20e-3 "Id,Iq set point step instant";
  parameter Current Id_sp = 1 "Id set point after Tstep";
  parameter Current Iq_sp = 1 "Iq set point after Tstep";
  Controllers.CurrentControlDQ3ph currentControlDQ3ph(f0 = f0, kp = kp, Ti = Ti, L = L, Vg = Vg, Vmax = Vmax) annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZa(b = {1}, a = {L, R}, initType = Modelica.Blocks.Types.Init.InitialState) "grid connection impedance, phase a" annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZb(a = {L, R}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialState) "grid connection impedance, phase b" annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZc(a = {L, R}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialState) "grid connection impedance, phase c" annotation(
    Placement(transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZa annotation(
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZb annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZc annotation(
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed3ph vGrid(amplitude = Vg, f = f0, n_odd = 2, amplitudes_odd_rel = {0.03, 0.03}, phases_odd = {3.141592653589793, 3.141592653589793}, harmonics = false) annotation(
    Placement(transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vi annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vg annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex3 mux_im annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_isp annotation(
    Placement(transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Id_step(height = Id_sp, startTime = Tstep) annotation(
    Placement(transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Iq_step(height = Iq_sp, startTime = Tstep) annotation(
    Placement(transformation(origin = {-130, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant f(k = f0) annotation(
    Placement(transformation(origin = {-130, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator integrator(k = 2*pi) annotation(
    Placement(transformation(origin = {-90, -70}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(vZa.y, tfZa.u) annotation(
    Line(points = {{40, 30}, {58, 30}}, color = {0, 0, 127}));
  connect(vZb.y, tfZb.u) annotation(
    Line(points = {{40, 0}, {58, 0}}, color = {0, 0, 127}));
  connect(vZc.y, tfZc.u) annotation(
    Line(points = {{40, -30}, {58, -30}}, color = {0, 0, 127}));
  connect(Id_step.y, mux_isp.u1[1]) annotation(
    Line(points = {{-118, 30}, {-110, 30}, {-110, 16}, {-102, 16}}, color = {0, 0, 127}));
  connect(Iq_step.y, mux_isp.u2[1]) annotation(
    Line(points = {{-118, -10}, {-110, -10}, {-110, 4}, {-102, 4}}, color = {0, 0, 127}));
  connect(mux_isp.y, currentControlDQ3ph.idq_sp) annotation(
    Line(points = {{-78, 10}, {-70, 10}, {-70, 4}, {-62, 4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(currentControlDQ3ph.vabc, demux_vi.u) annotation(
    Line(points = {{-38, 4}, {-32, 4}, {-32, 0}, {-22, 0}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demux_vi.y1[1], vZa.u1) annotation(
    Line(points = {{2, 8}, {8, 8}, {8, 30}, {22, 30}}, color = {0, 0, 127}));
  connect(demux_vi.y2[1], vZb.u1) annotation(
    Line(points = {{2, 0}, {22, 0}}, color = {0, 0, 127}));
  connect(demux_vi.y3[1], vZc.u1) annotation(
    Line(points = {{2, -6}, {10, -6}, {10, -30}, {22, -30}}, color = {0, 0, 127}));
  connect(vGrid.abc, demux_vg.u) annotation(
    Line(points = {{-38, -70}, {-22, -70}}, color = {0, 0, 127}, thickness = 0.5));
  connect(demux_vg.y1[1], vZa.u2) annotation(
    Line(points = {{2, -62}, {14, -62}, {14, 14}, {30, 14}, {30, 22}}, color = {0, 0, 127}));
  connect(demux_vg.y2[1], vZb.u2) annotation(
    Line(points = {{2, -70}, {16, -70}, {16, -16}, {30, -16}, {30, -8}}, color = {0, 0, 127}));
  connect(demux_vg.y3[1], vZc.u2) annotation(
    Line(points = {{2, -76}, {30, -76}, {30, -38}}, color = {0, 0, 127}));
  connect(tfZa.y, mux_im.u1[1]) annotation(
    Line(points = {{82, 30}, {90, 30}, {90, 8}, {98, 8}}, color = {0, 0, 127}));
  connect(tfZb.y, mux_im.u2[1]) annotation(
    Line(points = {{82, 0}, {98, 0}}, color = {0, 0, 127}));
  connect(tfZc.y, mux_im.u3[1]) annotation(
    Line(points = {{82, -30}, {90, -30}, {90, -6}, {98, -6}}, color = {0, 0, 127}));
  connect(mux_im.y, currentControlDQ3ph.iabc_m) annotation(
    Line(points = {{122, 0}, {140, 0}, {140, -94}, {-70, -94}, {-70, -4}, {-62, -4}}, color = {0, 0, 127}, thickness = 0.5));
  connect(f.y, integrator.u) annotation(
    Line(points = {{-118, -70}, {-102, -70}}, color = {0, 0, 127}));
  connect(integrator.y, currentControlDQ3ph.ph) annotation(
    Line(points = {{-78, -70}, {-76, -70}, {-76, -30}, {-50, -30}, {-50, -12}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-100, 20}, {100, -20}}, textString = "three phase AC current control
with DQ controller"), Rectangle(origin = {51, -18}, lineColor = {38, 162, 105}, fillColor = {38, 162, 105}, pattern = LinePattern.Dash, extent = {{-79, 68}, {79, -68}}), Text(origin = {83, -66}, textColor = {38, 162, 105}, extent = {{-39, 14}, {39, -14}}, textString = "grid connection through
impedance Z=R+jwL")}, coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 0.04, Tolerance = 1e-06, Interval = 2.001e-05));
end CurrentControlDemo;