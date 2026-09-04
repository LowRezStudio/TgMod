class TgAIUtilityHandle extends Object within Actor
    native(AI);

struct native UtilityFunctionList
{
    var native Pointer UtilityFunctionList;
    var int UtilityFunctionListCount;
    var native Pointer StaticMemory;
    var native transient Pointer CachedUtilities;
    var native transient Pointer DynamicStorageMemory;

    structdefaultproperties
    {
        UtilityFunctionListCount=0
    }
};

struct native UtilityPair
{
    var native transient map{VOID,VOID} FilteredAnnotationPoints;
};

struct native UtilitySet
{
    var UtilityFunctionList Functions;
    var UtilityFunctionList Filters;

    structdefaultproperties
    {
        Functions=(UtilityFunctionListCount=0)
        Filters=(UtilityFunctionListCount=0)
    }
};

var UtilitySet UtilitySets[EAIAnnotationType];
var UtilityPair FilteredAnnotationPoints[EAIAnnotationType];
var TgPawn.EBotBehaviorState eBehaviorState;
var TgAIController_Behavior.ERangeType AssaultRangeType;

// Export UTgAIUtilityHandle::execGetBestAnnotationPoint(FFrame&, void* const)
native function TgAIAnnotation GetBestAnnotationPoint(TgAIController_Behavior.EAIAnnotationType AnnotationType);

// Export UTgAIUtilityHandle::execComputeUtilities(FFrame&, void* const)
native function ComputeUtilities();
