class SkelControlFootPlacement extends SkelControlLimb
    native(Anim)
    hidecategories(Object,Object,Effector);

var(FootPlacement) float FootOffset;
var(FootPlacement) Object.EAxis FootUpAxis;
var(FootPlacement) Rotator FootRotOffset;
var(FootPlacement) bool bInvertFootUpAxis;
var(FootPlacement) bool bOrientFootToGround;
var(FootPlacement) bool bOnlyEnableForUpAdjustment;
var(FootPlacement) bool m_bManuallyOverrideEffectorLocation;
var bool m_bUseCachedFootOffset;
var(FootPlacement) float MaxUpAdjustment;
var(FootPlacement) float MaxDownAdjustment;
var(FootPlacement) float MaxFootOrientAdjust;
var Vector m_vCachedFootOffset;

defaultproperties
{
    FootUpAxis=EAxis.AXIS_X
    bOrientFootToGround=true
    MaxUpAdjustment=50.0000000
    MaxFootOrientAdjust=45.0000000
}