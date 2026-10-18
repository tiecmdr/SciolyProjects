# H2C printing and fit checks

Use **Bambu ASA Aero** for the three tubes, flange, and rigid fit coupons;
use **Bambu TPU 95A** for the nose and its socket coupon. ASA Aero is a
foaming material, not ABS or ordinary ASA. The TPU profile is for regular
95A, not 95A HF or TPU for AMS.

## Project setup

`PingPongParachute.3mf` targets the H2C with 0.4 mm nozzles and 0.20 mm
layers. Each plate uses only the **right hotend**, including the 320 mm
middle tube; the configured right-side height limit is 325 mm. No parts
are scaled. There is no prime tower or sparse infill.

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

All seven plates were sliced and saved by the installed Bambu Studio
2.8.2.61 with no reported slicing warnings. The project includes native
G-code and regenerated thumbnails. Inspect the full layer preview before
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
