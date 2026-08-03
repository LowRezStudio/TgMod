class LensFlareSource extends Actor
    native(LensFlare)
    placeable
    hidecategories(Navigation);

var() const editconst export editinline LensFlareComponent LensFlareComp;
var repnotify bool bCurrentlyActive;

replication
{
    // Pos:0x000
    if(bNoDelete)
        bCurrentlyActive;
}

// Export ULensFlareSource::execSetTemplate(FFrame&, void* const)
native final function SetTemplate(LensFlare NewTemplate);

simulated event PostBeginPlay()
{
    bCurrentlyActive = LensFlareComp.bIsActive;
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x66
    if(Action.InputLinks[0].bHasImpulse)
    {
        LensFlareComp.SetIsActive(true);
        bCurrentlyActive = true;        
    }
    else
    {
        // End:0xCC
        if(Action.InputLinks[1].bHasImpulse)
        {
            LensFlareComp.SetIsActive(false);
            bCurrentlyActive = false;            
        }
        else
        {
            // End:0x16E
            if(Action.InputLinks[2].bHasImpulse)
            {
                // End:0x142
                if(!bCurrentlyActive)
                {
                    LensFlareComp.SetIsActive(true);
                    bCurrentlyActive = true;                    
                }
                else
                {
                    LensFlareComp.SetIsActive(false);
                    bCurrentlyActive = false;
                }
            }
        }
    }
    LensFlareComp.LastRenderTime = WorldInfo.TimeSeconds;
    ForceNetRelevant();
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x7D
    if(VarName == 'bCurrentlyActive')
    {
        LensFlareComp.SetIsActive(bCurrentlyActive);
        LensFlareComp.LastRenderTime = WorldInfo.TimeSeconds;
    }
    //return;    
}

simulated function SetFloatParameter(name ParameterName, float Param)
{
    //return;    
}

simulated function SetVectorParameter(name ParameterName, Vector Param)
{
    //return;    
}

simulated function SetColorParameter(name ParameterName, LinearColor Param)
{
    //return;    
}

simulated function SetExtColorParameter(name ParameterName, float Red, float Green, float Blue, float Alpha)
{
    //return;    
}

simulated function SetActorParameter(name ParameterName, Actor Param)
{
    //return;    
}

defaultproperties
{
    // Reference: LensFlareComponent'Engine.Default__LensFlareSource.LensFlareComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'LensFlareComponent0'
    begin object name="LensFlareComponent0" class=Engine.LensFlareComponent
        ReplacementPrimitive=none
    end object
    LensFlareComp=LensFlareComponent0
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=none
    Components[4]=LensFlareComponent0
    Components[5]=none
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bNoDelete=true
    bHardAttach=true
    bGameRelevant=true
    bEdShouldSnap=true
}