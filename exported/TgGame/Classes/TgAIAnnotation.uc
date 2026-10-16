class TgAIAnnotation extends TgNavigationPoint
    abstract
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force)
    implements(Interface_AIAnnotation);

const DEFAULT_RANGE = 150;

var private native const noexport Pointer VfTable_IInterface_AIAnnotation;
var TgAIController_Behavior.EAIAnnotationType AnnotationType;
var Pawn m_pClaimedBy;

// Export UTgAIAnnotation::execGetClaimedBy(FFrame&, void* const)
native function Pawn GetClaimedBy();

// Export UTgAIAnnotation::execClaim(FFrame&, void* const)
native function Claim(Pawn pClaimedBy);

// Export UTgAIAnnotation::execInitialize(FFrame&, void* const)
native function Initialize();

// Export UTgAIAnnotation::execGetAdjustedPosition(FFrame&, void* const)
native function GetAdjustedPosition(out Vector out_Position, Pawn AnnotationOwner, Actor Target);

simulated function PostBeginPlay()
{
    super(Actor).PostBeginPlay();
    Initialize();
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgAIAnnotation.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgNavigationPoint.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}