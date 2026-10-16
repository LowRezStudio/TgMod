class TgAIUtilityHandle extends Object within Actor
    native(AI)
    config(Engine)
    dependson(TgAIController_Behavior, TgPawn);

struct UtilityFunctionList {
    var Pointer UtilityFunctionList;
    var int UtilityFunctionListCount;
    var Pointer StaticMemory;
    var transient Pointer CachedUtilities;
    var transient Pointer DynamicStorageMemory;
    structdefaultproperties {}
};

struct UtilityPair {
    var native transient map{VOID,VOID} FilteredAnnotationPoints;
};

struct UtilitySet {
    var UtilityFunctionList Functions;
    var UtilityFunctionList Filters;
    structdefaultproperties {}
};

var UtilitySet UtilitySets[EAIAnnotationType];
var UtilityPair FilteredAnnotationPoints[EAIAnnotationType];
var TgPawn.EBotBehaviorState eBehaviorState;
var TgAIController_Behavior.ERangeType AssaultRangeType;

native function TgAIAnnotation GetBestAnnotationPoint(TgAIController_Behavior.EAIAnnotationType AnnotationType);  // Export UTgAIUtilityHandle::execGetBestAnnotationPoint(FFrame&, void* const)

native function ComputeUtilities();  // Export UTgAIUtilityHandle::execComputeUtilities(FFrame&, void* const)
