class NavMeshGoalFilter_OutSideOfDotProductWedge extends NavMeshGoal_Filter
    native(AI)
    config(Engine);

var transient Vector Location;
var transient Vector Rotation;
var transient float Epsilon;

function bool OutsideOfDotProductWedge(NavMeshGoal_GenericFilterContainer FilterContainer, Vector InLocation, Rotator InRotation, float InEpsilon) { }
