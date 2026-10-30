// PPP cylinder V4: measured-bottle mounting prototype and 33 mm short top.
// Signature SELECT 1 L: reported base 83-84 mm, five 22-23 mm feet,
// 8.6-9 mm grooves and approximately 9 mm maximum bottom recess.
// The smooth five-foot surface is an approximation, not a bottle scan.
// Retain the V2 lower/middle pipes and all existing mating diameters.
// TPU-for-AMS top/flange; Bambu PLA Tough+ cup and V2 lower/middle pipes.
// See PRINTING.md. Material changes do not scale the mating geometry.
use <PingPongParachute-Cylinder.scad>
use <PingPongParachute-CylinderV2.scad>
use <PingPongParachute-CylinderV3.scad>

/* [Export] */
part = "assembly"; // [assembly, mount_assembly, upper_body, flange, alignment_cup, cup_fit_ring, pipe_guide_test]
print_orientation = true;
middle_count = 1; // Assembly preview only; reuse original 300 mm extensions.
head_diameter = 33; // V3 was 30 mm; change the head, not the connector scale.

/* [Measured bottle approximation] */
bottle_diameter = 84;
seat_feet = 5;
foot_width = 22.5; // Chord at the nominal bottle radius, not an angle.
groove_width = 8.8;
groove_depth = 9;
groove_relief = 0.3; // Avoid forcing an approximate ridge into the PET recess.
seat_rotation = 0;
flange_diameter = 50; // Keep the existing central flange/tape platform.
seat_skin = 2.2;

/* [Alignment cup] */
bottle_diametral_clearance = 0.6;
cup_wall = 1.2; // Skirt, cone-normal thickness and pipe guide.
cup_skirt_height = 19.62; // Original 12 mm plus 0.3 inch (7.62 mm).
cup_base_clearance = 2.2; // Cone starts above the bottle feet, not on the flange.
cone_height = 42;
guide_height = 12;
guide_radial_clearance = 0.25;
guide_slot_width = 1.2;
guide_unslotted_height = 3;

/* [Mesh quality] */
angular_segments = 120;
seat_radial_steps = 24;
$fn = angular_segments;

v4_upper_length = 100;
v4_old_body_start = 6.2;
v4_lower_join = 292.6;
v4_middle_length = 300;
v4_spigot_radius = 8.75;
v4_flange_bore_radius = 5.95;
v4_overlap = 20;
v4_pitch = 360 / seat_feet;
v4_foot_half_angle = asin(foot_width / bottle_diameter);
v4_groove_half_angle = asin(groove_width / bottle_diameter);
v4_seat_depth = groove_depth - groove_relief;
v4_flange_top = v4_seat_z(flange_diameter / 2, seat_rotation) + seat_skin;
v4_cup_base = cup_base_clearance;
v4_pipe_offset = v4_flange_top - v4_old_body_start;
v4_mouth_radius = (bottle_diameter + bottle_diametral_clearance) / 2;
v4_cup_outer_radius = v4_mouth_radius + cup_wall;
v4_guide_start = v4_cup_base + cone_height;
v4_cup_top = v4_guide_start + guide_height;
v4_cone_slope = (v4_mouth_radius - v4_guide_radius(v4_guide_start)) / cone_height;
// Offset the sloping wall normally, not just radially, by lifting its
// outer corners to meet the 1.2 mm skirt and guide walls.
v4_outer_corner_lift =
    cup_wall * (sqrt(1 + pow(v4_cone_slope, 2)) - 1) / v4_cone_slope;
v4_eps = 0.02;

assert(part == "assembly" || part == "mount_assembly" ||
       part == "upper_body" || part == "flange" ||
       part == "alignment_cup" || part == "cup_fit_ring" ||
       part == "pipe_guide_test",
       "Unknown V4 part selector.");
assert(head_diameter >= 30 && head_diameter <= 40);
assert(middle_count >= 0 && floor(middle_count) == middle_count);
assert(bottle_diameter > flange_diameter && flange_diameter > 23.2);
assert(seat_feet >= 3 && floor(seat_feet) == seat_feet);
assert(foot_width > 0 && groove_width > 0 &&
       foot_width < bottle_diameter && groove_width < bottle_diameter);
assert(v4_foot_half_angle + v4_groove_half_angle < v4_pitch / 2);
assert(groove_depth > groove_relief && groove_relief >= 0 && seat_skin >= 1.6);
assert(bottle_diametral_clearance >= 0.4 && cup_wall >= 1.2);
assert(cup_skirt_height > v4_seat_depth &&
       cup_base_clearance >= 0.5 && cone_height >= 35 && guide_height >= 10);
assert(guide_radial_clearance >= 0.15 && guide_radial_clearance <= 0.5);
assert(guide_slot_width >= 0.8 && guide_unslotted_height >= 3 &&
       guide_unslotted_height < guide_height);
assert(angular_segments >= 60 && angular_segments % seat_feet == 0 &&
       seat_radial_steps >= 12);
assert(v4_cone_slope > 0 && v4_cone_slope <= 1,
       "Keep the hollow cone's internal roof at 45 degrees or steeper.");
assert(flange_diameter / 2 + v4_eps <
       v4_cavity_radius(v4_flange_top + v4_overlap),
       "Leave access around the flange and its unchanged spigot.");

function v4_foot_phase(angle) =
    let(a = abs(((angle - seat_rotation + v4_pitch / 2) % v4_pitch +
                 v4_pitch) % v4_pitch - v4_pitch / 2),
        end = v4_pitch / 2 - v4_groove_half_angle)
    a <= v4_foot_half_angle ? 0 :
    a >= end ? 1 :
    (1 - cos(180 * (a - v4_foot_half_angle) /
             (end - v4_foot_half_angle))) / 2;
function v4_seat_z(r, angle) =
    let(t = min(1, pow(r / (bottle_diameter / 2), 2)))
    // Feet define Z=0; the inverted bottle's recess is BELOW that plane.
    -v4_seat_depth * (1 - t + t * v4_foot_phase(angle));
function v4_guide_radius(z) =
    radius_at(z - v4_pipe_offset) + guide_radial_clearance;
function v4_cavity_radius(z) =
    z <= v4_cup_base ? v4_mouth_radius :
    z < v4_guide_start ?
        v4_mouth_radius + (v4_guide_radius(v4_guide_start) - v4_mouth_radius) *
        (z - v4_cup_base) / cone_height : v4_guide_radius(z);
function v4_seat_index(side, ring, segment) =
    (side * (seat_radial_steps + 1) + ring) * angular_segments +
    segment % angular_segments;

module v4_seat_panel(inner_radius, outer_radius) {
    points = [
        for (side = [0 : 1], j = [0 : seat_radial_steps],
             i = [0 : angular_segments - 1])
            let(r = inner_radius + (outer_radius - inner_radius) *
                    j / seat_radial_steps,
                a = i * 360 / angular_segments)
            [r * cos(a), r * sin(a),
             side == 0 ? v4_seat_z(r, a) : v4_flange_top]
    ];
    surfaces = [
        for (side = [0 : 1], j = [0 : seat_radial_steps - 1],
             i = [0 : angular_segments - 1])
            each let(a = v4_seat_index(side, j, i),
                     b = v4_seat_index(side, j + 1, i),
                     c = v4_seat_index(side, j + 1, i + 1),
                     d = v4_seat_index(side, j, i + 1))
            side == 0 ? [[a, c, b], [a, d, c]] :
                        [[a, b, c], [a, c, d]]
    ];
    edges = [
        for (j = [0, seat_radial_steps], i = [0 : angular_segments - 1])
            each let(a = v4_seat_index(0, j, i),
                     b = v4_seat_index(0, j, i + 1),
                     c = v4_seat_index(1, j, i + 1),
                     d = v4_seat_index(1, j, i))
            j == 0 ? [[a, c, b], [a, d, c]] :
                     [[a, b, c], [a, c, d]]
    ];
    polyhedron(points,
        [for (f = concat(surfaces, edges)) [f[2], f[1], f[0]]],
        convexity = 10);
}

module v4_flange() {
    union() {
        v4_seat_panel(v4_flange_bore_radius, flange_diameter / 2);
        translate([0, 0, v4_flange_top - v4_eps])
            difference() {
                cylinder(r = v4_spigot_radius, h = v4_overlap + v4_eps);
                translate([0, 0, -v4_eps])
                    cylinder(r = v4_flange_bore_radius,
                             h = v4_overlap + 3 * v4_eps);
            }
    }
}

module v4_guide_slots() {
    for (angle = [0 : 90 : 270])
        rotate([0, 0, angle])
            translate([0, -guide_slot_width / 2,
                       v4_guide_start + guide_unslotted_height])
                cube([v4_guide_radius(v4_guide_start) + cup_wall + 1,
                      guide_slot_width,
                      guide_height - guide_unslotted_height + v4_eps]);
}

module v4_guide() {
    difference() {
        rotate_extrude(convexity = 10)
            polygon([
                [v4_guide_radius(v4_guide_start) + cup_wall, v4_guide_start],
                [v4_guide_radius(v4_cup_top) + cup_wall, v4_cup_top],
                [v4_guide_radius(v4_cup_top), v4_cup_top],
                [v4_guide_radius(v4_guide_start), v4_guide_start]]);
        v4_guide_slots();
    }
}

module v4_cup() {
    difference() {
        // Only the flange seats in the bottle recess. This independent
        // shell grips the bottle sides and guides the already seated pipe.
        rotate_extrude(convexity = 10)
            polygon([
                [v4_cup_outer_radius, -cup_skirt_height],
                [v4_cup_outer_radius, v4_cup_base + v4_outer_corner_lift],
                [v4_guide_radius(v4_guide_start) + cup_wall,
                 v4_guide_start + v4_outer_corner_lift],
                [v4_guide_radius(v4_cup_top) + cup_wall, v4_cup_top],
                [v4_guide_radius(v4_cup_top), v4_cup_top],
                [v4_guide_radius(v4_guide_start), v4_guide_start],
                [v4_mouth_radius, v4_cup_base],
                [v4_mouth_radius, -cup_skirt_height]]);
        v4_guide_slots();
    }
}

module v4_fit_ring() {
    difference() {
        cylinder(r = v4_cup_outer_radius, h = cup_skirt_height);
        translate([0, 0, -v4_eps])
            cylinder(r = v4_mouth_radius, h = cup_skirt_height + 2 * v4_eps);
    }
}

if (part == "upper_body")
    v3_upper(head_diameter = head_diameter);
else if (part == "flange")
    translate([0, 0, print_orientation ?
        v4_seat_depth : 0]) v4_flange();
else if (part == "alignment_cup")
    translate([0, 0, print_orientation ? cup_skirt_height : 0]) v4_cup();
else if (part == "cup_fit_ring") v4_fit_ring();
else if (part == "pipe_guide_test")
    translate([0, 0, -v4_guide_start]) v4_guide();
else {
    color([0.85, 0.65, 0.2]) v4_flange();
    color([0.2, 0.65, 0.85]) v4_cup();
    translate([0, 0, v4_pipe_offset]) {
        color([0.85, 0.65, 0.2]) v2_lower();
        if (part == "assembly") {
            for (i = [0 : 1 : max(0, middle_count - 1)])
                if (i < middle_count)
                    translate([0, 0, i * v4_middle_length]) middle_tube();
            color([0.9, 0.7, 0.25])
                translate([0, 0, v4_lower_join + middle_count * v4_middle_length])
                    v3_upper(head_diameter = head_diameter);
        }
    }
}

echo(str("PPP cylinder V4 upper: ", v4_upper_length,
         " mm total length; head OD ", head_diameter,
         " mm; V3 female socket ID 11.60 mm / 20 mm engagement unchanged."));
echo(str("Mount: central flange OD ", flange_diameter,
         "; bottle mouth ID ", 2 * v4_mouth_radius,
         "; cup OD ", 2 * v4_cup_outer_radius,
         "; cup print height ", v4_cup_top + cup_skirt_height, " mm."));
echo(str("Cup guide starts ", v4_guide_start - v4_flange_top,
         " mm above the lower pipe's bottom; no V2 pipe geometry changes."));
echo("Five-foot surface is an approximate fit trial. Dry-fit without force; tape symmetrically.");
echo("External attachment only: do not modify the pressure bottle. Fit, alignment and flight safety are unverified.");
