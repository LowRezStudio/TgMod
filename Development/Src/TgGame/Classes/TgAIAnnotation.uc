class TgAIAnnotation extends TgNavigationPoint
    abstract
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force)
    implements(Interface_AIAnnotation)
    config(Engine)
    dependson(TgAIController_Behavior);

const DEFAULT_RANGE = 150;

var TgAIController_Behavior.EAIAnnotationType AnnotationType;
var Pawn m_pClaimedBy;

native function Pawn GetClaimedBy();  // Export UTgAIAnnotation::execGetClaimedBy(FFrame&, void* const)

native function Claim(Pawn pClaimedBy);  // Export UTgAIAnnotation::execClaim(FFrame&, void* const)

native function Initialize();  // Export UTgAIAnnotation::execInitialize(FFrame&, void* const)

native function GetAdjustedPosition(out Vector out_Position, Pawn AnnotationOwner, Actor Target);  // Export UTgAIAnnotation::execGetAdjustedPosition(FFrame&, void* const)

simulated function PostBeginPlay() { }

defaultproperties
{}
