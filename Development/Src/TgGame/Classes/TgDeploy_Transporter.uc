class TgDeploy_Transporter extends TgDeployable
    native(ChampKinessa)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var Vector m_StartLocation;
var Vector m_ProjectileEndLocation;
var float m_fProjectileHeight;
var TgSpecialFx m_DeploymentFX;
var repnotify Vector r_TeleportLocation;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) r_TeleportLocation;
}

simulated event ReplicatedEvent(name VarName) { }

simulated event SpawnDeployFX() { }

simulated function Tick(float DeltaSeconds) { }

defaultproperties
{}
