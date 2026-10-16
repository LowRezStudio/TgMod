class PComMusicThemeSyncActor extends Actor
    native(Audio)
    notplaceable
    hidecategories(Navigation);

var repnotify name m_ReplicatedMusicEvent;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        m_ReplicatedMusicEvent;
}

// Export UPComMusicThemeSyncActor::execUpdateMusicEvent(FFrame&, void* const)
native function UpdateMusicEvent(name EventName);

// Export UPComMusicThemeSyncActor::execUpdateMusicEventClient(FFrame&, void* const)
native function UpdateMusicEventClient(name EventName);

simulated event ReplicatedEvent(name VarName)
{
    super.ReplicatedEvent(VarName);
    // End:0x3D
    if(VarName == 'm_ReplicatedMusicEvent')
    {
        UpdateMusicEventClient(m_ReplicatedMusicEvent);
    }
    //return;    
}

defaultproperties
{
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bServerTickIsDisabled=true
    bAlwaysRelevant=true
    bReplicateMovement=false
    bSkipActorPropertyReplication=true
    bOnlyDirtyReplication=true
    NetUpdateFrequency=1.0000000
    NetPriority=2.7000000
}