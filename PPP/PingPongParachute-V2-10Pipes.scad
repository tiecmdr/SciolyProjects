// One connected printing fixture for TEN ORIGINAL V2 middle pipes.
// Millimeters. The imported V2 STL and its connectors are not scaled.
// Cut away the shared foot, webs, and tabs before assembling the pipes.
part = "plate"; // [plate, bracing, pipe]
pipe_count = 10;
pipe_spacing = 28;
tilt_angle = 40; // Degrees above the bed.
rib_thickness = 1.2;
tab_width = 1.2;
tab_gap = 1.2;
tab_bite = 0.35;

use <PingPongParachute-Cylinder.scad>

v2_batch_join = 292.6;
v2_batch_length = 320; // 300 mm added length plus the original 20 mm spigot.
v2_batch_radius = 8.2;
v2_batch_lift = v2_batch_radius * cos(tilt_angle);
v2_batch_rib_start = 26;
v2_batch_rib_end = 294; // Clear the original male root at 296 mm.
v2_batch_tabs = concat([for (z = [30 : 30 : 270]) z], [291]);

assert(part == "plate" || part == "bracing" || part == "pipe");
assert(pipe_count >= 2 && pipe_count <= 10 && floor(pipe_count) == pipe_count);
assert(pipe_spacing >= 26 && pipe_spacing <= 28);
assert(tilt_angle >= 40 && tilt_angle <= 55);
assert(rib_thickness >= 0.8 && rib_thickness <= 2);
assert(tab_width >= 0.8 && tab_width <= 2 && tab_gap >= 0.8);
assert(tab_bite > 0 && tab_bite < 0.8);

function v2_batch_r(z) = middle_radius_at(v2_batch_join + z);
function v2_batch_under_x(z) =
    z * cos(tilt_angle) + v2_batch_r(z) * sin(tilt_angle);
function v2_batch_under_z(z) =
    v2_batch_lift + z * sin(tilt_angle) -
    v2_batch_r(z) * cos(tilt_angle);

module v2_batch_pipe() {
    translate([0, 0, v2_batch_lift])
        rotate([0, 90 - tilt_angle, 0])
            // Undo only the saved V2 STL's horizontal print orientation.
            rotate([0, -90, 0])
                rotate([0, 0, -45])
                    translate([0, 0, -v2_batch_radius])
                        import("PingPongParachute-V2-MiddleBody.stl");
}

module v2_batch_web() {
    rotate([90, 0, 0])
        linear_extrude(height = rib_thickness, center = true)
            polygon(concat(
                [[v2_batch_under_x(v2_batch_rib_start), 0],
                 [v2_batch_under_x(v2_batch_rib_end), 0]],
                [for (i = [120 : -1 : 0])
                    let(z = v2_batch_rib_start +
                        (v2_batch_rib_end - v2_batch_rib_start) * i / 120)
                    [v2_batch_under_x(z), v2_batch_under_z(z) - tab_gap]]));
    for (z = v2_batch_tabs)
        translate([v2_batch_under_x(z) - tab_width/2, -rib_thickness/2,
                   v2_batch_under_z(z) - tab_gap - 0.6])
            cube([tab_width, rib_thickness, tab_gap + tab_bite + 0.6]);
}

module v2_batch_bracing() {
    union() {
        for (i = [0 : pipe_count - 1])
            translate([0, i * pipe_spacing, 0]) v2_batch_web();
        // Every rung crosses ALL webs, tying all ten pipes into one ladder.
        for (z = v2_batch_tabs)
            translate([v2_batch_under_x(z) - tab_width/2, 0,
                       v2_batch_under_z(z) - tab_gap - 1.2])
                cube([tab_width, (pipe_count - 1) * pipe_spacing, 1.2]);
        translate([v2_batch_under_x(v2_batch_rib_start), -6, 0])
            cube([v2_batch_under_x(v2_batch_rib_end) -
                  v2_batch_under_x(v2_batch_rib_start),
                  (pipe_count - 1) * pipe_spacing + 12, 0.6]);
    }
}

if (part == "pipe") v2_batch_pipe();
else if (part == "bracing") v2_batch_bracing();
else
    union() {
        for (i = [0 : pipe_count - 1])
            translate([0, i * pipe_spacing, 0]) v2_batch_pipe();
        v2_batch_bracing();
    }

echo(str(pipe_count, " original V2 middles; each ", v2_batch_length,
         " mm; ", tilt_angle, " degrees above bed; one shared cut-away fixture."));
echo("Leave all original V2/V3 projects and pipe STLs unchanged. Slice the batch in PETG.");
