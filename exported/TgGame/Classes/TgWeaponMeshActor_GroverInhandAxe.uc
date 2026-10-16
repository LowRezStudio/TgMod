class TgWeaponMeshActor_GroverInhandAxe extends TgWeaponMeshActor
    notplaceable
    hidecategories(Navigation);

var TgAnimNodeStanceTransitionerSynchronized StanceNode;

simulated function FixUpReferencesToPawnMesh(SkeletalMeshComponent PawnMesh)
{
    super.FixUpReferencesToPawnMesh(PawnMesh);
    StanceNode = none;
    // End:0x66
    if(PawnMesh != none)
    {
        // End:0x65
        foreach PawnMesh.AllAnimNodes(Class'TgGame.TgAnimNodeStanceTransitionerSynchronized', StanceNode)
        {
            // End:0x65
            break;            
        }        
    }
    //return;    
}

simulated function Play3pFireAimedFX()
{
    local editinline TgSkeletalMeshComponent SkelMesh3P;
    local Vector fireLoc;
    local Rotator FireRot;
    local TgPawn TgP;

    // End:0x0F
    if(IsFirstPerson())
    {
        return;
    }
    TgP = TgPawn(Owner);
    // End:0x3C
    if(TgP == none)
    {
        return;
    }
    SkelMesh3P = TgSkeletalMeshComponent(TgP.Mesh);
    // End:0x7E
    if(SkelMesh3P == none)
    {
        return;
    }
    SkelMesh3P.GetSocketWorldLocationAndRotation('CSO_COG', fireLoc, FireRot);
    FireRot.Yaw = TgP.Rotation.Yaw;
    FireRot.Roll = 0;
    FireRot.Pitch = int(TgP.RemoteViewPitch) << int(8);
    // End:0x1DF
    if((StanceNode == none) || StanceNode.m_nCurrentStance == 1)
    {
        SkelMesh3P.FxSpawnEmitter('FireAimed', 0, fireLoc, Vector(FireRot));        
    }
    else
    {
        SkelMesh3P.FxSpawnEmitter('FireAimedAlt', 0, fireLoc, Vector(FireRot));
    }
    //return;    
}

defaultproperties
{
    // Reference: TgCameraShake'TgGame.Default__TgWeaponMeshActor_GroverInhandAxe.CameraShake'
    // Archetype: TgCameraShake'TgGame.Default__TgWeaponMeshActor.CameraShake'
    begin object name="CameraShake"
    end object
    m_FireCameraShake=CameraShake
}