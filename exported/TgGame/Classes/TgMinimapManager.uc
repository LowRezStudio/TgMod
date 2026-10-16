class TgMinimapManager extends Object
    native(Game);

struct native MiniMapServerEntity
{
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

    structdefaultproperties
    {
        vLocation=(X=0.0000000,Y=0.0000000,Z=0.0000000)
        eType=MiniMapEntityType.MMap_LocalSpectator
        nSubType=0
        nProfileId=0
        Team=TgMapTeam.MAPTEAM_1
        nVisionRange=0
        bIsDead=false
        RepInfo=none
        nIdx=0
        bMarked=false
        bVisibleOnMap=0
        bVisibleBySentinel=0
        bVisibleByDetector=false
        fLastPingTime=0.0000000
        bRequireLOS=false
        bDetector=false
        bSentinel=false
        byVisionMask=0
        fHealthPCT=0.0000000
        FogOfWarArea=none
        FogOfWarAreaRevealed=false
    }
};

var TgObject.TgMapTeam m_LocalTeam;
var private native const transient map{VOID,VOID} m_EntityMap;
var bool m_bShouldDisableVisionRange;
var bool m_bSkipWorldGeometryLOS;
var bool m_bRequiresVisionUpdate;
var float m_fFogOfWarAreaRevealTime;
var float m_fUpdateTimer;
var float m_fLastEntityUpdateTime;
var init array<init ReplicationInfo> m_ReferencedRepInfos;

// Export UTgMinimapManager::execUpdate(FFrame&, void* const)
native function Update(optional bool bForce = true);

// Export UTgMinimapManager::execUpdateThreaded(FFrame&, void* const)
native function UpdateThreaded();

// Export UTgMinimapManager::execRemoveAllEntities(FFrame&, void* const)
native function RemoveAllEntities();

// Export UTgMinimapManager::execForceUpdate(FFrame&, void* const)
native function ForceUpdate(ReplicationInfo ri);

event InitForTaskforce(TgRepInfo_TaskForce tf)
{
    m_LocalTeam = tf.r_MapTeam;
    //return;    
}

defaultproperties
{
    m_fFogOfWarAreaRevealTime=1.0000000
    m_fUpdateTimer=0.1000000
}