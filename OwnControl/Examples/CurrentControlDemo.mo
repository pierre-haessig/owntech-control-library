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
  parameter Duration Tci(displayUnit = "ms") = 2e-3 "closed loop current control time constant (Skogestad-IMC PI tuning)";
  parameter Real kp = L/Tci "PI proportional gain (unit: Ohms)";
  parameter Duration Ti(displayUnit = "ms") = min(4*Tci, L/R) "PI integrator time constant";
  /*Set point parameters */
  parameter Duration Tstep(displayUnit = "ms") = 20e-3 "Id,Iq set point step instant";
  parameter Current Id_sp = 1 "Id set point after Tstep";
  parameter Current Iq_sp = 0 "Iq set point after Tstep";
  Controllers.CurrentControlDQ3ph currentControlDQ3ph(f0 = f0, kp = kp, Ti = Ti, L = L, Vg = Vg, Vmax = Vmax) "current controller under test" annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZa(a = {L, R}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialState, y(unit="A")) "grid connection impedance, phase a" annotation(
    Placement(transformation(origin = {70, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZb(a = {L, R}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialState, y(unit="A")) "grid connection impedance, phase b" annotation(
    Placement(transformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.TransferFunction tfZc(a = {L, R}, b = {1}, initType = Modelica.Blocks.Types.Init.InitialState, y(unit="A")) "grid connection impedance, phase c" annotation(
    Placement(transformation(origin = {70, -30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZa annotation(
    Placement(transformation(origin = {30, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZb annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Math.Feedback vZc annotation(
    Placement(transformation(origin = {30, -30}, extent = {{-10, -10}, {10, 10}})));
  Utilities.CosinePerturbed3ph vGrid(amplitude_a = Vg, f = f0, n_odd = 2, amplitudes_odd_rel = {0.03, 0.03}, phases_odd = {3.141592653589793, 3.141592653589793}, harmonics = false) "three-phase grid voltage" annotation(
    Placement(transformation(origin = {-50, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vi(y1(each unit="V"), y2(each unit="V"), y3(each unit="V")) "demux three phase inverter voltages" annotation(
    Placement(transformation(origin = {-10, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.DeMultiplex3 demux_vg(y1(each unit="V"), y2(each unit="V"), y3(each unit="V")) "demux three phase grid voltages" annotation(
    Placement(transformation(origin = {-10, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex3 mux_im(y(each unit="A")) "mux three phase current measurement" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex2 mux_isp(y(each unit="A")) "mux dq current set points" annotation(
    Placement(transformation(origin = {-90, 10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Id_step(height = Id_sp, startTime = Tstep, y(unit="A")) "Id set point" annotation(
    Placement(transformation(origin = {-130, 30}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Step Iq_step(height = Iq_sp, startTime = Tstep, y(unit="A")) "Iq set point" annotation(
    Placement(transformation(origin = {-130, -10}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Sources.Constant f(k = f0) annotation(
    Placement(transformation(origin = {-130, -70}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Continuous.Integrator phase(k = 2*pi) annotation(
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
  connect(f.y, phase.u) annotation(
    Line(points = {{-118, -70}, {-102, -70}}, color = {0, 0, 127}));
  connect(phase.y, currentControlDQ3ph.ph) annotation(
    Line(points = {{-78, -70}, {-76, -70}, {-76, -30}, {-50, -30}, {-50, -12}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Text(origin = {0, 80}, extent = {{-120, 20}, {120, -20}}, textString = "Three-phase alternating current control
with DQ controller"), Rectangle(origin = {51, -18}, lineColor = {38, 162, 105}, fillColor = {233, 255, 237}, pattern = LinePattern.Dash, fillPattern = FillPattern.Solid, extent = {{-79, 68}, {79, -68}}), Text(origin = {83, -66}, textColor = {38, 162, 105}, extent = {{-39, 14}, {39, -14}}, textString = "grid connection through
impedance Z=R+jwL"), Rectangle(origin = {-49, 0}, lineColor = {26, 95, 180}, fillColor = {214, 232, 255}, pattern = LinePattern.Dash, fillPattern = FillPattern.Solid, extent = {{-17, 20}, {17, -20}}), Text(origin = {-50, 28}, textColor = {26, 95, 180}, extent = {{-18, 6}, {18, -6}}, textString = "Controller"), Text(origin = {-114, 56}, textColor = {26, 95, 180}, extent = {{-26, 8}, {26, -8}}, textString = "DQ Current
set points"), Text(origin = {-110, -45}, textColor = {26, 95, 180}, extent = {{-30, 7}, {30, -7}}, textString = "grid phase
(in practice:
 output of a PLL)")}, coordinateSystem(extent = {{-150, -100}, {150, 100}})),
    experiment(StartTime = 0, StopTime = 0.06, Tolerance = 1e-06, Interval = 3.0015e-05),
  Documentation(info = "<html><head></head><body><div><img src=\"modelica://OwnControl/Resources/Images/CurrentControlDemo.png\" style=\"width:100%;\"></div><div>Demo of three-phase current control with closed loop time constant Tci=2ms (PI control tuning with Skogestad-IMC [1] method):</div><div><br></div><div><img src=\"modelica://OwnControl/Resources/Images/CurrentControlDemo_plot_Tci2ms.png\" style=\"width:100%;\"></div><div>DQ current controller is implemented in the CurrentControlDQ model (while CurrentControlDQ3ph used in the demo is only a thin wrapper with DQ transform and inverse transform interfaces):</div><div><img src=\"modelica://OwnControl/Resources/Images/CurrentControlDQ.png\" style=\"width:100%;\"></div><div>[1] S. Skogestad, “Simple analytic rules for model reduction and PID controller tuning”, J. Process Control, vol. 13 (2003), 291-309. DOI <a href=\"https://doi.org/10.1016/S0959-1524(02)00062-8\">10.1016/S0959-1524(02)00062-8</a>. See also <a href=\"https://skoge.folk.ntnu.no/publications/2003/tuningPID/\">https://skoge.folk.ntnu.no/publications/2003/tuningPID/</a>.</div></body></html>"));
end CurrentControlDemo;