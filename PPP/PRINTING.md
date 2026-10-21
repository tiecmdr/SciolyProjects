# H2C printing and fit checks

The current projects use **Generic ABS** for the three tubes, flange,
fins, and rigid fit coupons, and **Bambu TPU 95A** for the nose and its
socket coupon. ABS replaces the failed ASA Aero printing trial; do not
use the former foaming material's 0.52 flow ratio. The TPU profile is for regular
95A, not 95A HF or TPU for AMS.

## Project setup

**Current customized body/nose project:** the main tube walls remain
**1.6 mm**, with the thicker base and joint reinforcement unchanged.
All three types of male connector retain their previous **0.4 mm diameter
enlargement**. Mating diameters and assembled lengths are unchanged,
retaining **0.10 mm diametral clearance** at rigid connections.
The flange spigot now engages **20 mm**, matching the tube joints.
The lower tube's straight reinforced base extends to **32 mm above the
flange's bottle-side datum**, clearing the full spigot before tapering;
the matching base fit coupon is now 23.8 mm tall (20 mm engagement plus margin).
The TPU nose now has a **1.2 mm spherical shell** and an **18.10 mm socket**,
0.4 mm smaller than before. Its 18.40 mm ABS neck gives **0.30 mm nominal
diametral interference**. Nose engagement is now **25 mm**. The matching TPU
collar is lengthened with its stop, retaining a 2.4 mm wall and 1.2 mm
stop height. The stationary neck tip is **9.8 mm below the inner crown**
along the axis, with about **4.3 mm radial clearance** between the collar's
upper rim and the inner shell. These undeformed CAD clearances do not
guarantee clearance during impact; the longer collar also stiffens the nose.
All affected STL meshes and embedded production copies/fit coupons are updated.

Both 3MF projects now use the installed **Generic ABS H2C 0.4 mm factory
profile** in slot 1. TPU settings remain unchanged in slot 2. Existing
fin copies in the body/nose project also use ABS; their geometry is unchanged.
The TPU noses previously sharing plate 1 with fins have moved to empty
plate 2, preserving their relative layout, so ABS and TPU remain separate jobs.
The separate fin project retains its geometry and solid-root modifiers.

`PingPongParachute.3mf` targets the H2C with 0.4 mm nozzles and 0.20 mm
layers. Each plate uses only the **right hotend**, including the 320 mm
middle tube; the configured right-side height limit is 325 mm. No parts
are scaled. There is no prime tower. Hollow body parts use zero sparse
infill. Fins have a separate `PingPongParachute-Fins.3mf` H2C project,
with light wing infill and solid mounting reinforcement.

| Filament slot | Material | Nozzle | Textured PEI bed | Chamber | Flow ratio | Max volumetric speed |
|---|---|---|---|---|---|---|
| 1 | Generic ABS, H2C 0.4 mm factory profile | 260 C first layer / 270 C subsequent | 90 C | 60 C | 0.98 | 15 mm3/s |
| 2 | Bambu TPU 95A, H2C 0.4 mm factory profile | 230 C | 35 C | Off | 1.00 | 3.6 mm3/s |

Both slots map to the right hotend, on **separate print jobs**. Load the
appropriate material for each job. Feed regular TPU 95A from the external
spool, **not the AMS**. Let the chamber cool before a TPU job. Dry both
filaments according to their spool/manufacturer instructions. Use
appropriate ventilation for ABS printing and a TPU-compatible release
layer on the plate.

The body/nose project uses Arachne, four wall loops, an 8 mm outer brim, reduced
wall speeds (35 mm/s outer, 50 mm/s inner), and reduced acceleration for
the tall, narrow tubes. These are conservative starting settings, not a
substitute for checking actual extrusion, shrinkage, and layer bonding.

| Plate | Contents | Notes |
|---|---|---|
| 1 | Existing fin copies, now ABS | Geometry and positions retained |
| 2 | TPU nose copies moved from plate 1 | Hollow 1.2 mm shells; TPU support settings retained |
| 3 | Empty upper-tube placeholder | No objects |
| 4 | ABS lower, middle, upper tubes and flange | Tube heights 311.4, 320, and 291.4 mm; 20 mm flange spigot; flange supports retained |
| 5 | TPU nose | Hollow 1.2 mm shell, internal tree support, 5 mm brim |
| 6 | ABS fit coupons | Base socket, male/female tube joint, and nose neck |
| 7 | TPU nose socket coupon | Full 25 mm engagement and stop; 26.2 mm tall; no full dome; inspect support preview |

`PingPongParachute-Fins.3mf` has three separate ABS plates:

| Plate | Contents | Notes |
|---|---|---|
| 1 | Two enlarged ABS swept fins | 5% gyroid wing infill; solid root and tape tabs |
| 2 | Third enlarged ABS swept fin | Same settings as plate 1 |
| 3 | ABS fin mounting test | Solid; print before the fins |

## Print the fit checks first

Print the **flange and plates 6 and 7** before the full-height tubes.
The flange currently shares plate 4 with the tubes; print only the flange
first using an object selection or a temporary separate plate. Use the same
material, temperatures, flow, line widths, brim gap, and compensation as
the production parts. Remove brims and support remnants before measuring.

| Interface | Male outside diameter | Female inside diameter | Nominal diametral clearance | Insertion depth |
|---|---|---|---|---|
| Lower/middle and middle/upper tube joints | 11.50 mm | 11.60 mm | 0.10 mm | 20 mm |
| Flange spigot / lower tube | 17.50 mm | 17.60 mm | 0.10 mm | 20 mm |
| Upper tube neck / TPU nose | 18.40 mm | 18.10 mm | -0.30 mm (interference) | 25 mm |

These are nominal CAD dimensions, not measured printed fits. The male-only
enlargement reduces the previous 0.50 mm diametral gaps to 0.10 mm after
the earlier connections were reported loose. The rigid fits and elastic nose fit are
not yet validated in ABS/TPU; actual shrinkage can change the result.
Keep factory shrink compensation and XY compensation unchanged until the
coupons establish a need; do not guess a scale factor for individual parts.

The two rigid joint coupons must slide fully together until the rims meet.
The base coupon must seat on the flange panel over the full 20 mm spigot,
without its bore taper obstructing insertion. The nose neck coupon must
reach the TPU stop without forcing or splitting the collar. Its shoulder
must not prevent seating. The rigid connections remain clearance fits;
the nose is a trial elastic interference fit. **External tape is still
required for retention**; the nose stop is not a latch. Test the socket
coupon before the full nose. Do not force an overly tight TPU collar.

If all fits are too tight, reduce `male_diameter_increase` in
`PingPongParachute-Cylinder.scad`, re-export all affected production parts
and coupons, and replace their project meshes before slicing again.
The increase is a **total diameter** change. The three radial-clearance
parameters describe the original **per-side** gaps before that enlargement:
effective diametral gap = `2 * radial_clearance - male_diameter_increase`.
The joint and flange clearance parameters affect only their male spigots;
`socket_radial_clearance` changes only the female nose hole; its new 0.05 mm
value produces the 18.10 mm socket. Adjust it independently for nose fit
without changing any ABS connector. Do not change only the test mesh.

For the ABS trial, retain the **1.6 mm main tube walls** while evaluating
thinner options separately. Thinning saves weight but reduces bending
and local-buckling resistance. Neither thickness is flight-qualified; added
stiffness does not establish launch or impact strength.

## Reinforcement after the failed prints

The three main tube skins are now **1.6 mm**, reduced by 0.2 mm from the
reinforced 1.8 mm version and still thicker than the original 0.9 mm. The base
wall is **2.8 mm** instead of 1.4 mm, female joint walls are **2.4 mm**
instead of 1.2 mm, and male spigot walls are **2 mm** instead of 1 mm.
The flange's locating spigot wall is also doubled to **2.8 mm**.
The joint outside diameter increases from 14 to **16.4 mm**, and the
base outside diameter from 20.4 to **23.2 mm**. This preserves the mating
female diameters rather than weakening the male spigots by shrinking
their outside diameter. The subsequent male-only fit revision reduces
the original 0.50 mm diametral gaps to the 0.10 mm values above.
Tube-joint engagement remains 20 mm and assembled lengths remain 900/600 mm.
The flange engagement remains 20 mm and nose engagement is extended to 25 mm.
The lower and upper tube print heights each increase by 8.5 mm relative
to the 8 mm nose-engagement revision to preserve assembled lengths.
The middle tube remains 320 mm tall. The upper shoulder transitions are
anchored to the neck base rather than its tip to preserve their shape
when the neck grows.
The 34 mm flange now leaves a **5.4 mm radial tape ledge** around the base.
Use the regenerated fit coupons, not the older thin-wall prints.

The TPU nose remains a **hollow 40 mm ball**, trimmed to 36 mm print height.
Its spherical wall is now **1.2 mm**, reduced from 1.6 mm, to
reduce rigidity while retaining the hollow center. **100% infill applies
to that shell and its mounting collar, not to the hollow center.** The
18.10 mm mounting socket has 0.30 mm interference over 25 mm engagement;
the seating stop height remains 1.2 mm, but its position moves to match
the longer neck. Local socket
transitions do not have uniform spherical-wall thickness.

The nose retains internal tree support because its inner spherical dome
is not self-supporting. Support top/bottom Z separation is increased from
0.3 to **0.4 mm**, and dense top interface layers are disabled to reduce
TPU-to-TPU bonding. These are trial separation settings: they may leave a
rougher inner dome, and do not guarantee easy support removal.
Remove all support through the **16.90 mm stop opening** before fitting
the nose. The longer 25 mm collar makes that access deeper; inspect tree
branches for removability rather than assuming the former setup still works.
If support cannot be removed without damaging the shell, do
not force assembly; a split nose or a self-supporting inner roof would
require another geometry revision.

These changes are not a strength or rebound certification. A thinner TPU
shell may dent, buckle, tear, or remain inverted after impact. Evaluate
the 1.2 mm shell before trying 1.0 mm or less. Use ABS with the ABS profile,
not the former ASA Aero 0.52 flow profile. Dry the
filament and check a short coupon for continuous extrusion and layer
bonding before spending material on another 320 mm tube. Added thickness
cannot compensate for wet filament, incorrect material settings, poor
bonding, or bad bed adhesion. Do not change flow or scale by guesswork.

## Center of mass: check the dry assembled rocket

**Historical reference only:** all mass and balance estimates in this section
predate the ABS switch, 1.2 mm nose, and tighter socket. They are not current
ABS/TPU estimates. Re-slice and weigh the new parts before assessing balance.

The 1.6 mm hollow nose is estimated at **9.6 g** using the retained
TPU 95A profile's density, compared with 16.2 g for the previous 3.2 mm
shell. The following reference table assumes **ASA Aero tubes/flange
and a TPU 95A nose**, using factory flow ratios (0.52 and 1.00) and
filament densities (0.99 and 1.22 g/cm3). These are CAD material-volume
estimates, not the current all-TPU tube configuration, measured weights or
whole-job slicer weights. They exclude removed supports/brims, bottle,
fins, tape, parachute, payload, and water; foaming and toolpaths can change
actual mass.

The customized nose plate contains several noses and fins. Its job total
includes those copies, support, brims and purging, not just one retained
nose. A flying assembly uses one nose, not every copy on the plate.

| Extension part | Estimated printed mass | Center above bottle-base mounting plane, 900 mm version |
|---|---|---|
| Lower tube | 13.3 g | 134 mm |
| Middle tube | 10.1 g | 443 mm |
| Upper tube | 9.5 g | 728 mm |
| Flange | 1.7 g | 5.5 mm |
| Hollow 1.6 mm TPU nose | 9.6 g | 880 mm |

These mass estimates predate the +0.4 mm male-connector revision; re-slice
for current estimates and use measured masses for balance.

The coordinate origin is the **bottle-base/flange mounting plane**, not
the bottle mouth. Positive positions point along the pipes toward the
nose; most bottle-side components have negative positions. The end of
the lower tube's main body is **288.1 mm** above this plane, excluding
its male joint's insertion length in that historical reference. The current
lower tube's main-body rim is **297.6 mm** above the mounting plane.

For illustration only, assume the combined bottle-side assembly has its
center **110 mm below the flange** (the midpoint of the unmeasured
220 mm example bottle). This is not a claim about the real bottle's
center of mass:

| Configuration | Extension mass | Extension-only center | Minimum bottle-side mass for center within lower tube | Minimum bottle-side mass for center within bottle |
|---|---|---|---|---|
| ASA Aero tubes/flange, TPU nose, 900 mm | 44.2 g | 489 mm above flange | 22.3 g | 197 g |
| ASA Aero tubes/flange, TPU nose, 600 mm | 34.1 g | 335 mm above flange | 4.1 g | 104 g |
| All TPU 95A reference, 900 mm | 91.6 g | 433 mm above flange | 33.4 g | 361 g |
| All TPU 95A reference, 600 mm | 67.6 g | 288 mm above flange | 0 g nominally | 177 g |

The all-TPU rows use the retained TPU 95A profile's density and flow,
including TPU for the flange. They are **not calibrated TPU 98 estimates**.
The compact all-TPU extension's nominal center is only about 0.6 mm
inside the lower-tube limit without a bottle: this is not a useful
manufacturing or flight-safety margin.

These are **total bottle-side assembly masses**, not instructions to add
that much ballast. Their assumed location is essential. For example,
with the ASA Aero/TPU reference extension, 30 g centered 110 mm below
the flange predicts a 247 mm balance point, inside the lowest tube;
20 g predicts 302 mm, beyond that tube's main-body rim.
For the full all-TPU reference, 40 g at that location predicts 268 mm,
whereas 30 g predicts 299 mm. Moving the same mass closer to the flange
can fail the target.

Use actual dry part masses and their axial centers:
`z_CG = sum(mass * position) / sum(mass)`. For a lower assembly with mass
`m_b` and center `z_b`, an extension of mass `M` and first moment `S`
meets an upper balance limit `z_target` only if
`m_b >= max(0, (S - M * z_target) / (z_target - z_b))`, with
`z_b < z_target`. The ASA Aero/TPU reference extension moments are
**21,600 g*mm** for 900 mm and **11,408 g*mm** for 600 mm; the all-TPU
reference moments are **39,671 g*mm** and **19,445 g*mm**, respectively.

**Bottle-side balance is not yet verified.** Weigh and gently balance the
empty, fully assembled rocket with its actual fins, tape, payload and
parachute, using a broad padded support. Check both launch and recovery
configurations; do not count launch water as permanent balancing mass.
If the full version misses the target, the already-compatible two-tube
version reduces top weight and leverage without adding ballast.
Do not add heavy ballast by guesswork. A lower center of mass is not
proof of launch stability, upright descent, or impact safety; aerodynamic
center of pressure and parachute deployment still require evaluation.

## Before sending a production plate

The body/nose geometry revision invalidates its affected plate caches.
**Re-slice occupied plates in Bambu Studio before printing.** Affected
cached previews/toolpaths have been removed from both projects.
Plate 2 now holds TPU nose copies; plate 3 remains empty.
The separate fin project also requires fresh ABS slicing.
Inspect the full layer preview before sending a job, and re-slice after
any settings, mesh, or nozzle changes. Check continuous
1.2 mm spherical nose walls and 1.6 mm main tube skins, connected joint roots,
open bores, correct material and right-hotend mapping, bed adhesion, and a maximum height below
the selected hotend's limit. Successful slicing does not verify physical
fit, bed adhesion, strength, or support removability.

The hollow spherical nose needs dome support. Ensure the generated tree
support can be removed through the socket's **16.90 mm stop opening**.
Same-material TPU support may be difficult to remove; do not print the
full nose if preview shows inaccessible branches or fused contact regions.
The socket coupon verifies fit, not dome printability or support removal.
Remove all nose supports before assembly. Remove flange supports without
changing the bottle-contact contour.

The flange assumes a 68 mm, five-foot bottle bottom; its contour is not a
scan of your bottle. Verify actual bottle seating and strap clearance.
Do not modify or damage a pressurized bottle. The assembled lengths remain
900 mm, or 600 mm without the middle tube. Watertight CAD meshes do not
establish launch strength, tape adhesion, impact survival, or event-rule
compliance; progressive physical testing is still required.

Manufacturer references:
[ASA Aero](https://us.store.bambulab.com/products/asa-aero),
[H2C filament guide](https://wiki.bambulab.com/en/h2c/h2c-filament-printing-guide).

## Three swept bottle fins

`PingPongParachute-Fin.scad` exports `PingPongParachute-Fin.stl` and
`PingPongParachute-FinMountTest.stl`. Select `part="assembly"` in OpenSCAD
to preview three identical fins spaced **120 degrees** around a reference
barrel. That barrel is a contact envelope, not a model of the complete bottle.

The fin follows the black-lined outline in the latest reference photo:
a smooth **S-curved swept outer edge**, narrower through the middle and
fuller toward a rounded lower tip, with a straight bottom edge. It has a
nominal **114.3 mm bottom edge** and a **150 mm bottle-facing root**.
The planform is enlarged by **150/84 = 1.786 times** from the earlier
84 x 64 mm design. The web is now **2 mm thick throughout**: there is no
top-to-bottom wedge. The opposite print face remains flat.

Two curved **rounded rectangular** tabs extend from **only one side** of
the fin. Each is **40 mm tall along the root**, projects **20 mm sideways
from the fin's center plane**, and has **0.8 mm wall thickness**.
One tab is at the top of the root and one at the bottom; the middle has no
tab. The larger tabs retain their original thin walls; they are not made
2 mm thick with the web.

The upstream and downstream tab edges taper to **0.6 mm over 5.36 mm**
to reduce the raised step under the tape. Fin planform corners have
**3.57 mm** rounding and tab corners **1.43 mm**. The exposed wing edges
have **0.8 mm three-dimensional rounding**, increased from 0.2 mm for a
smoother edge profile; tab edges retain **0.2 mm** rounding to preserve
their thin walls. The swept curve also uses twice as many samples.
Rounding trims the sharp outline tips; 114.3 mm and 150 mm are nominal
planform dimensions.
Inspect actual prints for burrs and damaged edges. Rounded plastic can
still injure someone; keep people clear of launch and recovery areas.

The larger fins add area and mass, **not a proven aerodynamic benefit**.
Extra tail mass can shift the center of mass rearward and does not
guarantee stability. A constant-thickness rounded plate is not a validated
airfoil or a CFD-validated drag improvement. Smooth tape edges, axial
alignment, and equal 120-degree spacing remain important. The larger tabs
still have thin 0.8 mm walls; more attachment area does not establish
impact strength. Verify them with the mounting test.
The 3 mm cardboard used on a hand-built rocket is a dimensional reference,
not evidence that these 2 mm ABS fins have equivalent stiffness.
The curved outline removes abrupt changes in edge direction, but it is
not proof of lower drag than a straight triangular fin. The wing has no
axial thickness taper, and its tape tabs remain one-sided. Whole-rocket center
of mass and center of pressure, stiffness and flight testing determine
whether this planform is suitable; three identical fins must be aligned.

**The bottle dimensions are not yet measured.** The file uses an explicitly
editable **220 mm example bottle height**, an independent 150 mm root, and a
nominal **68 mm cylindrical barrel** matching the earlier bottle-diameter
assumption. These are placeholders, not a verified contour fit or a claim
that the bottle is 220 mm tall.

Assembly coordinates measure from the **mouth/nozzle plane**, toward the
bottle base. The provisional fin and both tabs occupy **60-210 mm** from
that plane, leaving the lowest point 60 mm above it and exceeding the
required 55 mm clearance. The previous 100 mm start would place the
150 mm root beyond the example bottle's base, so the default start moves
to 60 mm. **This may reach the bottle shoulder; it is not a verified
barrel fit.** Measure the complete longer contact region before printing.
The 114.3 mm dimension is radial span, not distance from the mouth.

Before printing production fins, enter the actual `bottle_height` and set
`root_start` to put the mounting edge on the intended bottle surface.
Keep `root_start > 55` and `root_start + root_length <= bottle_height`.
Replace `bottle_profile` with measured `[axial_distance, diameter]` stations
along that mounting edge: the first distance is zero and the last is
`root_length`. Intermediate stations can describe a waist or shoulder.
Both the root and curved tabs follow these measurements, with 0.3 mm radial
clearance. Re-export **both** meshes and replace their project objects after
changing the source; the fin project includes three copies of the same fin mesh.
Its solid-root modifiers cover the first 10.7 mm outside the nominal barrel
contact edge; reposition or reshape these modifiers if the bottle contour changes.

Print **fin-project plate 3 first**, hold its full mounting edge against the bottle,
and check both curved tab locations without bending or forcing the fit.
If the reference bottle is not cylindrical at these locations, update the
profile rather than bridging a large gap with tape. Once the mounting test
fits, print fin-project plates 1 and 2 and install the three fins at 120-degree spacing with
their bottom edges level and their planes parallel to the bottle axis.
Apply Scotch tape over each tab and onto clean adjacent bottle surface;
keep tape and all printed material clear of the launcher.

Print the fins flat with tabs upward. The fin
objects use **5% gyroid infill**, two wall loops and two top/bottom
layers at 0.20 mm layer height. A **100% infill modifier with three wall
loops** reinforces the full **10.7 mm-wide bottle-facing root band** and both
tape tabs. The mounting-test coupon is entirely solid. The 2 mm wing
still needs solid skins, so 5% infill does not mean 95% less fin weight.
All three fin-project plates use only ABS slot 1; the retained TPU
slot is unused. The enlarged fins are split across two production plates
to leave room for their brims rather than squeezing three into one row.
Historical ASA Aero slicing estimated **12.42 g** for the two-fin plate, **6.22 g** for
the third-fin plate, and **2.21 g** for the mounting-test plate, including
brims. These are not current ABS weights; re-slice for new estimates.
Repeat the dry assembled balance check with these enlarged fins; the
extension-only mass table above does not include them.
The thin ABS attachment tabs can bend or break; no flight-load or
tape-retention rating is established. The photo and these dimensions do not establish
aerodynamic stability. Check event rules, launcher clearance, tape adhesion,
fin rigidity, and controlled-flight behavior before use. Never drill, heat,
cut, or otherwise damage the pressurized bottle.
