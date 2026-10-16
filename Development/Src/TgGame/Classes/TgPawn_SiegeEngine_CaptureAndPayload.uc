class TgPawn_SiegeEngine_CaptureAndPayload extends TgPawn_SiegeEngine_Payload
    native(Pawns)
    config(Game)
    hidecategories(Navigation)
    dependson(TgObject);

var private const float r_fMinimumPayloadTravelTime;
var private const float r_fTravelSpeedScaleBeforeBase;
var private const TgObject.ELanePusherActionPoint r_eSpeedScaledTravelPoint;
var private const bool r_bIsPassedSpeedScaledTravelPoint;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_fTravelSpeedScaleBeforeBase;
    if((int(Role) == int(ENetRole.ROLE_Authority)) && bNetInitial) r_bIsPassedSpeedScaledTravelPoint, r_eSpeedScaledTravelPoint, r_fMinimumPayloadTravelTime;
}

native function SetSpline(TgSplineActor NewSpline, optional bool bSnapToStart);  // Export UTgPawn_SiegeEngine_CaptureAndPayload::execSetSpline(FFrame&, void* const)

defaultproperties
{}
