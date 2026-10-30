# H2C printing and fit checks

## PPP cylinder V4: measured five-foot flange and hollow alignment cup

V4 keeps the **50 mm central TPU flange** and its working pipe connection,
and adds a separate **Bambu PLA Tough+ hollow cone/cup** around the bottle bottom.
**Upper and flange stay TPU for AMS; cup, lower and middle pipes use
Bambu PLA Tough+.** Retain the TPU flange following the reported PETG
flange fractures during drop experiments; this is not an impact rating
for either the TPU flange or the PLA Tough+ parts.
The broad bottle skirt and tapered pipe guide provide two separated
centering locations instead of relying on tape over a small flexible flange.
The pipe seats fully on the flange at the bottle's bottom center. The cup
is a **separate, full-360-degree alignment brace**, not a second bottom
seat or a spacer under the pipe. Its cone and bottle skirt are complete
circles; four equally spaced slots are confined to the small pipe guide.
This is a printable **measured approximation for dry-fitting**, not a
scanned contour or a physically proven anti-tilt mount.

The bottle is **Signature SELECT Strawberry Watermelon
Sparkling Water, 1 L (33.8 fl oz), UPC 021130253029**, manufactured by
**Better Living Brands LLC**, with this
[supplied Safeway product link](https://www.safeway.com/shop/product-details.960042854.html).
The supplied photographs/caliper measurements give approximately **83-84 mm
bottom diameter, five 22-23 mm feet, 8.6-9 mm grooves and 9 mm maximum
recess depth**. The smooth model uses 84 / 22.5 / 8.8 mm respectively,
interpreting widths as chords at the nominal bottle circle. Radial curvature
and transitions between the feet remain approximations.

With the bottle inverted for launch, its feet define Z=0 and the center
and grooves recess **below** that plane. The flange follows this
orientation, using **8.7 mm intrusion** into the reported 9 mm recess
(0.3 mm relief). The central flange has a flat pipe-facing surface; the
lower pipe's bottom rests directly on it with the original 20 mm spigot
fully inserted. The cup has **no internal annular seat, shelf or flange
connection**: its skirt surrounds the bottle, and its upper guide braces
the pipe without lifting it off the central flange.

| Feature | V4 dimension |
|---|---|
| Central flange OD | 50 mm, unchanged |
| Bottle skirt ID / maximum cup outside diameter | 84.6 / 87.0 mm |
| Bottle skirt height | 19.62 mm (12 mm + 0.3 inch / 7.62 mm) |
| Hollow conical section height | 42 mm |
| Tapered pipe guide height | 12 mm |
| Cup overall print height | 75.82 mm; cone starts 2.2 mm above the bottle feet |
| Skirt / cone / pipe guide wall | 1.2 mm; cone measured normal to its slope |
| Guide radial clearance / relief slots | 0.25 mm / four 1.2 mm slots |
| Guide position above the lower pipe's physical bottom | 47.6-59.6 mm |
| Flange spigot OD / lower socket ID / engagement | 17.50 / 17.60 / 20 mm, unchanged |

The skirt extends 7.62 mm farther down the bottle for more tape overlap.
The assembled cone and guide positions, diameters and 1.2 mm walls are
unchanged; only the skirt and its matching fit ring are longer.

Use the **unchanged V2 lower and V2 middle pipes**, not the shorter V3
middle. Each V2 middle is 320 mm physically and adds 300 mm assembled;
the new PLA Tough+ project prints these same geometries, without scaling
the connectors. Existing V2 parts remain geometrically compatible, but
check the printed fit when changing materials. The short V4 TPU upper
retains V3's 100 mm length and 11.60 mm female socket / 20 mm engagement,
with the rounded tip enlarged exactly **30 to 33 mm diameter**. Check
that head with the actual standard soda-bottle cap used at the event;
the change is not a compliance certification. None of the slip joints
is a latch: retain them with external tape.

### Print projects and fit-first sequence

All four projects are separate, editable **H2C right 0.4 mm hotend** jobs.
Open them in Bambu Studio and re-slice/review for the actual machine.
These are not printer-ready Gcode archives, and no job has been sent.

| Project / plate | Material | Slicer estimate including supports/brim |
|---|---|---|
| `PPP-Cylinder-V4-Cup-PLA-ToughPlus.3mf`, plate 1: bottle ring + tapered guide | Bambu PLA Tough+ | 9.0 g / 54 min |
| Same project, plate 2: full hollow cup | Bambu PLA Tough+ | 23.6 g / 2 h 4 min |
| `PPP-Cylinder-V4-Pipes-PLA-ToughPlus.3mf`, plate 1: V2 lower + flange-socket fit coupon | Bambu PLA Tough+ | 42.3 g / 4 h 54 min |
| Same project, plate 2: ten V2 middles, one connected 40-degree fixture | Bambu PLA Tough+ | 635.7 g / 73 h 1 min |
| `PPP-Cylinder-V4-Flange-TPU.3mf`: contoured 50 mm flange | Bambu TPU for AMS | 9.6 g / 1 h 5 min |
| `PPP-Cylinder-V4-Upper-TPU.3mf`: short 33 mm-tip upper | Bambu TPU for AMS | 14.4 g / 1 h 46 min |

The mounting projects use 0.20 mm model layers, four walls, 0% sparse
infill, 6 mm outer brims, and conservative 300/500 mm/s2 outer/default
acceleration. PLA Tough+ uses the installed **`Bambu PLA Tough+ @BBL H2C`**
profile, compatible with the H2C 0.4 mm nozzle: 245 C nozzle for all
layers, 55 C Textured PEI bed, factory flow ratio 1.00 and 1.21 g/cm3
density, with conservative 30/45 mm/s outer/inner walls. This is
**PLA Tough+**, not the separate PLA Tough or Generic PLA preset.
TPU uses 230 C nozzle,
35 C bed, 25/35 mm/s walls. Dry filament and a calibrated material profile
remain important.

The entire PLA Tough+ cup uses the **1.2 mm experimental wall thickness**:
skirt, cone and pipe guide. The cone's outer corners are offset so its
sloped wall is 1.2 mm thick perpendicular to the surface, rather than
a thinner wall from a 1.2 mm radial offset. The fit ring and guide coupon
match this revision. Start with a dry-fit and gentle tape tension; this
thin prototype may ovalize, crease or crack and should be revised after
the physical trial if needed.

**Print the PLA Tough+ cup project's plate 1 first.** The 19.62 mm ring checks the entire bottle-skirt
depth; the separate slotted guide checks the unchanged lower tube at
47.6-59.6 mm above its bottom, not at an arbitrary point on the taper.
The ring should seat without force, rocking or squeezing the bottle.
Check the full extended depth: do not force it over a wider bottle section.
The guide should slide to its intended position and allow gentle,
symmetric tape closure. If either is wrong, adjust
`bottle_diameter` / `bottle_diametral_clearance` or
`guide_radial_clearance` in SCAD, then regenerate the affected STL and
print project. Do not scale the whole cup or flange, which would alter
the other fit surfaces. The pipe project's plate 1 also includes the
original V2 flange-socket coupon: print that object alone first to test
the PLA Tough+ socket over the TPU flange's full 20 mm spigot before
committing to the full lower. Use Bambu Studio's object selection, not
scaling, to print just that coupon.

The coupons, full cup and upper print without supports. Print the cup with
its **wide bottle opening on the bed**, cone and narrow guide upward:
its 75.82 mm height and broad footprint avoid another tall pipe cantilever.
Removing the former internal five-foot annulus leaves a continuously
supported shell with a steep cone; supports are disabled for both PLA cup
plates, with no support blocker needed.
The flange prints bottle-contact side down, with local supports
and a 0.3 mm separation gap to ease TPU removal. Remove all support/brim
material before fit checks. Review the hollow cavity and both bores in
Preview; the final slices contain no extrusion through the cup's upper
cavity or flange bore. Support removal and TPU surface quality still
need a physical trial.

The PLA pipe project retains the original horizontal, diagonally oriented
V2 lower and the existing ten-middle, 40-degree connected ladder. Normal
build-plate-only supports are enabled, with blockers keeping the lower,
socket coupon and all ten middle bores clear. Cut away all 100 small
body tabs and remove the shared bracing before assembly; keep the V2
connector surfaces unchanged. The ten-pipe job is a large, approximately
three-day batch, not a first-print trial. Validate material adhesion,
bridging, clean support removal and joints before committing to it.
Original V2/V3 projects, including their historical PETG jobs, are unchanged.

### Mounting and source exports

Dry-fit on an **empty, unpressurized bottle**. Clock the flange
to the five feet/grooves. The circular cup needs no five-foot indexing.
Seat and symmetrically tape the central TPU flange first, install the
original V2 lower fully over its 20 mm spigot, and tape-retain that joint.
Slide the cup down over the lower **before installing middles/upper**,
gently settle the skirt around the bottle and adjust alignment before
securing it. Do not lift the pipe or use the cup as a load-bearing stop.
Tape around the skirt-to-bottle junction and close the slotted guide
evenly around the pipe. Uneven tape tension can still pull the assembly off axis.
Check perpendicularity in two planes and check for rocking/slipping
before adding the remaining sections.

The 50 mm flange is preserved, but the **separate cup necessarily expands
the mounting envelope to 87.0 mm**. Allow clearance around any launcher,
and check event rules. The cup adds meaningful flight mass: the 23.6 g
job estimate includes removable brim; weigh the cleaned part
and assembled rocket. The previously reported near-30-second flight
does not predict the heavier V4 assembly's flight time or stability.
Do not cut, drill, heat or otherwise modify the pressure bottle, and
do not force the printed parts onto it. Actual bottle fit, alignment,
retention, launch safety and flight performance remain unverified.

`PingPongParachute-CylinderV4.scad` defaults to an assembly preview; never
print that assembly. Keep V1/V2/V3 SCAD files beside it. Export with
`print_orientation=true` and the appropriate `part`:
`flange`, `alignment_cup`, `cup_fit_ring`, `pipe_guide_test` or
`upper_body`. The corresponding generated STLs are
`PingPongParachute-V4-Flange.stl`,
`PingPongParachute-V4-AlignmentCup.stl`,
`PingPongParachute-V4-CupFitRing.stl`,
`PingPongParachute-V4-PipeGuideTest.stl` and
`PingPongParachute-V4-UpperBody.stl`.
`mount_assembly` previews just the mount and lower. Assembly views and
individual exports both show the complete circular cup, not a half-cut
section. Bottle dimensions and clearances are exposed at the top of
the SCAD file; `cup_base_clearance` places the cone above the bottle feet
independently of flange thickness.
Changing to PLA Tough+ changes the print presets, not these STL dimensions.

## Cylinder V3: short TPU top and 150 mm rigid extensions

`PingPongParachute-CylinderV3.scad` is a separate design; **V1, V2, their
STLs, and your saved V2 project are not overwritten**. Keep both older SCAD
files beside V3. The lower tube, including its labels, and the 50 mm flange
are reused directly from V2 without changing their shape. Continue using
`PingPongParachute-V2-LowerBody.stl` and `PingPongParachute-V2-Flange.stl`;
there is no need to reprint a good lower or flange.

The chosen starting dimensions are a **100 mm total TPU upper**, including
the integral **30 mm rounded head**, and middles that add **150 mm each to
the assembled length**. Each middle is **170 mm physically**, including its
20 mm male spigot. If 150 mm was intended as the entire printed length,
set `extension_length=130` and re-export/re-slice. The old 307.4 mm upper
is replaced, not scaled: the short upper retains a 24 mm reinforced
socket/root region, tapers to a 12 mm neck, then blends smoothly into the
head. Less unsupported TPU neck reduces the lever arm; resistance to
folding still requires a physical trial.

The middle has the same 12 mm waist, 1.6 mm nominal wall, and reinforced
ends as before, with shorter transitions between the ends. **Female ID
11.60 mm, male OD 11.50 mm, bore ID 7.50 mm in the male spigot, and 20 mm
engagement are unchanged.** Existing V1/V2 tube joints and V3 sections
remain interchangeable; any number of middles can be inserted or removed.
Mixed-material shrinkage and TPU deformation can change the *printed* fit,
so test the TPU socket against the PETG/ABS male coupon first. These remain
clearance-fit, **externally tape-retained** joints, not latches.

Assembly height from the bottle-seat datum is
`292.6 + middle_count * extension_length + upper_length` mm:
392.6 mm without middles, 692.6 mm with two, or **842.6 mm with three** at
the defaults. V3 does not silently lengthen the bottom to recover V2's
900 mm height. `middle_count` changes the preview only.

### Why shorter sections and grounded bracing

A 40-degree tilt alone leaves a long, lightly supported cantilever.
Cross-links between two equally floppy pipes alone can let the entire pair
sway together. V3's optional **`middle_braced_pair`** therefore combines:

- Two parallel 170 mm middles, **40 degrees above the bed** (50 degrees
  from vertical), with centers 28 mm apart.
- A **1.2 mm thick longitudinal sacrificial web under each pipe**, anchored
  to a shared 0.6 mm foot and connected through small, spaced cutting tabs.
- Horizontal cross-links between the webs at the tab stations, restraining
  relative side-to-side movement. These include approximately 27 mm clear
  bridges, which must be proven with `brace_test`.

The webs stop short of the male root and begin beyond the full female
engagement. Only the small tabs touch the outer body; **neither mating
surface nor the hollow bore is intentionally modified**. The clean
`middle_body` export has no bracing. The full inclined pair stays below
120 mm tall, instead of a 170 mm upright middle or the old 320 mm middle.
The short `brace_test` contains two 64 mm socket/body samples and the same
web/tab/cross-link construction. It is a disposable printing/removal trial,
not an extension to install in the assembly.

This is an **experimental stabilizer, not a proven printing or impact
solution**. Check that the slicer actually generates the thin webs and tabs.
If the bridges sag or the webs shake, do not launch a full plate: adjust the
bridge settings, reduce speed/acceleration, or revise the bracing after the
short trial. Ordinary supports remain useful under the inclined sockets and
local overhangs; removable supports with a separation gap are not structural
braces.

After cooling, remove ordinary supports, then use flush cutters to sever
the cross-links and each small body tab while supporting the tube close to
the cut. **Do not twist or snap a whole rigid web off the tube**, and do not
cut into its 1.6 mm wall. Remove the foot/webs completely, trim remaining
nubs, and reject tubes with cuts, cracks, or damaged layers. Inspect the
cord-contact surfaces and both connectors before assembly.

### Material-separated H2C projects

Open the following **as projects**, not geometry-only imports. Both target
the H2C 0.4 mm right hotend and Textured PEI; select the actual installed
plate/material before printing. They are separate from your customized V2
layout and do not change it.

| Project | Plate 1: print first | Plate 2 |
|---|---|---|
| `PPP-Cylinder-V3-TPU.3mf` | 28 mm female socket coupon | One 100 mm upper, socket down |
| `PPP-Cylinder-V3-PETG.3mf` | Male coupon and short braced-pair trial | Two full inclined middles with cut-away bracing |

These are **unsliced, editable projects**, not jobs sent to the printer.
All four plates were sliced with the installed Bambu Studio without slicer
warnings. The resulting support paths were checked: no TPU supports and no
PETG support inside either tube bore; all modeled body attachment tabs
appear in the toolpaths. This checks preparation, not real-world printing.
Approximate slicer totals, including brims/supports, are **13.2 g / 1 h 41 min**
for the upper and **50.4 g / 6 h 39 min** for a pair of full rigid middles.
The male/brace trial plate is about **18.0 g / 2 h 39 min**.
Re-slice and review on your installed printer configuration before printing;
no machine-ready G-code is supplied in the repository.

The six new STL exports are `PingPongParachute-V3-UpperBody.stl`,
`PingPongParachute-V3-MiddleBody.stl`,
`PingPongParachute-V3-MiddleBracedPair.stl`,
`PingPongParachute-V3-BraceTest.stl`,
`PingPongParachute-V3-JointLowerTest.stl`, and
`PingPongParachute-V3-JointUpperTest.stl`. They are closed meshes in their
intended print orientations: upright clean parts/coupons, pre-inclined
braced pairs. **Do not auto-orient the braced STL.** Projects embed the
default geometry; editing SCAD does not update them automatically.
If you change length, angle, or spacing, re-export, replace the meshes,
and refit the bore blockers before re-slicing.

The TPU project uses the installed **Bambu TPU for AMS**, not Generic TPU
95A: 230 C nozzle, 35 C textured bed, factory 0.97 flow ratio. Its short
upper prints **upright**, below the reported instability height, without
supports. The outside shoulder is gradual, and the hollow head has a
**45-degree conical internal roof** for this orientation. The outside stays
smooth and spherical; the crown is locally thicker than the nominal wall.
Do not lay it sideways and assume V2's horizontal pitched roof is present.

The rigid project uses installed **Bambu PETG Basic**: 245 C first-layer /
250 C subsequent nozzle, 70 C textured bed, factory 0.97 flow ratio.
Use the correct preset for your actual PETG if it is not PETG Basic.
Normal/snug build-plate-only supports are enabled for the inclined pairs;
explicit **bore support-blocker volumes** are included. Keep those
non-printing blockers in place. Inspect the sliced preview to confirm that
the bore and connectors do not contain trapped supports.

Both use **0.20 mm layers, four walls, 0% sparse infill, 6 mm outer brim**,
and deliberately conservative trial motion settings: **500 mm/s2 normal
acceleration, 300 mm/s2 outer walls, 800 mm/s2 travel**. TPU walls are
25/35 mm/s outer/inner; PETG walls 30/45 mm/s; first layer and bridges
20 mm/s. These are starting settings, not measured optimum values.
Print **by layer**, not sequentially/by object, so the nozzle does not
collide with neighboring tall sections or the connected brace structure.

For **ABS**, use the same rigid meshes and switch to the installed H2C ABS
preset, including its bed, chamber, cooling, flow, and shrink compensation;
do not print ABS using this PETG project unchanged. Use an enclosed,
appropriately ventilated setup. PETG is the first trial to avoid making
ABS warping another variable, not a guarantee of superior drop survival.
Do not co-print TPU and ABS/PETG on a shared plate with incompatible bed
or chamber settings. Dry each filament per its manufacturer instructions.

### Print and impact checks

Start with both material-specific fit coupons and the short brace trial.
Then print one upper and one pair of middles. Check fit, straightness,
brace removal, layer quality, cap clearance, and dry cord deployment before
repeating the middle plate. Keep a known-good lower unchanged.

**Orientation is a tradeoff, not a cure for brittle layers.** Flat tubes can
have filament paths along their axis, while upright tubes put axial loads
across layer bonds. Which orientation survives a drop depends on the impact
direction, seam, material, and bonding; 40 degrees does not eliminate
anisotropy or establish drop strength. Compare identical PETG/ABS coupons
printed flat and inclined under controlled, representative bending/impact.
Improve drying, calibrated flow, temperature within the material's range,
and cooling before attributing every crack to orientation. Extra infill in
the empty bore is not a substitute for sound shell bonding.

For wobble, prioritize **shorter modules, grounded stabilization, clean bed
adhesion, and lower acceleration** before tuning just print speed. Input
shaping compensates printer motion, not arbitrary movement of a flexible
part. Inspect for nozzle strikes, curled edges and material blobs; do not
hide those problems with braces. Keep cooling adequate for the short TPU
roof and PETG bridges without sacrificing wall bonding.

General references: [MakerVerse: stronger FDM prints](https://www.makerverse.com/resources/3d-printing/stronger-fdm-3d-printing/)
discusses anisotropy, perimeter shells, ribs, and temperature/speed/cooling
tradeoffs; [Xometry: FDM design tips](https://xometry.asia/en/fdm-3d-printing-design-tips-best-practices-and-techniques-for-stronger-prints/)
discusses orientation, supports, and design for strength. The particular
cut-away fixture and numeric motion settings here are a proposed trial,
not manufacturer-qualified settings.

The 30 mm nose is still subject to the actual bottle-cap clearance test
described in V2 below. A shorter TPU neck and rigid middles do not validate
impact survival, launch stability, tape retention, or event compliance.
Use controlled progressive tests; this remains an external attachment,
not a pressure vessel or release mechanism.

## Cylinder V2: 50 mm tape flange and integral rounded nose

`PingPongParachute-CylinderV2.scad` is a separate V2 design. The instructions
below this section and the older `PingPongParachute*.3mf` projects still
describe **V1**; they have not been converted to V2. Keep the V1 SCAD file next to V2 because
V2 imports its unchanged lower/middle tubes and tube connectors.

### Ten original V2 middle pipes on one plate

Open **`PPP-Cylinder-V2-10MiddlePipes-PETG.3mf`** as a project for the
requested batch: **10 V2 middle pipes, all joined into ONE shared cut-away
ladder**, not five independent pairs. These are the original **320 mm**
printed pipes (**300 mm added assembled length plus 20 mm spigot**), not
the shorter V3 middles. The existing V2 project and original pipe STL
remain unchanged.

All ten axes are **40 degrees above the bed**, with 28 mm center spacing.
Ten grounded longitudinal webs, ten cross-rungs spanning the whole row,
100 small exterior attachment tabs, and one shared 0.6 mm foot stabilize
the complete batch. The connected model is approximately **254.1 x 268.4 x
216.4 mm**, before slicer supports/brims. The webs and tabs stay clear of
the original socket engagement and male connector/root. Cut every
attachment tab while supporting the nearby tube; do not tear or twist
the ladder off. Remove all fixture material before use.

The installed slicer estimates approximately **637 g of PETG and 73 hours**
for the complete plate, including supports/brims. The batch slices without
warnings, all 100 body tabs appear in the toolpaths, and support paths stay
out of all ten bores. These are preparation checks, not a physical print
trial. Ensure sufficient filament with margin for calibration/purge.

`PingPongParachute-V2-10Pipes.scad` defines the fixture and imports the
unscaled original `PingPongParachute-V2-MiddleBody.stl`.
`PingPongParachute-V2-10MiddlePipes-Braced.stl` is the exported single,
connected printing model. Keep the original middle STL and
`PingPongParachute-Cylinder.scad` beside the batch SCAD. Do not auto-orient
or split the connected model in the slicer.

This **separate batch intentionally uses PETG Basic**, unlike the
all-TPU V2 instructions below. It targets the H2C right 0.4 mm hotend and
Textured PEI, using 245/250 C nozzle, 70 C bed, 0.20 mm model layers,
four walls, 0% sparse infill, 6 mm outer brim, normal/snug external supports,
and by-layer printing. Ten bore-blocking regions are packaged as one
non-printing support-blocker part; leave it in place. Conservative motion
settings match the V3 PETG trial: 30/45 mm/s outer/inner walls and
500/300 mm/s2 normal/outer acceleration. Select the actual filament/plate,
re-slice and inspect the preview before printing. For ABS, change to the
correct ABS material/chamber settings rather than using PETG temperatures.

This is a long, experimental print: unlike the short V3 layout, the
original V2 pipes extend above 150 mm even when inclined. The shared
grounded ladder is intended to restrain that motion, not proof that
vibration or drop failures are eliminated. Prove fit and support/tab removal
on a small trial before committing to all ten. The project is editable and
unsliced; no print has been sent to the machine.

### Ready-to-slice H2C project

Open **`PPP-Cylinder-V2.3mf`** in Bambu Studio as a **project**, not just
geometry. It contains the generated V2 STLs, their horizontal orientations,
and these settings:

- **H2C, 0.4 mm, right hotend**; filament slot 1 is **Bambu TPU for AMS**.
- Factory material values: **230 C nozzle, 35 C textured PEI bed, 0.97 flow
  ratio, 12 mm3/s maximum volumetric speed**; no heated chamber.
- **0.20 mm layers, four walls, 0% sparse infill**, 5 mm outer brim.
- **Normal/snug support, build-plate-only**, not trees; 3 mm support spacing,
  no dense interface layers, and trial 0.3 mm top/bottom support separation.
- Conservative 30 mm/s outer walls and 40 mm/s inner walls.

Your saved **Engineering Plate** selection, rearranged plates, and duplicate
objects are preserved in the smaller-head and engraving updates. The table below describes
the **original layout**, not a reset of your saved arrangement.

| Original plate | Contents |
|---|---|
| 1 - Fit checks | Full 50 mm wavy flange, base fit coupon, male/female joint coupons, hollow nose/shoulder sample |
| 2 - Lower | One horizontal lower tube |
| 3 - Middle | One horizontal middle tube |
| 4 - Upper | One horizontal upper tube with integral hollow rounded nose |

The updated saved project loads in Bambu Studio. The 30 mm upper and nose
sample were also sliced individually with the saved H2C settings, without
slicer warnings. Their support toolpaths were checked against their cavities:
**no internal support paths**. One upper tube is estimated at **36.3 g**
total filament, including **4.1 g** external support, versus 43.7 g total
for the earlier 40 mm version. These are isolated-part slicer estimates,
not measured weights or totals for your rearranged multi-object plates.

The saved project is **unsliced**, so slice it in your installed Bambu Studio
and inspect the preview before sending a job. Do not auto-orient the tubes
or switch to automatic trees. Print the short nose and connector coupons
first; print the flange alone using object selection if it shares a plate
with full tubes. Confirm TPU support removal, connector fits, bottle contact,
cap-ceiling clearance, and cord release before printing the full tubes.
The project uses automatic external normal support, not pre-painted supports;
the manual painting advice below is for further refinement after that trial.

### Geometry and fit

The **tape flange is 50 mm in diameter**, not 50 cm. The tube base remains
23.2 mm, its bore remains 17.60 mm, and the flange spigot remains 17.50 mm
over 20 mm engagement. The widened panel provides a **13.4 mm radial tape
ledge** around the tube. The **entire five-lobed, wavy bottle-contact
underside spans the full 50 mm diameter**; this is not a flat ring added
around the old 34 mm seat. It follows V1's approximate petaloid **1 L soda
bottle bottom**, retaining the 5 mm central dome and 3 mm valley heights
while expanding the radial pattern to the new edge. The top remains flat
for tape. The center bore and locating spigot are not scaled.
This assumes a 68 mm bottle with five feet, not a scan of a specific bottle:
check the contour's contact, foot alignment, and tape routing against the
actual 1 L bottle before printing the full tubes.

V2's **30 mm rounded nose is integral with the TPU for AMS upper tube**,
reduced from 40 mm. There is
no separate TPU nose, nose socket, collar, or nose-retaining tape. A
tangent-matched shoulder widens continuously from the pipe into the lower
spherical surface, removing the annular nose joint reported to trap parachute
strings. This eliminates that joint, **not every possible snag**: a string
can still wrap around the wider head, other tube joints, rough print layers,
or tape edges.
The head is kept **completely smooth**: no target grooves, engraving,
mounting hole, or added mounting anchor.

**Bottle-cap test: not yet verified.** The supplied official Figure 1 says
**"Nose not touching inside top of cap"** and shows the cap rim resting on
the nose. This is a cap-ceiling clearance test, not a ping-pong-ball diameter
requirement or a ban on rim contact. The 30 mm diameter is a smaller
prototype, not a claim that it meets the event rule or is the minimum
passing size. Check it using the actual 1 L bottle cap.
Do not scale the whole upper STL: that would change its connector.
`head_diameter` changes only V2's head/shoulder and print orientation;
the imported V1 tube dimensions stay unchanged.

For an ideal cylindrical cap of opening diameter `d` and clear inside depth
`h`, a spherical head of radius `R` resting on the rim protrudes by
`R - sqrt(R*R - (d/2)*(d/2))`. Its diameter must exceed `d`, and that
protrusion must be **less than `h` with a tolerance margin**. For example,
a 30 mm head with a hypothetical 26 mm opening protrudes about 7.52 mm.
Those are not measured cap dimensions. Real threads, liners, seals, rim
geometry, and TPU deformation can change contact and invalidate that
simple calculation. Print the short nose sample, place the actual cap
over it as shown in Figure 1, and verify clearance below the inside top
before printing the full upper tube.

### Lower-cylinder identity engravings

The lower tube has four **recessed, longitudinal labels**, spaced at
90-degree intervals around its circumference:

| Angle around tube | Engraving |
|---|---|
| 0 degrees | Odle Middle School |
| 90 degrees | Siddhu |
| 180 degrees | Team Feynman |
| 270 degrees | Allen |

The lettering uses a 5 mm font-size setting with a **0.35 mm radial recess**
following the tapered outer surface. The available marking window is
48-123 mm above the bottle-seat datum, away from the flange socket and
upper spigot. The full longest label fits within that window; none is
clipped to fit. Nominal material behind the letters is at least **1.25 mm**
where the original tube wall is 1.6 mm. Do not deepen the text without
checking wall thickness again.

Only the lower-tube geometry changes; its mating dimensions and overall
length are unchanged. The middle, fit coupons, and smooth head retain their
geometry. The saved H2C project includes the engraved lower mesh without
resetting your existing placements, duplicate objects, or print settings.
Some lettering faces external support during horizontal printing; remove
that support carefully and check readability and surface condition before use.
The engraved lower also slices without warnings using the saved H2C settings;
its support toolpaths remain outside the hollow bore.

**Print all V2 parts in Bambu TPU for AMS**, including the flange, tubes,
and coupons. The reported brittle ABS impact failures motivate this material
change; keeping the reinforced walls is a starting point, not proof of drop
survival. [Bambu TPU for AMS](https://bambulab.com/en/filament/tpu-for-ams)
is **68D Shore hardness**, tougher and more flexible than rigid ABS but much
stiffer than the former TPU 95A nose. It is not a soft crash bumper. Select
the **Bambu TPU for AMS** material preset for the actual printer/nozzle,
not Generic ABS, regular TPU 95A, or TPU 95A HF. Use a supported AMS model
and the manufacturer's current drying, bed, cooling, and feed instructions.
Do not carry over the ABS heated-chamber settings or its flow/speed profile.

Assembled height remains **900 mm**, or **600 mm** without the middle.
Export each part individually with `print_orientation=true`:

| V2 selector | Material | Print orientation / height |
|---|---|---|
| `lower_body` | TPU for AMS | Horizontal, diagonal on bed; 23.2 mm high, 306.4 mm long |
| `middle_body` | TPU for AMS | Horizontal, diagonal on bed; 16.4 mm high, 320 mm long |
| `upper_body` | TPU for AMS | Horizontal, diagonal on bed; 30 mm high, 307.4 mm long |
| `flange` | TPU for AMS | Bottle-contact side down; 50 mm outside diameter |
| `fit_test`, `joint_lower_test`, `joint_upper_test` | TPU for AMS | Existing base/joint interfaces, in V2 print orientation |
| `nose_transition_test` | TPU for AMS | Horizontal, 90 mm long shoulder/nose sample; no connector |

V2 exports are `PingPongParachute-V2-LowerBody.stl`,
`PingPongParachute-V2-MiddleBody.stl`, `PingPongParachute-V2-UpperBody.stl`,
`PingPongParachute-V2-Flange.stl`, and
`PingPongParachute-V2-NoseTransitionTest.stl`, plus
`PingPongParachute-V2-FitTest.stl`, `PingPongParachute-V2-JointLowerTest.stl`,
and `PingPongParachute-V2-JointUpperTest.stl`. The middle geometry and all
base/joint interfaces are unchanged; the lower tube now has the shallow
identity engraving described above. Their V2 export orientation is
horizontal. **Re-slice in TPU for AMS**; unchanged geometry does not mean
reuse ABS toolpaths or assume the same printed fit.

**Do not stand the tubes upright.** Tall, slender V1 prints were reported
to oscillate and become unstable at 200-300 mm height. V2's
`print_orientation=true` lays the tubes on their sides at `bed_angle=45`
degrees, reducing height to their maximum diameter and fitting their long
axes diagonally across the plate. Check actual printable area, brim, and
toolhead-exclusion zones in the slicer; print long sections on separate
plates if necessary. Do not auto-orient them upright. `print_orientation=false`
is the assembled-coordinate model, not the intended print orientation.

The upper tube is **hollow through the shoulder and rounded head**, with
an internal **45-degree pitched roof** in its horizontal orientation.
There is no solid/conical nose plug, permanent internal tree, or modeled
infill. The pitched roof replaces the wide internal circular ceiling,
while retaining the round 11.60 mm
female connector for its full 20 mm engagement. The roof tapers into that
round socket over the following 4 mm. Local roof walls are thicker than
the 1.6 mm skin. Keep the exported roll orientation: rolling the part around
its long axis would turn the pitched roof sideways. The lower/middle bores
remain circular; their short-span internal bridging still needs a coupon
check in TPU for AMS.

**Minimize support waste:** use build-plate-only, manually painted support
along the narrow external underside that actually needs it, not automatic
trees around the whole tube. The integral ball lifts the narrower upper
pipe above the bed, so it needs external support along that pipe, not just
under the ball. Compare sparse normal support with trees; a low continuous
support strip may use less material than many branches. Leave the internal
cavities support-free only after inspecting the sliced roof and proving it
with the horizontal nose and joint coupons. A failed bridge is not fixed
by hiding an unremovable tree inside a long tube. The flange still needs
local support under its widened bottle-seat contours.
Compare support filament separately from model filament.
Set **sparse infill to 0%** for the hollow upper part. Start with **normal
support, build-plate-only**, restricted to the painted external underside;
do not allow automatic trees to grow into the socket or head. In layer
preview, confirm that the cavity contains **no support or infill toolpaths**
before printing. Zero infill alone does not disable support. If the slicer
still inserts internal supports, block those regions or disable automatic
support and use external support painting; do not print the full part
hoping the trapped trees can be removed later.
Keep interfaces minimal only after a small TPU-for-AMS support-removal
trial; tune Z separation using that material's profile rather than copying
V1's TPU 95A gaps. Excessive gaps can ruin the underside, while fused
supports can waste the entire part. Keep external rounded surfaces free
of support scars wherever possible because they can catch cord.
Do not print the assembly as a single object or scale mating parts.

Print the flange/base and tube-joint coupons first. Print the
`nose_transition_test` before the full upper tube and check the surface
with the **actual parachute cord**, pulling it across the shoulder from
multiple directions and under light tension. Remove burrs and layer defects
without damaging the shell. Repeat deployment checks on the full dry
assembly, including tape and all remaining joints, before controlled flight
tests. CAD smoothness alone does not establish reliable release, strength,
impact survival, stability, or event compliance.
The 900 mm flexible assembly may bend or buckle more than ABS; inspect joint
retention and balance under load, and compare the 600 mm configuration before
attempting full-height launches. All tube joints still require external tape.

## V1 project reference

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
diametral interference**. Nose engagement is now **15 mm**. The matching TPU
collar is lengthened with its stop, retaining a 2.4 mm wall and 1.2 mm
stop height. The stationary neck tip is **19.8 mm below the inner crown**
along the axis, with about **7.3 mm radial clearance** between the collar's
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
| 4 | ABS lower, middle, upper tubes and flange | Tube heights 306.4, 320, and 286.4 mm; 20 mm flange spigot; flange supports retained |
| 5 | TPU nose | Hollow 1.2 mm shell, internal tree support, 5 mm brim |
| 6 | ABS fit coupons | Base socket, male/female tube joint, and nose neck |
| 7 | TPU nose socket coupon | Full 15 mm engagement and stop; 16.2 mm tall; no full dome; inspect support preview |

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
| Upper tube neck / TPU nose | 18.40 mm | 18.10 mm | -0.30 mm (interference) | 15 mm |

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
The flange engagement remains 20 mm and nose engagement is now 15 mm.
The lower and upper tube print heights each decrease by 5 mm relative
to the 25 mm nose-engagement revision to preserve assembled lengths.
The middle tube remains 320 mm tall. The upper shoulder transitions are
anchored to the neck base rather than its tip to preserve their shape
when the neck grows.
The 34 mm flange now leaves a **5.4 mm radial tape ledge** around the base.
Use the regenerated fit coupons, not the older thin-wall prints.

The TPU nose remains a **hollow 40 mm ball**, trimmed to 36 mm print height.
Its spherical wall is now **1.2 mm**, reduced from 1.6 mm, to
reduce rigidity while retaining the hollow center. **100% infill applies
to that shell and its mounting collar, not to the hollow center.** The
18.10 mm mounting socket has 0.30 mm interference over 15 mm engagement;
the seating stop height remains 1.2 mm, but its position moves to match
the longer neck. Local socket
transitions do not have uniform spherical-wall thickness.

The nose retains internal tree support because its inner spherical dome
is not self-supporting. Support top/bottom Z separation is increased from
0.3 to **0.4 mm**, and dense top interface layers are disabled to reduce
TPU-to-TPU bonding. These are trial separation settings: they may leave a
rougher inner dome, and do not guarantee easy support removal.
Remove all support through the **16.90 mm stop opening** before fitting
the nose. The 15 mm collar makes that access deeper than the original 6 mm collar; inspect tree
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
lower tube's main-body rim is **292.6 mm** above the mounting plane.

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
