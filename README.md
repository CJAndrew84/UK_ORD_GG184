# UK_ORD_GG184 — OpenRoads Designer Workspace

A curated OpenRoads Designer (ORD) workspace aligned to UK practice. It provides consistent standards, seeds, symbology, Feature Definitions, and production assets. This repository is intended to be used as a complete “Custom Configuration,” so teams can get up-and-running quickly and produce repeatable, standards-aligned deliverables.

This workspace references and organises content with respect to:
- MCHW (including SHW)
- MMHW
- ADMM
- buildingSMART Data Dictionary (bsDD) Property Sets (Psets)

Feature Definitions are structured around maintainable assets and construction elements reflected in these documents. Item Types are provided to encode specification metadata (e.g., SHW/MMHW/ADMM) and bsDD properties.

- Repository: [UK_ORD_GG184](https://github.com/CJAndrew84/UK_ORD_GG184)
- Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)

> Note: Validate requirements against your client’s latest specifications and project BEP. This workspace provides guidance and defaults, not legal or contractual compliance on its own.

---

## Highlights

- UK-centric defaults (units, annotation scales, drawing seeds, level libraries)
- Feature Definitions for:
  - Alignments (horizontal/vertical), Profiles
  - Corridor design (corridor, components, linear features, earthworks)
- Symbology via Feature Symbology, Element Templates, Levels, Linestyles
- Drawing/Sheet seeds and drawing production rules for plans, profiles, sections
- Centralised DGNLIBs: levels, text styles, dimension styles, annotation, feature defs
- Item Types for SHW/MMHW/ADMM metadata and bsDD Psets (with GUIDs where applicable)
- Reporting templates (quantities, schedules) and example configuration

---

## Quick Start

1. Download or clone this repo to a local or network path.
2. Point ORD to this path as your “Custom Configuration.”
3. Launch ORD, pick the “UK_ORD_GG184” Workspace, and use or create a WorkSet.
4. Start modelling with the provided seeds, Feature Definitions, and Item Types.

Detailed steps follow.

---

## Prerequisites

- OpenRoads Designer (2022 R3 or newer recommended; 2023+ preferred)
- Windows 10/11 with access to the configuration path
- Optional: Network share for team deployment

---

## Installation Options

You can use this configuration locally, from a shared network location, or managed by ProjectWise.

### Option A — Local (single user)

1. Place (or clone) this repository locally, e.g.:
   - `C:\Workspaces\UK_ORD_GG184\`

2. Open (as admin) your ConfigurationSetup.cfg:
   - Typical locations:
     - ORD CE: `C:\ProgramData\Bentley\OpenRoads Designer CE\Configuration\ConfigurationSetup.cfg`
     - ORD 2023: `C:\ProgramData\Bentley\OpenRoads Designer 2023\Configuration\ConfigurationSetup.cfg`

3. Add or update:
   ```
   # Custom Configuration root
   _USTN_CUSTOM_CONFIGURATION = C:/Workspaces/UK_ORD_GG184/

   # (Optional) Workspace/WorkSet roots
   _USTN_WORKSPACESROOT = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
   _USTN_WORKSETSROOT   = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/

   # (Optional) Name the Organization layer
   CIVIL_ORGANIZATION_NAME = UK_ORD_GG184
   ```

4. Launch ORD. On the WorkPage, choose the “Custom Configuration” if prompted, then select Workspace “UK_ORD_GG184” and a WorkSet.

### Option B — Network (team)

1. Place (or clone) this repo to a read-only share, e.g.:
   - `\\YourServer\Design\UK_ORD_GG184\`

2. Update ConfigurationSetup.cfg:
   ```
   _USTN_CUSTOM_CONFIGURATION = //YourServer/Design/UK_ORD_GG184/
   _USTN_WORKSPACESROOT       = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
   _USTN_WORKSETSROOT         = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/
   CIVIL_ORGANIZATION_NAME    = UK_ORD_GG184
   ```

3. Restart ORD and select the “UK_ORD_GG184” Workspace. Ensure users have suitable permissions for WorkSets and project deliverables.

### Option C — ProjectWise (optional)

Mirror the contents into a Managed Workspace or point your PW Managed Configuration to this structure. Keep the folder layout and variables. Coordinate with your PW administrator for deployment.

---

## Typical Folder Layout

Adjust to match the actual repository structure—this reflects common ORD organisation.

```
UK_ORD_GG184/
├─ Organization/
│  ├─ Standards/
│  │  ├─ DGNLIB/                    # Levels, Text, Dim, Feature Symbology, Annotation, Feature Definitions
│  │  ├─ Cells/                     # .cel libraries (title blocks, symbols)
│  │  ├─ Linestyles/                # .rsc or DGNLIB-based linestyles
│  │  ├─ Materials/                 # Material definitions, color books
│  │  ├─ Reports/                   # XML/XSLT/CSV templates for reports
│  │  ├─ ItemTypes/                 # Item Type DGNLIBs (SHW/MMHW/ADMM/bsDD mappings)
│  │  ├─ Templates/                 # Civil/ITL templates (if used)
│  │  ├─ Seed/                      # Design/Drawing/Sheet seed DGNs
│  │  ├─ GeoCoord/                  # GCS files or notes (e.g., OSGB/BNG)
│  │  └─ Config/                    # .cfg files binding resources and variables
│  └─ WorkSpaces/
│     └─ UK_ORD_GG184/              # Workspace root (cfg + standards references)
├─ WorkSets/
│  └─ <YourProject>/
├─ _ConfigSamples/
└─ README.md
```

---

## Key Configuration Variables

- `_USTN_CUSTOM_CONFIGURATION` — Root folder of this repo
- `_USTN_WORKSPACESROOT` — Path to WorkSpaces/
- `_USTN_WORKSETSROOT` — Path to WorkSets/
- `CIVIL_ORGANIZATION_NAME` — Friendly name for the Organization layer

Common resource bindings (usually set in Organization/Config .cfg):

```
# DGNLIBs (levels, text, dim, feature symbology, annotation, feature defs)
MS_DGNLIBLIST                 > $(_USTN_ORGANIZATION)Standards/DGNLIB/*.dgnlib

# Cells
MS_CELL                       > $(_USTN_ORGANIZATION)Standards/Cells/

# Linestyles (RSC or DGNLIB)
MS_SYMBRSRC                   > $(_USTN_ORGANIZATION)Standards/Linestyles/*.rsc

# Seed files
MS_SEEDFILES                  > $(_USTN_ORGANIZATION)Standards/Seed/*.dgn
MS_DESIGNSEED                 > $(_USTN_ORGANIZATION)Standards/Seed/DesignSeed.dgn
MS_DRAWINGSEED                > $(_USTN_ORGANIZATION)Standards/Seed/DrawingSeed.dgn
MS_SHEETSEED                  > $(_USTN_ORGANIZATION)Standards/Seed/SheetSeed.dgn

# Reports, Materials, Item Types
CIVIL_REPORTS_DIRECTORY       > $(_USTN_ORGANIZATION)Standards/Reports/
MS_MATERIAL                   > $(_USTN_ORGANIZATION)Standards/Materials/
MS_ITEMTYPES                  > $(_USTN_ORGANIZATION)Standards/ItemTypes/*.dgnlib
```

Tip: Use “>” to append and “:=” to replace search paths. Prefer portable paths.

---

## Standards Mapping (MCHW/SHW, MMHW, ADMM, bsDD)

This workspace aligns assets and metadata to UK documentation and bsDD:

- MCHW/SHW: Feature Definitions and symbology can be grouped or named by relevant Series/Clauses (e.g., pavements, earthworks, drainage).
- MMHW: Maintenance-focused Item Types to capture inspection, service life, and maintainability attributes.
- ADMM: Item Types to capture administrative or delivery/management metadata as required by your programme.
- bsDD: Item Types include bsDD properties with namespace/identifier (GUID) where applicable, to support interoperable data exchange.

> Versioning: Pin your project to the intended publication/version of SHW/MMHW/ADMM and record it in your WorkSet readme or metadata. Update mappings as publications evolve.

---

## Feature Definitions Provided

Feature Definitions are organised in DGNLIBs with corresponding Feature Symbology and Element Templates. Naming and grouping are designed to reflect maintainable assets and construction elements as referenced in MCHW/SHW, MMHW, and ADMM.

Core coverage includes:

1. Alignments (Geometry)
   - Horizontal Alignment Feature Definitions (e.g., Design, Control, Land Boundaries)
   - Vertical Alignments / Profiles (Design, Existing, Control)
   - Associated Feature Symbology and Element Templates for 2D/3D representation
   - Typical examples:
     - Alignment.Design.Centreline
     - Alignment.Control.SettingOut
     - Profile.Design.Primary
     - Profile.Existing.Survey

2. Corridors and Components
   - Corridor Feature Definitions for model containers
   - Linear Features for edges, centrelines, kerbs, channels, barriers (mapped to SHW Series where helpful)
   - Components for pavement layers, verges, footways/cycleways, earthworks, drainage elements
   - Earthworks Feature Definitions (cut/fill, embankment, formation)
   - Typical examples:
     - Corridor.Design.Standard
     - Linear.Kerb.HB2.SHW_1100
     - Pavement.SurfaceCourse.SHW_910
     - Earthworks.Cut.Slope1in3
     - Drainage.Pipe.SHW_500

3. Profiles (explicit)
   - Profile Feature Definitions for vertical design and existing ground
   - Symbology for annotation/labels to UK scales

Each Feature Definition is paired with:
- Feature Symbology for model/drawing annotation
- Element Templates for level/style/colour/linestyle
- Item Type associations for specification and asset metadata (see next section)

> DGNLIB structure suggestion:
> - Geometry_FeatureDefinitions.dgnlib
> - Corridor_FeatureDefinitions.dgnlib
> - Earthworks_FeatureDefinitions.dgnlib
> - Drainage_FeatureDefinitions.dgnlib
> - Symbology_*.dgnlib
> - Templates_*.dgnlib

---

## Item Types and Data Model (SHW/MMHW/ADMM + bsDD)

Item Types are included to encode specification metadata and support downstream data exchange.

Common Item Type groups:

- Spec.Reference
  - Standard: Enum [SHW, MMHW, ADMM, Other]
  - Series: Text/Enum (e.g., “1100”)
  - Clause: Text (e.g., “1101”)
  - Class/Type: Text (e.g., material class)
  - Version: Text (publication/date)

- Asset.Classification
  - AssetType: Enum (e.g., Pavement, Kerb, Barrier, Drainage, Earthwork, Alignment)
  - Maintainable: Bool
  - InspectionInterval: Text/Duration
  - ServiceLifeTarget: Number/Years

- bsdd.Mapping
  - bsdd.PropertySet: Text (Pset name)
  - bsdd.PropertyName: Text
  - bsdd.Identifier: Text (GUID/IRI)
  - bsdd.Unit: Text
  - bsdd.ValueType: Text (e.g., String, Number, Enum)

- Construction.Delivery
  - Product: Text
  - Manufacturer: Text
  - Model/Type: Text
  - Certification/DoP: Text/Link

Binding strategy:

- Default Item Types are associated to Feature Definitions via DGNLIB so placed elements automatically carry metadata.
- For components created by templates, ensure the Component Feature Definition carries the same Item Type association.
- Use Pick Lists/Enums to control values for Series, Clauses, and Asset Types to improve data quality.

> Optional: Provide a mapping table (XSLT/CSV) to transform internal Item Type names to client-specific deliverable schemas.

---

## Using the Workspace

1. Launch ORD and select:
   - Configuration: Custom (if prompted)
   - Workspace: “UK_ORD_GG184”
   - WorkSet: Choose or create a project WorkSet (generates a DGNWS file)

2. Start a new design file:
   - Use provided seeds (Design/Drawing/Sheet) to ensure metric units, working units, GCS, annotation scales, and sheet sizes.

3. Geometry and Profiles:
   - Create Horizontal/Vertical geometry using the provided Alignment/Profile Feature Definitions.
   - Use the corresponding Annotation Groups and UK scales (1:200, 1:250, 1:500, 1:1000, etc.).

4. Corridors:
   - Apply Corridor Feature Definitions and template libraries.
   - Use Linear Feature Definitions for kerbs, channels, edges, barriers mapped to SHW/MMHW as needed.
   - Ensure components (pavement, earthworks, drainage) use the correct Feature Definitions so Item Types attach.

5. Metadata:
   - Verify Item Types on placed elements (Properties > Item Types).
   - Populate Spec.Reference (SHW/MMHW/ADMM) and bsDD fields where required by the BEP.
   - Use Reports to extract schedules or quantities with these properties.

6. Drawing Production:
   - Use Drawing and Sheet Seeds to create plans/profiles/sections.
   - Detailing Symbols, labels and title blocks are managed via DGNLIBs.
   - Item Types can feed title blocks and schedules where configured.

---

## Extending or Adding Feature Definitions

- Clone an existing FD near your need (e.g., Kerb HB2) and adjust naming, symbology, and Item Types.
- Keep naming consistent, e.g.:
  - Domain.Subdomain.Object.[SHWSeries/Clause]
  - Example: Linear.Kerb.HB2.SHW_1100
- Update:
  - Feature Symbology (model/drawing)
  - Element Template (level/style)
  - Item Type bindings (Spec.Reference, Asset.Classification, bsdd.Mapping)
- Validate by:
  - Placing a test element
  - Checking annotation output
  - Running a report to confirm Item Type values are present

---

## UK-Specific Notes

- Units: Metric (m, mm); seeds and styles assume UK practice.
- Coordinate System: British National Grid (OSGB36 / EPSG:27700) recommended unless otherwise specified.
- Scales and Symbology: Configured for typical UK deliverable scales.
- Standards: Align Feature Definitions and Item Types with MCHW/SHW, MMHW, ADMM. Confirm the version required for your contract.

---

## Reporting

- Use the Reports templates in Standards/Reports for:
  - Quantities by Feature Definition / SHW Series
  - Asset registers including MMHW fields
  - Data drops with bsDD properties
- Export to CSV/Excel; tailor XSLT/CSV mappings as needed for client formats.

---

## Updating the Workspace

- Pull the latest changes:
  ```
  git pull origin main
  ```
- For network deployments, update from a tagged release or known-good commit.
- Users should restart ORD after updates to reload DGNLIBs and configuration.

---

## Troubleshooting

- Workspace not appearing:
  - Check `_USTN_CUSTOM_CONFIGURATION` and trailing slash
  - Confirm permissions and expected folder layout

- Missing styles/levels/FDs:
  - Verify MS_DGNLIBLIST and related search paths
  - In ORD, check Configuration Variables to confirm resolved paths

- Cache/prefs issues after updates:
  - Close ORD and clear user prefs cache:
    - `%LOCALAPPDATA%\Bentley\OpenRoadsDesigner\` (delete/rename versioned folders)
  - Relaunch ORD

- Incorrect seed scale/units:
  - Start from provided seeds
  - Confirm Drawing and Annotation Scales before placing text/labels

---

## Contributing

- Fork and use feature branches
- Submit pull requests with clear descriptions and example outputs
- Maintain backward compatibility in DGNLIBs and seeds where possible
- Update this README when adding standards or breaking changes

---

## Roadmap

- Broaden FD coverage for additional SHW/MMHW/ADMM assets
- Expand Annotation Groups for more drawing types
- Add more report templates (BoQ, drainage schedules, pavement)
- Provide a sample WorkSet with demo data and example sheets
- Optional ProjectWise deployment pack

---

## License

Unless otherwise stated in a LICENSE file, this content is provided “as is.” Respect any third‑party licenses for included resources (fonts, transformations, symbol libraries).

---

## Support

- Open a repository issue including:
  - ORD version and OS version
  - Steps to reproduce
  - Screenshots/logs if helpful
- Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)

---

## Appendix A: Example Feature Definition Inventory (indicative)

- Alignment
  - Alignment.Design.Centreline
  - Alignment.Control.SettingOut
  - Profile.Design.Primary
  - Profile.Existing.Survey
- Corridor and Linear Features
  - Corridor.Design.Standard
  - Linear.EdgeOfPavement.MainCarriageway
  - Linear.Kerb.HB2.SHW_1100
  - Linear.Channel.SHW_1100
  - Barrier.Vehicle.Steel.SHW_1100
- Pavement Components
  - Pavement.SurfaceCourse.SMA.SHW_910
  - Pavement.BinderCourse.DBBM.SHW_910
  - Pavement.Base.CBGM.SHW_890
  - Pavement.Subbase.Type1.SHW_803
- Earthworks
  - Earthworks.Cut.Slope1in3
  - Earthworks.Fill.Slope1in2
  - Earthworks.Formation.SHW_600
- Drainage (indicative)
  - Drainage.Pipe.UPVC.SHW_500
  - Drainage.MH.PrecastConcrete.SHW_500
  - Drainage.Gully.Grating.SHW_500

Map or rename to match your client specification.

---

## Appendix B: Sample Item Types (fields)

- Spec.Reference
  - Standard: SHW
  - Series: 1100
  - Clause: 1101
  - Class: HB2
  - Version: 2025-xx
- Asset.Classification
  - AssetType: Kerb
  - Maintainable: true
  - InspectionInterval: 12 months
  - ServiceLifeTarget: 20
- bsdd.Mapping
  - bsdd.PropertySet: Pset_Kerb
  - bsdd.PropertyName: Material
  - bsdd.Identifier: {guid-or-iri}
  - bsdd.Unit: -
  - bsdd.ValueType: Enum
