// V2: wider tape flange and a single-piece TPU for AMS upper tube/rounded nose.
// Dimensions are millimeters. V1 stays unchanged; its lower/middle tubes
// and 20 mm clearance-fit connectors are reused at their original size.
// Four shallow identity labels are debossed into the lower tube only.
// The entire five-lobed bottle-seat contour spans the 50 mm flange.
// Export individual parts, never the assembly. See PRINTING.md for V2.
// H2C project: PPP-Cylinder-V2.3mf; tubes are horizontal, not upright.
// This is an external attachment, not a pressure vessel or release mechanism.
// Geometry removes the separate nose seam, not every possible string snag.
// Print all V2 parts with the Bambu TPU for AMS profile, not ABS or TPU 95A.
// Fit, strength, deployment, and event compliance require physical testing.
use <PingPongParachute-Cylinder.scad>

/* [Export] */
part = "assembly"; // [assembly, lower_body, middle_body, upper_body, flange, fit_test, joint_lower_test, joint_upper_test, nose_transition_test]
print_orientation = true;
include_middle = true; // Assembly only; exports are identical for both lengths.
bed_angle = 45; // Long tube axes lie diagonally in the XY plane, not upright.

/* [V2 shape] */
flange_diameter = 50; // Entire wavy seat/panel; tube base remains 23.2 mm.
head_diameter = 30; // Smaller prototype; verify against the actual event-test cap.
blend_start = 520; // Compact-assembly datum; below the old nose joint.
sphere_join_angle = -20; // Lower hemisphere; tangent matched to the tube blend.

/* [Surface markings] */
lower_labels = ["Odle Middle School", "Siddhu", "Team Feynman", "Allen"];
label_font = "Liberation Sans:style=Bold";
label_size = 5;
label_depth = 0.35;
label_start = 48; // Above the flange engagement, far below the tube joint.
label_length = 75; // Available axial length, not a text scaling factor.

/* [Mesh quality] */
angular_segments = 120;
body_steps = 180;
$fn = angular_segments;

// V1 interface datums. Do not scale the imported parts independently.
v2_body_start = 6.2;
v2_split_height = 292.6;
v2_middle_length = 300;
v2_compact_height = 600;
v2_joint_overlap = 20;
v2_joint_root_height = 4;
v2_joint_test_margin = 8;
v2_flange_radial_steps = 20;
v2_flange_spigot_radius = 8.75;
v2_flange_bore_radius = 5.95;
v2_body_wall = 1.6; // Retain V1's wall/joint reinforcement for the TPU trial.
v2_eps = 0.02;

v2_ball_radius = head_diameter / 2;
v2_ball_center = v2_compact_height - v2_ball_radius;
v2_blend_end = v2_ball_center +
               v2_ball_radius * sin(sphere_join_angle);
v2_blend_radius = v2_ball_radius * cos(sphere_join_angle);
v2_blend_slope = -tan(sphere_join_angle);
v2_start_radius = radius_at(blend_start);
v2_blend_length = v2_blend_end - blend_start;
v2_inner_roof_radius = v2_ball_radius - v2_body_wall;
v2_inner_roof_tip = v2_ball_center + v2_inner_roof_radius;
v2_extension = include_middle ? v2_middle_length : 0;

assert(part == "assembly" || part == "lower_body" ||
       part == "middle_body" || part == "upper_body" || part == "flange" ||
       part == "fit_test" || part == "joint_lower_test" ||
       part == "joint_upper_test" || part == "nose_transition_test",
       "Unknown V2 part selector; there is no separate nose.");
assert(flange_diameter > 23.2 && flange_diameter <= 68,
       "The wavy bottle seat must surround the tube and stay within the assumed bottle.");
assert(v2_body_wall > 0 && v2_body_wall < v2_ball_radius);
assert(angular_segments >= 40 && body_steps >= 40);
assert(blend_start > v2_split_height + v2_joint_overlap +
       v2_joint_root_height && blend_start < 532,
       "Start the replacement shoulder in V1's narrow tube, below its old flare.");
assert(sphere_join_angle > -90 && sphere_join_angle < 0);
assert(v2_blend_length > 0 && v2_blend_radius > v2_start_radius);
assert(v2_start_slope() >= 0 &&
       (v2_start_slope() + v2_blend_slope) * v2_blend_length <=
       3 * (v2_blend_radius - v2_start_radius),
       "The nose blend must widen monotonically, without an extra string pocket.");
assert(len(lower_labels) == 4 && label_size > 0 && label_depth > 0 &&
       v2_body_wall - label_depth >= 1.2);
assert(label_start > 32 && label_length > 0 &&
       label_start + label_length < v2_split_height - v2_joint_root_height,
       "Keep lettering away from the base socket and upper spigot.");

// Cubic Hermite interpolation matches BOTH endpoint slopes: the existing
// tube's cosine profile and the exact spherical tangent, not just radii.
function v2_start_slope() =
    (radius_at(blend_start + 0.001) -
     radius_at(blend_start - 0.001)) / 0.002;
function v2_blend_radius_at(z) =
    let(t = (z - blend_start) / v2_blend_length,
        m0 = v2_start_slope() * v2_blend_length,
        m1 = v2_blend_slope * v2_blend_length)
    (2 * t * t * t - 3 * t * t + 1) * v2_start_radius +
    (t * t * t - 2 * t * t + t) * m0 +
    (-2 * t * t * t + 3 * t * t) * v2_blend_radius +
    (t * t * t - t * t) * m1;
function v2_outer_radius(z) =
    z <= blend_start ? radius_at(z) :
    z < v2_blend_end ? v2_blend_radius_at(z) :
    sqrt(max(0, v2_ball_radius * v2_ball_radius -
                pow(z - v2_ball_center, 2)));
function v2_inner_radius(z) =
    z <= v2_ball_center ?
        v2_outer_radius(z) - socket_wall_at(z - v2_split_height) :
        sqrt(max(0, pow(v2_inner_roof_radius, 2) -
                    pow(z - v2_ball_center, 2)));

// Printing maps model -X to bed +Z. An inscribed 45-degree roof replaces
// the upper half of the internal circular bore, except at the round socket.
function v2_cavity_radius(z, a) =
    let(t = min(1, max(0, (z - v2_split_height - v2_joint_overlap) /
                         v2_joint_root_height)),
        roof_scale = 1 / max(1, abs(sin(a)) - cos(a)))
    v2_inner_radius(z) * (1 + t * (roof_scale - 1));
function v2_ring_faces(offset, rings, inward = false) = [
    for (j = [0 : rings - 2], i = [0 : angular_segments - 1])
        each let(a = offset + j * angular_segments + i,
                 b = offset + j * angular_segments + (i + 1) % angular_segments,
                 c = b + angular_segments, d = a + angular_segments)
        inward ? [[a, c, b], [a, d, c]] : [[a, b, c], [a, c, d]]
];

module v2_upper(start = v2_split_height) {
    assert(start >= v2_split_height && start < blend_start);
    stations = concat([start],
        [for (z = [v2_split_height + v2_joint_overlap,
                   v2_split_height + v2_joint_overlap + v2_joint_root_height,
                   579 * 0.64, blend_start])
            if (z > start) z],
        [v2_blend_end]);
    tube_points = [
        for (i = [0 : len(stations) - 2])
            each let(n = max(1, ceil(body_steps *
                (stations[i + 1] - stations[i]) /
                (v2_blend_end - start))))
            [for (j = [0 : n - 1])
                let(z = stations[i] +
                    (stations[i + 1] - stations[i]) * j / n)
                [v2_outer_radius(z), z]]
    ];
    sphere_points = concat(
        [for (i = [0 : 20])
            let(a = sphere_join_angle * (1 - i / 20))
            [v2_ball_radius * cos(a),
             v2_ball_center + v2_ball_radius * sin(a)]],
        [for (i = [1 : 90])
            let(a = 90 * i / 90)
            [i == 90 ? 0 : v2_ball_radius * cos(a),
             v2_ball_center + v2_ball_radius * sin(a)]]);
    // The pitched roof continues through a hollow spherical cavity.
    // No solid/conical nose plug or sacrificial internal support is modeled.
    inner_levels = concat(
        [for (i = [0 : len(stations) - 2])
            each let(n = max(1, ceil(body_steps *
                (stations[i + 1] - stations[i]) /
                (v2_blend_end - start))))
            [for (j = [0 : n - 1])
                stations[i] + (stations[i + 1] - stations[i]) * j / n]],
        [v2_blend_end, v2_ball_center],
        [for (i = [1 : 89])
            v2_ball_center + v2_inner_roof_radius * sin(i)]);
    outer_rings = concat(tube_points,
        [for (i = [0 : len(sphere_points) - 2]) sphere_points[i]]);
    inner_offset = len(outer_rings) * angular_segments;
    outer_tip = inner_offset + len(inner_levels) * angular_segments;
    inner_tip = outer_tip + 1;
    points = concat(
        [for (p = outer_rings, i = [0 : angular_segments - 1])
            let(a = i * 360 / angular_segments)
            [p[0] * cos(a), p[0] * sin(a), p[1]]],
        [for (z = inner_levels, i = [0 : angular_segments - 1])
            let(a = i * 360 / angular_segments, r = v2_cavity_radius(z, a))
            [r * cos(a), r * sin(a), z]],
        [[0, 0, v2_compact_height], [0, 0, v2_inner_roof_tip]]);
    ends = [
        for (i = [0 : angular_segments - 1])
            each let(n = (i + 1) % angular_segments,
                     outer_last = inner_offset - angular_segments,
                     inner_last = outer_tip - angular_segments)
            [[i, inner_offset + i, inner_offset + n],
             [i, inner_offset + n, n],
             [outer_last + i, outer_last + n, outer_tip],
             [inner_last + i, inner_tip, inner_last + n]]
    ];
    faces = concat(v2_ring_faces(0, len(outer_rings)),
                   v2_ring_faces(inner_offset, len(inner_levels), true), ends);
    // OpenSCAD uses clockwise winding viewed from outside.
    polyhedron(points, [for (f = faces) [f[2], f[1], f[0]]], convexity = 10);
}

function v2_seat_z(r, angle) =
    let(t = pow(r / (flange_diameter / 2), 2))
    5 * (1 - t) + 3 * t * (1 - cos(5 * angle)) / 2;
function v2_flange_index(side, ring, segment) =
    (side * (v2_flange_radial_steps + 1) + ring) * angular_segments +
    segment % angular_segments;

module v2_flange() {
    // Widen the WHOLE wavy seat, preserving heights and connector diameters.
    points = [
        for (side = [0 : 1], j = [0 : v2_flange_radial_steps],
             i = [0 : angular_segments - 1])
            let(r = v2_flange_bore_radius +
                    (flange_diameter / 2 - v2_flange_bore_radius) *
                    j / v2_flange_radial_steps,
                a = i * 360 / angular_segments)
            [r * cos(a), r * sin(a),
             side == 0 ? v2_seat_z(r, a) : v2_body_start]
    ];
    surfaces = [
        for (side = [0 : 1], j = [0 : v2_flange_radial_steps - 1],
             i = [0 : angular_segments - 1])
            each let(a = v2_flange_index(side, j, i),
                     b = v2_flange_index(side, j + 1, i),
                     c = v2_flange_index(side, j + 1, i + 1),
                     d = v2_flange_index(side, j, i + 1))
            side == 0 ? [[a, c, b], [a, d, c]] :
                        [[a, b, c], [a, c, d]]
    ];
    edges = [
        for (j = [0, v2_flange_radial_steps], i = [0 : angular_segments - 1])
            each let(a = v2_flange_index(0, j, i),
                     b = v2_flange_index(0, j, i + 1),
                     c = v2_flange_index(1, j, i + 1),
                     d = v2_flange_index(1, j, i))
            j == 0 ? [[a, c, b], [a, d, c]] :
                     [[a, b, c], [a, c, d]]
    ];
    union() {
        polyhedron(points,
            [for (f = concat(surfaces, edges)) [f[2], f[1], f[0]]],
            convexity = 10);
        translate([0, 0, v2_body_start - v2_eps])
            difference() {
                cylinder(r = v2_flange_spigot_radius,
                         h = v2_joint_overlap + v2_eps);
                translate([0, 0, -v2_eps])
                    cylinder(r = v2_flange_bore_radius,
                             h = v2_joint_overlap + 3 * v2_eps);
            }
    }
}

module v2_print_at(start, radius) {
    if (print_orientation)
        translate([0, 0, radius])
            rotate([0, 0, bed_angle])
                rotate([0, 90, 0])
                    translate([0, 0, -start]) children();
    else
        children();
}

module v2_label_cutters() {
    // Limit all four text prisms to a shallow skin following the tube taper.
    skin_steps = 80;
    outer = [for (i = [0 : skin_steps])
        let(z = label_start + label_length * i / skin_steps)
        [radius_at(z) + v2_eps, z]];
    inner = [for (i = [skin_steps : -1 : 0])
        let(z = label_start + label_length * i / skin_steps)
        [radius_at(z) - label_depth, z]];
    intersection() {
        rotate_extrude(convexity = 10) polygon(concat(outer, inner));
        union() {
            for (i = [0 : 3])
                rotate([0, 0, i * 90])
                    translate([0, 0, label_start])
                        rotate([180, -90, 0])
                            linear_extrude(height = 12, convexity = 10)
                                text(lower_labels[i], size = label_size,
                                     font = label_font, halign = "left",
                                     valign = "center");
        }
    }
}

module v2_lower() {
    difference() {
        lower_tube();
        v2_label_cutters();
    }
}

if (part == "lower_body")
    v2_print_at(v2_body_start, 11.6) v2_lower();
else if (part == "middle_body")
    v2_print_at(v2_split_height, 8.2) middle_tube();
else if (part == "upper_body")
    v2_print_at(v2_split_height, v2_ball_radius) v2_upper();
else if (part == "flange")
    v2_flange();
else if (part == "fit_test")
    v2_print_at(v2_body_start, 11.6) body_shell(30, v2_body_start);
else if (part == "joint_lower_test")
    v2_print_at(v2_split_height - v2_joint_test_margin, 8.2)
        lower_tube(v2_split_height - v2_joint_test_margin);
else if (part == "joint_upper_test")
    v2_print_at(v2_split_height, 8.2)
        body_shell(v2_split_height + v2_joint_overlap +
                   v2_joint_test_margin, v2_split_height, "upper");
else if (part == "nose_transition_test")
    v2_print_at(blend_start - 10, v2_ball_radius) v2_upper(blend_start - 10);
else {
    color([0.85, 0.65, 0.2]) v2_lower();
    if (include_middle)
        color([0.82, 0.6, 0.18]) middle_tube();
    color([0.9, 0.7, 0.25])
        translate([0, 0, v2_extension]) v2_upper();
    color([0.85, 0.65, 0.2]) v2_flange();
}

echo(str("V2: flange OD ", flange_diameter,
         " mm; unchanged tube base OD 23.2 mm; integral TPU for AMS nose ",
         head_diameter, " mm; no separate TPU nose or mounting socket."));
echo(str("Assembled height: ", v2_compact_height + v2_extension,
         " mm. Tube lengths: lower 306.4, middle 320, upper ",
         v2_compact_height - v2_split_height,
         " mm. Horizontal print heights: lower 23.2, middle 16.4, upper ",
         head_diameter, " mm."));
echo("Cap-test compliance is unverified: test the printed nose sample with the actual cap.");
