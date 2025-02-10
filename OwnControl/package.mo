package OwnControl "OwnTech Signal processing & Control library for power electronics. Pierre Haessg 2025"
extends Modelica.Icons.Package;
import Modelica.Constants.pi;
import Modelica.Units.SI.{Angle, Frequency, AngularFrequency, Duration};
import Modelica.Units.SI.{Voltage, Current, Resistance, Capacitance, Inductance};

annotation(
    uses(Modelica(version = "4.0.0")),
    Icon(graphics = {Rectangle(origin = {0, 20}, extent = {{-60, 40}, {60, -40}}), Rectangle(extent = {{40, 0}, {40, 0}}), Line(origin = {0, -20}, points = {{60, 40}, {80, 40}, {80, -40}, {-80, -40}, {-80, 40}, {-60, 40}}, arrow = {Arrow.None, Arrow.Filled})}));

end OwnControl;