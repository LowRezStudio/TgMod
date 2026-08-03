class TgAIBehaviorNode extends TgAIBehaviorObject
    abstract
    native(AI)
    hidecategories(Object);

enum EBehaviorComparison
{
    BEHAVIORCOMPARE_Equal,          // 0
    BEHAVIORCOMPARE_NotEqual,       // 1
    BEHAVIORCOMPARE_LessThan,       // 2
    BEHAVIORCOMPARE_LessThanOrEqual,// 3
    BEHAVIORCOMPARE_GreaterThan,    // 4
    BEHAVIORCOMPARE_GreaterThanOrEqual,// 5
    BEHAVIORCOMPARE_MAX             // 6
};

enum EBehaviorStatus
{
    BEHAVIOR_None,                  // 0
    BEHAVIOR_Complete,              // 1
    BEHAVIOR_Running,               // 2
    BEHAVIOR_Paused,                // 3
    BEHAVIOR_Failed,                // 4
    BEHAVIOR_Aborted,               // 5
    BEHAVIOR_MAX                    // 6
};

struct native BehaviorStateData
{
    var float LastTickTime;
    var int NodeToken;
    var TgAIBehaviorNode.EBehaviorStatus Status;

    structdefaultproperties
    {
        LastTickTime=0.0000000
        NodeToken=0
        Status=EBehaviorStatus.BEHAVIOR_None
    }
};

var duplicatetransient TgAIBehaviorNode Parent;
var float InvTickFrequency;
var string TitleName;
var() init string FriendlyName;
var bool bShownInMenu;
