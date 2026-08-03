class TgDeviceForm_DarklordInhand extends TgDeviceForm_Inhand
    native(ChampDarklord);

var TgPawn_Darklord m_CachedDarklord;
var const float m_fFadeParamMin;
var const float m_fFadeParamMax;
var const float m_fAmmoParamMin;
var const float m_fAmmoParamMax;
var const float m_fMaskParamMin;
var const float m_fMaskParamMax;
var float m_fPreviousAppliedAmmoPerc;
var float m_fCurrentAppliedAmmoPerc;
var const float m_fAnimatedReloadStartNormalizedTime;
var const float m_fAnimatedReloadEndNormalizedTime;
var float m_fReloadDuration;
var float m_fReloadTimer;

simulated function bool HasCachedDarklord()
{
    // End:0x2B
    if(m_CachedDarklord == none)
    {
        m_CachedDarklord = TgPawn_Darklord(PawnOwner);
    }
    return m_CachedDarklord != none;
    //return ReturnValue;    
}

simulated function OnReload(float fReloadTime)
{
    m_fReloadDuration = fReloadTime;
    m_fReloadTimer = fReloadTime;
    //return;    
}

simulated event ForceUpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc)
{
    UpdateAmmoCountFx(fPreviousPerc, fCurrentPerc);
    //return;    
}

simulated function UpdateAmmoCountFx(float fPreviousPerc, float fCurrentPerc)
{
    local int I;
    local array<Object> FxList;

    // End:0x39
    if(m_fReloadTimer <= -1.0000000)
    {
        m_fPreviousAppliedAmmoPerc = fPreviousPerc;
        m_fCurrentAppliedAmmoPerc = fCurrentPerc;
    }
    // End:0x650
    if((HasCachedDarklord()) && m_CachedDarklord.m_WeaponMesh != none)
    {
        // End:0x12F
        if((fPreviousPerc <= 0.0000000) && fCurrentPerc > 0.0000000)
        {
            // End:0x12C
            if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('AmmoGroup1', c_nFireMode);
            }            
        }
        else
        {
            // End:0x1ED
            if((fPreviousPerc > 0.0000000) && fCurrentPerc <= 0.0000000)
            {
                // End:0x1ED
                if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
                {
                    m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('AmmoGroup1', c_nFireMode);
                }
            }
        }
        // End:0x2B0
        if((fPreviousPerc <= 0.3400000) && fCurrentPerc > 0.3400000)
        {
            // End:0x2AD
            if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('AmmoGroup2', c_nFireMode);
            }            
        }
        else
        {
            // End:0x36E
            if((fPreviousPerc > 0.3400000) && fCurrentPerc <= 0.3400000)
            {
                // End:0x36E
                if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
                {
                    m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('AmmoGroup2', c_nFireMode);
                }
            }
        }
        // End:0x431
        if((fPreviousPerc <= 0.6700000) && fCurrentPerc > 0.6700000)
        {
            // End:0x42E
            if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxActivateGroup('AmmoGroup3', c_nFireMode);
            }            
        }
        else
        {
            // End:0x4EF
            if((fPreviousPerc > 0.6700000) && fCurrentPerc <= 0.6700000)
            {
                // End:0x4EF
                if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
                {
                    m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P.FxDeactivateGroup('AmmoGroup3', c_nFireMode);
                }
            }
        }
        // End:0x60A
        if(m_CachedDarklord.IsLocallyControlled())
        {
            // End:0x60A
            if(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P != none)
            {
                FxList = PawnOwner.m_WeaponMesh.m_WeaponMesh1P.FxGetAll('AmmoGroup1', 0);
                I = 0;
                J0x5B5:

                // End:0x60A [Loop If]
                if(I < FxList.Length)
                {
                    UpdateSpecialFxMaterials(TgSpecialFx(FxList[I]), fCurrentPerc);
                    I++;
                    // [Loop Continue]
                    goto J0x5B5;
                }
            }
        }
        UpdateMeshMaterials(m_CachedDarklord.m_WeaponMesh.m_WeaponMesh1P, fCurrentPerc);
    }
    //return;    
}

// Export UTgDeviceForm_DarklordInhand::execUpdateSpecialFxMaterials(FFrame&, void* const)
native simulated function UpdateSpecialFxMaterials(TgSpecialFx Fx, float fPerc);

simulated function UpdateMeshMaterials(TgSkeletalMeshComponent_Weapon Mesh, float fPerc)
{
    local int I;
    local MaterialInstanceConstant MIC;

    // End:0x16E
    if(Mesh != none)
    {
        I = 0;
        J0x1A:

        // End:0x16E [Loop If]
        if(I < Mesh.Materials.Length)
        {
            MIC = MaterialInstanceConstant(Mesh.Materials[I]);
            // End:0x160
            if(MIC != none)
            {
                MIC.SetScalarParameterValue('Fade', Lerp(m_fFadeParamMin, m_fFadeParamMax, fPerc));
                MIC.SetScalarParameterValue('Ammo', Lerp(m_fAmmoParamMin, m_fAmmoParamMax, fPerc));
                MIC.SetScalarParameterValue('Emissive Ramp Mask', Lerp(m_fMaskParamMin, m_fMaskParamMax, fPerc));
            }
            I++;
            // [Loop Continue]
            goto J0x1A;
        }
    }
    //return;    
}

defaultproperties
{
    m_fFadeParamMin=0.5000000
    m_fFadeParamMax=1.0000000
    m_fAmmoParamMin=0.1000000
    m_fAmmoParamMax=1.0000000
    m_fMaskParamMin=0.1000000
    m_fMaskParamMax=1.0000000
    m_fAnimatedReloadStartNormalizedTime=0.3500000
    m_fAnimatedReloadEndNormalizedTime=0.5500000
    m_fReloadTimer=-1.0000000
}