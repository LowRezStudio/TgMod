class TgDeviceForm_IronSights extends TgDeviceForm_ToggleWithLockout
    native(ChampViktor);

var float m_fCameraFOVInterpolationTime;
var() float m_fMaxCameraFOVInteprolationTime;
var float m_fCameraFOVInterpolationTarget;
var float m_fActiveFOV;
var bool m_fHasStartedInterpolation;
var float m_fDesiredStartInterpolationTimestamp;

event Generic1(optional byte byExtraData)
{
    super.Generic1(byExtraData);
    ClearPendingFOVInterpolation();
    //return;    
}

event Fire(Vector HitLocation, int nFireMode, optional int nEquipSlot = 0, optional int nSocketIndex = 0, optional bool bSuccessfulHit = false, optional float fRefireTime)
{
    super.Fire(HitLocation, nFireMode, nEquipSlot, nSocketIndex, bSuccessfulHit, fRefireTime);
    ClearPendingFOVInterpolation();
    //return;    
}

event StopFire(int nFireModeNum)
{
    super(TgDeviceForm).StopFire(nFireModeNum);
    //return;    
}

event Generic2(optional byte byExtraData)
{
    super.Generic2(byExtraData);
    ClearPendingFOVInterpolation();
    //return;    
}

simulated function ClearPendingFOVInterpolation()
{
    m_fDesiredStartInterpolationTimestamp = 0.0000000;
    m_fHasStartedInterpolation = true;
    //return;    
}

simulated event PlayToggleTransitionAnimations(float transitionPercent, float totalTransitionTime, bool transitionToActive)
{
    local WorldInfo World;
    local float fTransitionTimeRemaining;

    super(TgDeviceForm).PlayToggleTransitionAnimations(transitionPercent, totalTransitionTime, transitionToActive);
    // End:0x13E
    if(transitionToActive)
    {
        fTransitionTimeRemaining = (1.0000000 - transitionPercent) * totalTransitionTime;
        m_fCameraFOVInterpolationTime = FMin(m_fMaxCameraFOVInteprolationTime, fTransitionTimeRemaining);
        m_fCameraFOVInterpolationTarget = m_fActiveFOV;
        // End:0xC8
        if(fTransitionTimeRemaining <= m_fCameraFOVInterpolationTime)
        {
            StartCameraInterpolation();
            m_fDesiredStartInterpolationTimestamp = 0.0000000;
            m_fHasStartedInterpolation = true;            
        }
        else
        {
            m_fHasStartedInterpolation = false;
            World = Class'Engine.WorldInfo'.static.GetWorldInfo();
            m_fDesiredStartInterpolationTimestamp = World.TimeSeconds + (fTransitionTimeRemaining - m_fCameraFOVInterpolationTime);
        }        
    }
    else
    {
        fTransitionTimeRemaining = transitionPercent * totalTransitionTime;
        m_fCameraFOVInterpolationTime = FMin(m_fMaxCameraFOVInteprolationTime - (totalTransitionTime - fTransitionTimeRemaining), m_fMaxCameraFOVInteprolationTime);
        m_fCameraFOVInterpolationTarget = 0.0000000;
        // End:0x1BD
        if(m_fCameraFOVInterpolationTime <= float(0))
        {
            ClearPendingFOVInterpolation();            
        }
        else
        {
            StartCameraInterpolation();
        }
    }
    //return;    
}

simulated event StartCameraInterpolation()
{
    local TgPawn_Character TgP;

    TgP = TgPawn_Character(PawnOwner);
    // End:0x5C
    if(TgP != none)
    {
        TgP.StartWeaponZoomInterpolation(m_fCameraFOVInterpolationTarget, m_fCameraFOVInterpolationTime);
    }
    ClearPendingFOVInterpolation();
    //return;    
}

defaultproperties
{
    m_fMaxCameraFOVInteprolationTime=0.1200000
    m_fActiveFOV=70.0000000
}