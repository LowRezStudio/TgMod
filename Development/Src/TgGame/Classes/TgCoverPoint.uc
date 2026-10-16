class TgCoverPoint extends TgAIAnnotation
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force)
    config(Engine);

var () bool m_bLeanLeft;
var () bool m_bLeanRight;
var () bool m_bAllowPopup;
var () bool m_bAllowMantle;
var Vector m_vLeanLeft;
var Vector m_vLeanRight;
var Vector m_vPopUp;

native function GetAdjustedPosition(out Vector out_Position, Pawn AnnotationOwner, Actor Target);  // Export UTgCoverPoint::execGetAdjustedPosition(FFrame&, void* const)

simulated function PostBeginPlay() { }

defaultproperties
{}
