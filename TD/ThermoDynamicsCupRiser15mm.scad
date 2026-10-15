// Cup riser for the Science Olympiad Thermodynamics collector.
// Fits on the 72 mm cup platform in ThermoDynamicsHeatCollectionBowl.scad.

riser_diameter = 65;
riser_height = 30;

$fn = 180;

cylinder(
    h = riser_height,
    d = riser_diameter
);

echo(str("Cup riser diameter: ", riser_diameter, " mm"));
echo(str("Cup riser height: ", riser_height, " mm"));
