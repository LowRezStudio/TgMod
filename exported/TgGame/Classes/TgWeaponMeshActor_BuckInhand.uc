class TgWeaponMeshActor_BuckInhand extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var array<TgAnimBlendByProgressiveReload> m_PawnMeshProgressiveReloadNodes;
var array<TgAnimBlendByProgressiveReload> m_ProgressiveReloadNodes;

simulated function FixUpReferencesToWeaponMesh1P(SkeletalMeshComponent WeaponMesh)
{
    local TgAnimBlendByProgressiveReload AnimNode;

    m_ProgressiveReloadNodes.Length = 0;
    // End:0x57
    foreach WeaponMesh.AllAnimNodes(Class'TgGame.TgAnimBlendByProgressiveReload', AnimNode)
    {
        m_ProgressiveReloadNodes.AddItem(AnimNode);        
    }    
    super.FixUpReferencesToWeaponMesh1P(WeaponMesh);
    //return;    
}

simulated function FixUpReferencesToPawnMesh(SkeletalMeshComponent PawnMesh)
{
    local TgAnimBlendByProgressiveReload AnimNode;

    m_PawnMeshProgressiveReloadNodes.Length = 0;
    // End:0x57
    foreach PawnMesh.AllAnimNodes(Class'TgGame.TgAnimBlendByProgressiveReload', AnimNode)
    {
        m_PawnMeshProgressiveReloadNodes.AddItem(AnimNode);        
    }    
    super.FixUpReferencesToPawnMesh(PawnMesh);
    //return;    
}

simulated event PlayReload(int nEquipPoint, float ReloadTime, int AmmoRemainingInClip, optional int ReloadType = 0)
{
    local TgAnimBlendByProgressiveReload ProgressiveReloadNode;

    // End:0x45
    foreach m_PawnMeshProgressiveReloadNodes(ProgressiveReloadNode)
    {
        ProgressiveReloadNode.SetReloadType(ReloadType);        
    }    
    // End:0x86
    foreach m_ProgressiveReloadNodes(ProgressiveReloadNode)
    {
        ProgressiveReloadNode.SetReloadType(ReloadType);        
    }    
    super.PlayReload(nEquipPoint, ReloadTime, AmmoRemainingInClip, ReloadType);
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_BuckInhand.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}