// Science Olympiad Thermodynamics finite-distance heat/light collector
//
// The source is close to the device, so this uses an ellipsoidal reflector.
// An ellipse reflects rays from one focus to the other focus.

// ---------- Required dimensions ----------
// Sized below the Science Olympiad 300 mm cube limit and within the
// Bambu Lab H2C build volume.
maximum_event_dimension = 300;
overall_height = 280;
aperture_diameter = 280;
reflector_wall_thickness = 3.5;
maximum_cup_base_diameter = 60;
cup_platform_diameter = 72;
cup_platform_thickness = 4;
focus_above_cup_base = 30;
support_pedestal_diameter = cup_platform_diameter;
base_plate_thickness = 3;
stability_base_diameter = 260;
stability_ring_width = 15;
stability_spoke_width = 16;
stability_spoke_count = 6;

// The target is one-third of the bowl height above its bottom. The lamp
// may be 400-550 mm above the bottom; use the 475 mm midpoint to define
// the nominal ellipsoid.
target_height_from_bottom = overall_height / 3;
source_height_from_bottom = (400 + 550) / 2;

// Optical heights are measured from the top of the bottom plate.
target_height =
    target_height_from_bottom - base_plate_thickness;
rim_height = overall_height - base_plate_thickness;
source_height =
    source_height_from_bottom - base_plate_thickness;
source_above_rim = source_height - rim_height;

// ---------- Print/render quality ----------
profile_step = 0.75;
$fn = 180;

aperture_radius = aperture_diameter / 2;
optical_aperture_radius =
    aperture_radius - reflector_wall_thickness;
// Start the reflector at the largest expected cup-base radius. The wider
// raised platform overlaps this edge and gives the cup a stable margin.
reflector_inner_radius = maximum_cup_base_diameter / 2;
profile_steps =
    ceil((optical_aperture_radius - reflector_inner_radius) / profile_step);

// The two axial foci are the desired target and the nominal source.
ellipse_center = (source_height + target_height) / 2;
ellipse_focus_offset = (source_height - target_height) / 2;

// Solve the ellipse dimensions so its rim reaches the requested overall
// height while retaining both required focal positions.
rim_offset_sq = pow(rim_height - ellipse_center, 2);
quadratic_term =
    pow(ellipse_focus_offset, 2)
    + pow(optical_aperture_radius, 2)
    + rim_offset_sq;
ellipse_a_sq =
    (
        quadratic_term
        + sqrt(
            pow(quadratic_term, 2)
            - 4 * rim_offset_sq * pow(ellipse_focus_offset, 2)
        )
    ) / 2;
ellipse_a = sqrt(ellipse_a_sq);
ellipse_b = sqrt(ellipse_a_sq - pow(ellipse_focus_offset, 2));

function reflector_z(r) =
    ellipse_center
    - ellipse_a * sqrt(1 - pow(r / ellipse_b, 2));

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

function profile_r(i) =
    reflector_inner_radius
    + (optical_aperture_radius - reflector_inner_radius)
    * i / profile_steps;

assert(aperture_diameter <= maximum_event_dimension,
    "The model footprint exceeds the 300 mm event limit.");
assert(overall_height <= maximum_event_dimension,
    "The model height exceeds the 300 mm event limit.");
assert(stability_base_diameter <= aperture_diameter,
    "The stability base must fit within the reflector footprint.");
assert(stability_base_diameter > 2 * stability_ring_width,
    "The stability ring width is too large.");
assert(optical_aperture_radius < ellipse_b,
    "The requested aperture is too wide for this ellipsoid.");
assert(abs(reflector_z(optical_aperture_radius) - rim_height) < 0.01,
    "The reflector rim does not meet the requested height.");
assert(shell_outer_r(optical_aperture_radius) <= aperture_radius,
    "The constant-thickness shell exceeds the requested footprint.");
assert(shell_outer_z(reflector_inner_radius) >= 0,
    "The reflector intersects the flat cup platform.");

module reflector_shell() {
    translate([0, 0, base_plate_thickness])
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

cup_platform_top =
    target_height_from_bottom - focus_above_cup_base;
cup_platform_bottom =
    cup_platform_top - cup_platform_thickness;
cup_support_diameter = cup_platform_diameter;

assert(cup_support_diameter / 2
        > shell_outer_r(reflector_inner_radius),
    "The raised cup platform does not overlap the reflector shell.");
assert(cup_platform_diameter > maximum_cup_base_diameter,
    "The cup platform must be wider than the expected cup base.");
assert(support_pedestal_diameter == cup_platform_diameter,
    "The pedestal must align with the platform to avoid an overhang.");
assert(cup_platform_top < target_height_from_bottom,
    "The cup platform must remain below the optical target.");
assert(abs(
        target_height_from_bottom
        - cup_platform_top
        - focus_above_cup_base
    ) < 0.01,
    "The optical focus is not at the requested height above the cup.");

module cup_support_and_base() {
    union() {
        // A wide outer ring and radial spokes maximize tipping resistance
        // without the mass of a large solid plate.
        difference() {
            cylinder(
                h = base_plate_thickness,
                d = stability_base_diameter
            );
            translate([0, 0, -1])
                cylinder(
                    h = base_plate_thickness + 2,
                    d = stability_base_diameter
                        - 2 * stability_ring_width
                );
        }

        for (angle = [
            0 : 360 / stability_spoke_count : 359
        ])
            rotate([0, 0, angle])
                translate([
                    0,
                    -stability_spoke_width / 2,
                    0
                ])
                    cube([
                        stability_base_diameter / 2,
                        stability_spoke_width,
                        base_plate_thickness
                    ]);

        // A straight-sided pedestal supports the cup and eliminates the
        // otherwise unsupported cup-platform overhang.
        cylinder(
            h = cup_platform_top,
            d = support_pedestal_diameter
        );
    }
}

union() {
    reflector_shell();
    cup_support_and_base();
}

// Preview-only marker for the intended concentration point.
if ($preview)
    %translate([
        0,
        0,
        base_plate_thickness + target_height
    ])
        sphere(d = 6, $fn = 36);

echo(str("Overall footprint: ", aperture_diameter, " mm"));
echo(str("Clear optical aperture: ",
    2 * optical_aperture_radius, " mm"));
echo(str("True reflector wall thickness: ",
    reflector_wall_thickness, " mm"));
echo(str("Solid cup platform: ", cup_platform_diameter, " mm"));
echo(str("Cup-base radial margin: ",
    (cup_platform_diameter - maximum_cup_base_diameter) / 2,
    " mm"));
echo(str("Cup platform height above bottom: ",
    cup_platform_top, " mm"));
echo(str("Optical focus above cup base: ",
    focus_above_cup_base, " mm"));
echo(str("Support pedestal: ",
    support_pedestal_diameter, " mm"));
echo(str("Stability base footprint: ",
    stability_base_diameter, " mm"));
echo(str("Stability ring: ", stability_ring_width,
    " mm wide with ", stability_spoke_count, " spokes"));
echo(str("Overall height: ", overall_height, " mm"));
echo(str("Reflector rim above platform: ", rim_height, " mm"));
echo(str("Target above platform: ", target_height, " mm"));
echo(str("Target above bowl bottom: ",
    target_height_from_bottom, " mm"));
echo(str("Source above rim: ", source_above_rim, " mm"));
echo(str("Nominal source above bowl bottom: ",
    source_height_from_bottom, " mm"));
