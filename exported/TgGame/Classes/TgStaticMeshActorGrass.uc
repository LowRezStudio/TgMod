class TgStaticMeshActorGrass extends StaticMeshActor
    hidecategories(Navigation);

var float m_fTargetScale;
var Vector m_TargetScale3D;
var float m_fScaleTransitionTime;

function OnChangeScale(TgSeqAct_ChangeScale SeqAct_ChangeScale)
{
    m_fTargetScale = SeqAct_ChangeScale.TargetScale;
    m_TargetScale3D = SeqAct_ChangeScale.TargetScale3D;
    m_fScaleTransitionTime = SeqAct_ChangeScale.TransitionTime;
    // End:0xB4
    if(m_fScaleTransitionTime <= 0.0000000)
    {
        SetDrawScale(m_fTargetScale);
        SetDrawScale3D(m_TargetScale3D);        
    }
    else
    {
        SetTickIsDisabled(false);
    }
    //return;    
}

event Tick(float DeltaTime)
{
    local Vector NewScale3D;

    super(Actor).Tick(DeltaTime);
    // End:0x249
    if(m_fScaleTransitionTime > 0.0000000)
    {
        // End:0x7C
        if(m_fTargetScale != DrawScale)
        {
            SetDrawScale(FInterpConstantTo(DrawScale, m_fTargetScale, DeltaTime, 1.0000000 / m_fScaleTransitionTime));
        }
        // End:0x20E
        if(m_TargetScale3D != DrawScale3D)
        {
            NewScale3D.X = FInterpConstantTo(DrawScale3D.X, m_TargetScale3D.X, DeltaTime, 1.0000000 / m_fScaleTransitionTime);
            NewScale3D.Y = FInterpConstantTo(DrawScale3D.Y, m_TargetScale3D.Y, DeltaTime, 1.0000000 / m_fScaleTransitionTime);
            NewScale3D.Z = FInterpConstantTo(DrawScale3D.Z, m_TargetScale3D.Z, DeltaTime, 1.0000000 / m_fScaleTransitionTime);
            SetDrawScale3D(NewScale3D);
        }
        // End:0x249
        if((m_fTargetScale == DrawScale) && m_TargetScale3D == DrawScale3D)
        {
            SetTickIsDisabled(false);
        }
    }
    //return;    
}

defaultproperties
{
    m_fTargetScale=1.0000000
    m_TargetScale3D=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    // Reference: StaticMeshComponent'TgGame.Default__TgStaticMeshActorGrass.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
        bDisableAllRigidBody=true
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActorGrass.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgStaticMeshActorGrass.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    CollisionType=ECollisionType.COLLIDE_NoCollision
    bStatic=false
    bTickIsDisabled=true
    bCollideActors=false
    bBlockActors=false
    CollisionComponent=StaticMeshComponent0
}