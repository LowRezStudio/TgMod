class TgAnimNodeLockableChannelFire extends TgAnimNodeChannelFire
    native(Anim)
    hidecategories(Object,Object,Object,Object);

var() bool m_bPlayStartOnLock;
var() bool m_bPlayStartOnUnlock;
var() bool m_bPlayStartAfterLockLost;
var transient bool m_bLocked;

// Export UTgAnimNodeLockableChannelFire::execSetLocked(FFrame&, void* const)
native function SetLocked(bool bLocked);

simulated function SetLockedBase(bool bLocked)
{
    SetLocked(bLocked);
    //return;    
}

defaultproperties
{
    m_bPlayStartOnLock=true
    m_bPlayStartOnUnlock=true
    Children=/* Array type was not detected. */
}