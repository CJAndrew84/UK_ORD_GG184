# Plan: Role‑Based Workflow Replacement in **UK_ORD_GG184** Workspace

> Objective: Replace Bentley’s delivered workflows (e.g., *OpenRoads Modeling*, *Drawing Production*, *OpenRail Modeling*) with **task‑role–based workflows** curated for the UK_ORD_GG184 workspace — without modifying Bentley’s installed content.

---

## 1) Goals & Non‑Goals

### Goals
- Hide Bentley-delivered GUI workflows and tasks from end users.
- Provide **role‑based workflows** (e.g., *Designer*, *Drainage*, *Earthworks*, *Reviewer*, *CAD Manager*).
- Keep configuration **upgrade‑safe** (no edits under `Program Files`).
- Make the solution **ProjectWise‑friendly** and **local‑install friendly**.
- Document a repeatable process to **add/retire roles** and **evolve ribbons**.

### Non‑Goals
- Rebuilding every single Bentley tool group 1:1 (we’ll expose the essential, UK‑specific ones).
- Changing ORD licensing or schema behavior.
- Providing corporate‑specific IP; this remains a public baseline.

---

## 2) Architecture Overview

ORD loads GUI content from DGN libraries referenced by config variables. We will:
1. **Clear** Bentley’s default GUI DGNLib lists.
2. **Point** the lists at our **Organization/GUI/** folders.
3. Provide **one DGNLib per role**. Each DGNLib contains exactly one workflow with curated tasks/ribbons.
4. Optionally **auto‑select** a workflow at startup based on role/environment (local or ProjectWise).

Key variables:
- `_USTN_WORKFLOWDGNLS` → list of DGNLibs that define **Workflows**
- `_USTN_TASKDGNLS`     → list of DGNLibs that define **Tasks/Ribbons**
- `MS_GUIDGNLIBLIST`    → general GUI DGNLibs (toolboxes, etc.)

---

## 3) Folder Structure (Proposed)

```
Organization/
  GUI/
    Workflows/
      UKGG184_WF_Designer.dgnlib
      UKGG184_WF_Drainage.dgnlib
      UKGG184_WF_Earthworks.dgnlib
      UKGG184_WF_Reviewer.dgnlib
      UKGG184_WF_CADManager.dgnlib
    Tasks/
      UKGG184_TaskGroups_Common.dgnlib
      UKGG184_Tasks_Designer.dgnlib
      UKGG184_Tasks_Drainage.dgnlib
      UKGG184_Tasks_Earthworks.dgnlib
      UKGG184_Tasks_Reviewer.dgnlib
      UKGG184_Tasks_CADManager.dgnlib
    Icons/   (optional: custom PNG/SVG)
    Readme.md
  Standards/...
  WorkSpaces/UK_ORD_GG184/...
```

> **Naming rule:** `UKGG184_WF_<Role>.dgnlib` for workflows; `UKGG184_Tasks_<Role>.dgnlib` for tasks; keep a single `*_Common` for shared ribbons/tool groups.

---

## 4) Configuration (CFG) Changes

Create/extend a GUI config include at:
```
Organization/Standards/Config/UK_ORD_GG184_GUI.cfg
```

**Minimal viable setup (hides Bentley, loads ours):**
```cfg
# 1) Clear delivered GUI lists
_USTN_WORKFLOWDGNLS >
_USTN_TASKDGNLS >

# 2) Point to our Organization GUI folders
_USTN_WORKFLOWDGNLS > $(_USTN_CUSTOM_CONFIGURATION)Organization/GUI/Workflows/
_USTN_TASKDGNLS     > $(_USTN_CUSTOM_CONFIGURATION)Organization/GUI/Tasks/

# 3) (Optional) also include our GUI libs in general list
MS_GUIDGNLIBLIST > $(_USTN_CUSTOM_CONFIGURATION)Organization/GUI/Workflows/
MS_GUIDGNLIBLIST > $(_USTN_CUSTOM_CONFIGURATION)Organization/GUI/Tasks/
```

**Optional: Role‑based auto‑selection**
```cfg
# Example: Evaluate role via env var or PW attribute
# Set UKGG184_ROLE externally (login script / PW user group mapping)
%if $(UKGG184_ROLE) == "Drainage"
    _USTN_WORKFLOW = UKGG184_Drainage
%elif $(UKGG184_ROLE) == "Earthworks"
    _USTN_WORKFLOW = UKGG184_Earthworks
%elif $(UKGG184_ROLE) == "Reviewer"
    _USTN_WORKFLOW = UKGG184_Reviewer
%elif $(UKGG184_ROLE) == "CADManager"
    _USTN_WORKFLOW = UKGG184_CADManager
%else
    _USTN_WORKFLOW = UKGG184_Designer
%endif
```

**ProjectWise include (example CSB fragment):**
```cfg
%if exists ($(_USTN_CUSTOM_CONFIGURATION)Organization/Standards/Config/UK_ORD_GG184_GUI.cfg)
  %include $(_USTN_CUSTOM_CONFIGURATION)Organization/Standards/Config/UK_ORD_GG184_GUI.cfg
%endif
```

---

## 5) Role Definitions (Initial Cut)

**Designer**  
- Geometry creation, corridor modeling, profiles, annotation, reporting, model review.
- Drawing production shortcuts: sheet seeds, named boundaries, plan‑profile‑section.

**Drainage**  
- Subsurface utilities (SUDA/SUE), nodes/links libraries, hydraulic analysis access, drainage reports.

**Earthworks**  
- Terrain tools, earthworks volumes, end‑area volumes reports, mesh utilities, cut/fill annotation.

**Reviewer**  
- Read‑only navigation, section cutting, measurements, basic annotation, clash/QA reports.

**CAD Manager**  
- Workspace audits, cache management, standards sync, seed/DGNLIB editors, variable inspector.

> Keep each role **focused**. If a tool is needed across roles, put it in `*_Common.dgnlib` and reference it as a shared ribbon/tab group.

---

## 6) Build Steps

1. **Scaffold DGNLibs**  
   - Create empty DGNLibs per the folder structure.
   - In each Workflow DGNLib: define **one** Workflow (name must match `_USTN_WORKFLOW` values above).

2. **Curate Ribbons & Tasks**  
   - Start from a white‑sheet ribbon. Add groups in the order users work: *Start → Model → Annotate → Check → Deliver*.
   - Pull only required commands (reduce cognitive load).

3. **Common Library**  
   - Create `UKGG184_TaskGroups_Common.dgnlib` for shared panels (Selection, View, References, Levels).

4. **Icons (optional)**  
   - Store role icons under `Organization/GUI/Icons/`. Reference in ribbon definitions.

5. **Variable Control**  
   - Add `UK_ORD_GG184_GUI.cfg` include to your existing WorkSpace CSB/CFG chain.

6. **Disable Personal Overrides** (optional but recommended)  
   ```cfg
   MS_PERSONALDGNLIBLIST =
   MS_GUIDGNLIBLISTFilterOut = Personal.dgnlib
   ```

---

## 7) Test Plan & Acceptance Criteria

### Environments
- **Local**: Windows 10/11, ORD 10.12 + 2023.2
- **PW Managed**: PW Explorer 10.00.03+, same ORD versions

### Test Cases
- **TC‑01**: Default delivered workflows are **not visible**.
- **TC‑02**: Selecting **UK_ORD_GG184** workspace loads only role‑based workflows.
- **TC‑03**: Role env var `UKGG184_ROLE=Drainage` opens the Drainage workflow at startup.
- **TC‑04**: Common task groups appear across all roles.
- **TC‑05**: Sheet creation works from curated ribbon (Named Boundaries → Sheets).

### Acceptance Criteria
- All TC‑01..TC‑05 pass on both Local and ProjectWise.
- No errors in Message Center related to missing DGNLibs.
- Startup time not degraded by more than 10% vs baseline.
- Documentation updated (Quick Start & Troubleshooting).

---

## 8) Rollout Strategy

**Phase 0 – Prototype (You only)**  
- Implement Designer + Reviewer.  
- Validate on a demo WorkSet.

**Phase 1 – Pilot (2–5 users)**  
- Add Drainage and Earthworks.  
- Collect feedback; adjust ribbon groups.

**Phase 2 – Public Beta**  
- Tag `v0.2.0‑gui` and publish release notes.  
- Provide GIFs/screenshots of each role workflow.

**Phase 3 – Stabilize**  
- Lock tool IDs, avoid breaking changes.  
- Document deprecation policy for ribbon moves.

**Rollback**  
- Comment out the GUI include and restore defaults by removing the `GUI/*.dgnlib` references.

---

## 9) Governance & Change Control

- **Single owner** for GUI decisions (you, as curator).  
- Proposals via GitHub Issues (template: *“GUI Change Request”*).  
- Use **semver qualifiers** (e.g., `v0.2.0‑gui`) for GUI releases.  
- Maintain a **mapping table** of Tool → Ribbon → Role in `/docs/gui_map.csv`.

---

## 10) Documentation To‑Do

- Update **README Quick Start** with role explanation + one‑liner install.
- Add **/docs/GUI_Setup.md** (this plan → simplified consumer version).
- Add **Troubleshooting** FAQ (Missing ribbon, cache, Personal.dgnlib disabled, etc.).
- Add **PW Admin** note on setting `UKGG184_ROLE` via user groups or environment mapping.

---

## 11) Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Users can’t find a hidden tool | Provide search panel + `/docs/gui_map.csv` index |
| ORD update adds new essentials | Quarterly review of delivered ribbons; add selectively |
| Personal.dgnlib conflicts | Disable personal DGNLib; purge GUI cache on upgrade |
| PW path resolution | Use absolute `_USTN_CUSTOM_CONFIGURATION`; test offline mode |

---

## 12) Deliverables Checklist

- [ ] `Organization/GUI/Workflows/*.dgnlib` (roles)
- [ ] `Organization/GUI/Tasks/*.dgnlib` (role + common)
- [ ] `Organization/Standards/Config/UK_ORD_GG184_GUI.cfg`
- [ ] `/docs/GUI_Setup.md` + screenshots/GIFs
- [ ] `/docs/gui_map.csv` (tool index)
- [ ] Release notes `v0.2.0‑gui`

---

## 13) Appendix A — Sample Empty Workflow DGNLib Steps

1. File → New → DGNLib (2D) → Name `UKGG184_WF_Designer.dgnlib`  
2. Ribbon > **Workflow** manager → Create Workflow: **UKGG184_Designer**  
3. Add Tabs: `Start`, `Model`, `Annotate`, `Check`, `Deliver`  
4. Add Groups under each tab; populate with commands via Customize (drag from Available Tools).  
5. Save. Repeat for other roles.

---

## 14) Appendix B — Example GUI Mapping CSV (snippet)

```csv
Role,Tab,Group,Command,Tool ID,Notes
Designer,Model,Geometry,Complex By Elements,XYZ123,Primary geometry tool
Designer,Annotate,Labels,Element Annotation,XYZ456,Uses UK text styles
Drainage,Model,SUDA,Place Node,SUDA001,Uses drainage feature defs
Reviewer,Check,Review,Measure Between Points,MEAS01,Read-only toolset
```

---

## 15) Appendix C — Message Center / Cache Tips

- If ribbon updates don’t appear: delete GUI cache in `%LOCALAPPDATA%\Bentley\OpenRoadsDesigner\10\GuiCache` and restart.  
- Confirm which DGNLibs are loaded: `Utilities → Key-In → dgnlib list`  
- Log variables: `Utilities → Key-In → expand echo on` and review startup log.

---

**End of Plan** — Ready for implementation and pilot.
