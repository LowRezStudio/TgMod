class TgLobbyCamera extends CameraActor
    native(View)
    hidecategories(Navigation);

enum ELobbyCameraTag
{
    LobbyCam_Login,                 // 0
    LobbyCam_TitleHome,             // 1
    LobbyCam_TitlePlay,             // 2
    LobbyCam_SearchingForMatch,     // 3
    LobbyCam_MatchLobby,            // 4
    LobbyCam_TitleChampions,        // 5
    LobbyCam_ViewAllChampions,      // 6
    LobbyCam_ViewChampion,          // 7
    LobbyCam_TitleChests,           // 8
    LobbyCam_LootChest,             // 9
    LobbyCam_Store,                 // 10
    LobbyCam_StoreDetail,           // 11
    LobbyCam_EndOfMatchLobby,       // 12
    LobbyCam_WisdomDetail,          // 13
    LobbyCam_ViewChampionWeapon,    // 14
    LobbyCam_TeamMatchLobby,        // 15
    LobbyCam_MAX                    // 16
};

var(CameraActor) TgSkeletalMeshActor_Lobby m_ViewTarget;
var(CameraActor) array<TgSkeletalMeshActor_Lobby> m_FriendlyTargets;
var(CameraActor) array<TgSkeletalMeshActor_Lobby> m_EnemyTargets;
var(CameraActor) Vector m_RenderCenterPointOffset;
var transient bool m_bActive;
var() bool m_bAdjustCameraToTarget;
var bool m_bFirstCameraEyeCheck;
var transient int m_nPosition;
var float m_fRemainingTweenTime;
var float m_fTotalTweenTime;
var transient TPOV m_TweenSourcePOV;
var() float m_fLateralOffsetMultiplier;
var() float m_fHorizontalOffsetMultiplier;
var() float m_fViewLateralOffsetMultiplier;
var() float m_fViewHorizontalOffsetMultiplier;
var() float m_fMaxAdjustSpeedTranslation;
var() float m_fMaxAdjustSpeedRotation;
var() Vector m_vViewOffset;
var float m_fFirstCameraEyeCheckTimestamp;
var(CameraActor) TgLobbyCamera.ELobbyCameraTag m_CameraTag;

// Export UTgLobbyCamera::execSetActive(FFrame&, void* const)
native function SetActive(bool bActive);

// Export UTgLobbyCamera::execClearFriendlyTargets(FFrame&, void* const)
native function ClearFriendlyTargets();

// Export UTgLobbyCamera::execClearEnemyTargets(FFrame&, void* const)
native function ClearEnemyTargets();

event TriggerKismetActivationEvent(bool bActive, optional int nPosition = 0)
{
    TriggerEventClass(Class'TgGame.TgSeqEvent_LobbyCameraSetActive', none, ((bActive) ? 1 + nPosition : 0));
    //return;    
}

event SetPosition(int nPosition)
{
    // End:0x56
    if(m_bActive && m_nPosition != nPosition)
    {
        m_nPosition = nPosition;
        TriggerKismetActivationEvent(m_bActive, m_nPosition);
    }
    //return;    
}

simulated function StartTween(float TweenTime)
{
    m_fRemainingTweenTime = TweenTime;
    m_fTotalTweenTime = TweenTime;
    m_TweenSourcePOV = GetALocalPlayerController().PlayerCamera.CameraCache.POV;
    //return;    
}

simulated event GetActorEyesViewPoint(out Vector out_Location, out Rotator out_Rotation)
{
    local Vector vCurrentLocation, vCurrentRotation, vTargetForward, vDesiredLocation, vInterpolatedLocation, vDesiredRotation,
	    vToDesiredRotation, vOrthogonalRotationVector;

    local Rotator rInterpolatedRotation;
    local editinline CylinderComponent pCylinder;
    local float fHeight, fRadius;

    // End:0x5CD
    if(m_bAdjustCameraToTarget)
    {
        vCurrentLocation = out_Location;
        vCurrentRotation = Vector(out_Rotation);
        // End:0x2B1
        if(m_ViewTarget != none)
        {
            vTargetForward = Vector(((m_ViewTarget.m_bCanBeRotated) ? m_ViewTarget.m_rOriginalRotation : m_ViewTarget.Rotation));
            vTargetForward.Z = 0.0000000;
            vTargetForward = Normal(vTargetForward);
            vCurrentLocation -= (m_vViewOffset >> Rotator(-vTargetForward));
            pCylinder = CylinderComponent(m_ViewTarget.CollisionComponent);
            // End:0x19E
            if(pCylinder != none)
            {
                fHeight = pCylinder.CollisionHeight;
                fRadius = pCylinder.CollisionRadius;                
            }
            else
            {
                // End:0x290
                if(m_ViewTarget.m_ChildMeshes.Length > 0)
                {
                    fHeight = m_ViewTarget.m_ChildMeshes[0].Bounds.BoxExtent.Z;
                    fRadius = m_ViewTarget.m_ChildMeshes[0].Bounds.BoxExtent.Y;                    
                }
                else
                {
                    fHeight = -1.0000000;
                    fRadius = -1.0000000;
                }
            }            
        }
        else
        {
            fHeight = -1.0000000;
        }
        // End:0x362
        if((m_ViewTarget != none) && fHeight > 0.0000000)
        {
            vDesiredLocation = m_ViewTarget.Location + ((vTargetForward * m_fLateralOffsetMultiplier) * fHeight);
            vDesiredLocation.Z += (m_fHorizontalOffsetMultiplier * fHeight);            
        }
        else
        {
            super(Actor).GetActorEyesViewPoint(vDesiredLocation, out_Rotation);
        }
        vInterpolatedLocation = VInterpTo(vCurrentLocation, vDesiredLocation, WorldInfo.DeltaSeconds, m_fMaxAdjustSpeedTranslation);
        // End:0x4CF
        if((m_ViewTarget != none) && fHeight > 0.0000000)
        {
            vDesiredRotation = m_ViewTarget.Location - vInterpolatedLocation;
            // End:0x49A
            if((m_fViewLateralOffsetMultiplier != 0.0000000) && fRadius > 0.0000000)
            {
                vOrthogonalRotationVector = Normal(vect(0.0000000, 0.0000000, 1.0000000) Cross -vDesiredRotation);
                vDesiredRotation += ((vOrthogonalRotationVector * m_fViewLateralOffsetMultiplier) * fRadius);
            }
            vDesiredRotation.Z += (m_fViewHorizontalOffsetMultiplier * fHeight);            
        }
        else
        {
            vDesiredRotation = Vector(out_Rotation);
        }
        vToDesiredRotation = vDesiredRotation - vCurrentRotation;
        // End:0x56B
        if((m_fMaxAdjustSpeedRotation > 0.0000000) && VSizeSq(vToDesiredRotation) > (m_fMaxAdjustSpeedRotation * m_fMaxAdjustSpeedRotation))
        {
            rInterpolatedRotation = Rotator(vCurrentRotation + (Normal(vToDesiredRotation) * m_fMaxAdjustSpeedRotation));            
        }
        else
        {
            rInterpolatedRotation = Rotator(vDesiredRotation);
        }
        vInterpolatedLocation += (m_vViewOffset >> Rotator(-vTargetForward));
        out_Location = vInterpolatedLocation;
        out_Rotation = rInterpolatedRotation;        
    }
    else
    {
        super(Actor).GetActorEyesViewPoint(out_Location, out_Rotation);
    }
    // End:0x62A
    if(m_bFirstCameraEyeCheck)
    {
        m_bFirstCameraEyeCheck = false;
        m_fFirstCameraEyeCheckTimestamp = WorldInfo.TimeSeconds;
    }
    //return;    
}

simulated function GetCameraView(float DeltaTime, out TPOV OutPOV)
{
    GetActorEyesViewPoint(OutPOV.Location, OutPOV.Rotation);
    OutPOV.FOV = (57.2957800 * Atan(Tan((0.0174533 * FOVAngle) / 2.0000000) * AspectRatio)) * 2.0000000;
    //return;    
}

defaultproperties
{
    m_bFirstCameraEyeCheck=true
    m_TweenSourcePOV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    m_fLateralOffsetMultiplier=3.0000000
    m_fHorizontalOffsetMultiplier=2.0000000
    m_fViewLateralOffsetMultiplier=1.0000000
    m_fViewHorizontalOffsetMultiplier=1.0000000
    m_fMaxAdjustSpeedTranslation=10000.0000000
    m_fMaxAdjustSpeedRotation=10000.0000000
    SupportedEvents=/* Array type was not detected. */
}