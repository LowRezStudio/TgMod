class KMeshProps extends Object
    native
    noexport;

struct KSphereElem
{
    var() editconst Matrix TM;
    var() editconst float Radius;
    var() bool bNoRBCollision;
    var() bool bPerPolyShape;

    structdefaultproperties
    {
        TM=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        Radius=1.0000000
        bNoRBCollision=false
        bPerPolyShape=false
    }
};

struct KBoxElem
{
    var() editconst Matrix TM;
    var() editconst float X;
    var() editconst float Y;
    var() editconst float Z;
    var() bool bNoRBCollision;
    var() bool bPerPolyShape;

    structdefaultproperties
    {
        TM=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        X=1.0000000
        Y=1.0000000
        Z=1.0000000
        bNoRBCollision=false
        bPerPolyShape=false
    }
};

struct KSphylElem
{
    var() editconst Matrix TM;
    var() editconst float Radius;
    var() editconst float Length;
    var() bool bNoRBCollision;
    var() bool bPerPolyShape;

    structdefaultproperties
    {
        TM=(XPlane=(W=0.0000000,X=1.0000000,Y=0.0000000,Z=0.0000000),YPlane=(W=0.0000000,X=0.0000000,Y=1.0000000,Z=0.0000000),ZPlane=(W=0.0000000,X=0.0000000,Y=0.0000000,Z=1.0000000),WPlane=(W=1.0000000,X=0.0000000,Y=0.0000000,Z=0.0000000))
        Radius=1.0000000
        Length=1.0000000
        bNoRBCollision=false
        bPerPolyShape=false
    }
};

struct KConvexElem
{
    var array<Vector> VertexData;
    var array<Plane> PermutedVertexData;
    var array<int> FaceTriData;
    var array<Vector> EdgeDirections;
    var array<Vector> FaceNormalDirections;
    var array<Plane> FacePlaneData;
    var Box ElemBox;

    structdefaultproperties
    {
        VertexData=none
        PermutedVertexData=none
        FaceTriData=none
        EdgeDirections=none
        FaceNormalDirections=none
        FacePlaneData=none
        ElemBox=(Min=(X=0.0000000,Y=0.0000000,Z=0.0000000),Max=(X=0.0000000,Y=0.0000000,Z=0.0000000),IsValid=0)
    }
};

struct KAggregateGeom
{
    var() editfixedsize array<KSphereElem> SphereElems;
    var() editfixedsize array<KBoxElem> BoxElems;
    var() editfixedsize array<KSphylElem> SphylElems;
    var() editfixedsize array<KConvexElem> ConvexElems;
    var noimport nontransactional native Pointer RenderInfo;
    var() bool bSkipCloseAndParallelChecks;

    structdefaultproperties
    {
        SphereElems=none
        BoxElems=none
        SphylElems=none
        ConvexElems=none
        bSkipCloseAndParallelChecks=false
    }
};

var() Vector COMNudge;
var() KAggregateGeom AggGeom;
