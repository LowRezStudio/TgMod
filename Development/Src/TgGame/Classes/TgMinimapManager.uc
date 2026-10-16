class TgMinimapManager extends Object
    native(Game)
    config(Engine)
    dependson(TgObject);

struct MiniMapServerEntity {
    var Vector vLocation;
    var TgObject.MiniMapEntityType eType;
    var int nSubType;
    var int nProfileId;
    var TgObject.TgMapTeam Team;
    var int nVisionRange;
    var bool bIsDead;
    var ReplicationInfo RepInfo;
    var int nIdx;
    var bool bMarked;
    var byte bVisibleOnMap;
    var byte bVisibleBySentinel;
    var bool bVisibleByDetector;
    var float fLastPingTime;
    var bool bRequireLOS;
    var bool bDetector;
    var bool bSentinel;
    var byte byVisionMask;
    var float fHealthPCT;
    var Actor FogOfWarArea;
    var bool FogOfWarAreaRevealed;
    structdefaultproperties {}
};

var TgObject.TgMapTeam m_LocalTeam;
var bool m_bShouldDisableVisionRange;
var bool m_bSkipWorldGeometryLOS;
var bool m_bRequiresVisionUpdate;
var float m_fFogOfWarAreaRevealTime;
var float m_fUpdateTimer;
var float m_fLastEntityUpdateTime;
var init array<init ReplicationInfo> m_ReferencedRepInfos;

native function Update(optional bool bForce=true);  // Export UTgMinimapManager::execUpdate(FFrame&, void* const)

native function UpdateThreaded();  // Export UTgMinimapManager::execUpdateThreaded(FFrame&, void* const)

native function RemoveAllEntities();  // Export UTgMinimapManager::execRemoveAllEntities(FFrame&, void* const)

native function ForceUpdate(ReplicationInfo ri);  // Export UTgMinimapManager::execForceUpdate(FFrame&, void* const)

event InitForTaskforce(TgRepInfo_TaskForce tf) { }

defaultproperties
{
    m_fFogOfWarAreaRevealTime=1.0000000
    m_fUpdateTimer=0.1000000
}
