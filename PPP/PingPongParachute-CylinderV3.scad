// V3: short TPU upper, rigid modular middles, unchanged V2 lower and flange.
// Millimeters. Keep V1 and V2 SCAD files beside this file.
// Export parts separately; never print the assembly. See PRINTING.md.
use <PingPongParachute-Cylinder.scad>
use <PingPongParachute-CylinderV2.scad>

/* [Export] */
part = "assembly"; // [assembly, lower_body, middle_body, upper_body, flange, middle_braced_pair, brace_test, joint_lower_test, joint_upper_test]
print_orientation = true;
middle_count = 3;

/* [V3 lengths] */
upper_length = 100; // Total, including the integral 30 mm rounded head.
extension_length = 150; // Added assembly length; printed middle is 170 mm.

/* [Braced print trial] */
tilt_angle = 40; // Tube axis ABOVE THE BED, not from vertical.
pair_spacing = 28;
rib_thickness = 1.2;
tab_width = 1.2;
tab_gap = 1.2;
tab_bite = 0.35; // Outside skin only; never reaches the bore.

/* [Mesh quality] */
angular_segments = 120;
body_steps = 180;
$fn = angular_segments;

v3_lower_start = 6.2;
v3_lower_join = 292.6;
v3_overlap = 20;
v3_root = 4;
v3_joint_radius = 8.2;
v3_socket_radius = 5.8;
v3_wall = 1.6;
v3_head_radius = 15;
v3_center = upper_length - v3_head_radius;
v3_blend_start = upper_length - 60;
v3_blend_end = v3_center + v3_head_radius * sin(-20);
v3_blend_radius = v3_head_radius * cos(-20);
v3_inner_tip = upper_length - v3_wall;
v3_rib_start = 26;
v3_rib_end = extension_length - 6;
v3_bed_lift = v3_joint_radius * cos(tilt_angle);
v3_eps = 0.02;

assert(part == "assembly" || part == "lower_body" ||
       part == "middle_body" || part == "upper_body" || part == "flange" ||
       part == "middle_braced_pair" || part == "brace_test" ||
       part == "joint_lower_test" || part == "joint_upper_test",
       "Unknown V3 part selector.");
assert(upper_length >= 100 && extension_length >= 100);
assert(middle_count >= 0 && floor(middle_count) == middle_count);
assert(angular_segments >= 40 && body_steps >= 40);
assert(tilt_angle >= 35 && tilt_angle <= 55);
assert(pair_spacing >= 26 && pair_spacing <= 40);
assert(rib_thickness >= 0.8 && rib_thickness <= 2);
assert(tab_width >= 0.8 && tab_width <= 2 && tab_gap >= 0.8);
assert(tab_bite > 0 && tab_bite < v3_wall / 2);

function v3_middle_radius(z) =
    z <= 24 ? v3_joint_radius :
    z <= extension_length * 0.25 ?
        blend(v3_joint_radius, 6, (z - 24) / (extension_length * 0.25 - 24)) :
    z <= extension_length * 0.75 ? 6 :
    z <= extension_length - v3_root ?
        blend(6, v3_joint_radius, (z - extension_length * 0.75) /
              (extension_length * 0.25 - v3_root)) : v3_joint_radius;

function v3_upper_radius(z, head_radius = v3_head_radius) =
    let(center = upper_length - head_radius,
        blend_end = center + head_radius * sin(-20),
        blend_radius = head_radius * cos(-20))
    z <= 24 ? v3_joint_radius :
    z <= 36 ? blend(v3_joint_radius, 6, (z - 24) / 12) :
    z <= v3_blend_start ? 6 :
    z < blend_end ?
        let(t = (z - v3_blend_start) / (blend_end - v3_blend_start),
            m1 = -tan(-20) * (blend_end - v3_blend_start))
        (2*t*t*t - 3*t*t + 1) * 6 +
        (-2*t*t*t + 3*t*t) * blend_radius +
        (t*t*t - t*t) * m1 :
    sqrt(max(0, head_radius*head_radius - pow(z - center, 2)));

// Upright TPU printing: a 45-degree INTERNAL roof closes without a trapped
// support tree. The smooth outside remains spherical; the crown is thicker.
function v3_upper_inner(z, head_radius = v3_head_radius) =
    z <= upper_length - head_radius ?
        v3_upper_radius(z, head_radius) - socket_wall_at(z) :
    max(0, v3_inner_tip - z);

module v3_middle() {
    levels = concat([0, 20, 24],
        [for (i = [1 : body_steps - 1])
            let(z = extension_length * i / body_steps)
            if (z > 24 && z < extension_length - v3_root) z],
        [extension_length - v3_root, extension_length]);
    union() {
        rotate_extrude(convexity = 10)
            polygon(concat(
                [for (z = levels) [v3_middle_radius(z), z]],
                [for (i = [len(levels)-1 : -1 : 0])
                    let(z = levels[i])
                    [v3_middle_radius(z) - socket_wall_at(z), z]]));
        midpoint_spigot(extension_length);
    }
}

module v3_upper(head_diameter = 30) {
    assert(head_diameter >= 30 && head_diameter <= 40);
    head_radius = head_diameter / 2;
    center = upper_length - head_radius;
    blend_end = center + head_radius * sin(-20);
    levels = concat([0, 20, 24, 36, v3_blend_start],
        [for (i = [1 : body_steps])
            v3_blend_start + (blend_end - v3_blend_start) * i / body_steps],
        [for (i = [1 : 20])
            center + head_radius * sin(-20 + i)],
        [for (i = [1 : 89])
            center + head_radius * sin(i)]);
    inner_levels = [for (z = levels) if (z <= center) z];
    rotate_extrude(convexity = 10)
        polygon(concat(
            [for (z = levels) [v3_upper_radius(z, head_radius), z]],
            [[0, upper_length], [0, v3_inner_tip]],
            [for (i = [len(inner_levels)-1 : -1 : 0])
                let(z = inner_levels[i]) [v3_upper_inner(z, head_radius), z]]));
}

module v3_tilted() {
    translate([0, 0, v3_bed_lift])
        rotate([0, 90 - tilt_angle, 0]) children();
}

function v3_under_x(z) =
    z * cos(tilt_angle) + v3_middle_radius(z) * sin(tilt_angle);
function v3_under_z(z) =
    v3_bed_lift + z * sin(tilt_angle) -
    v3_middle_radius(z) * cos(tilt_angle);
function v3_tabs(end) = concat([for (z = [30 : 30 : end - 10]) z], [end - 3]);

module v3_ground_rib(end) {
    // A continuous bed-grounded web resists lean-direction motion. Small
    // isolated tabs join the OUTSIDE only, away from both mating interfaces.
    rotate([90, 0, 0])
        linear_extrude(height = rib_thickness, center = true)
            polygon(concat(
                [[v3_under_x(v3_rib_start), 0], [v3_under_x(end), 0]],
                [for (i = [60 : -1 : 0])
                    let(z = v3_rib_start + (end - v3_rib_start) * i / 60)
                    [v3_under_x(z), v3_under_z(z) - tab_gap]]));
    for (z = v3_tabs(end))
        translate([v3_under_x(z) - tab_width/2, -rib_thickness/2,
                   v3_under_z(z) - tab_gap - 0.6])
            cube([tab_width, rib_thickness, tab_gap + tab_bite + 0.6]);
}

module v3_braced_pair(test = false) {
    end = test ? 56 : v3_rib_end;
    union() {
        for (y = [0, pair_spacing])
            translate([0, y, 0]) {
                v3_tilted()
                    if (test)
                        intersection() {
                            v3_middle();
                            translate([-10, -10, -v3_eps])
                                cube([20, 20, 64 + v3_eps]);
                        }
                    else v3_middle();
                v3_ground_rib(end);
            }
        // Horizontal bridges connect the grounded webs, not the sockets.
        // Each end grows from an existing rib; the short clear span bridges.
        for (z = v3_tabs(end))
            translate([v3_under_x(z) - tab_width/2, 0,
                       v3_under_z(z) - tab_gap - 1.2])
                cube([tab_width, pair_spacing, 1.2]);
        translate([v3_under_x(v3_rib_start), -6, 0])
            cube([v3_under_x(end) - v3_under_x(v3_rib_start),
                  pair_spacing + 12, 0.6]);
    }
}

module v3_lower_print() {
    if (print_orientation)
        translate([0, 0, 11.6]) rotate([0, 0, 45]) rotate([0, 90, 0])
            translate([0, 0, -v3_lower_start]) v2_lower();
    else v2_lower();
}

if (part == "lower_body") v3_lower_print();
else if (part == "middle_body") v3_middle();
else if (part == "upper_body") v3_upper();
else if (part == "flange") v2_flange();
else if (part == "middle_braced_pair") v3_braced_pair();
else if (part == "brace_test") v3_braced_pair(true);
else if (part == "joint_lower_test")
    translate([0, 0, -(v3_lower_join - 8)])
        lower_tube(v3_lower_join - 8);
else if (part == "joint_upper_test")
    intersection() {
        v3_upper();
        translate([-10, -10, -v3_eps]) cube([20, 20, 28 + v3_eps]);
    }
else {
    color([0.85, 0.65, 0.2]) v2_lower();
    for (i = [0 : 1 : max(0, middle_count - 1)])
        if (i < middle_count)
            color([0.3, 0.65, 0.85])
                translate([0, 0, v3_lower_join + i * extension_length])
                    v3_middle();
    color([0.9, 0.7, 0.25])
        translate([0, 0, v3_lower_join + middle_count * extension_length])
            v3_upper();
    color([0.85, 0.65, 0.2]) v2_flange();
}

echo(str("V3: lower 306.4 mm unchanged; upper ", upper_length,
         " mm; middle printed ", extension_length + v3_overlap,
         " mm, adds ", extension_length, " mm."));
echo(str("Assembly height from bottle-seat datum: ",
         v3_lower_join + middle_count * extension_length + upper_length,
         " mm with ", middle_count, " middle(s)."));
echo("Connectors unchanged: female ID 11.60, male OD 11.50, engagement 20 mm. Tape-retained.");
echo("Braces are a print trial: cut away before use. Verify mixed-material fit, cap clearance and controlled impact/deployment.");
