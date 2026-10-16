class TgIdol extends Actor
    placeable
    hidecategories(Navigation);

var transient int r_nDefenderTaskForce;
var transient TgPawn_Character m_Holder;
var repnotify transient TgRepInfo_Player r_HolderPRI;
var transient TgPawn_Character m_OldHolder;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_HolderPRI, r_nDefenderTaskForce;
}

defaultproperties
{
    // Reference: StaticMeshComponent'TgGame.Default__TgIdol.FlagMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FlagMesh'
    begin object name="FlagMesh" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        Translation=(X=0.0000000,Y=0.0000000,Z=-45.0000000)
    end object
    Components[0]=FlagMesh
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bIgnoreRigidBodyPawns=true
    bAlwaysRelevant=true
    bUpdateSimulatedPosition=true
    NetPriority=2.0000000
}