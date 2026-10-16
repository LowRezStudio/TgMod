class TgMarkComponent extends ActorComponent
    native;

struct native TargetMark
{
    var Actor Target;
    var float fTimeLeft;
    var int nNumMarks;
    var init array<init TgEffectGroup> AppliedEffects;

    structdefaultproperties
    {
        Target=none
        fTimeLeft=0.0000000
        nNumMarks=0
        AppliedEffects=none
    }
};

var init transient array<init TargetMark> s_MarkList;
var init transient array<init TgEffectGroup> s_MarkEffectGroup;
var const int m_nHostItemId;
var const bool m_bStackEffects;
var const bool m_bRemoveMarksOnDeath;
var const float m_fMarkDuration;
var const int m_nMaxMarks;
var const int m_nPhysicalType;

// Export UTgMarkComponent::execAddMark(FFrame&, void* const)
native function AddMark(Actor Target);

// Export UTgMarkComponent::execRemoveAllMarksByActor(FFrame&, void* const)
native function RemoveAllMarksByActor(Actor Target);

// Export UTgMarkComponent::execRemoveMarkByActor(FFrame&, void* const)
native function RemoveMarkByActor(Actor Target);

// Export UTgMarkComponent::execRemoveAllMarksByIndex(FFrame&, void* const)
native function RemoveAllMarksByIndex(int nIndex);

// Export UTgMarkComponent::execRemoveMarkByIndex(FFrame&, void* const)
native function RemoveMarkByIndex(int nIndex);

// Export UTgMarkComponent::execRemoveAllMarks(FFrame&, void* const)
native function RemoveAllMarks();

// Export UTgMarkComponent::execGetNumMarksFor(FFrame&, void* const)
native function int GetNumMarksFor(Actor Target);

defaultproperties
{
    m_bRemoveMarksOnDeath=true
    m_nPhysicalType=860
}