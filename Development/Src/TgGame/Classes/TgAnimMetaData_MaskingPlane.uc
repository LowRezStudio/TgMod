class TgAnimMetaData_MaskingPlane extends TgAnimMetaData_MICScalarParameterExtended
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var () int WallIndex;
var () Vector WallNormal;
var () Vector WallPosition0;
var () Vector WallPosition1;
var const name WallEnableBaseName;
var const name WallPositionBaseName;
var const name WallNormalBaseName;

defaultproperties
{
    WallNormal=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    WallEnableBaseName="WallEnable"
    WallPositionBaseName="WallPosition"
    WallNormalBaseName="WallNormal"
    bSearchSiblings=true
    bSearchChildren=true
    bForceAllMaterials=true
}
