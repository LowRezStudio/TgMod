class TgSkeletalMeshActor extends SkeletalMeshActor
    native(Pawns)
    hidecategories(Navigation);

var MeshAssets c_MeshAssets;
var() bool c_bLoadMeshAssetts;

// Export UTgSkeletalMeshActor::execAttachToSocket(FFrame&, void* const)
native function bool AttachToSocket(Actor Attachment, name BoneName);

// Export UTgSkeletalMeshActor::execCreateSkeletalMeshComponent(FFrame&, void* const)
native function TgSkeletalMeshComponent CreateSkeletalMeshComponent(int MeshAsmId, optional TgSkeletalMeshComponent DestComponent, optional bool bPartialFixup = false);

// Export UTgSkeletalMeshActor::execCreateStaticMeshComponent(FFrame&, void* const)
native function TgStaticMeshComponent CreateStaticMeshComponent(int MeshAsmId, optional TgStaticMeshComponent DestComponent);

// Export UTgSkeletalMeshActor::execCreateMeshComponent(FFrame&, void* const)
native function MeshComponent CreateMeshComponent(int MeshAsmId, optional MeshComponent DestComponent, optional bool bPartialFixup = false);

// Export UTgSkeletalMeshActor::execLoadClientOnlyMeshAssets(FFrame&, void* const)
native function LoadClientOnlyMeshAssets();

function OnParentAnimComponent(TgSeqAct_ParentAnimComponent Action)
{
    local array<Object> objVars;
    local int Idx;
    local SkeletalMeshActor Attachment;

    Action.GetObjectVars(objVars, "Child");
    Idx = 0;
    J0x3A:

    // End:0x15D [Loop If]
    if(Idx < objVars.Length)
    {
        Attachment = SkeletalMeshActor(objVars[Idx]);
        // End:0xD5
        if(Action.bDetach == true)
        {
            Attachment.SkeletalMeshComponent.SetParentAnimComponent(none);            
        }
        else
        {
            Attachment.SkeletalMeshComponent.SetParentAnimComponent(SkeletalMeshComponent);
            Attachment.SkeletalMeshComponent.SetShadowParent(SkeletalMeshComponent);
        }
        Idx++;
        // [Loop Continue]
        goto J0x3A;
    }
    //return;    
}

function DoKismetAttachment(Actor Attachment, SeqAct_AttachToActor Action)
{
    // End:0x92
    if((SkeletalMeshComponent != none) && Action.BoneName != 'None')
    {
        // End:0x8F
        if(!AttachToSocket(Attachment, Action.BoneName))
        {
            super.DoKismetAttachment(Attachment, Action);
        }        
    }
    else
    {
        super.DoKismetAttachment(Attachment, Action);
    }
    //return;    
}

defaultproperties
{
    c_bLoadMeshAssetts=true
    // Reference: SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'Engine.Default__SkeletalMeshActor.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'Engine.Default__SkeletalMeshActor.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgSkeletalMeshActor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'Engine.Default__SkeletalMeshActor.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgSkeletalMeshActor.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__SkeletalMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=SkeletalMeshComponent'TgGame.Default__TgSkeletalMeshActor.SkeletalMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgSkeletalMeshActor.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'Engine.Default__SkeletalMeshActor.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    CollisionComponent=SkeletalMeshComponent0
}