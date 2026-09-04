class MobileTouchInputVolume extends Volume
    hidecategories(Navigation,Object,Movement,Display)
    implements(TouchableElement3D);

var bool bEnabled;

simulated function OnToggle(SeqAct_Toggle inAction)
{
    // End:0x46
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(inAction.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    super.OnToggle(inAction);
    //return;    
}

function HandleClick()
{
    // End:0x24
    if(bEnabled)
    {
        TriggerEventClass(Class'GameFramework.SeqEvent_MobileTouchInputVolume', self, 1);
    }
    //return;    
}

function HandleDoubleClick()
{
    // End:0x25
    if(bEnabled)
    {
        TriggerEventClass(Class'GameFramework.SeqEvent_MobileTouchInputVolume', self, 2);
    }
    //return;    
}

function HandleDragOver()
{
    // End:0x24
    if(bEnabled)
    {
        TriggerEventClass(Class'GameFramework.SeqEvent_MobileTouchInputVolume', self, 0);
    }
    //return;    
}

defaultproperties
{
    bEnabled=true
    // Reference: BrushComponent'GameFramework.Default__MobileTouchInputVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    CollisionComponent=BrushComponent0
    SupportedEvents=/* Array type was not detected. */
}