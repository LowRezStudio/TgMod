class LandscapeInfo extends Object
    native(Terrain);

struct native LandscapeAddCollision
{
};

var const Guid LandscapeGuid;
var native const map{VOID,VOID} LayerInfoMap;
var native const Pointer DataInterface;
var native const map{VOID,VOID} XYtoComponentMap;
var native const map{VOID,VOID} XYtoCollisionComponentMap;
var const LandscapeProxy LandscapeProxy;
var native const map{VOID,VOID} XYtoAddCollisionMap;
var private native const transient Set_Mirror Proxies;
var private native const Set_Mirror SelectedComponents;
var private native const Set_Mirror SelectedCollisionComponents;
var private native const Set_Mirror SelectedRegionComponents;
var private native const map{VOID,VOID} SelectedRegion;
var editoronly transient bool bIsValid;
