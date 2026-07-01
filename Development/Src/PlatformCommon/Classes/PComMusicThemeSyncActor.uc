class PComMusicThemeSyncActor extends Actor
    native(Audio)
    notplaceable
    hidecategories(Navigation);

var repnotify name m_ReplicatedMusicEvent;

replication
{
    // Pos:0x000
     if(Role == ROLE_Authority)
        m_ReplicatedMusicEvent;
}

// Export UPComMusicThemeSyncActor::execUpdateMusicEvent(FFrame&, void* const)
native function UpdateMusicEvent(name EventName);

// Export UPComMusicThemeSyncActor::execUpdateMusicEventClient(FFrame&, void* const)
native function UpdateMusicEventClient(name EventName);

simulated event ReplicatedEvent(name VarName)
{
    //return;    
}

defaultproperties
{
    RemoteRole=ROLE_SimulatedProxy
    //bServerTickIsDisabled=true
    bAlwaysRelevant=true
    bReplicateMovement=false
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=1.0000000
    NetPriority=2.7000000
}