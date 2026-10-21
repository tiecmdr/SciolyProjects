// Reinforced bottle-bottom nose extension. Dimensions are in millimeters.
// Export lower_body, middle_body, upper_body, and flange in ABS;
// nose in TPU 95A. Use an ABS profile, not the former foaming ASA Aero profile.
// Never print the full assembly as one piece.
// Assembly is for viewing. part="fit_test" is a short tube/socket coupon;
// print it with the flange to check both socket fit and bottle seating.
// Defaults: 900 mm assembled, or 600 mm with the middle section removed.
// The middle adds exactly 300 mm; its 20 mm spigot makes print height 320 mm.
// With an assumed 68 mm bottle: 34 mm flange, 23.2 mm base, 12 mm waist.
// The flange has a flat tape-facing top and a contoured bottle-facing underside.
// Mass depends on material density, calibrated flow, and sliced walls.
// Re-slice in ABS; the former ASA Aero mass estimates are not applicable.
// Estimates exclude tape/supports/bottle/payload.
// The broad tape flange is separate to avoid a tall supported overhang.
//
// The Coke bottle dimensions and five-foot seat below are APPROXIMATIONS.
// Measure your actual bottle and adjust the seat parameters; not a scan/fit claim.
// This is an external, open-ended attachment, NOT a pressure vessel or a
// parachute-release mechanism. The TPU nose is NOT the event's payload ball.
// Check your season/division rules, including the rounded-nose test, materials,
// attachments, launcher clearance, and payload deployment, before use.
//
// With print_orientation=true, print the lower tube base-down and the upper
// tube nose-collar-down. Print the middle female-socket-down. Heights are
// 306.4 mm lower, 320 mm middle, and 286.4 mm upper,
// including the male spigots; all three fit a 325 mm
// printer height limit.
// Use approximately
// 0.2 mm layers, a brim, and the enclosed H2C Generic ABS profile.
// Inspect continuous walls; use perimeter printing, not vase
// mode. TPU: print flat opening down at 100% infill within the thick shell.
// The center remains hollow; internal dome support still needs removal.
// Print the flange bottle-contact side down with local support beneath its
// shallow contours (only a few millimeters tall). Do not invert the flange.
// No infill is intended in the hollow cavities. Do not scale individual parts.
//
// Seat the contoured flange on the inverted bottle bottom. Use multiple
// symmetric straps over its broad outer panel and down onto the bottle.
// Slip the tube over the flange's central spigot until it reaches the flat panel;
// tape across this clearance-fit joint to retain it. Neither socket locks.
// Lower and middle have identical male spigots; middle and upper have
// identical female sockets. Slide each joint together until the tube rims
// meet, then retain with external tape. None is a latch.
// Without the middle, connect the SAME lower and upper parts directly.
// Print joint_lower_test and joint_upper_test to check this fit beforehand.
// Print nose_neck_test in ABS and nose_socket_test in TPU 95A to check
// the elastic nose fit and stop without printing the full upper body.
// The longer, narrow tube is more flexible; geometry alone does not establish
// launch/impact strength or rule compliance. Test before flight.
// PROTOTYPE ONLY: not qualified for repeated launches or 20 m drops.
// The 900 mm length, thin walls, layer bonding, and tape-retained joints
// can fail under bending or impact. A TPU nose is not a validated crash absorber.
// Tape does not have a calculated safety rating here; do not
// sand, heat, cut, glue, or otherwise damage the pressurized bottle.
// The nose socket is a trial interference fit, NOT a locking connection.
// Retain the TPU nose with external tape across the ABS/TPU joint and verify
// adhesion on both materials; the stop controls depth, not pull-off retention.
// "3M tape" does not specify adhesion, peel strength, or ABS/TPU compatibility.
// Neither a safe tape load nor 20 m impact survival is established by this CAD.
// Fit-test, verify nose retention, and test progressively in a controlled area.
// The 1.2 mm TPU shell is not a validated shock absorber.
// Bottle/payload masses and locations are needed to determine assembled balance.
// A low center of mass does NOT guarantee upright descent or stable launch.
// Aerodynamic balance, parachute behavior and orientation require flight testing.

/* [Export] */
part = "assembly"; // [assembly, lower_body, middle_body, upper_body, flange, nose, fit_test, joint_lower_test, joint_upper_test, nose_neck_test, nose_socket_test]
print_orientation = true;
include_middle = true; // Assembly preview only; individual exports never change.

/* [Overall shape] */
assembled_height = 900; // Full assembly, including the TPU nose.
middle_length = 300; // Added assembled length; excludes the male spigot.
ball_diameter = 40;
body_wall = 1.6;
nose_wall = 1.2; // Trial flexible shell; keep the mounting collar reinforced.
waist_diameter = 12;

/* [Connector fit] */
male_diameter_increase = 0.4; // Total OD increase on all three male connectors; holes unchanged.

/* [Interchangeable tube joints] */
joint_diameter = 16.4; // Wider outside preserves the original 11.6 mm socket ID.
joint_socket_wall = 2.4;
joint_overlap = 20;
joint_radial_clearance = 0.25; // PER SIDE before male enlargement; tape retains the fit.
joint_wall = 2;
joint_root_height = 4; // Tapered reinforcement avoids a sharp internal shelf.
joint_test_margin = 8;
printer_max_height = 325;

/* [Bottle seat - measure your bottle] */
bottle_diameter = 68; // Assumed Coca-Cola 1 L outside diameter, not verified.
base_diameter_fraction = 23.2 / 68; // Preserve the 17.6 mm base bore with 2.8 mm walls.
base_wall = 2.8;
base_skirt_height = 32; // Straight 17.6 mm bore clears the longer flange spigot.
seat_feet = 5;
seat_dome_height = 5; // Height of central recess above the lowest feet.
seat_lobe_height = 3; // Additional valley height between the feet.
seat_rotation = 0; // Rotate the five-lobe pattern to align with your bottle.
seat_clearance = 0; // Vertical clearance; tape bridges any remaining gap.
fit_test_height = 30; // Includes the full 20 mm flange engagement plus clearance.

/* [Horizontal tape flange] */
flange_diameter_fraction = 0.5; // Half bottle width; 5.4 mm tape ledge around the tube.
flange_thickness = 1.2; // Minimum stock above the highest bottle-seat contour.
flange_collar_height = 20; // Match the interchangeable tube spigot engagement.
flange_collar_wall = 2.8;
flange_radial_clearance = 0.25; // PER SIDE before male enlargement.
flange_radial_steps = 20;

/* [TPU socket] */
neck_diameter = 18;
socket_overlap = 15; // Elastic grip; verify shell deformation clearance physically.
socket_radial_clearance = 0.05; // 18.10 mm hole; 0.30 mm interference on the 18.40 mm neck.
socket_wall = 2.4;
socket_stop_height = 1.2;
nose_bottom_trim = 4; // Remove the lowest 4 mm of the 40 mm sphere.

/* [Mesh quality] */
angular_segments = 120;
body_steps = 160;
$fn = angular_segments;

base_radius = bottle_diameter * base_diameter_fraction / 2;
flange_radius = bottle_diameter * flange_diameter_fraction / 2;
flange_spigot_radius = base_radius - base_wall - flange_radial_clearance +
                       male_diameter_increase / 2;
flange_bore_radius = flange_spigot_radius - flange_collar_wall;
body_start = seat_dome_height + seat_clearance + flange_thickness;
flange_height = body_start + flange_collar_height;
neck_radius = neck_diameter / 2;
neck_spigot_radius = neck_radius + male_diameter_increase / 2;
ball_radius = ball_diameter / 2;
nose_height = ball_diameter - nose_bottom_trim;
compact_height = assembled_height - middle_length;
body_height = compact_height - nose_height + socket_overlap;
split_height = (body_start + body_height) / 2;
middle_end = split_height + middle_length;
display_extension = include_middle ? middle_length : 0;
nose_origin = body_height - socket_overlap + display_extension;
socket_radius = neck_radius + socket_radial_clearance;
socket_outer_radius = socket_radius + socket_wall;
seat_end = max(body_start + 1, flange_height);
eps = 0.02;

assert(part == "assembly" || part == "lower_body" || part == "middle_body" ||
       part == "upper_body" ||
       part == "flange" || part == "nose" || part == "fit_test" ||
       part == "joint_lower_test" || part == "joint_upper_test" ||
       part == "nose_neck_test" || part == "nose_socket_test",
       "Unknown part selector; export the three tube sections separately.");
assert(angular_segments >= 40 && body_steps >= 40, "Mesh quality is too low.");
assert(body_wall > 0 && nose_wall > 0 && nose_wall < ball_radius);
assert(male_diameter_increase >= 0 &&
       male_diameter_increase / 2 < min(joint_radial_clearance,
                                      flange_radial_clearance),
       "Male enlargement must leave positive clearance at the rigid sockets.");
assert(base_wall >= body_wall && base_radius > base_wall);
assert(base_radius > neck_radius && waist_diameter / 2 > body_wall);
assert(seat_feet >= 3 && floor(seat_feet) == seat_feet);
assert(seat_dome_height >= 0 && seat_lobe_height >= 0 && seat_clearance >= 0);
assert(seat_dome_height >= seat_lobe_height,
       "The central mounting boss must be above the bottle valleys.");
assert(flange_radius > base_radius && flange_radius <= bottle_diameter / 2);
assert(flange_thickness > 0 && flange_collar_height > 0 &&
       flange_collar_wall > 0 && flange_radial_clearance >= 0);
assert(flange_bore_radius > 0 && flange_spigot_radius < base_radius - base_wall);
assert(flange_radial_steps >= 4 && floor(flange_radial_steps) == flange_radial_steps);
assert(flange_height < fit_test_height);
assert(base_skirt_height > seat_end && fit_test_height > seat_end);
assert(base_skirt_height >= flange_height + joint_root_height,
       "Keep the base bore straight beyond the full flange spigot.");
assert(fit_test_height <= base_skirt_height);
assert(nose_bottom_trim > 0 && nose_bottom_trim < ball_radius);
assert(socket_overlap > 0 && socket_overlap + socket_stop_height < nose_height);
assert(socket_overlap + socket_stop_height < nose_height - nose_wall,
       "Keep the nose collar below the inner crown.");
assert(sqrt(pow(ball_radius - nose_wall, 2) -
            pow(socket_overlap + socket_stop_height -
                (ball_radius - nose_bottom_trim), 2)) >
       max(socket_outer_radius, neck_spigot_radius) + 2,
       "Keep at least 2 mm radial clearance between the collar rim and inner shell.");
assert(socket_radial_clearance >= 0 && socket_wall > 0);
assert(neck_spigot_radius - body_wall > 0.5);
assert(body_height > base_skirt_height + 100 && body_height <= assembled_height);
assert(base_diameter_fraction > 0 && base_diameter_fraction <= 1);
assert(socket_outer_radius <
       sqrt(ball_radius * ball_radius -
            pow(ball_radius - nose_bottom_trim, 2)),
       "Socket must fit inside the trimmed sphere's bottom rim.");
assert(socket_radius - 0.6 > 0 &&
       socket_radius - 0.6 < neck_spigot_radius,
       "Socket stop must overlap the ABS collar.");
assert(joint_overlap > 0 && joint_wall > 0 && joint_root_height > 0 &&
       joint_radial_clearance >= 0 && joint_test_margin > joint_root_height);
assert(joint_diameter > waist_diameter && joint_socket_wall >= body_wall);
assert(middle_length > 4 * (joint_overlap + joint_root_height));
assert(split_height - joint_root_height > base_skirt_height + 8);
assert(split_height + joint_overlap + joint_test_margin <
       body_height - socket_overlap);
assert(split_height + joint_overlap - body_start <= printer_max_height &&
       body_height - split_height <= printer_max_height &&
       middle_length + joint_overlap <= printer_max_height,
       "A tube section exceeds the configured printer height.");

joint_outer_radius = joint_diameter / 2;
joint_socket_radius = joint_outer_radius - joint_socket_wall;
joint_spigot_radius = joint_socket_radius - joint_radial_clearance +
                      male_diameter_increase / 2;
joint_bore_radius = joint_spigot_radius - joint_wall;
assert(joint_bore_radius > 0, "Joint wall leaves no hollow center.");

// Cosine blends keep the perfume-bottle silhouette smooth at each station.
profile = [
    [seat_end, base_radius],
    [base_skirt_height, base_radius],
    [body_height * 0.37, waist_diameter / 2 + 1],
    [split_height - joint_root_height, joint_outer_radius],
    [split_height, joint_outer_radius],
    [split_height + joint_overlap, joint_outer_radius],
    [split_height + joint_overlap + joint_root_height, joint_outer_radius],
    [body_height * 0.64, waist_diameter / 2],
    [body_height - socket_overlap - 32, waist_diameter / 2 + 0.5],
    [body_height - socket_overlap - 8, 12],
    [body_height - socket_overlap - 2, 11],
    [body_height - socket_overlap, neck_spigot_radius],
    [body_height, neck_spigot_radius]
];
for (i = [1 : len(profile) - 1])
    assert(profile[i][0] > profile[i - 1][0],
           "Body profile stations must stay strictly increasing.");
assert(body_height * 0.37 < split_height - joint_root_height &&
       split_height + joint_overlap + joint_root_height < body_height * 0.64,
       "Compact tube length leaves insufficient room for the standard joint.");

function blend(a, b, t) = a + (b - a) * (1 - cos(180 * t)) / 2;
function radius_at(z, i = 0) =
    z <= profile[0][0] ? profile[0][1] :
    i >= len(profile) - 1 ? profile[len(profile) - 1][1] :
    z <= profile[i + 1][0] ?
        blend(profile[i][1], profile[i + 1][1],
              (z - profile[i][0]) / (profile[i + 1][0] - profile[i][0])) :
        radius_at(z, i + 1);
function wall_at(z) =
    z <= base_skirt_height ? base_wall :
    z >= base_skirt_height + 8 ? body_wall :
    blend(base_wall, body_wall, (z - base_skirt_height) / 8);

function socket_wall_at(distance) =
    distance <= joint_overlap ? joint_socket_wall :
    distance >= joint_overlap + joint_root_height ? body_wall :
    blend(joint_socket_wall, body_wall,
          (distance - joint_overlap) / joint_root_height);

middle_profile = [
    [split_height, joint_outer_radius],
    [split_height + joint_overlap, joint_outer_radius],
    [split_height + joint_overlap + joint_root_height, joint_outer_radius],
    [split_height + middle_length * 0.25, waist_diameter / 2],
    [split_height + middle_length * 0.75, waist_diameter / 2],
    [middle_end - joint_root_height, joint_outer_radius],
    [middle_end, joint_outer_radius]
];

function middle_radius_at(z, i = 0) =
    i >= len(middle_profile) - 1 ? joint_outer_radius :
    z <= middle_profile[i + 1][0] ?
        blend(middle_profile[i][1], middle_profile[i + 1][1],
              (z - middle_profile[i][0]) /
              (middle_profile[i + 1][0] - middle_profile[i][0])) :
        middle_radius_at(z, i + 1);

// A thin transverse panel follows an approximate petaloid bottle bottom.
function seat_z(r, angle) =
    seat_clearance +
    seat_dome_height * (1 - pow(r / flange_radius, 2)) +
    seat_lobe_height * pow(r / flange_radius, 2) *
    (1 - cos(seat_feet * (angle - seat_rotation))) / 2;

function index_of(ring, side, segment) =
    (ring * 2 + side) * angular_segments +
    (segment % angular_segments);

module body_shell(height = body_height, start = body_start, section = "lower") {
    assert(height > start);
    shape = section == "middle" ? middle_profile : profile;
    stations = concat([start],
        [for (p = shape) if (p[0] > start && p[0] < height) p[0]],
        [height]);
    // Include exact socket endpoints, so both female bores are identical.
    levels = concat(
        [for (k = [0 : len(stations) - 2])
            each let(steps = max(1, ceil(body_steps *
                         (stations[k + 1] - stations[k]) / (height - start))))
                [for (j = [0 : steps - 1])
                    stations[k] + (stations[k + 1] - stations[k]) * j / steps]],
        [height]);
    last = len(levels) - 1;
    points = [
        for (j = [0 : last], side = [0 : 1],
             i = [0 : angular_segments - 1])
            let(z = levels[j],
                angle = 360 * i / angular_segments,
                outer = section == "middle" ? middle_radius_at(z) : radius_at(z),
                wall = section == "middle" || section == "upper" ?
                    socket_wall_at(z - split_height) : wall_at(z),
                r = outer - side * wall)
            [r * cos(angle), r * sin(angle),
             z]
    ];
    outside = [
        for (j = [0 : last - 1], i = [0 : angular_segments - 1])
            each [
                [index_of(j, 0, i), index_of(j, 0, i + 1),
                 index_of(j + 1, 0, i + 1)],
                [index_of(j, 0, i), index_of(j + 1, 0, i + 1),
                 index_of(j + 1, 0, i)]
            ]
    ];
    inside = [
        for (j = [0 : last - 1], i = [0 : angular_segments - 1])
            each [
                [index_of(j, 1, i), index_of(j + 1, 1, i + 1),
                 index_of(j, 1, i + 1)],
                [index_of(j, 1, i), index_of(j + 1, 1, i),
                 index_of(j + 1, 1, i + 1)]
            ]
    ];
    ends = [
        for (i = [0 : angular_segments - 1])
            each [
                [index_of(0, 0, i), index_of(0, 1, i),
                 index_of(0, 1, i + 1)],
                [index_of(0, 0, i), index_of(0, 1, i + 1),
                 index_of(0, 0, i + 1)],
                [index_of(last, 0, i), index_of(last, 0, i + 1),
                 index_of(last, 1, i + 1)],
                [index_of(last, 0, i), index_of(last, 1, i + 1),
                 index_of(last, 1, i)]
            ]
    ];
    // OpenSCAD polyhedron faces use clockwise winding viewed from outside.
    faces = [for (face = concat(outside, inside, ends))
        [face[2], face[1], face[0]]];
    polyhedron(points, faces, convexity = 10);
}

module midpoint_spigot(join_z = split_height) {
    root_z = join_z - joint_root_height;
    difference() {
        union() {
            translate([0, 0, root_z])
                cylinder(h = joint_root_height,
                         r1 = joint_outer_radius - eps,
                         r2 = joint_spigot_radius);
            translate([0, 0, join_z - eps])
                cylinder(h = joint_overlap + eps, r = joint_spigot_radius);
        }
        translate([0, 0, root_z - eps])
            cylinder(h = joint_root_height + eps,
                     r1 = joint_outer_radius - body_wall + 2 * eps,
                     r2 = joint_bore_radius);
        translate([0, 0, root_z - eps])
            cylinder(h = joint_root_height + joint_overlap + 2 * eps,
                     r = joint_bore_radius);
    }
}

module middle_tube() {
    union() {
        body_shell(middle_end, split_height, "middle");
        midpoint_spigot(middle_end);
    }
}

module exported_middle() {
    if (print_orientation)
        translate([0, 0, -split_height]) middle_tube();
    else
        middle_tube();
}

module lower_tube(start = body_start) {
    union() {
        body_shell(split_height, start);
        midpoint_spigot();
    }
}

module exported_lower(start = body_start) {
    if (print_orientation)
        translate([0, 0, -start]) lower_tube(start);
    else
        lower_tube(start);
}

module exported_upper(height = body_height, start = split_height) {
    if (print_orientation)
        translate([0, 0, height])
            rotate([180, 0, 0]) body_shell(height, start, "upper");
    else
        body_shell(height, start, "upper");
}

function flange_index(side, ring, segment) =
    (side * (flange_radial_steps + 1) + ring) * angular_segments +
    (segment % angular_segments);

module tape_panel() {
    points = [
        for (side = [0 : 1], j = [0 : flange_radial_steps],
             i = [0 : angular_segments - 1])
            let(r = flange_bore_radius +
                    (flange_radius - flange_bore_radius) * j / flange_radial_steps,
                a = 360 * i / angular_segments)
            [r * cos(a), r * sin(a),
             side == 0 ? seat_z(r, a) : body_start]
    ];
    surfaces = [
        for (side = [0 : 1], j = [0 : flange_radial_steps - 1],
             i = [0 : angular_segments - 1])
            each let(a = flange_index(side, j, i),
                     b = flange_index(side, j + 1, i),
                     c = flange_index(side, j + 1, i + 1),
                     d = flange_index(side, j, i + 1))
                side == 0 ? [[a, c, b], [a, d, c]] :
                            [[a, b, c], [a, c, d]]
    ];
    edges = [
        for (j = [0, flange_radial_steps], i = [0 : angular_segments - 1])
            each let(a = flange_index(0, j, i),
                     b = flange_index(0, j, i + 1),
                     c = flange_index(1, j, i + 1),
                     d = flange_index(1, j, i))
                j == 0 ? [[a, c, b], [a, d, c]] :
                         [[a, b, c], [a, c, d]]
    ];
    faces = [for (f = concat(surfaces, edges)) [f[2], f[1], f[0]]];
    polyhedron(points, faces, convexity = 10);
}

module tape_flange() {
    union() {
        tape_panel();
        // The flat panel sets tube seating height; the spigot locates it.
        difference() {
            translate([0, 0, body_start - eps])
                cylinder(r = flange_spigot_radius,
                         h = flange_collar_height + eps);
            translate([0, 0, -eps])
                cylinder(r = flange_bore_radius, h = flange_height + 2 * eps);
        }
    }
}

module nose_shell() {
    center_z = ball_radius - nose_bottom_trim;
    bottom_angle = asin(-center_z / ball_radius);
    // Explicit equator and pole give exactly 40 mm width and the target height.
    arc = concat(
        [for (i = [0 : 30])
            let(a = bottom_angle * (1 - i / 30))
            [ball_radius * cos(a), center_z + ball_radius * sin(a)]],
        [for (i = [1 : 60])
            let(a = 90 * i / 60)
            [i == 60 ? 0 : ball_radius * cos(a),
             center_z + ball_radius * sin(a)]]
    );
    union() {
        difference() {
            rotate_extrude(convexity = 10)
                polygon(concat([[0, 0]], arc));
            translate([0, 0, center_z])
                sphere(r = ball_radius - nose_wall);
            translate([0, 0, -eps])
                cylinder(r = socket_radius, h = socket_overlap + eps);
        }
        // Elastic interference collar grips the spigot; the stop sets depth.
        difference() {
            cylinder(r = socket_outer_radius,
                     h = socket_overlap + socket_stop_height);
            translate([0, 0, -eps])
                cylinder(r = socket_radius, h = socket_overlap + eps);
            translate([0, 0, socket_overlap - eps])
                cylinder(r = socket_radius - 0.6,
                         h = socket_stop_height + 2 * eps);
        }
    }
}

module exported_body(height) {
    if (print_orientation)
        translate([0, 0, height])
            rotate([180, 0, 0]) body_shell(height);
    else
        body_shell(height);
}

if (part == "lower_body")
    exported_lower();
else if (part == "middle_body")
    exported_middle();
else if (part == "upper_body")
    exported_upper();
else if (part == "nose")
    nose_shell();
else if (part == "flange")
    tape_flange();
else if (part == "fit_test")
    exported_body(fit_test_height);
else if (part == "joint_lower_test")
    exported_lower(split_height - joint_test_margin);
else if (part == "joint_upper_test")
    exported_upper(split_height + joint_overlap + joint_test_margin);
else if (part == "nose_neck_test")
    exported_upper(body_height, body_height - socket_overlap - 2);
else if (part == "nose_socket_test")
    intersection() {
        nose_shell();
        cylinder(r = ball_radius, h = socket_overlap + socket_stop_height);
    }
else {
    color([0.85, 0.65, 0.2]) lower_tube();
    if (include_middle)
        color([0.82, 0.6, 0.18]) middle_tube();
    color([0.9, 0.7, 0.25])
        translate([0, 0, display_extension])
            body_shell(body_height, split_height, "upper");
    color([0.85, 0.65, 0.2]) tape_flange();
    color([0.95, 0.95, 0.95, 0.7])
        translate([0, 0, nose_origin]) nose_shell();
}

echo(str("Assembled height: ", compact_height + display_extension,
         " mm; TPU nose: ", nose_height,
         " mm; overlap: ", socket_overlap, " mm"));
echo(str("Tape flange diameter: ", 2 * flange_radius,
         " mm; tube base: ", 2 * base_radius,
         " mm; waist: ", waist_diameter, " mm"));
echo(str("Standard joint: female ID=", 2 * joint_socket_radius,
         " mm; male bore=", 2 * joint_bore_radius, " mm; lower joint at z=", split_height,
         " mm; spigot OD=", 2 * joint_spigot_radius,
         " mm; overlap=", joint_overlap, " mm"));
echo(str("Print heights: lower=", split_height + joint_overlap - body_start,
         " mm; middle=", middle_length + joint_overlap,
         " mm; upper=", body_height - split_height, " mm"));
echo(str("Reinforced walls: body=", body_wall, " mm; base=", base_wall,
         " mm; socket=", joint_socket_wall, " mm; spigot=", joint_wall, " mm."));
echo(str("Connector male ODs / female IDs: joint=", 2 * joint_spigot_radius,
         "/", 2 * joint_socket_radius, " mm; flange=", 2 * flange_spigot_radius,
         "/", 2 * (base_radius - base_wall), " mm; nose=", 2 * neck_spigot_radius,
         "/", 2 * socket_radius, " mm. Tape retention still required."));
echo(str("Engagement lengths: flange=", flange_collar_height,
         " mm; nose=", socket_overlap,
         " mm; nose tip to inner crown=",
         nose_height - nose_wall - socket_overlap, " mm."));
echo(str("Hollow TPU nose: ", nose_wall,
         " mm shell at 100% infill; remove internal dome support before assembly."));
echo("WARNING: bottle-side balance and TPU impact recovery must be measured, not assumed.");
echo("WARNING: approximate bottle seat; verify fit, rules, tape and impact behavior.");
