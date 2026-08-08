class TgSkeletalMeshComponent_WeaponFirstPerson extends TgSkeletalMeshComponent_Weapon
    editinlinenew
    hidecategories(Object)
    config(Engine);

defaultproperties
{
    m_bCanPlayFireSounds=true
    m_bCanPlayFireLoopSounds=true
    bOverrideAttachmentOwnerVisibility=true
    bOverrideAttachmentDepthPriorityGroup=true
    ReplacementPrimitive=none
    DepthPriorityGroup=SDPG_Foreground
    bOnlyOwnerSee=true
    TickGroup=TG_DuringAsyncWork
}
