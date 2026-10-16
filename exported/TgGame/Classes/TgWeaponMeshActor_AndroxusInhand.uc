class TgWeaponMeshActor_AndroxusInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var bool m_bHasFinishedBurst;
var int m_nCachedFireMode;

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh)
{
    local AnimNode AnimNode;
    local TgAnimNodeBlendBySlowFall SlowFallNode;
    local TgPawn_Androxus androxus;

    androxus = TgPawn_Androxus(Owner);
    // End:0xB7
    if(androxus != none)
    {
        // End:0xB6
        foreach WeaponMesh.AllAnimNodes(Class'Engine.AnimNode', AnimNode)
        {
            SlowFallNode = TgAnimNodeBlendBySlowFall(AnimNode);
            // End:0xB5
            if(SlowFallNode != none)
            {
                androxus.m_SlowFallAnimNodes.AddItem(SlowFallNode);
            }            
        }        
    }
    super.FixUpReferencesToWeaponMesh1P(WeaponMesh);
    //return;    
}

simulated function PlayFireEffects(int nEquipSlot, float fRefireTime, int nFireMode)
{
    m_nCachedFireMode = nFireMode;
    // End:0x43
    if(nEquipSlot == 18)
    {
        super.PlayFireEffects(1, fRefireTime, nFireMode);        
    }
    else
    {
        super.PlayFireEffects(nEquipSlot, fRefireTime, nFireMode);
    }
    // End:0x83
    if(m_nCachedFireMode == 1)
    {
        m_bHasFinishedBurst = true;
    }
    //return;    
}

simulated function StopFireEffects(int nEquipSlot)
{
    // End:0x1E
    if(nEquipSlot == 18)
    {
        super.StopFireEffects(1);        
    }
    else
    {
        super.StopFireEffects(nEquipSlot);
    }
    // End:0x4C
    if(nEquipSlot == 1)
    {
        m_bHasFinishedBurst = true;
    }
    //return;    
}

simulated function PlayFireAnimation(int nEquipSlot, float fRefireTime)
{
    // End:0x3E
    if((nEquipSlot != 1) || m_nCachedFireMode == 0)
    {
        super.PlayFireAnimation(nEquipSlot, fRefireTime);
        return;
    }
    // End:0x73
    if(m_bHasFinishedBurst)
    {
        m_bHasFinishedBurst = false;
        super.PlayFireAnimation(nEquipSlot, fRefireTime);
    }
    //return;    
}

defaultproperties
{
    m_bHasFinishedBurst=true
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_AndroxusInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}