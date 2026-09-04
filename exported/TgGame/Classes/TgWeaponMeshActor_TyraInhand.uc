class TgWeaponMeshActor_TyraInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgPawn_Tyra m_CachedTyra;
var() float m_fWeaponZoomFOV;
var() float m_fWeaponFOVDefault;
var() float m_fDoFMultiplier;

simulated function bool HasCachedTyra()
{
    // End:0x38
    if(m_CachedTyra == none)
    {
        m_CachedTyra = TgPawn_Tyra(Instigator);
        return m_CachedTyra != none;
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
    // End:0x204
    if(m_WeaponMesh1P != none)
    {
        fZoomPct = Cam.GetFOVInterpZoomPct();
        // End:0x18C
        if(HasCachedTyra())
        {
            m_CachedTyra.m_CurrentDOFSettings.IsActive = fZoomPct > 0.0000000;
            m_CachedTyra.m_CurrentDOFSettings.MaxNearBlurAmount = fZoomPct;
        }
        m_WeaponMesh1P.SetFOV(Lerp(m_fWeaponFOVDefault, m_fWeaponZoomFOV, fZoomPct));
        m_HandsMesh.SetFOV(Lerp(m_fWeaponFOVDefault, m_fWeaponZoomFOV, fZoomPct));
    }
    //return;    
}

defaultproperties
{
    m_fWeaponZoomFOV=45.0000000
    m_fWeaponFOVDefault=77.0000000
    m_fDoFMultiplier=1.0000000
    m_PlayFireEffectsOn[1]=TG_PLAY_FIRE_EFFECT_ON.Fire
    m_PlayFireEffectsOn[16]=TG_PLAY_FIRE_EFFECT_ON.Fire
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_TyraInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}