class UIAchievementPopups extends TgGfxScene within GFxMoviePlayer
    native(GFxScene);

const UIACHIEVEMENTPOPUPS_PROGRESS_PERCENT = 0.2;

struct native AchievementProgressData
{
    var bool hasBeenProcessed;
    var bool isCompleted;
    var int ActivityId;
    var int goalId;
    var int goalGroupType;
    var int numGoalsInGroup;
    var int descMsgId;
    var int activityMsgId;
    var int goalMsgId;
    var int activationValueId;
    var int countToComplete;
    var int currentCount;
    var int countDelta;
    var int titleMsgId;
    var int IconId;
    var int pointValue;

    structdefaultproperties
    {
        hasBeenProcessed=false
        isCompleted=false
        ActivityId=0
        goalId=0
        goalGroupType=0
        numGoalsInGroup=0
        descMsgId=0
        activityMsgId=0
        goalMsgId=0
        activationValueId=0
        countToComplete=0
        currentCount=0
        countDelta=0
        titleMsgId=0
        IconId=0
        pointValue=0
    }
};

var bool m_bNewElementsQueued;
var array<AchievementProgressData> m_rawProgressList;
var array<AchievementProgressData> m_queuedProgressList;
var GFxObject m_pPopup;
var GFxObject m_pUnlockedTF;
var GFxObject m_pPointsTF;
var GFxObject m_pNameTF;
var GFxObject m_pDescriptionTF;
var GFxObject m_pIconLoader;
var GFxObject m_pProgressBar;
var GFxObject m_pProgressBarMask;
var GFxObject m_pProgressBarTF;
var GFxObject m_pProgressBarFill;
var float m_fDisplayTimer;
var float m_fDelayTimer;

defaultproperties
{
    m_bBlur=true
    m_bVisibleOnLoad=true
    m_bAlwaysTick=true
    m_Name="UIAchievementPopups"
}