class SplineMeshComponent extends StaticMeshComponent
    native(Mesh)
    editinlinenew
    hidecategories(Object);

struct native SplineMeshParams
{
    var Vector StartPos;
    var Vector StartTangent;
    var Vector2D StartScale;
    var float StartRoll;
    var Vector2D StartOffset;
    var Vector EndPos;
    var Vector EndTangent;
    var Vector2D EndScale;
    var float EndRoll;
    var Vector2D EndOffset;

    structdefaultproperties
    {
        StartPos=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        StartTangent=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        StartScale=(X=0.0000000,Y=0.0000000)
        StartRoll=0.0000000
        StartOffset=(X=0.0000000,Y=0.0000000)
        EndPos=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        EndTangent=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        EndScale=(X=0.0000000,Y=0.0000000)
        EndRoll=0.0000000
        EndOffset=(X=0.0000000,Y=0.0000000)
    }
};

var SplineMeshParams SplineParams;
var Vector SplineXDir;
var bool bSmoothInterpRollScale;

defaultproperties
{
    SplineXDir=(X=1.0000000,Y=0.0000000,Z=0.0000000)
    ReplacementPrimitive=none
    bUseAsOccluder=false
    bUsePrecomputedShadows=true
}