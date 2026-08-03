class LevelGridVolume extends Volume
    native
    placeable
    hidecategories(Navigation,Object,Movement,Display,Advanced,Attachment,Collision,Volume,Physics,Location)
    autoexpandcategories(LevelGridVolume);

enum LevelGridCellShape
{
    LGCS_Box,                       // 0
    LGCS_Hex,                       // 1
    LGCS_MAX                        // 2
};

struct native LevelGridCellCoordinate
{
    var int X;
    var int Y;
    var int Z;

    structdefaultproperties
    {
        X=0
        Y=0
        Z=0
    }
};

var() const string LevelGridVolumeName;
var() const LevelGridVolume.LevelGridCellShape CellShape;
var() const int Subdivisions[3];
var() const float LoadingDistance;
var() const float KeepLoadedRange;
var const transient KConvexElem CellConvexElem;

defaultproperties
{
    Subdivisions[0]=1
    Subdivisions[1]=1
    Subdivisions[2]=1
    LoadingDistance=20480.0000000
    KeepLoadedRange=2048.0000000
    BrushColor=(R=80,G=80,B=80,A=255)
    bColored=true
    // Reference: BrushComponent'Engine.Default__LevelGridVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
        CollideActors=false
        BlockNonZeroExtent=false
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    bCollideActors=false
    CollisionComponent=BrushComponent0
    SupportedEvents=none
}