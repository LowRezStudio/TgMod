class PComMusicThemeSyncActor extends Actor
    native(Audio)
    notplaceable
    hidecategories(Navigation)
    config(Engine);

var repnotify name m_ReplicatedMusicEvent;

replication {
    if(int(Role) == int(ENetRole.ROLE_Authority)) m_ReplicatedMusicEvent;
}

native function UpdateMusicEvent(name EventName);  // Export UPComMusicThemeSyncActor::execUpdateMusicEvent(FFrame&, void* const)

native function UpdateMusicEventClient(name EventName);  // Export UPComMusicThemeSyncActor::execUpdateMusicEventClient(FFrame&, void* const)

simulated event ReplicatedEvent(name VarName) { }

defaultproperties
{
    RemoteRole=ROLE_SimulatedProxy
    bServerTickIsDisabled=true
    bAlwaysRelevant=true
    bReplicateMovement=false
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=1.0000000
    NetPriority=2.7000000
}
