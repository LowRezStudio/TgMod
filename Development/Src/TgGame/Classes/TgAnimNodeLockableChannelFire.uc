class TgAnimNodeLockableChannelFire extends TgAnimNodeChannelFire
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

var () bool m_bPlayStartOnLock;
var () bool m_bPlayStartOnUnlock;
var () bool m_bPlayStartAfterLockLost;
var transient bool m_bLocked;

native function SetLocked(bool bLocked);  // Export UTgAnimNodeLockableChannelFire::execSetLocked(FFrame&, void* const)

simulated function SetLockedBase(bool bLocked) { }

defaultproperties
{
    m_bPlayStartOnLock=true
    m_bPlayStartOnUnlock=true
    Children=/* Array type was not detected. */
}
