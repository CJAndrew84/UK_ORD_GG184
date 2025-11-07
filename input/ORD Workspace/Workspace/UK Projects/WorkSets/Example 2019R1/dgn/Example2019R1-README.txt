The 'Example 2019R1' WorkSet uses the 'UK Projects' WorkSpace.

Files
=====

1-Terrain.dgn 	: The existing terrain element.
2-Geometry.dgn	: Proposed centreline of the new road.
3-Corridor.dgn	: Corridor using centreline from '2-Geometry.dgn' as its baseline
4-PlanProfiles.dgn	: Plan and Profiles Drawing and Sheet models stored in this file. It references the files above.
5-VolumesXSections.dgn	: Cut and fill meshes, and cross sections stored in this file. The cross sections annotate the End Area Volumes details. This references the first 3 files above.

Notes
=====
This example shows just one way of organising the project data. It is not meant to be 'endorse' one methos over another, but it shows the ability to federate the data. For example, the superelevation data in '3-Corridor.dgn' could have been stored in '2-Geometry.dgn', or in a completely separate file.
