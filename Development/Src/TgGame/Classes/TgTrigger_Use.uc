class TgTrigger_Use extends Trigger
    native(Kismet)
    hidecategories(Navigation)
    config(Engine);

var () editinline string m_sDisplayText;
var () editinline string m_sInactiveText;
var () editinline int m_nInteractDistance;
var () editinline bool m_bAimToInteract;
var () editinline int m_nDisplayMsgId;
var () editinline int m_nInactiveMsgId;

native function UsedByPawn(TgPawn User);  // Export UTgTrigger_Use::execUsedByPawn(FFrame&, void* const)

native function bool IsUsedEnabled();  // Export UTgTrigger_Use::execIsUsedEnabled(FFrame&, void* const)

native function int GetMsgIdToDisplay();  // Export UTgTrigger_Use::execGetMsgIdToDisplay(FFrame&, void* const)

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal) { }

simulated event UnTouch(Actor Other) { }

defaultproperties
{}
