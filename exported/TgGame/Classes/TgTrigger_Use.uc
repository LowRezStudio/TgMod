class TgTrigger_Use extends Trigger
    native(Kismet)
    hidecategories(Navigation);

var() editinline string m_sDisplayText;
var() editinline string m_sInactiveText;
var() editinline int m_nInteractDistance;
var() editinline bool m_bAimToInteract;
var() editinline int m_nDisplayMsgId;
var() editinline int m_nInactiveMsgId;

// Export UTgTrigger_Use::execUsedByPawn(FFrame&, void* const)
native function UsedByPawn(TgPawn User);

// Export UTgTrigger_Use::execIsUsedEnabled(FFrame&, void* const)
native function bool IsUsedEnabled();

// Export UTgTrigger_Use::execGetMsgIdToDisplay(FFrame&, void* const)
native function int GetMsgIdToDisplay();

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn P;
    local bool bTriggerUsed, foundTouch;
    local Actor A;

    foundTouch = false;
    // End:0x4B
    foreach TouchingActors(Class'Engine.Actor', A)
    {
        // End:0x4A
        if(A == Other)
        {
            foundTouch = true;
            // End:0x4B
            break;
        }        
    }    
    // End:0x5D
    if(!foundTouch)
    {
        return;
    }
    P = TgPawn(Other);
    // End:0x8A
    if(P == none)
    {
        return;
    }
    bTriggerUsed = true;
    // End:0xE8
    if(m_bAimToInteract)
    {
        bTriggerUsed = P.Controller.IsAimingAt(self, 0.9800000);
    }
    // End:0x116
    if(bTriggerUsed)
    {
        P.SetTriggerToUse(self, true);
    }
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn P;

    P = TgPawn(Other);
    // End:0x2D
    if(P == none)
    {
        return;
    }
    // End:0x72
    if(P.m_CurrentUseActor == self)
    {
        P.SetTriggerToUse(self, false);
    }
    //return;    
}

defaultproperties
{
    m_bAimToInteract=true
    // Reference: CylinderComponent'TgGame.Default__TgTrigger_Use.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Trigger.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=96.0000000
        CollisionRadius=128.0000000
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    // Reference: SpriteComponent'TgGame.Default__TgTrigger_Use.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    // Archetype: SpriteComponent'Engine.Default__Trigger.Sprite'
    begin object name="Sprite"
        ReplacementPrimitive=none
    end object
    Components[0]=Sprite
    Components[1]=CollisionCylinder
    CollisionComponent=CollisionCylinder
    SupportedEvents=/* Array type was not detected. */
}