class TgFatalityMeshActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

var() int m_nTaskForceId;
var() export editinline TgSkeletalMeshComponent m_Mesh;

// Export UTgFatalityMeshActor::execInitialize(FFrame&, void* const)
native function Initialize(int MeshAssemblyId, int TaskForceId);

defaultproperties
{
    // Reference: TgSkeletalMeshComponent'TgGame.Default__TgFatalityMeshActor.SkelMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkelMesh'
    begin object name="SkelMesh" class=TgGame.TgSkeletalMeshComponent
        Animations=AnimNodeSequence'TgGame.Default__TgFatalityMeshActor.AnimNodeSeq0'
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgFatalityMeshActor.MyLightEnvironment'
        CastShadow=false
    end object
    m_Mesh=SkelMesh
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgFatalityMeshActor.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
        bSynthesizeSHLight=true
        bIsCharacterLightEnvironment=true
    end object
    Components[0]=MyLightEnvironment
    Components[1]=SkelMesh
}