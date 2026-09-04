class Brush extends Actor
    native
    notplaceable
    hidecategories(Navigation,Object,Movement,Display);

enum ECsgOper
{
    CSG_Active,                     // 0
    CSG_Add,                        // 1
    CSG_Subtract,                   // 2
    CSG_Intersect,                  // 3
    CSG_Deintersect,                // 4
    CSG_MAX                         // 5
};

struct native export GeomSelection
{
    var int Type;
    var int Index;
    var int SelectionIndex;

    structdefaultproperties
    {
        Type=0
        Index=0
        SelectionIndex=0
    }
};

var() Brush.ECsgOper CsgOper;
var() Color BrushColor;
var int PolyFlags;
var() bool bColored;
var() bool bCuttingBrush;
var bool bSolidWhenSelected;
var bool bPlaceableFromClassBrowser;
var const export Model Brush;
var const editconst export editinline BrushComponent BrushComponent;
var array<GeomSelection> SavedSelections;

defaultproperties
{
    // Reference: BrushComponent'Engine.Default__Brush.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    begin object name="BrushComponent0" class=Engine.BrushComponent
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=true
    bHidden=true
    bNoDelete=true
    bEdShouldSnap=true
    CollisionComponent=BrushComponent0
}