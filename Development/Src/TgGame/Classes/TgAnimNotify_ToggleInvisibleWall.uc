class TgAnimNotify_ToggleInvisibleWall extends AnimNotify
    native(Anim)
    editinlinenew
    collapsecategories
    hidecategories(Object)
    config(Engine);

var () bool TurnWallOn;
var () bool TurnOffOnCeaseRelevant;
var () int WallIndex;
var () Vector WallPosition;
var () Vector WallNormal;
var const name WallEnableBaseName;
var const name WallPositionBaseName;
var const name WallNormalBaseName;

simulated event OnAnimNodeSequenceCeaseRelevant(AnimNodeSequence OwningNode) { }

defaultproperties
{
    TurnWallOn=true
    TurnOffOnCeaseRelevant=true
    WallNormal=(X=0.0000000,Y=0.0000000,Z=1.0000000)
    WallEnableBaseName="WallEnable"
    WallPositionBaseName="WallPosition"
    WallNormalBaseName="WallNormal"
}
