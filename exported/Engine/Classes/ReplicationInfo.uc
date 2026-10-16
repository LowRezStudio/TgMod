class ReplicationInfo extends Info
    abstract
    native(ReplicationInfo)
    notplaceable
    hidecategories(Navigation,Movement,Collision);

defaultproperties
{
    Components=none
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bAlwaysRelevant=true
    s_bThrottleNetRelevancy=true
}