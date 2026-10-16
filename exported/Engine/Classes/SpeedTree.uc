class SpeedTree extends Object
    native(SpeedTree);

var private const bool bLegacySpeedTree;
var duplicatetransient native const Pointer SRH;
var(Lighting) float LeafStaticShadowOpacity;
var(Material) MaterialInterface Branch1Material;
var(Material) MaterialInterface Branch2Material;
var(Material) MaterialInterface FrondMaterial;
var(Material) MaterialInterface LeafCardMaterial;
var(Material) MaterialInterface LeafMeshMaterial;
var(Material) MaterialInterface BillboardMaterial;
var(Material) MaterialInterface Branch1MaterialNoScreenDoor;
var(Material) MaterialInterface Branch2MaterialNoScreenDoor;
var(Material) MaterialInterface FrondMaterialNoScreenDoor;
var(Material) MaterialInterface LeafCardMaterialNoScreenDoor;
var(Material) MaterialInterface LeafMeshMaterialNoScreenDoor;
var(Material) MaterialInterface BillboardMaterialNoScreenDoor;
var(Wind) float WindStrength;
var(Wind) Vector WindDirection;

defaultproperties
{
    LeafStaticShadowOpacity=0.5000000
    WindStrength=0.2000000
    WindDirection=(X=1.0000000,Y=0.0000000,Z=0.0000000)
}