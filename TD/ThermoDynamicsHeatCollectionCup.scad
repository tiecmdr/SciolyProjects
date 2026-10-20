// Compact Science Olympiad Thermodynamics heat/light collector.
//
// The bulb is a finite distance above the collector, so the optically
// correct profile is an ellipsoid rather than a true paraboloid. Rays
// originating at the bulb focus reflect toward the cup focus.

inch = 25.4;

// ---------- Foam-box socket and cup opening ----------
socket_opening_width = 5 * inch;
socket_depth = 2.7 * inch;
socket_side_clearance = 0.5;
socket_bottom_clearance = 0.5;
base_width = socket_opening_width - 2 * socket_side_clearance;
// Align the closed bowl floor with the box walls on the print bed.
base_height = 23;
socket_wall_thickness = 3;
sealing_lip_overlap = 0.5 * inch;
sealing_lip_width = socket_opening_width + 2 * sealing_lip_overlap;
sealing_lip_thickness = 3.2;
cup_hole_diameter = 70;

// ---------- Optical layout ----------
// Heights above the box include the lip and reflector, but not a cover.
// The 85 mm exposed height includes the stop lip.
maximum_height_above_box = 100;
collector_height_above_box = 85;
standard_cup_height = 95;
overall_height = base_height + collector_height_above_box;
cup_support_height =
    max(socket_wall_thickness, overall_height - standard_cup_height - 10);
reflector_above_cup =
    overall_height - cup_support_height - standard_cup_height;
focus_above_device_bottom = cup_support_height + 30;
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

// Constrain the ellipse at the socket top so the submerged shell fits
// inside the square. Allow a full wall thickness in both directions
// for the outward/downward normal offset of the outer surface.
socket_fit_z = base_height + reflector_wall_thickness;
socket_fit_radius = base_width / 2 - reflector_wall_thickness;
ellipse_a =
    (
        sqrt(
            pow(socket_fit_radius, 2)
            + pow(
                socket_fit_z - target_z,
                2
            )
        )
        + sqrt(
            pow(socket_fit_radius, 2)
            + pow(
                socket_fit_z - source_z,
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

// Truncate the optical surface above the closed floor: the virtual
// ellipsoid vertex lies below this shallow insert.
reflector_start_height =
    cup_support_height + reflector_wall_thickness;
reflector_inner_radius = reflector_radius(reflector_start_height);
cup_support_diameter =
    2 * shell_outer_r(reflector_inner_radius);
optical_rim_radius = reflector_radius(overall_height);
outer_rim_radius = shell_outer_r(optical_rim_radius);
profile_steps =
    ceil(
        (optical_rim_radius - reflector_inner_radius)
        / profile_step
    );

function profile_r(i) =
    reflector_inner_radius
    + (optical_rim_radius - reflector_inner_radius)
    * i / profile_steps;

assert(socket_fit_radius > cup_hole_radius
        && socket_fit_z < overall_height,
    "The socket must surround the lower bowl below the rim.");
assert(abs(
        reflector_radius(socket_fit_z) - socket_fit_radius
    ) < 0.01,
    "The reflector does not meet the socket fit constraint.");
assert(reflector_radius(socket_fit_z) + reflector_wall_thickness
        <= base_width / 2 + 0.01,
    "The submerged reflector shell must fit inside the square insert.");
assert(abs(
        reflector_z(optical_rim_radius)
        - overall_height
    ) < 0.01,
    "The reflector does not reach the requested height.");
assert(2 * outer_rim_radius <= maximum_rim_diameter,
    "The reflector exceeds the maximum allowed diameter.");
assert(collector_height_above_box > sealing_lip_thickness
        && collector_height_above_box <= maximum_height_above_box,
    "The collector must fit below the above-box height limit.");
assert(base_width > cup_hole_diameter,
    "The square base must surround the cup opening.");
assert(socket_side_clearance > 0
        && socket_bottom_clearance > 0,
    "The socket needs side and bottom clearance for insertion.");
assert(base_height > 2 * socket_wall_thickness
        && base_height <= socket_depth - socket_bottom_clearance,
    "The insert must fit within the recess depth.");
assert(base_width > cup_support_diameter + 2 * socket_wall_thickness,
    "The hollow insert needs clearance around the bowl support.");
assert(sealing_lip_width > socket_opening_width,
    "The lip must cover the entire socket opening.");
assert(cup_support_height >= socket_wall_thickness
        && cup_support_height < reflector_start_height,
    "The cup needs a solid floor below the reflector opening.");
assert(abs(cup_support_height - socket_wall_thickness) < 0.01,
    "The closed bowl floor and box walls must both start on the print bed.");
assert(reflector_inner_radius > cup_hole_radius
        && reflector_start_height < ellipse_center,
    "The closed cup well must fit inside the lower ellipsoid branch.");
assert(reflector_start_height < base_height,
    "The bowl must begin inside the foam-box recess.");

module socket_base() {
    difference() {
        union() {
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

            // The lip rests on the box top and covers the insertion
            // clearance; the insert stops short of the recess floor.
            translate([
                -sealing_lip_width / 2,
                -sealing_lip_width / 2,
                base_height
            ])
                cube([
                    sealing_lip_width,
                    sealing_lip_width,
                    sealing_lip_thickness
                ]);
        }

        // Open the underside while retaining 3 mm sides and roof.
        // Preserve the central support so the bowl floor stays closed.
        difference() {
            translate([
                -base_width / 2 + socket_wall_thickness,
                -base_width / 2 + socket_wall_thickness,
                -1
            ])
                cube([
                    base_width - 2 * socket_wall_thickness,
                    base_width - 2 * socket_wall_thickness,
                    base_height - socket_wall_thickness + 1
                ]);
            translate([
                0,
                0,
                cup_support_height - socket_wall_thickness
            ])
                cylinder(
                    h = base_height + sealing_lip_thickness,
                    d = cup_support_diameter
                );
        }

        // Stop the cup well at its support floor instead of cutting
        // through the base. This also keeps the focus 30 mm above it.
        translate([0, 0, cup_support_height])
            cylinder(
                h = base_height + sealing_lip_thickness
                    - cup_support_height + 1,
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
echo(str("Hollow underside; insert side and roof thickness: ",
    socket_wall_thickness, " mm"));
echo(str("Foam-box opening: ",
    socket_opening_width, " x ", socket_opening_width,
    " mm; recess depth: ", socket_depth, " mm"));
echo(str("Insertion clearance per side / below: ",
    socket_side_clearance, " / ", socket_bottom_clearance, " mm"));
echo(str("Gap-covering lip: ",
    sealing_lip_width, " x ", sealing_lip_width,
    " x ", sealing_lip_thickness, " mm"));
echo(str("Stop-lip overlap beyond opening per side: ",
    sealing_lip_overlap, " mm"));
echo(str("Reflector rim above box top: ",
    overall_height - base_height, " mm"));
echo(str("Nominal cup top above box top: ",
    cup_support_height + standard_cup_height - base_height, " mm"));
echo(str("Remaining above-rim allowance for cover and mounting: ",
    maximum_height_above_box - collector_height_above_box, " mm"));
echo(str("Bowl start below box top: ",
    base_height - reflector_start_height, " mm"));
echo(str("Cup opening: ",
    cup_hole_diameter, " mm"));
echo(str("Closed cup-support floor above device bottom: ",
    cup_support_height, " mm"));
echo(str("Optical focus above cup-support floor: ",
    target_z - cup_support_height, " mm"));
echo(str("Reflector start above device bottom: ",
    reflector_start_height, " mm"));
echo(str("Focus above device bottom: ",
    target_z, " mm"));
echo(str("Nominal cup height: ",
    standard_cup_height, " mm"));
echo(str("Rim above nominal cup top (negative means cup protrudes): ",
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
