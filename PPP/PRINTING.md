# H2C printing and fit checks

Use **Bambu ASA Aero** for the three tubes, flange, fins, and rigid fit coupons;
use **Bambu TPU 95A** for the nose and its socket coupon. ASA Aero is a
foaming material, not ABS or ordinary ASA. The TPU profile is for regular
95A, not 95A HF or TPU for AMS.

## Project setup

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

The project uses Arachne, two wall loops, an 8 mm outer brim, reduced
wall speeds (35 mm/s outer, 50 mm/s inner), and reduced acceleration for
the tall, narrow tubes. These are conservative starting settings, not a
substitute for checking actual foaming and layer bonding.

| Plate | Contents | Notes |
|---|---|---|
| 1 | TPU nose | Opening down; automatic tree supports, including the internal dome; 5 mm brim |
| 2 | ASA Aero middle tube | Female socket down; 320 mm tall |
| 3 | ASA Aero upper tube | Nose neck down; 281.9 mm tall |
| 4 | ASA Aero lower tube | Base down; 301.9 mm tall |
| 5 | ASA Aero flange | Bottle-contact side down; automatic normal supports beneath the contours |
| 6 | ASA Aero fit coupons | Base socket, male/female tube joint, and nose neck |
| 7 | TPU nose socket coupon | Includes the actual socket stop; no dome or support needed |

`PingPongParachute-Fins.3mf` has two separate ASA Aero plates:

| Plate | Contents | Notes |
|---|---|---|
| 1 | Three ASA Aero swept fins | 5% gyroid wing infill; solid root and tape tabs |
| 2 | ASA Aero fin mounting test | Solid; print before the fins |

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

## Before sending a production plate

The seven body/nose plates and the two separate fin plates were sliced
and saved by the installed Bambu Studio 2.8.2.61 with no reported slicing
warnings. Both projects include native G-code and regenerated thumbnails.
Inspect the full layer preview before
sending a job, and re-slice after any settings, mesh, or nozzle changes.
Check continuous
0.8 mm TPU and 0.9 mm ASA skins, connected joint roots, open bores, correct
material and right-hotend mapping, bed adhesion, and a maximum height below
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
nominal **64 mm bottom edge** and an **84 mm bottle-facing root**.
Thickness changes **continuously over the full fin height,
from 1 mm at the top to 2.4 mm at the bottom**. It is a long, shallow wedge
in side view, not a short reinforced band. Extra thickness is added on only
one side, keeping the opposite print face flat.

Two curved **rounded rectangular** tabs extend from **only one side** of
the fin. Each is **20 mm tall along the root**, projects **5 mm sideways
from the fin's center plane**, and has **0.8 mm wall thickness**.
One tab is at the top of the root and one at the bottom; the middle has no
tab. The 20 mm tab height follows the revised request; the 5 mm dimension
is its sideways extension.

The upstream and downstream tab edges taper to **0.6 mm over 3 mm** to
reduce the raised step under the tape. Fin planform corners have **2 mm**
rounding, tab corners **0.8 mm**, and exposed three-dimensional edges
approximately **0.2 mm** rounding. Rounding trims the sharp triangle tips;
the 64 mm and 84 mm dimensions describe the nominal outline.
Inspect actual prints for burrs and damaged edges. Rounded plastic can
still injure someone; keep people clear of launch and recovery areas.

The thicker bottom adds weight and stiffness, **not a proven aerodynamic
benefit**. Extra tail mass can shift the center of mass rearward and does
not guarantee stability. This wedge is not a validated airfoil or a
CFD-validated drag improvement. Smooth tape edges, axial alignment, and equal
120-degree spacing remain important. The thinner tabs also have less
material for retention; verify them with the mounting test rather than
assuming the original strength.
The 3 mm cardboard used on a hand-built rocket is a dimensional reference,
not evidence that these thinner foamed-ASA fins have equivalent stiffness.
The curved outline removes abrupt changes in edge direction, but it is
not proof of lower drag than a straight triangular fin. The taper remains
one-sided for flat printing, not a symmetric airfoil. Whole-rocket center
of mass and center of pressure, stiffness and flight testing determine
whether this planform is suitable; three identical fins must be aligned.

**The bottle dimensions are not yet measured.** The file uses an explicitly
editable **220 mm example bottle height**, an independent 84 mm root, and a
nominal **68 mm cylindrical barrel** matching the earlier bottle-diameter
assumption. These are placeholders, not a verified contour fit or a claim
that the bottle is 220 mm tall.

Assembly coordinates measure from the **mouth/nozzle plane**, toward the
bottle base. The default fin and both tabs occupy **100-184 mm** from that
plane, so their lowest point is 100 mm above it, exceeding the required
55 mm clearance. This conservative placement avoids guessing the shoulder
shape. The 64 mm dimension is the fin's radial bottom-edge length, **not**
its distance from the mouth.

Before printing production fins, enter the actual `bottle_height` and set
`root_start` to put the mounting edge on the intended bottle surface.
Keep `root_start > 55` and `root_start + root_length <= bottle_height`.
Replace `bottle_profile` with measured `[axial_distance, diameter]` stations
along that mounting edge: the first distance is zero and the last is
`root_length`. Intermediate stations can describe a waist or shoulder.
Both the root and curved tabs follow these measurements, with 0.3 mm radial
clearance. Re-export **both** meshes and replace their project objects after
changing the source; the fin project includes three copies of the same fin mesh.
Its solid-root modifiers cover the first 6 mm outside the nominal barrel
contact edge; reposition or reshape these modifiers if the bottle contour changes.

Print **fin-project plate 2 first**, hold its full mounting edge against the bottle,
and check both curved tab locations without bending or forcing the fit.
If the reference bottle is not cylindrical at these locations, update the
profile rather than bridging a large gap with tape. Once the mounting test
fits, print fin-project plate 1 and install the three fins at 120-degree spacing with
their bottom edges level and their planes parallel to the bottle axis.
Apply Scotch tape over each tab and onto clean adjacent bottle surface;
keep tape and all printed material clear of the launcher.

Print the fins flat with tabs and the slanted face upward. The fin
objects use **5% gyroid infill**, two wall loops and two top/bottom
layers at 0.20 mm layer height. A **100% infill modifier with three wall
loops** reinforces the full **6 mm-wide bottle-facing root band** and both
tape tabs. The mounting-test coupon is entirely solid. The 1-2.4 mm wing
still needs solid skins, so 5% infill does not mean 95% less fin weight.
Bambu Studio estimates **5.82 g for the three-fin plate**, including
brims, and **0.59 g for the mounting-test plate**.
These are slicer estimates, not measured foamed-part weights. Both fin
plates use only ASA Aero slot 1; the retained TPU slot is unused.
The thin foamed-ASA attachment tabs can bend or break; no flight-load or
tape-retention rating is established. The photo and these dimensions do not establish
aerodynamic stability. Check event rules, launcher clearance, tape adhesion,
fin rigidity, and controlled-flight behavior before use. Never drill, heat,
cut, or otherwise damage the pressurized bottle.
