within OwnControl.Utilities;

model CosinePerturbed3ph "Three phase cosine source perturbed with harmonics and high frequency noise"
  extends Modelica.Blocks.Icons.Block;
  parameter Real amplitude=1 "Amplitude of cosine wave";
  parameter Frequency f(start=1) "Frequency of cosine wave";
  parameter Angle phase_a = 0 "Phase shift of cosine wave, phase a";
  parameter Angle phase_b = phase_a-2*pi/3 "Phase shift of cosine wave, phase b";
  parameter Angle phase_c = phase_a-4*pi/3 "Phase shift of cosine wave, phase c";
  parameter Real offset = 0 "Offset of output signal y";
  /*Harmonics*/
  parameter Integer n_odd = 3 "Number of odd harmonics";
  final parameter Frequency f_odd[n_odd] = {(2*n + 1)*f for n in 1:n_odd} "Frequency of odd harmonics";
  parameter Real amplitudes_odd_rel[n_odd] = {0, 0, 0} "Relative amplitudes of odd harmonics of cosine wave";
  parameter Angle phases_odd[n_odd] = {0, 0, 0} "Phases of odd cosine wave";
  parameter Boolean harmonics=true "convenience toogle to enable/disable harmonics";
  /*HF noise*/
  parameter Real amplitude_hf_rel=0 "Relative amplitude of high frequency noise";
  parameter Frequency f_hf = 20*f "Frequency of high frequency noise";
  
  Modelica.Blocks.Interfaces.RealOutput abc[3] "three phase cosine" annotation(
    Placement(transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}})));
  CosinePerturbed ya(amplitude = amplitude, final f = f, final phase = phase_a, offset = offset, final n_odd = n_odd, final amplitudes_odd_rel = amplitudes_odd_rel, final phases_odd = phases_odd, harmonics = harmonics, amplitude_hf_rel = amplitude_hf_rel, f_hf = f_hf)  annotation(
    Placement(transformation(origin = {-50, 50}, extent = {{-10, -10}, {10, 10}})));
  CosinePerturbed yb(amplitude = amplitude, amplitude_hf_rel = amplitude_hf_rel, final amplitudes_odd_rel = amplitudes_odd_rel, final f = f, f_hf = f_hf, harmonics = harmonics, final n_odd = n_odd, offset = offset, final phase = phase_b, final phases_odd = phases_odd) annotation(
    Placement(transformation(origin = {-50, 0}, extent = {{-10, -10}, {10, 10}})));
  CosinePerturbed yc(amplitude = amplitude, amplitude_hf_rel = amplitude_hf_rel, final amplitudes_odd_rel = amplitudes_odd_rel, final f = f, f_hf = f_hf, harmonics = harmonics, final n_odd = n_odd, offset = offset, final phase = phase_c, final phases_odd = phases_odd) annotation(
    Placement(transformation(origin = {-50, -50}, extent = {{-10, -10}, {10, 10}})));
  Modelica.Blocks.Routing.Multiplex3 mux_abc(final n1 = 1, final n2 = 1, final n3 = 1)  annotation(
    Placement(transformation(origin = {30, 0}, extent = {{-10, -10}, {10, 10}})));
equation
  connect(ya.y, mux_abc.u1[1]) annotation(
    Line(points = {{-38, 50}, {0, 50}, {0, 8}, {18, 8}}, color = {0, 0, 127}));
  connect(yb.y, mux_abc.u2[1]) annotation(
    Line(points = {{-38, 0}, {18, 0}}, color = {0, 0, 127}));
  connect(yc.y, mux_abc.u3[1]) annotation(
    Line(points = {{-38, -50}, {0, -50}, {0, -6}, {18, -6}}, color = {0, 0, 127}));
  connect(mux_abc.y, abc) annotation(
    Line(points = {{42, 0}, {110, 0}}, color = {0, 0, 127}, thickness = 0.5));
  annotation(
    Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100, -100}, {100, 100}}), graphics = {Line(points = {{-80, 68}, {-80, -80}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{-80, 90}, {-88, 68}, {-72, 68}, {-80, 90}}), Line(points = {{-90, 0}, {68, 0}}, color = {192, 192, 192}), Polygon(lineColor = {192, 192, 192}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, points = {{90, 0}, {68, 8}, {68, -8}, {90, 0}}), Line(points = {{-80, 80}, {-76.2, 79.8}, {-70.6, 76.6}, {-64.9, 69.7}, {-59.3, 59.4}, {-52.9, 44.1}, {-44.83, 21.2}, {-27.9, -30.8}, {-20.7, -50.2}, {-14.3, -64.2}, {-8.7, -73.1}, {-3, -78.4}, {2.6, -80}, {8.2, -77.6}, {13.9, -71.5}, {19.5, -61.9}, {25.9, -47.2}, {34, -24.8}, {42, 0}}, smooth = Smooth.Bezier), Text(extent = {{-147, -152}, {153, -112}}, textString = "f=%f"), Line(points = {{42, 1}, {53.3, 35.2}, {60.5, 54.1}, {66.9, 67.4}, {72.6, 75.6}, {78.2, 80.1}, {83.8, 80.8}}), Line(origin = {1.99, 1.49}, points = {{-81.989, 78.508}, {-75.989, 86.508}, {-69.989, 62.508}, {-63.989, 74.508}, {-57.989, 42.508}, {-51.989, 48.508}, {-47.989, 10.508}, {-41.989, 18.508}, {-37.989, -23.492}, {-31.989, -11.492}, {-27.989, -45.492}, {-23.989, -37.492}, {-21.989, -63.492}, {-15.989, -53.492}, {-5.989, -85.492}, {-1.989, -73.492}, {4.011, -87.492}, {14.011, -53.492}, {18.011, -67.492}, {30.011, -19.492}, {34.011, -29.492}, {42.011, 16.508}, {48.011, 10.508}, {52.011, 46.508}, {56.011, 36.508}, {60.011, 68.508}, {66.011, 58.508}, {68.011, 78.508}, {72.011, 70.508}, {82.011, 86.508}, {82.011, 86.508}}, color = {165, 29, 45}), Line(origin = {54, 0}, points = {{-80, 80}, {-76.2, 79.8}, {-70.6, 76.6}, {-64.9, 69.7}, {-59.3, 59.4}, {-52.9, 44.1}, {-44.83, 21.2}, {-27.9, -30.8}, {-20.7, -50.2}, {-14.3, -64.2}, {-8.7, -73.1}, {-3, -78.4}, {2.6, -80}, {8.2, -77.6}, {13.9, -71.5}, {19.5, -61.9}}, smooth = Smooth.Bezier), Line(origin = {-110, 0}, points = {{32, -35}, {42, 1}, {53.3, 35.2}, {60.5, 54.1}, {66.9, 67.4}, {72.6, 75.6}, {78.2, 80.1}, {83.8, 80.8}}), Line(origin = {-56, 0}, points = {{-20.7, -50.2}, {-14.3, -64.2}, {-8.7, -73.1}, {-3, -78.4}, {2.6, -80}, {8.2, -77.6}, {13.9, -71.5}, {19.5, -61.9}, {25.9, -47.2}, {34, -24.8}, {42, 0}}, smooth = Smooth.Bezier), Line(origin = {-56, 0}, points = {{42, 1}, {53.3, 35.2}, {60.5, 54.1}, {66.9, 67.4}, {72.6, 75.6}, {78.2, 80.1}, {83.8, 80.8}}), Line(origin = {108, 0}, points = {{-80, 80}, {-76.2, 79.8}, {-70.6, 76.6}, {-64.9, 69.7}, {-59.3, 59.4}, {-52.9, 44.1}, {-44.83, 21.2}, {-27.9, -30.8}}, smooth = Smooth.Bezier)}),
  Documentation(info = "<html><head></head><body><h1>Three phase cosine source perturbed with harmonics and high frequency noise</h1><div>Illustration of three phase voltage generation with some 3rd harmonics and high frequency (20×fundamental) noise:</div><div><img src=\"modelica://OwnControl/Resources/Images/CosinePerturbed3ph.png\"></div><div><br></div></body></html>"));
end CosinePerturbed3ph;