# UK_ORD_GG184 — OpenRoads Designer Workspace

A curated OpenRoads Designer (ORD) workspace aligned to UK practice and GG 184. It provides consistent standards, seeds, symbology, Feature Definitions, Item Types, and production assets. Use this as a complete “Custom Configuration” so teams can start quickly and produce repeatable, standards‑aligned deliverables.

This workspace references and organises content with respect to:
- MCHW (including the Specification for Highway Works, SHW)
- MMHW (Maintenance Manual for Highway Works)
- ADMM (Asset Data Management Manual)
- buildingSMART Data Dictionary (bsDD) Property Sets and Quantity Takeoffs (Psets/Qto)
- Uniclass 2015 classifications (Co, En, SL, EF, Ss, Pr, etc.)
- GG 184 “Specification for the use of Computer Aided Design”

Feature Definitions are structured around maintainable assets and construction elements reflected in these documents. Item Types encode specification and classification metadata (SHW/MMHW/ADMM), Uniclass, and bsDD properties.

Repository: [UK_ORD_GG184](https://github.com/CJAndrew84/UK_ORD_GG184) • Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)

> Validate against your client’s latest specifications and the project BEP. This workspace provides guidance and defaults, not compliance on its own.

---

## Key inputs in this repository

- GG 184 (reference and guidance)
  - GG 184 PDF (reference): [GG 184 Specification for the use of Computer Aided Design-web.pdf](input/GG%20184%20Specification%20for%20the%20use%20of%20Computer%20Aided%20Design-web.pdf)
    - Permalink: https://github.com/CJAndrew84/UK_ORD_GG184/blob/eeb83b15de39c639571b7be434832a5ee2af8a1e/input/GG%20184%20Specification%20for%20the%20use%20of%20Computer%20Aided%20Design-web.pdf
- SHW to Uniclass mapping dataset
  - [SHW_England_enriched_with_Uniclass.csv](input/SHW_England_enriched_with_Uniclass.csv)
    - Permalink: https://github.com/CJAndrew84/UK_ORD_GG184/blob/eeb83b15de39c639571b7be434832a5ee2af8a1e/input/SHW_England_enriched_with_Uniclass.csv
- bsDD (IFC Psets/Qto) seed
  - [bsdd_Ifc_Pset_Qto.xlsx](input/bsdd_Ifc_Pset_Qto.xlsx)
    - Permalink: https://github.com/CJAndrew84/UK_ORD_GG184/blob/eeb83b15de39c639571b7be434832a5ee2af8a1e/input/bsdd_Ifc_Pset_Qto.xlsx
- Feature Definitions (extract)
  - [GG184.xml](input/GG184.xml)
    - Permalink: https://github.com/CJAndrew84/UK_ORD_GG184/blob/eeb83b15de39c639571b7be434832a5ee2af8a1e/input/GG184.xml
- Levels seed (CSV import)
  - [Levels.csv](input/Levels.csv)
    - Permalink: https://github.com/CJAndrew84/UK_ORD_GG184/blob/eeb83b15de39c639571b7be434832a5ee2af8a1e/input/Levels.csv
- Reference only (not Bentley, not distributed standards)
  - Autodesk C3D UKIE example: [ukie-user-guide-and-reference.pdf](input/ukie-user-guide-and-reference.pdf) • For reference only; useful to understand UK naming/unit conventions and deliverables when onboarding mixed‑tool teams. Not used directly by ORD.

---

## Highlights

- UK‑centric defaults (metric units, annotation scales, design/drawing/sheet seeds)
- Feature Definitions for:
  - Alignments and Profiles (horizontal/vertical) — includes the required ORD FDs so geometry, profiles, and corridors function out‑of‑the‑box
  - Corridors and components (linear features, pavement, earthworks, drainage)
  - Terrain (existing/proposed contours, triangles, thematic height/slope)
  - Safety and visibility (VRS, aquaplaning, sight visibility)
- Symbology via Feature Symbology and Element Templates
- Centralised DGNLIBs: levels, text styles, dimension styles, annotation groups/definitions, feature defs
- Item Types for SHW/MMHW/ADMM metadata, Uniclass (Co/En/SL/EF/Ss/Pr…), and bsDD Psets/Qto
- Reporting templates for quantities, schedules, and data drops

---

## Quick Start

1. Clone or download this repo to a local or network path.
2. Point ORD to this path as your “Custom Configuration.”
3. Launch ORD, select “UK_ORD_GG184” Workspace, choose/create a WorkSet.
4. Start modelling with the provided seeds, Feature Definitions, and Item Types.

Installation details and variables are below.

---

## Installation

Local (single user)
- Path example: C:/Workspaces/UK_ORD_GG184/
- Edit (admin) ConfigurationSetup.cfg:
  ```
  _USTN_CUSTOM_CONFIGURATION = C:/Workspaces/UK_ORD_GG184/
  _USTN_WORKSPACESROOT       = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
  _USTN_WORKSETSROOT         = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/
  CIVIL_ORGANIZATION_NAME    = UK_ORD_GG184
  ```
Network (team)
- Path example: //YourServer/Design/UK_ORD_GG184/
- Use the same variables as above (UNC path).

ProjectWise (optional)
- Mirror this structure into a Managed Workspace or point your Managed Configuration to it.

Common bindings inside Organization/Config .cfg
```
MS_DGNLIBLIST           > $(_USTN_ORGANIZATION)Standards/DGNLIB/*.dgnlib
MS_CELL                 > $(_USTN_ORGANIZATION)Standards/Cells/
MS_SYMBRSRC             > $(_USTN_ORGANIZATION)Standards/Linestyles/*.rsc
MS_SEEDFILES            > $(_USTN_ORGANIZATION)Standards/Seed/*.dgn
CIVIL_REPORTS_DIRECTORY > $(_USTN_ORGANIZATION)Standards/Reports/
MS_ITEMTYPES            > $(_USTN_ORGANIZATION)Standards/ItemTypes/*.dgnlib
```

---

## Standards mapping in this workspace

- SHW/MCHW: Feature Definitions and Item Types group/nest by SHW “Doc Code” (e.g., CC/CP 201–207 Pavements, CC/CP 400 Restraint, CC/CP 500 Drainage).
- MMHW: Item Types capture maintenance attributes (maintainable, inspection regime, condition).
- ADMM: Item Types capture handover and lifecycle data fields.
- bsDD: Item Types include bsDD Psets/Qto properties (with identifiers) for interoperable exchange.
- Uniclass 2015: Levels and Item Types carry Uniclass codes/descriptions (Co/En/SL/EF/Ss/Pr), enabling classification‑driven reporting.

Source dataset (CSV): [SHW_England_enriched_with_Uniclass.csv](input/SHW_England_enriched_with_Uniclass.csv). Use this to drive pick lists, Item Types, and Feature Definition naming.

---

## Feature Definitions provided (from GG184.xml)

The included Feature Definitions extract defines a broad set ready for ORD usage:
- Terrain (Existing/Proposed)
  - Existing/Proposed Contours, Triangles, Thematic Height/Slope, Survey, Building Pad
  - Unsuitable Boundary, Temporary Construction
- Geometry and production
  - Linear Template FDs: Design, Final, “Final w/ Contours”
  - Surface Template FDs: Enable/Disable 3D Linear Features
  - Trace Slope (trace, pond, low points)
- Safety and visibility
  - Sight Visibility: Stopping (SSD), Passing (PSD), Overtaking (OSD)
  - Aquaplaning: surface, linear, risk categories (Low/Acceptable/High/Unacceptable)
- Road restraint systems (VRS) and barriers
  - Cable barrier, TL2/TL3 guardrail start/end (left/right)
- Existing assets and survey
  - Monuments (e.g., Half Section Corner, Iron Pin/Pipe Found)
  - Traffic and Safety: signals, light poles, signs
  - Utilities: inlet, poles
  - Right of Way: pins, property corners/lines
- Terrain points/lines
  - Boreholes, spot elevations, random points, ditch top/bottom, flowlines

File: [GG184.xml](input/GG184.xml). This content is packaged into DGNLIBs with corresponding Feature Symbology and Element Templates within the Workspace.

Required geometry Feature Definitions (Alignments and Profiles)
- Workspace includes Feature Definitions for:
  - Alignments (horizontal) — e.g., Centreline, Control, Temporary/Scratch
  - Profiles (vertical) — e.g., Design, Existing/Survey, Control
- These are the minimum needed for ORD geometry, profiles, and corridor modelling to function.

Tip: Where appropriate, Feature Definition names can include SHW references from the CSV, for example:
- Linear.Kerb.HB2.SHW_CC_CP_207
- Pavement.SurfaceCourse.SMA10.SHW_CC_CP_202
- VRS.Barrier.Steel.SHW_CC_CP_400
- Drainage.Pipe.UPVC.SHW_CC_CP_500

---

## Levels and Uniclass

Levels.csv provides a seed list of levels with Uniclass‑influenced naming where available, and pragmatic “Non_Uniclass_*” entries when required.

- File: [Levels.csv](input/Levels.csv)
- Import via Level Manager (Tools > Import/Export > Import CSV) into the appropriate DGNLIB to seed project levels.
- Examples found in the CSV:
  - CH‑Ss251694‑M‑VrsGen (Guardrail; Uniclass Systems Ss 25-16 94…)
  - CB‑EF2510‑M‑StructWallTop (Structural elements; Uniclass EF)
  - VT‑En803574‑M‑ExPaveEdge (Existing pavement; Uniclass Entities En)
  - Non_Uniclass_* where no suitable Uniclass mapping exists or for temporary/working layers

Recommendation
- Keep Uniclass alignment for publishable deliverables.
- Reserve Non_Uniclass_* for internal working or where the spec explicitly requires.

---

## Item Types: SHW/MMHW/ADMM + Uniclass + bsDD

This workspace ships Item Types designed to:
- Reference SHW/MMHW/ADMM context (DocCode, Series/Clause, version/publication)
- Carry Uniclass codes/descriptions (Co/En/SL/EF/Ss/Pr as available from the CSV)
- Include bsDD Psets/Qto properties for IFC‑aligned data.

Seed sources:
- SHW mappings: [SHW_England_enriched_with_Uniclass.csv](input/SHW_England_enriched_with_Uniclass.csv)
- bsDD properties: [bsdd_Ifc_Pset_Qto.xlsx](input/bsdd_Ifc_Pset_Qto.xlsx)

Suggested Item Type structure:
- Spec.Reference
  - Standard: Enum [SHW, MMHW, ADMM, Other]
  - DocCode, DocTitle, Series, Clause, Version
- Asset.Taxonomy
  - TopGroup, AssetElement, VariantType, AssetName (from CSV)
  - Maintainable: Bool (MMHW)
- Uniclass.Mapping
  - Co/En/SL/EF/Ss/Pr Code and Description (fields only populated if present in CSV)
- bsdd.Mapping
  - Pset, PropertyName, Identifier (GUID/IRI), Unit, ValueType

Binding strategy:
- Attach Item Types to Feature Definitions in DGNLIB so elements inherit metadata automatically.
- For corridor templates (components and linear features), ensure the Component/Linear FDs carry the same Item Types.

---

## Using the workspace

1. Geometry and Profiles
   - Use Alignment/Profile FDs for horizontal and vertical design, including Existing/Survey profiles.
   - Apply UK annotation groups/scales (1:200, 1:250, 1:500, 1:1000, etc).

2. Corridors
   - Use the Corridor/Linear/Component FDs aligned to SHW assets (e.g., kerbs per CC/CP 207, pavement per CC/CP 201–203, VRS per CC/CP 400, drainage per CC/CP 500).
   - Template libraries to reflect pavement build‑up, drainage, and earthworks.

3. Terrain and Safety
   - Terrain FDs for existing/proposed surfaces.
   - Sight Visibility and Aquaplaning FDs to evaluate SSD/PSD/OSD and run risk visualisations.

4. Metadata and Reporting
   - Populate Spec.Reference, Uniclass, and bsDD fields as required by BEP.
   - Use Reports to extract quantities and asset registers grouped by DocCode, AssetElement, or Uniclass.

---

## Data workflow (recommended)

When standards update (SHW/MMHW/ADMM/Uniclass/bsDD):

1. Update input datasets
   - Replace/update [SHW_England_enriched_with_Uniclass.csv](input/SHW_England_enriched_with_Uniclass.csv).
   - Update [bsdd_Ifc_Pset_Qto.xlsx](input/bsdd_Ifc_Pset_Qto.xlsx) if bsDD mappings change.
   - Keep a record of the commit SHA used in your WorkSet metadata.

2. Regenerate pick lists and Item Types
   - Refresh enums/pick lists for DocCode, TopGroup, AssetElement, VariantType, AssetName.
   - Update Uniclass mapping fields (Co/En/SL/EF/Ss/Pr) as available in the CSV.
   - Extend Item Types with new bsDD properties if required.

3. Review Feature Definitions
   - If FD names encode SHW/Uniclass, review for changes (e.g., renames, new types).
   - Keep Feature Symbology and Element Templates in sync.

4. Levels/DGNLIBs
   - If needed, import updated [Levels.csv](input/Levels.csv) into a levels DGNLIB.

5. Tag and publish
   - Create a release tag so projects can pin to a known dataset version.

> Governance/process rows in the CSV (e.g., “Governance requirement - spec/procedure”) are valuable for documentation but are typically excluded from modelling FDs. Filter per BEP to focus on maintainable/constructed assets.

---

## UK‑specific settings

- Units: Metric (m, mm)
- Coordinate System: British National Grid (OSGB36 / EPSG:27700) recommended unless stated otherwise
- Drawing scales: configured for UK deliverables
- Standards: Align FDs and Item Types with SHW/MMHW/ADMM; confirm required versions

---

## Reference: UKIE C3D guide (for context only)

The Autodesk UKIE Country Kit guide is included for reference to naming conventions, units, and deliverable expectations:
- [ukie-user-guide-and-reference.pdf](input/ukie-user-guide-and-reference.pdf)
- Not a Bentley standard. Do not copy content verbatim into ORD resources. Use it only to help mixed‑tool teams align expectations.

---

## Troubleshooting

- Workspace not appearing: verify `_USTN_CUSTOM_CONFIGURATION` path and folder structure (Organization/WorkSpaces).
- Missing styles/FDs: confirm MS_DGNLIBLIST and other search paths; check effective variables in ORD.
- Cache/prefs after updates: clear `%LOCALAPPDATA%\Bentley\OpenRoadsDesigner\` versioned folders and restart.
- Scales/units off: start from provided seeds; check Drawing/Annotation scales before labeling.

---

## Roadmap

- Extend FD coverage across more SHW sections (e.g., CC/CP 480s structures) and MMHW/ADMM fields.
- Enrich Item Types with additional bsDD Psets/Qto and tighter value constraints (pick lists).
- Add example WorkSet with demo data and reports grouped by Uniclass/SHW.
- Optional ProjectWise deployment pack.

---

## License

Unless otherwise stated in a LICENSE file, this content is provided “as is.” Respect any third‑party licenses for included resources (fonts, transformations, symbol libraries).

---

## Support

Open a repository issue including:
- ORD version and OS version
- Steps to reproduce
- Screenshots/logs if available

Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)
