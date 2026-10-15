// Science Olympiad Thermodynamics finite-distance heat/light collector
//
// A parabola focuses parallel rays (a source effectively at infinity). The
// competition heat/light source is 150 mm above the collector rim, so
// this model uses the lower portion of an ellipsoid. An ellipsoid reflects
// rays from one focus to the other focus.

// ---------- Collector geometry ----------
// Recommended: 250 mm, approximately matching the 8.5-10 inch event lamp
// reflector. Up to 300 mm may be useful only if testing at 150 mm spacing
// confirms that the illuminated beam footprint is at least 300 mm wide.
aperture_diameter = 200;
wall_thickness = 3.5;
base_height = 4;
base_diameter = 125;

// The source is centered on the bowl axis at this height above the rim.
source_above_rim = 150;
rim_height = 110;

// Desired concentration point, measured above the reflector's virtual
// bottom (the vertex at z=0). Adjust this to match the sample location.
target_height = 25;

// ---------- Sample-cup support ----------
// Sized for a typical tapered 9 oz cup with an approximately 75-80 mm
// top and a 50-60 mm base.
cup_lip_diameter = 60;            // Leaves a 5-10 mm radial base overlap
join_overlap = 0.6;               // Ensures holder and reflector fuse
sleeve_wall_thickness = wall_thickness;        // Radial wall between opening and reflector

// ---------- Print/render quality ----------
profile_step = 0.75;
$fn = 180;

aperture_radius = aperture_diameter / 2;
optical_aperture_radius = aperture_radius - wall_thickness;
// With a 25 mm focus, the virtual ellipse extends below the base plane near
// its center. Start the printable reflector where its full wall is above
// that plane; the independent 60 mm through-hole remains centered below it.
reflector_inner_radius = 45;
profile_steps =
    ceil((optical_aperture_radius - reflector_inner_radius) / profile_step);

// Solve an ellipse whose two on-axis foci are the target and light source,
// and whose 200 mm rim is exactly rim_height above the bowl center.
source_z = rim_height + source_above_rim;
ellipse_center = (source_z + target_height) / 2;
ellipse_focus_offset = (source_z - target_height) / 2;
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
    + wall_thickness
    * reflector_slope(r)
    / sqrt(1 + pow(reflector_slope(r), 2));

function shell_outer_z(r) =
    reflector_z(r)
    - wall_thickness
    / sqrt(1 + pow(reflector_slope(r), 2));

overall_diameter = max(aperture_diameter, base_diameter);

assert(overall_diameter <= 200,
    "The model footprint must not exceed 200 mm.");
assert(target_height > wall_thickness,
    "target_height must be greater than wall_thickness.");
assert(optical_aperture_radius < ellipse_b,
    "The requested aperture is too wide for this ellipsoid.");
assert(abs(reflector_z(optical_aperture_radius) - rim_height) < 0.01,
    "The reflector rim does not meet the requested height.");
assert(shell_outer_r(optical_aperture_radius) <= aperture_radius,
    "The constant-thickness shell exceeds the 200 mm footprint.");
assert(shell_outer_z(reflector_inner_radius) >= 0,
    "The reflector intersects the base plane.");

function profile_r(i) =
    reflector_inner_radius
    + (optical_aperture_radius - reflector_inner_radius)
    * i / profile_steps;

module reflector_shell() {
    rotate_extrude(convexity = 10)
        polygon(concat(
            // Exact optical surface, from the cup holder to the rim.
            [
                for (i = [0 : profile_steps])
                    let(r = profile_r(i))
                    [r, base_height + reflector_z(r)]
            ],
            // Underside follows the same curve with printable thickness.
            [
                for (i = [profile_steps : -1 : 0])
                    let(r = profile_r(i))
                    [
                        shell_outer_r(r),
                        base_height
                        + shell_outer_z(r)
                    ]
            ]
        ));
}

// This platform is only tall enough to meet the reflector underside.
// Keeping it low leaves the cup sides exposed to the reflected rays.
cup_support_height =
    base_height
    + reflector_z(reflector_inner_radius)
    - wall_thickness / 2;
cup_support_diameter =
    max(
        cup_lip_diameter + 2 * sleeve_wall_thickness,
        2 * (reflector_inner_radius + join_overlap)
    );

assert(
    (cup_support_diameter - cup_lip_diameter) / 2
        >= sleeve_wall_thickness,
    "The base-to-reflector sleeve wall is thinner than requested."
);

module cup_support_and_base() {
    union() {
        cylinder(h = base_height, d = base_diameter);
        cylinder(
            h = cup_support_height,
            d = cup_support_diameter
        );
    }
}

difference() {
    union() {
        reflector_shell();
        cup_support_and_base();
    }

    // Cut through the complete final assembly so no reflector or support
    // geometry can accidentally close the open-hole variant.
    translate([0, 0, -1])
        cylinder(
            h = base_height + rim_height + 2,
            d = cup_lip_diameter
        );
}

// Preview-only marker showing the intended concentration point.
if ($preview)
    %translate([0, 0, base_height + target_height])
        sphere(d = 6, $fn = 36);

echo(str("Overall footprint: ", overall_diameter, " mm"));
echo(str("Clear optical aperture: ",
    2 * optical_aperture_radius, " mm"));
echo(str("True reflector wall thickness: ",
    wall_thickness, " mm"));
echo(str("Reflector rim height above center: ", rim_height, " mm"));
echo(str("Centered source distance above rim: ", source_above_rim, " mm"));
echo(str("Target height above center: ", target_height, " mm"));
