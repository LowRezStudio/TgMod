class TgStaticMeshActor_PantheonMIC extends TgStaticMeshActor
    native(Pawns)
    hidecategories(Navigation);

var() MaterialInstanceConstant MICOverrides[GOD_PANTHEON];
var() int m_nGameTaskForce;
var() int m_nTeamIndex;

// Export UTgStaticMeshActor_PantheonMIC::execChangePantheonMIC(FFrame&, void* const)
native function ChangePantheonMIC(int nTaskForce, int nTeamIndex);

simulated event PreBeginPlay()
{
    super(StaticMeshActor).PreBeginPlay();
    // End:0x46
    if((m_nGameTaskForce > 0) && m_nTeamIndex >= 0)
    {
        ChangePantheonMIC(m_nGameTaskForce, m_nTeamIndex);
    }
    //return;    
}

defaultproperties
{
    m_nGameTaskForce=-1
    m_nTeamIndex=-1
    // Reference: StaticMeshComponent'TgGame.Default__TgStaticMeshActor_PantheonMIC.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'TgGame.Default__TgStaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActor_PantheonMIC.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgStaticMeshActor_PantheonMIC.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    bRouteBeginPlayEvenIfStatic=true
    CollisionComponent=StaticMeshComponent0
}