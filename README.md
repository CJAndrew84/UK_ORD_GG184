# UK_ORD_GG184 — OpenRoads Designer Workspace

A curated OpenRoads Designer (ORD) workspace aligned to UK practice, intended to provide consistent standards, seeds, symbology, and production assets. This repository is designed to be used as a complete “Custom Configuration” so teams can get up-and-running quickly and produce repeatable, standards-compliant deliverables.

If you’re new to Bentley configurations, think of this as the “Organization” layer you point ORD at, and then you select the provided Workspace/WorkSet inside ORD.

- Repository: [UK_ORD_GG184](https://github.com/CJAndrew84/UK_ORD_GG184)
- Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)

## Highlights

- UK-centric defaults (units, annotation scales, drawing seeds, level libraries)
- Feature Definitions/Symbology for common ORD civil tasks (corridors, geometry, terrain, drainage)
- Drawing/Sheet seed files and drawing production rules for plans, profiles, sections
- Centralized DGNLIBs: levels, text styles, dimension styles, annotation definitions
- Ready-to-use title blocks, cells and item types for metadata
- Reporting templates (quantities, schedules) and example configuration

> Note: GG 184 references and compliance are provided as a guide. Validate against your client’s/latest DMRB requirements and project BEP.

---

## Quick Start

1. Download or clone this repo to a local or network path.
2. Point ORD to this path as your “Custom Configuration”.
3. Launch ORD, pick the “UK_ORD_GG184” Workspace, and use or create a WorkSet.
4. Start modeling/drawing with the provided seeds and standards.

Detailed steps follow.

---

## Prerequisites

- OpenRoads Designer (2022 R3 or newer recommended). 2023+ is preferred.
- Windows 10/11 with permission to read/write the configuration location.
- Optional: Network share if you are deploying for a team.

---

## Installation Options

You can use this configuration either locally, from a shared network location, or managed by ProjectWise. Choose one option below.

### Option A — Local (single user)

1. Place (or clone) this repository somewhere local, e.g.:
   - `C:\Workspaces\UK_ORD_GG184\`

2. Open (as admin) your ConfigurationSetup.cfg:
   - Typical locations:
     - ORD CE: `C:\ProgramData\Bentley\OpenRoads Designer CE\Configuration\ConfigurationSetup.cfg`
     - ORD 2023: `C:\ProgramData\Bentley\OpenRoads Designer 2023\Configuration\ConfigurationSetup.cfg`

3. Add or update:
   ```
   # Point to your custom configuration root folder (the folder that contains Organization/WorkSpaces/WorkSets, etc.)
   _USTN_CUSTOM_CONFIGURATION = C:/Workspaces/UK_ORD_GG184/

   # (Optional) Make Workspace/WorkSet roots explicit
   _USTN_WORKSPACESROOT = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
   _USTN_WORKSETSROOT   = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/

   # (Optional) Give the Organization a name
   CIVIL_ORGANIZATION_NAME = UK_ORD_GG184
   ```

4. Launch ORD. In the WorkPage, switch Configuration to “Custom Configuration” if prompted, then select Workspace “UK_ORD_GG184” and the appropriate WorkSet.

### Option B — Network (team deployment)

1. Place (or clone) this repo to a read-only network share, e.g.:
   - `\\YourServer\Design\UK_ORD_GG184\`

2. Update ConfigurationSetup.cfg:
   ```
   _USTN_CUSTOM_CONFIGURATION = //YourServer/Design/UK_ORD_GG184/
   _USTN_WORKSPACESROOT       = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
   _USTN_WORKSETSROOT         = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/
   CIVIL_ORGANIZATION_NAME    = UK_ORD_GG184
   ```

3. Ask users to restart ORD and select the “UK_ORD_GG184” Workspace. For write access to WorkSets (DGNWS) or project deliverables, ensure appropriate permissions.

### Option C — ProjectWise (optional)

If you manage standards through ProjectWise, mirror the contents into a Managed Workspace or point your PW Managed Configuration to this structure. Maintain the same folder layout and variables. Coordinate with your PW administrator for deployment.

---

## Typical Folder Layout

Adjust to match the actual repository structure—this reflects common ORD organization.

```
UK_ORD_GG184/
├─ Organization/                    # Organization-level resources
│  ├─ Standards/
│  │  ├─ DGNLIB/                    # Levels, Text Styles, Dim Styles, Feature Symbology, Annotation, etc.
│  │  ├─ Cells/                     # .cel libraries
│  │  ├─ Linestyles/                # .rsc, .linestyle dgnlibs
│  │  ├─ Materials/                 # Material definitions, color books
│  │  ├─ Reports/                   # XML/XSLT/Excel templates for ORD reports
│  │  ├─ ItemTypes/                 # Item type libraries
│  │  ├─ Templates/                 # Civil/ITL templates (if used)
│  │  ├─ Seed/                      # Design/Drawing/Sheet seed DGNs
│  │  ├─ GeoCoord/                  # GCS files or notes for BNG/OSGB (if applicable)
│  │  └─ Config/                    # .cfg that bind resources and variables
│  └─ WorkSpaces/
│     └─ UK_ORD_GG184/              # Workspace root (cfg + standards references)
├─ WorkSets/
│  └─ <YourProject>/                # Project-specific area (DGNWS, project assets)
├─ _ConfigSamples/                  # Example cfg snippets (if provided)
└─ README.md
```

---

## Key Configuration Variables

Use these to wire up the workspace or override paths if needed.

- `_USTN_CUSTOM_CONFIGURATION` — Root folder of this repo
- `_USTN_WORKSPACESROOT` — Path to WorkSpaces/
- `_USTN_WORKSETSROOT` — Path to WorkSets/
- `CIVIL_ORGANIZATION_NAME` — Friendly name for the Organization layer

Common resource bindings (typically set inside your Organization/Config .cfg files):

```
# DGNLIBs (levels, text/dim styles, feature symbology, annotation definitions)
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

# References, Reports, Materials, Item Types
MS_RFDIR                      > $(_USTN_ORGANIZATION)Standards/References/
CIVIL_REPORTS_DIRECTORY       > $(_USTN_ORGANIZATION)Standards/Reports/
MS_MATERIAL                   > $(_USTN_ORGANIZATION)Standards/Materials/
MS_ITEMTYPES                  > $(_USTN_ORGANIZATION)Standards/ItemTypes/*.dgnlib
```

> Tip: Use “>” to append to existing search paths, and “:=” to replace. Keep paths portable (avoid hard-coded user profiles).

---

## Using the Workspace

1. Launch ORD and select:
   - Configuration: Custom (if prompted)
   - Workspace: “UK_ORD_GG184”
   - WorkSet: Choose an existing one or create a new project WorkSet (generates a DGNWS file)

2. Start a new design file:
   - Use provided seeds (Design/Drawing/Sheet) to ensure correct units (metric), working units, GCS, annotation scales, and sheet sizes.

3. Modeling & Standards:
   - Geometry, Terrain, Corridor, Drainage: Use Feature Definitions provided by the DGNLIBs.
   - Annotation: Use Annotation Groups/Definitions aligned to UK scales (1:200, 1:250, 1:500, 1:1000, etc.).
   - Levels: Managed by the level DGNLIB; avoid creating ad-hoc levels.
   - Text/Dimensions: Use the configured styles. Avoid manual overrides unless required.

4. Drawing Production:
   - Use Drawing and Sheet Seeds to create plans/profiles/sections.
   - Manage Detailing Symbols via DGNLIB so callouts and labels are consistent.
   - Title blocks and Item Types populate default metadata (project, sheet number, revision).

5. Reporting:
   - Use the Reports folder templates for quantities, schedules, or Civil reports (Corridor, Superelevation, etc.).
   - Export to CSV/Excel as needed; adjust XSLT templates to suit the client format.

---

## UK-Specific Notes

- Units: Metric (m, mm); seed files and styles assume UK practice.
- Coordinate System: British National Grid (OSGB36 / EPSG:27700) recommended for UK projects unless otherwise specified. Confirm OSTN/OSGM transformations are installed/licensed as needed.
- Scales and Symbology: Provided styles target common UK deliverable scales. Validate against client standards and GG 184-related requirements.

---

## Updating the Workspace

- Pull the latest changes from the repository:
  ```
  git pull origin main
  ```
- If deploying on a network share, update the share from a known-good release tag or commit.
- Notify users to restart ORD after updates to reload DGNLIBs and configuration.

---

## Troubleshooting

- Workspace not appearing:
  - Recheck `_USTN_CUSTOM_CONFIGURATION` path and trailing slash.
  - Confirm permissions and that the folder contains Organization/WorkSpaces structure.

- Styles/levels missing:
  - Verify MS_DGNLIBLIST and other search paths in Organization/Config .cfg files.
  - In ORD, open Configuration Variables dialog to confirm resolved paths.

- Cache/prefs issues after updates:
  - Close ORD and clear user prefs cache:
    - `%LOCALAPPDATA%\Bentley\OpenRoadsDesigner\` (delete or rename versioned folders like `10.0.x` / `23.x`)
  - Relaunch ORD.

- Seed scale or units incorrect:
  - Start from provided seed files.
  - Check Drawing Scale and Annotation Scale before placing text/labels.

---

## Contributing

- Fork the repo and create feature branches.
- Use pull requests with a clear description and example outputs.
- Keep DGNLIBs and seeds backward compatible where possible.
- Update this README when introducing new standards or breaking changes.

---

## Roadmap

- Expand Feature Definitions and Annotation Groups for additional disciplines.
- Add more report templates (BoQ, drainage schedules, pavement).
- Provide sample WorkSet with demonstration data and example sheets.
- Optional ProjectWise deployment pack.

---

## License

Unless otherwise stated in a LICENSE file, this content is provided “as is” without warranty. Check and honor any third‑party licenses for included resources (fonts, transformations, symbol libraries).

---

## Support

- Open an issue in the repository with:
  - ORD version, OS version
  - Steps to reproduce
  - Screenshots and logs (if applicable)
- Maintainer: [@CJAndrew84](https://github.com/CJAndrew84)

---

## Appendix: Sample ConfigurationSetup.cfg

```
# Custom Configuration root
_USTN_CUSTOM_CONFIGURATION = C:/Workspaces/UK_ORD_GG184/

# Workspace/WorkSet roots
_USTN_WORKSPACESROOT = $(_USTN_CUSTOM_CONFIGURATION)WorkSpaces/
_USTN_WORKSETSROOT   = $(_USTN_CUSTOM_CONFIGURATION)WorkSets/

# Organization name
CIVIL_ORGANIZATION_NAME = UK_ORD_GG184
```

Replace `C:/Workspaces/UK_ORD_GG184/` with your actual path, e.g. `//Server/Design/UK_ORD_GG184/` for network.

---

If you’d like, I can tailor this README to the exact folders and assets in this repo and commit it for you. Please confirm:
- ORD version(s) you want to officially support
- Target deployment (local, network, ProjectWise)
- Actual folder structure if it differs from the “Typical” layout above
- Any client-specific requirements (naming, title blocks, report formats)
