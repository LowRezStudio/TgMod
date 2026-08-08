class TgMissionListVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display)
    config(Engine);

var (Object) editconst int m_nMapObjectId;
var () int s_nQueueTableId;
var () int s_nQueueTableMsgId;
var () Teleporter m_Teleporter;

defaultproperties
{}
