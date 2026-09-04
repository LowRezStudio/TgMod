class TgAnimNodeMountSync extends AnimNodeBlendBase
    native(Anim)
    hidecategories(Object,Object,Object)
    config(Engine);

var TgPawn m_TgP;
var () array<name> m_nmSyncGroupNames;

defaultproperties
{
    m_nmSyncGroupNames[0]="MountRun"
    m_nmSyncGroupNames[1]="MountIdle"
    Children=/* Array type was not detected. */
    bFixNumChildren=true
}
