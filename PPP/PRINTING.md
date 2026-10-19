# H2C printing and fit checks

The original material reference uses **Bambu ASA Aero** for the three
tubes, flange, fins, and rigid fit coupons, and **Bambu TPU 95A** for the
nose and its socket coupon. The customized TPU trial is described below.
ASA Aero is a
foaming material, not ABS or ordinary ASA. The TPU profile is for regular
95A, not 95A HF or TPU for AMS.

## Project setup

**Current customized body/nose project:** the 1.6 mm revision preserves
your existing plate settings, material profiles, object copies and
positions, including the empty placeholder plates. Production tubes,
flange, noses and the fins copied into this project remain assigned to
the **Bambu TPU 95A** profile; the rigid fit coupons retain **Generic ABS**.
No TPU 98-specific profile has been selected or calibrated. Existing
plate titles are also preserved and may mention the previous wall sizes.
The ABS-assigned coupons do not establish how TPU tube joints will fit
or flex. To validate a TPU trial, print its joint coupons in the actual
tube material using the appropriate profile; assignments are not changed
automatically by this geometry-only revision.
The ASA Aero/right-hotend setup and seven-plate table below describe the
original reference configuration, not the current customized arrangement.
The separate `PingPongParachute-Fins.3mf` remains unchanged in ASA Aero.

`PingPongParachute.3mf` targets the H2C with 0.4 mm nozzles and 0.20 mm
layers. Each plate uses only the **right hotend**, including the 320 mm
middle tube; the configured right-side height limit is 325 mm. No parts
are scaled. There is no prime tower. Hollow body parts use zero sparse
infill. Fins have a separate `PingPongParachute-Fins.3mf` H2C project,
with light wing infill and solid mounting reinforcement.

| Filament slot | Material | Nozzle | Textured PEI bed | Chamber | Flow ratio | Max volumetric speed |
|---|---|---|---|---|---|---|
| 1 | Bambu ASA-Aero, H2C 0.4 mm factory profile | 270 C | 90 C | 60 C | 0.52 | 12 mm3/s |
| 2 | Bambu TPU 95A, H2C 0.4 mm factory profile | 230 C | 35 C | Off | 1.00 | 3.6 mm3/s |

Both slots map to the right hotend, on **separate print jobs**. Load the
appropriate material for each job. Feed regular TPU 95A from the external
spool, **not the AMS**. Let the chamber cool before a TPU job. Dry both
filaments according to their spool/manufacturer instructions. Use
appropriate ventilation for ASA printing and a TPU-compatible release
layer on the plate.

The body/nose project uses Arachne, four wall loops, an 8 mm outer brim, reduced
wall speeds (35 mm/s outer, 50 mm/s inner), and reduced acceleration for
the tall, narrow tubes. These are conservative starting settings, not a
substitute for checking actual foaming and layer bonding.

| Plate | Contents | Notes |
|---|---|---|
| 1 | TPU nose | Hollow 1.6 mm shell, 100% shell infill; opening down; internal tree support; 5 mm brim |
| 2 | ASA Aero middle tube | Female socket down; 320 mm tall |
| 3 | ASA Aero upper tube | Nose neck down; 281.9 mm tall |
| 4 | ASA Aero lower tube | Base down; 301.9 mm tall |
| 5 | ASA Aero flange | Bottle-contact side down; automatic normal supports beneath the contours |
| 6 | ASA Aero fit coupons | Base socket, male/female tube joint, and nose neck |
| 7 | TPU nose socket coupon | Includes the actual socket stop; no dome or support needed |

`PingPongParachute-Fins.3mf` has three separate ASA Aero plates:

| Plate | Contents | Notes |
|---|---|---|
| 1 | Two enlarged ASA Aero swept fins | 5% gyroid wing infill; solid root and tape tabs |
| 2 | Third enlarged ASA Aero swept fin | Same settings as plate 1 |
| 3 | ASA Aero fin mounting test | Solid; print before the fins |

## Print the fit checks first

Print plates **5, 6, and 7** before the full-height tubes. Use the same
material, temperatures, flow, line widths, brim gap, and compensation as
the production parts. Remove brims and support remnants before measuring.

| Interface | Male outside diameter | Female inside diameter | Nominal diametral clearance | Insertion depth |
|---|---|---|---|---|
| Lower/middle and middle/upper tube joints | 11.10 mm | 11.60 mm | 0.50 mm | 20 mm |
| Flange spigot / lower tube | 17.10 mm | 17.60 mm | 0.50 mm | 6 mm |
| Upper tube neck / TPU nose | 18.00 mm | 18.50 mm | 0.50 mm | 6 mm |

These are nominal CAD dimensions, not measured printed fits. The original
clearances are retained: there is no evidence yet that a different gap is
needed. ASA Aero's foaming and actual shrinkage can change the result.
Keep factory shrink compensation and XY compensation unchanged until the
coupons establish a need; do not guess a scale factor for individual parts.

The two rigid joint coupons must slide fully together until the rims meet.
The base coupon must seat on the flange panel. The nose neck coupon must
reach the TPU stop without forcing or splitting the collar. Its shoulder
must not prevent seating. All three are clearance fits and **require
external tape for retention**; the nose stop is not a latch.

If a fit is wrong, tune `joint_radial_clearance`,
`flange_radial_clearance`, or `socket_radial_clearance` in
`PingPongParachute-Cylinder.scad`, re-export all affected production parts
and coupons, and replace their project meshes before slicing again.
Clearances are **per side**. Do not change only the test mesh.

## Reinforcement after the failed prints

The three main tube skins are now **1.6 mm**, reduced by 0.2 mm from the
reinforced 1.8 mm version and still thicker than the original 0.9 mm. The base
wall is **2.8 mm** instead of 1.4 mm, female joint walls are **2.4 mm**
instead of 1.2 mm, and male spigot walls are **2 mm** instead of 1 mm.
The flange's locating spigot wall is also doubled to **2.8 mm**.
The joint outside diameter increases from 14 to **16.4 mm**, and the
base outside diameter from 20.4 to **23.2 mm**. This preserves the mating
diameters and 0.50 mm diametral gaps in the table above, rather than
weakening the male spigots by shrinking their outside diameter.
All insertion depths and the 900/600 mm assembled lengths are unchanged.
The 34 mm flange now leaves a **5.4 mm radial tape ledge** around the base.
Use the regenerated fit coupons, not the older thin-wall prints.

The TPU nose remains a **hollow 40 mm ball**, trimmed to 36 mm print height.
Its spherical wall is now **1.6 mm**, half the previous 3.2 mm shell, to
reduce rigidity while retaining the hollow center. **100% infill applies
to that shell and its mounting collar, not to the hollow center.** The
18.50 mm mounting socket and seating stop remain unchanged. Local socket
transitions do not have uniform spherical-wall thickness.

The nose retains internal tree support because its inner spherical dome
is not self-supporting. Support top/bottom Z separation is increased from
0.3 to **0.4 mm**, and dense top interface layers are disabled to reduce
TPU-to-TPU bonding. These are trial separation settings: they may leave a
rougher inner dome, and do not guarantee easy support removal.
Remove all support through the **17.30 mm stop opening** before fitting
the nose. If support cannot be removed without damaging the shell, do
not force assembly; a split nose or a self-supporting inner roof would
require another geometry revision.

These changes add material, not a strength certification. ASA Aero remains
a foamed material. Check the actual spool is **Bambu ASA Aero**, not ABS;
the retained 270 C / 0.52 flow profile is specific to ASA Aero. Dry the
filament and check a short coupon for continuous extrusion and layer
bonding before spending material on another 320 mm tube. Added thickness
cannot compensate for wet filament, incorrect material settings, poor
bonding, or bad bed adhesion. Do not change flow or scale by guesswork.

## Center of mass: check the dry assembled rocket

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

The coordinate origin is the **bottle-base/flange mounting plane**, not
the bottle mouth. Positive positions point along the pipes toward the
nose; most bottle-side components have negative positions. The end of
the lower tube's main body is **288.1 mm** above this plane, excluding
its male joint's insertion length.

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
**Re-slice occupied plates in Bambu Studio before printing.** Empty
placeholder plates and all your current plate settings are retained.
Occupied layouts were checked in a temporary copy without changing the
saved layout. The separate fin project's saved slicing is unchanged.
Inspect the full layer preview before sending a job, and re-slice after
any settings, mesh, or nozzle changes. Check continuous
1.6 mm spherical nose walls and 1.6 mm main tube skins, connected joint roots,
open bores, correct material and right-hotend mapping, bed adhesion, and a maximum height below
the selected hotend's limit. Successful slicing does not verify physical
fit, bed adhesion, strength, or support removability.

The hollow spherical nose needs dome support. Ensure the generated tree
support can be removed through the socket's **17.30 mm stop opening**.
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
not evidence that these 2 mm foamed-ASA fins have equivalent stiffness.
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
All three fin-project plates use only ASA Aero slot 1; the retained TPU
slot is unused. The enlarged fins are split across two production plates
to leave room for their brims rather than squeezing three into one row.
Bambu Studio estimates **12.42 g** for the two-fin plate, **6.22 g** for
the third-fin plate, and **2.21 g** for the mounting-test plate, including
brims. These are slicer estimates, not measured foamed-part weights.
Repeat the dry assembled balance check with these enlarged fins; the
extension-only mass table above does not include them.
The thin foamed-ASA attachment tabs can bend or break; no flight-load or
tape-retention rating is established. The photo and these dimensions do not establish
aerodynamic stability. Check event rules, launcher clearance, tape adhesion,
fin rigidity, and controlled-flight behavior before use. Never drill, heat,
cut, or otherwise damage the pressurized bottle.
