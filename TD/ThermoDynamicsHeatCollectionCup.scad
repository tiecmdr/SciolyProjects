// Compact Science Olympiad Thermodynamics heat/light collector.
//
// The bulb is a finite distance above the collector, so the optically
// correct profile is an ellipsoid rather than a true paraboloid. Rays
// originating at the bulb focus reflect toward the cup focus.

inch = 25.4;

// ---------- Foam-box socket and cup opening ----------
base_width = 3.95 * inch;
base_height = 1 * inch;
cup_hole_diameter = 70;
reflector_start_height = 0.5 * inch;

// ---------- Optical layout ----------
focus_above_device_bottom = 30;
standard_cup_height = 95;
reflector_above_cup = 10;
overall_height =
    standard_cup_height + reflector_above_cup;
source_above_rim = 170;
maximum_rim_diameter = 285;

// Eight 0.4 mm extrusion widths.
reflector_wall_thickness = 3.2;

// ---------- Render quality ----------
profile_step = 0.5;
$fn = 180;

cup_hole_radius = cup_hole_diameter / 2;
target_z = focus_above_device_bottom;
source_z = overall_height + source_above_rim;

// The reflector begins 0.5 inch above the bottom at the edge of the
// 70 mm cup opening. The sum of distances from that point to both foci
// defines the ellipse.
ellipse_a =
    (
        sqrt(
            pow(cup_hole_radius, 2)
            + pow(
                reflector_start_height - target_z,
                2
            )
        )
        + sqrt(
            pow(cup_hole_radius, 2)
            + pow(
                reflector_start_height - source_z,
                2
            )
        )
    ) / 2;
ellipse_center = (source_z + target_z) / 2;
ellipse_focus_offset = (source_z - target_z) / 2;
ellipse_b =
    sqrt(
        pow(ellipse_a, 2)
        - pow(ellipse_focus_offset, 2)
    );

function reflector_z(r) =
    ellipse_center
    - ellipse_a * sqrt(1 - pow(r / ellipse_b, 2));

function reflector_radius(z) =
    ellipse_b
    * sqrt(
        1
        - pow((z - ellipse_center) / ellipse_a, 2)
    );

function reflector_slope(r) =
    ellipse_a * r
    / (
        pow(ellipse_b, 2)
        * sqrt(1 - pow(r / ellipse_b, 2))
    );

function shell_outer_r(r) =
    r
    + reflector_wall_thickness
    * reflector_slope(r)
    / sqrt(1 + pow(reflector_slope(r), 2));

function shell_outer_z(r) =
    reflector_z(r)
    - reflector_wall_thickness
    / sqrt(1 + pow(reflector_slope(r), 2));

optical_rim_radius = reflector_radius(overall_height);
outer_rim_radius = shell_outer_r(optical_rim_radius);
profile_steps =
    ceil(
        (optical_rim_radius - cup_hole_radius)
        / profile_step
    );

function profile_r(i) =
    cup_hole_radius
    + (optical_rim_radius - cup_hole_radius)
    * i / profile_steps;

assert(abs(
        reflector_z(cup_hole_radius)
        - reflector_start_height
    ) < 0.01,
    "The reflector does not meet the cup opening.");
assert(abs(
        reflector_z(optical_rim_radius)
        - overall_height
    ) < 0.01,
    "The reflector does not reach the requested height.");
assert(2 * outer_rim_radius <= maximum_rim_diameter,
    "The reflector exceeds the maximum allowed diameter.");
assert(base_width > cup_hole_diameter,
    "The square base must surround the cup opening.");

module socket_base() {
    difference() {
        translate([
            -base_width / 2,
            -base_width / 2,
            0
        ])
            cube([
                base_width,
                base_width,
                base_height
            ]);

        translate([0, 0, -1])
            cylinder(
                h = base_height + 2,
                d = cup_hole_diameter
            );

        // Remove the complete optical cavity from the square socket so
        // no flat or box-shaped surface protrudes inside the reflector.
        optical_cavity();
    }
}

module optical_cavity() {
    rotate_extrude(convexity = 10)
        polygon(concat(
            [[0, reflector_start_height]],
            [
                for (i = [0 : profile_steps])
                    let(r = profile_r(i))
                        [r, reflector_z(r)]
            ],
            [[0, overall_height]]
        ));
}

module reflector_shell() {
    rotate_extrude(convexity = 10)
        polygon(concat(
            [
                for (i = [0 : profile_steps])
                    let(r = profile_r(i))
                        [r, reflector_z(r)]
            ],
            [
                for (i = [profile_steps : -1 : 0])
                    let(r = profile_r(i))
                        [
                            shell_outer_r(r),
                            shell_outer_z(r)
                        ]
            ]
        ));
}

union() {
    socket_base();
    reflector_shell();
}

// Preview-only markers for the target and bulb positions.
if ($preview) {
    %translate([
        0,
        0,
        target_z
    ])
        sphere(d = 5, $fn = 36);

    %translate([
        0,
        0,
        source_z
    ])
        sphere(d = 8, $fn = 36);
}

echo(str("Square base: ",
    base_width, " x ", base_width,
    " x ", base_height, " mm"));
echo(str("Cup opening: ",
    cup_hole_diameter, " mm"));
echo(str("Reflector start above device bottom: ",
    reflector_start_height, " mm"));
echo(str("Focus above device bottom: ",
    target_z, " mm"));
echo(str("Nominal cup height: ",
    standard_cup_height, " mm"));
echo(str("Device above cup: ",
    reflector_above_cup, " mm"));
echo(str("Overall device and reflector height: ",
    overall_height, " mm"));
echo(str("Clear rim diameter: ",
    2 * optical_rim_radius, " mm"));
echo(str("Outer rim diameter: ",
    2 * outer_rim_radius, " mm"));
echo(str("Source above rim: ",
    source_above_rim, " mm"));
echo(str("Source above device bottom: ",
    source_z, " mm"));
