class InterpTrackInstHeadTracking extends InterpTrackInst
    native(Interpolation);

var() InterpTrackHeadTracking.EHeadTrackingAction Action;
var native const transient map{VOID,VOID} CurrentActorMap;
var export editinline transient SkeletalMeshComponent Mesh;
var transient array<SkelControlLookAt> TrackControls;
var float LastUpdatePosition;
