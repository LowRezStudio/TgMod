class Landscape extends LandscapeProxy
    native(Terrain)
    notplaceable
    hidecategories(Navigation,Attachment,Physics,Debug,LandscapeProxy);

enum ELandscapeSetupErrors
{
    LSE_None,                       // 0
    LSE_NoLandscapeInfo,            // 1
    LSE_CollsionXY,                 // 2
    LSE_NoLayerInfo,                // 3
    LSE_MAX                         // 4
};

struct native LandscapeLayerInfo
{
    var() name LayerName;
    var() float Hardness;
    var bool bNoWeightBlend;
    var() PhysicalMaterial PhysMaterial;
    var editoronly transient bool bSelected;

    structdefaultproperties
    {
        LayerName="None"
        Hardness=0.0000000
        bNoWeightBlend=false
        PhysMaterial=none
        bSelected=false
    }
};

var deprecated array<deprecated name> LayerNames;
var deprecated array<deprecated LandscapeLayerInfo> LayerInfos;

defaultproperties
{
    bIsProxy=false
    bLockLocation=false
}