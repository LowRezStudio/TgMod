class TgWeaponMeshActor_ViktorInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgPawn_Viktor m_CachedViktor;
var() float m_fWeaponZoomFOV;
var() float m_fWeaponFOVDefault;
var() float m_fDoFMultiplier;
var bool m_bPlayingADSFX;

simulated function Rotator ApplyRotationModifier(Rotator NewRotation)
{
    // End:0x36
    if(HasCachedViktor())
    {
        return m_CachedViktor.ApplyRecoilToRotation(NewRotation);
    }
    return NewRotation;
    //return ReturnValue;    
}

simulated function bool HasCachedViktor()
{
    // End:0x38
    if(m_CachedViktor == none)
    {
        m_CachedViktor = TgPawn_Viktor(Instigator);
        return m_CachedViktor != none;
    }
    return true;
    //return ReturnValue;    
}

simulated function UpdateTransform(float DeltaTime, optional bool bFromCameraUpdate = false)
{
    local TgPlayerController TgPC;
    local TgPlayerCamera Cam;
    local float fZoomPct;

    super.UpdateTransform(DeltaTime, bFromCameraUpdate);
    TgPC = TgPlayerController(GetALocalPlayerController());
    // End:0x87
    if(((TgPC == none) || m_WeaponMesh1P == none) || TgPC.PlayerCamera == none)
    {
        return;
    }
    Cam = TgPlayerCamera(TgPC.PlayerCamera);
    // End:0xC9
    if(Cam == none)
    {
        return;
    }
    // End:0x21E
    if(m_WeaponMesh1P != none)
    {
        fZoomPct = Cam.GetFOVInterpZoomPct();
        UseADSFireSounds(fZoomPct > 0.0000000);
        // End:0x1A6
        if(HasCachedViktor())
        {
            m_CachedViktor.m_CurrentDOFSettings.IsActive = fZoomPct > 0.0000000;
            m_CachedViktor.m_CurrentDOFSettings.MaxNearBlurAmount = fZoomPct;
        }
        m_WeaponMesh1P.SetFOV(Lerp(m_fWeaponFOVDefault, m_fWeaponZoomFOV, fZoomPct));
        m_HandsMesh.SetFOV(Lerp(m_fWeaponFOVDefault, m_fWeaponZoomFOV, fZoomPct));
    }
    //return;    
}

simulated function UseADSFireSounds(bool bShouldUse)
{
    // End:0x11
    if(m_WeaponMesh1P == none)
    {
        return;
    }
    // End:0xAC
    if(bShouldUse && !m_bPlayingADSFX)
    {
        m_WeaponMesh1P.SetFireDisplayGroup('FireADS');
        m_WeaponMesh1P.SetFireLoopDisplayGroup('FireLoopADS', m_WeaponMesh1P.m_nmFireLoopTailSound);
        m_bPlayingADSFX = true;        
    }
    else
    {
        // End:0x144
        if(!bShouldUse && m_bPlayingADSFX)
        {
            m_WeaponMesh1P.SetFireDisplayGroup('Fire');
            m_WeaponMesh1P.SetFireLoopDisplayGroup('FireLoop', m_WeaponMesh1P.m_nmFireLoopTailSound);
            m_bPlayingADSFX = false;
        }
    }
    //return;    
}

defaultproperties
{
    m_fWeaponZoomFOV=45.0000000
    m_fWeaponFOVDefault=77.0000000
    m_fDoFMultiplier=1.0000000
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_ViktorInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}