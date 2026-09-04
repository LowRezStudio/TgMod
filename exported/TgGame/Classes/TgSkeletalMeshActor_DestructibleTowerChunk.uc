class TgSkeletalMeshActor_DestructibleTowerChunk extends TgSkeletalMeshActorSpawnable
    hidecategories(Navigation);

var export editinline TgSkeletalMeshComponent TgSkeletalMeshComp;

simulated function PlayDestruction(int MeshId, TgPawn_Tower OwningTower)
{
    local AnimNodeSequence DestroyAnimNode;

    CreateSkeletalMeshComponent(MeshId, TgSkeletalMeshComp);
    TgSkeletalMeshComp.SetLightEnvironment(OwningTower.Mesh.LightEnvironment);
    TgSkeletalMeshComp.SetShadowParent(OwningTower.Mesh);
    DestroyAnimNode = AnimNodeSequence(TgSkeletalMeshComp.FindAnimNode('DestroyAnimNode'));
    // End:0x123
    if(DestroyAnimNode != none)
    {
        DestroyAnimNode.PlayAnim(false, 1.0000000, 0.0000000);        
    }
    //return;    
}

event bool PlayParticleEffect(const AnimNotify_PlayParticleEffect AnimNotifyData)
{
    local Vector Loc;
    local Rotator Rot;
    local editinline ParticleSystemComponent PSC;
    local bool bPlayNonExtreme;

    // End:0x2B
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        return true;
    }
    bPlayNonExtreme = (AnimNotifyData.bIsExtremeContent == true) && WorldInfo.GRI.ShouldShowGore() == false;
    // End:0xDB
    if((bShouldDoAnimNotifies == false) || bPlayNonExtreme && AnimNotifyData.PSNonExtremeContentTemplate == none)
    {
        return true;
    }
    // End:0x15A
    if(AnimNotifyData.SocketName != 'None')
    {
        TgSkeletalMeshComp.GetSocketWorldLocationAndRotation(AnimNotifyData.SocketName, Loc, Rot);        
    }
    else
    {
        // End:0x223
        if(AnimNotifyData.BoneName != 'None')
        {
            Loc = TgSkeletalMeshComp.GetBoneLocation(AnimNotifyData.BoneName);
            Rot = QuatToRotator(TgSkeletalMeshComp.GetBoneQuaternion(AnimNotifyData.BoneName));            
        }
        else
        {
            Loc = Location;
            Rot = rot(0, 0, 1);
        }
    }
    PSC = WorldInfo.MyEmitterPool.SpawnEmitter(AnimNotifyData.PSTemplate, Loc, Rot);
    // End:0x33B
    if((PSC != none) && AnimNotifyData.BoneSocketModuleActorName != 'None')
    {
        PSC.SetActorParameter(AnimNotifyData.BoneSocketModuleActorName, self);
    }
    return true;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: TgSkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.TgSkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'TgSkeletalMeshComponent0'
    begin object name="TgSkeletalMeshComponent0" class=TgGame.TgSkeletalMeshComponent
        ReplacementPrimitive=none
    end object
    TgSkeletalMeshComp=TgSkeletalMeshComponent0
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.SkeletalMeshComponent0.AnimNodeSeq0_9'
        // Archetype: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActorSpawnable.SkeletalMeshComponent0.AnimNodeSeq0_6'
        begin object name="AnimNodeSeq0_9"
        end object
        Animations=AnimNodeSeq0_9
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor_DestructibleTowerChunk.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgSkeletalMeshActorSpawnable.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    Components[4]=TgSkeletalMeshComponent0
    LifeSpan=5.0000000
    CollisionComponent=SkeletalMeshComponent0
}