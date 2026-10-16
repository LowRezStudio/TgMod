class TgAnimBlendBySpeed extends AnimNodeBlendBySpeed
    native(Anim)
    hidecategories(Object,Object,Object,Object)
    config(Engine);

enum ESpeedType {
    EST_Velocity,  // 0
    EST_AccelAndMaxSpeed,  // 1
};

struct ResetSynchGroup {
    var () name AnimNodeSynchName;
    var AnimNodeSynch SynchNode;
    var () name GroupName;
    var () array<int> ResetChannels;
    structdefaultproperties {}
};

var TgPawn m_TgPawn;
var () TgAnimBlendBySpeed.ESpeedType m_SpeedType;
var () array<ResetSynchGroup> ResetSynchGroups;
var () bool m_bIgnoreRootMotion;
var () bool m_bIgnoreZVelocity;
var () bool m_bNotifyOwnerOnChildChange;
var (ClassOverrides) bool m_bEnableClassOverrides;
var () array<int> m_WalkChildren;
var () array<int> m_SprintChildren;
var () array<float> m_BaseSpeed;
var () array<Actor.EPhysics> m_IgnoredPhysics;
var (ClassOverrides) int m_nIndexToOverride;
var (ClassOverrides) float m_fBaseSpeedRecon;
var (ClassOverrides) float m_fBaseSpeedRobotics;
var (ClassOverrides) float m_fBaseSpeedAssault;
var (ClassOverrides) float m_fBaseSpeedMedic;
var (ClassOverrides) float m_fBaseSpeedReconFemale;
var (ClassOverrides) float m_fBaseSpeedRoboticsFemale;
var (ClassOverrides) float m_fBaseSpeedAssaultFemale;
var (ClassOverrides) float m_fBaseSpeedMedicFemale;
var (ClassOverrides) float m_fBaseSpeedReconCity;
var (ClassOverrides) float m_fBaseSpeedRoboticsCity;
var (ClassOverrides) float m_fBaseSpeedAssaultCity;
var (ClassOverrides) float m_fBaseSpeedMedicCity;
var (ClassOverrides) float m_fBaseSpeedReconFemaleCity;
var (ClassOverrides) float m_fBaseSpeedRoboticsFemaleCity;
var (ClassOverrides) float m_fBaseSpeedAssaultFemaleCity;
var (ClassOverrides) float m_fBaseSpeedMedicFemaleCity;

native function AnimNodeSynch FindSynchAnimNode(name nmNodeName);  // Export UTgAnimBlendBySpeed::execFindSynchAnimNode(FFrame&, void* const)

event OnInit() { }

defaultproperties
{
    m_bIgnoreZVelocity=true
}
