// Three identical, tape-mounted fins for the nominal 68 mm bottle barrel.
// Dimensions are millimeters. The mouth/nozzle plane is assembly z=0;
// positive z points toward the bottle base. Print three fins in ASA Aero.
// The default cylindrical contour is NOT a measured Coca-Cola bottle profile.
// Check fit_test first; replace bottle_profile with measured diameters if needed.
// Never alter the pressurized bottle to make the fin fit.
//
// Both curved tape tabs extend toward assembly +y only. Print the opposite
// flat face down: the tabs grow upward, not into the bed. No supports intended.
// Tabs occupy the first and last 20 mm of the mounting edge, not its middle.
// The entire fin thickens toward the bottom on that same side, preserving
// the flat print face. This is a weight/stiffness feature, not a tested airfoil.
// The swept outer edge follows a smooth S curve; no drag optimum is claimed.
// Tape adhesion, aerodynamic stability and launch strength require testing.

/* [Export] */
part = "fin"; // [fin, fit_test, assembly]
print_orientation = true;

/* [Placement and size] */
minimum_mouth_clearance = 55;
root_start = 100; // From the mouth, along the bottle axis; locate on the barrel.
bottle_height = 220; // EXAMPLE ONLY: enter measured mouth-to-base height.
root_length = 84; // Bottle-facing edge length, independent of bottle height.
fin_span = 64; // Bottom edge from bottle-facing edge to the outer tip.
fin_thickness = 1; // Nominal thickness at the top of the fin.
bottom_thickness = 2.4; // A continuous linear taper over the full root length.
mount_test_width = 5;

/* [Rounded edges] */
corner_radius = 2;
tab_corner_radius = 0.8;
edge_radius = 0.2; // Limited by the thin web and tab edges.

/* [Bottle contour - replace with measurements] */
// [distance from the lower end of the mounting edge, bottle DIAMETER].
// Three stations permit a waist/contour without changing the export logic.
bottle_profile = [[0, 68], [root_length / 2, 68], [root_length, 68]];
bottle_radial_clearance = 0.3;

/* [One-sided tape tabs] */
tab_width = 5; // Sideways projection from the fin's center plane.
tab_length = 20; // Axial height at each end of the root.
tab_thickness = 0.8;
tab_edge_thickness = 0.6;
tab_edge_taper = 3; // Feather the upstream/downstream edges under the tape.

/* [Preview] */
fin_count = 3;
show_barrel_envelope = true;
$fn = 120;

root_end = root_start + root_length;
root_levels = [for (p = bottle_profile) root_start + p[0]];
outer_radius = max([for (p = bottle_profile) p[1] / 2]) +
               bottle_radial_clearance + fin_span;

assert(part == "fin" || part == "fit_test" || part == "assembly",
       "Unknown fin part selector.");
assert(root_start > minimum_mouth_clearance && minimum_mouth_clearance >= 55,
       "Every fin and tab must stay strictly above 55 mm from the mouth.");
assert(root_length > 2 * tab_length && tab_length > 0);
assert(root_end <= bottle_height,
       "The mounting edge must fit between the mouth and base.");
assert(fin_span > mount_test_width && mount_test_width > tab_thickness);
assert(fin_thickness >= 0.8 && tab_thickness >= 0.8);
assert(bottom_thickness >= fin_thickness);
assert(tab_edge_thickness >= 0.6 && tab_edge_thickness <= tab_thickness);
assert(tab_edge_taper > 0 && 2 * tab_edge_taper < tab_length);
assert(edge_radius > 0 &&
       2 * edge_radius < min(fin_thickness, tab_edge_thickness));
assert(corner_radius > edge_radius && 2 * corner_radius < mount_test_width);
assert(tab_corner_radius > edge_radius &&
       2 * tab_corner_radius < min(tab_width, tab_length));
assert(bottle_radial_clearance >= 0 && tab_width > 0);
assert(fin_count == 3, "The assembly preview uses three fins at 120 degrees.");
assert(len(bottle_profile) >= 2 && bottle_profile[0][0] == 0 &&
       bottle_profile[len(bottle_profile) - 1][0] == root_length,
       "The bottle profile must span the complete mounting edge.");
for (i = [0 : len(bottle_profile) - 1]) {
    assert(bottle_profile[i][1] > 2 * tab_width,
           "Tape tab is too wide for this bottle radius.");
    if (i > 0)
        assert(bottle_profile[i][0] > bottle_profile[i - 1][0],
               "Bottle measurement stations must be strictly increasing.");
}

function radius_at(z, i = 0) =
    z <= root_levels[0] ? bottle_profile[0][1] / 2 :
    i >= len(root_levels) - 1 ? bottle_profile[len(root_levels) - 1][1] / 2 :
    z <= root_levels[i + 1] ?
        let(t = (z - root_levels[i]) / (root_levels[i + 1] - root_levels[i]))
            (bottle_profile[i][1] * (1 - t) + bottle_profile[i + 1][1] * t) / 2 :
        radius_at(z, i + 1);

function contact_radius(z) = radius_at(z) + bottle_radial_clearance;
function levels_between(start, end) =
    concat([start], [for (z = root_levels) if (z > start && z < end) z], [end]);
function tab_wall_at(z, start) =
    tab_edge_thickness + (tab_thickness - tab_edge_thickness) *
    min(1, (z - start) / tab_edge_taper,
           (start + tab_length - z) / tab_edge_taper);

// [span fraction, distance from top / root length]; adjacent tangents match.
leading_segments = [
    [[0, 0], [0.0766667, 0.0666667], [0.1866667, 0.1333333], [0.23, 0.2]],
    [[0.23, 0.2], [0.2841667, 0.2833333], [0.29, 0.3666667], [0.34, 0.45]],
    [[0.34, 0.45], [0.39, 0.5333333], [0.6816667, 0.6166667], [0.79, 0.7]],
    [[0.79, 0.7], [0.868, 0.76], [0.949, 0.82], [0.97, 0.88]],
    [[0.97, 0.88], [0.984, 0.92], [1, 0.96], [1, 1]]
];
function bezier(points, t) =
    pow(1 - t, 3) * points[0] +
    3 * pow(1 - t, 2) * t * points[1] +
    3 * (1 - t) * t * t * points[2] +
    pow(t, 3) * points[3];

module fin_web(test = false, thickness = fin_thickness) {
    edge = [for (z = root_levels) [contact_radius(z), z]];
    outside = test ?
        [for (i = [len(root_levels) - 1 : -1 : 0])
            [contact_radius(root_levels[i]) + mount_test_width, root_levels[i]]] :
        [for (segment = leading_segments)
            for (step = [1 : 12])
                let(p = bezier(segment, step / 12),
                    z = root_end - root_length * p[1])
                    [contact_radius(z) + fin_span * p[0], z]];
    translate([0, (thickness - fin_thickness) / 2, 0])
        rotate([90, 0, 0])
            linear_extrude(height = thickness - 2 * edge_radius,
                           center = true, convexity = 5)
                offset(r = corner_radius - edge_radius)
                    offset(delta = -corner_radius)
                        polygon(concat(edge, outside));
}

module radial_prism(yz_points, rounding = 0) {
    rotate([0, 90, 0])
        linear_extrude(height = outer_radius + tab_thickness + 1, convexity = 5)
            if (rounding > 0)
                offset(r = rounding - edge_radius)
                    offset(delta = -rounding)
                        polygon([for (p = yz_points) [-p[1], p[0]]]);
            else
                offset(delta = -edge_radius)
                    polygon([for (p = yz_points) [-p[1], p[0]]]);
}

module tapered_web(test = false) {
    intersection() {
        fin_web(test, bottom_thickness);
        radial_prism([
            [-fin_thickness / 2, root_start],
            [bottom_thickness - fin_thickness / 2, root_start],
            [fin_thickness / 2, root_end],
            [-fin_thickness / 2, root_end]
        ]);
    }
}

module tape_tab(start) {
    end = start + tab_length;
    stations = [start, start + tab_edge_taper, end - tab_edge_taper, end];
    levels = concat(
        [for (i = [0 : len(stations) - 2])
            each let(section = levels_between(stations[i], stations[i + 1]))
                [for (j = [0 : len(section) - 2]) section[j]]],
        [end]);
    angle = asin(tab_width / min([for (z = levels) contact_radius(z)]));
    intersection() {
        rotate_extrude(angle = angle, convexity = 5)
            polygon(concat(
                [for (z = levels) [contact_radius(z) + edge_radius, z]],
                [for (i = [len(levels) - 1 : -1 : 0])
                    [contact_radius(levels[i]) + tab_wall_at(levels[i], start) -
                     edge_radius, levels[i]]]
            ));
        radial_prism([
            [0, start], [tab_width, start], [tab_width, end], [0, end]
        ], tab_corner_radius);
    }
}

module round_edges() {
    minkowski() {
        children();
        resize([2 * edge_radius, 2 * edge_radius, 2 * edge_radius])
            sphere(r = edge_radius, $fn = 24);
    }
}

module fin(test = false) {
    // Round inset components separately to avoid decomposing the full fin union.
    union() {
        round_edges() tapered_web(test);
        round_edges() tape_tab(root_start);
        round_edges() tape_tab(root_end - tab_length);
    }
}

module exported_fin(test = false) {
    if (print_orientation)
        translate([0, root_end, fin_thickness / 2])
            rotate([90, 0, 0]) fin(test);
    else
        fin(test);
}

if (part == "fin")
    exported_fin();
else if (part == "fit_test")
    exported_fin(true);
else {
    if (show_barrel_envelope)
        color([0.6, 0.8, 0.9, 0.2])
            translate([0, 0, root_start])
                rotate_extrude()
                    polygon(concat([[0, 0]],
                        [for (p = bottle_profile) [p[1] / 2, p[0]]],
                        [[0, root_length]]));
    for (i = [0 : fin_count - 1])
        color([0.9, 0.7, 0.2])
            rotate([0, 0, i * 360 / fin_count]) fin();
}

echo(str("Lowest fin/tab point: ", root_start,
         " mm above mouth; required > ", minimum_mouth_clearance, " mm."));
echo(str("Mounting edge: ", root_length, " mm; radial span: ", fin_span,
         " mm; three fins at 120 degrees."));
echo(str("Full-height thickness taper: ", fin_thickness, " mm at top to ",
         bottom_thickness, " mm at bottom over ", root_length, " mm."));
echo(str("Corner radii: fin ", corner_radius, " mm; tabs ", tab_corner_radius,
         " mm; exposed edge rounding ", edge_radius, " mm."));
echo(str("One-sided rounded rectangular tabs: ", tab_width, " mm sideways x ", tab_length,
         " mm axial x ", tab_thickness, " mm thick; edges taper to ",
         tab_edge_thickness, " mm over ", tab_edge_taper, " mm."));
echo("WARNING: nominal barrel contour only; verify the mounting test on your bottle.");
