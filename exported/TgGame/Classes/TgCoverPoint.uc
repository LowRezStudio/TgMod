class TgCoverPoint extends TgAIAnnotation
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

var() bool m_bLeanLeft;
var() bool m_bLeanRight;
var() bool m_bAllowPopup;
var() bool m_bAllowMantle;
var Vector m_vLeanLeft;
var Vector m_vLeanRight;
var Vector m_vPopUp;

// Export UTgCoverPoint::execGetAdjustedPosition(FFrame&, void* const)
native function GetAdjustedPosition(out Vector out_Position, Pawn AnnotationOwner, Actor Target);

simulated function PostBeginPlay()
{
    local Rotator rotLean;

    super.PostBeginPlay();
    rotLean = rot(0, 49151, 0);
    m_vLeanLeft = Location + (float(250) * Normal(Vector(Rotation + rotLean)));
    m_vLeanRight = Location + (float(250) * Normal(Vector(Rotation - rotLean)));
    m_vPopUp = Location + vect(0.0000000, 0.0000000, 50.0000000);
    //return;    
}

defaultproperties
{
    AnnotationType=EAIAnnotationType.AIA_CoverPoint
    // Reference: CylinderComponent'TgGame.Default__TgCoverPoint.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgAIAnnotation.CollisionCylinder'
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