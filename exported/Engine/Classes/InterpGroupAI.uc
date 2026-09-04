class InterpGroupAI extends InterpGroup
    native(Interpolation)
    collapsecategories
    hidecategories(Object,Object);

var() name StageMarkGroup;
var() bool SnapToRootBoneLocationWhenFinished;
var() bool bNoEncroachmentCheck;
var() bool bDisableWorldCollision;
var() bool bIgnoreLegacyHeightAdjust;
var editoronly transient bool bRecreatePreviewPawn;
var editoronly transient bool bRefreshStageMarkGroup;

defaultproperties
{
    GroupName="AIGroup"
}