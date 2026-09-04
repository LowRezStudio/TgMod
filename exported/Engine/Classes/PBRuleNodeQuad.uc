class PBRuleNodeQuad extends PBRuleNodeBase
    native(ProcBuilding)
    editinlinenew
    collapsecategories
    hidecategories(Object,Object);

var() MaterialInterface Material;
var() float RepeatMaxSizeX;
var() float RepeatMaxSizeZ;
var() int QuadLightmapRes;
var() float YOffset;
var() bool bDisableMaterialRepeat;

defaultproperties
{
    RepeatMaxSizeX=512.0000000
    RepeatMaxSizeZ=512.0000000
    QuadLightmapRes=32
    NextRules=none
}