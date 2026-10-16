class AnimNode extends AnimObject
    abstract
    native(Anim)
    hidecategories(Object,Object);

enum ESliderType
{
    ST_1D,                          // 0
    ST_2D,                          // 1
    ST_MAX                          // 2
};

struct CurveKey
{
    var name CurveName;
    var float Weight;

    structdefaultproperties
    {
        CurveName="None"
        Weight=0.0000000
    }
};

var const transient bool bRelevant;
var const transient bool bJustBecameRelevant;
var(Performance) bool bTickDuringPausedAnims;
var const bool bEditorOnly;
var const transient bool bDisableCaching;
var() bool bCallScriptEventOnInit;
var() bool bCallScriptEventOnBecomeRelevant;
var() bool bCallScriptEventOnCeaseRelevant;
var const transient int NodeTickTag;
var const transient int PostBoneUpdateNodeTickTag;
var const transient int NodeInitTag;
var const transient int NodeEndEventTick;
var const int TickArrayIndex;
var const transient int NodeCachedAtomsTag;
var const float NodeTotalWeight;
var duplicatetransient array<AnimNodeBlendBase> ParentNodes;
var() name NodeName;
var transient array<BoneAtom> CachedBoneAtoms;
var transient byte CachedNumDesiredBones;
var transient BoneAtom CachedRootMotionDelta;
var transient int bCachedHasRootMotion;
var transient array<CurveKey> CachedCurveKeys;
var transient int SearchTag;
var() Color m_LabelColor;

event OnInit()
{
    //return;    
}

event OnBecomeRelevant()
{
    //return;    
}

event OnCeaseRelevant()
{
    //return;    
}

// Export UAnimNode::execFindAnimNode(FFrame&, void* const)
native final function AnimNode FindAnimNode(name InNodeName);

// Export UAnimNode::execGetNodesByClassWrapper(FFrame&, void* const)
native final function GetNodesByClassWrapper(out array<AnimNode> Nodes, Class BaseClass);

// Export UAnimNode::execPlayAnim(FFrame&, void* const)
native function PlayAnim(optional bool bLoop = false, optional float Rate = 1.0000000, optional float StartTime = 0.0000000);

// Export UAnimNode::execStopAnim(FFrame&, void* const)
native function StopAnim();

// Export UAnimNode::execReplayAnim(FFrame&, void* const)
native function ReplayAnim();

defaultproperties
{
    m_LabelColor=(R=112,G=112,B=112,A=255)
}