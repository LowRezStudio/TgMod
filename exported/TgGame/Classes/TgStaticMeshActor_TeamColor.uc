class TgStaticMeshActor_TeamColor extends StaticMeshActor
    native(Pawns)
    hidecategories(Navigation);

var(TeamColoring) const int nTaskForce;
var(TeamColoring) const name TeamColoringParameterName;
var(TeamColoring) const bool bInvertColoringParameter;
var const bool bInstancedAllMaterials;
var byte bFriendlyWithLocalPlayer;
var transient array<MaterialInterface> InitialMaterialList;

// Export UTgStaticMeshActor_TeamColor::execForceRecalculateMaterial(FFrame&, void* const)
native function ForceRecalculateMaterial();

// Export UTgStaticMeshActor_TeamColor::execRecalculateMaterial(FFrame&, void* const)
native function RecalculateMaterial(bool bIsFriendlyWithLocalPawn, optional bool bForce);

// Export UTgStaticMeshActor_TeamColor::execUpdateFriendlyFlag(FFrame&, void* const)
native final function UpdateFriendlyFlag();

simulated function NotifyLocalPlayerTeamReceived()
{
    super(Actor).NotifyLocalPlayerTeamReceived();
    UpdateFriendlyFlag();
    RecalculateMaterial(int(bFriendlyWithLocalPlayer) == int(1));
    //return;    
}

defaultproperties
{
    TeamColoringParameterName="Color_Switch"
    bFriendlyWithLocalPlayer=2
    // Reference: StaticMeshComponent'TgGame.Default__TgStaticMeshActor_TeamColor.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActor_TeamColor.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgStaticMeshActor_TeamColor.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    bAlwaysInformOfTimelapse=true
    CollisionComponent=StaticMeshComponent0
}