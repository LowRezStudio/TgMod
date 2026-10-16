class TgDeviceVolume_Pulse extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var Controller DamageInstigator;
var(Object) editconst int m_nMapObjectId;
var() int s_nDeviceId;
var TgDeviceFire m_FireMode;
var int s_nTeamNumber;
var() byte s_nTaskForce;

// Export UTgDeviceVolume_Pulse::execSetupDevice(FFrame&, void* const)
native function bool SetupDevice();

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    SetupDevice();
    //return;    
}

function OnSetDamageInstigator(SeqAct_SetDamageInstigator Action)
{
    DamageInstigator = Action.GetController(Action.DamageInstigator);
    //return;    
}

simulated function OnToggle(SeqAct_Toggle inAction)
{
    super.OnToggle(inAction);
    // End:0x57
    if(inAction.InputLinks[0].bHasImpulse)
    {
        TurnOn();        
    }
    else
    {
        // End:0x9B
        if(inAction.InputLinks[1].bHasImpulse)
        {
            TurnOff();            
        }
        else
        {
            // End:0x101
            if(inAction.InputLinks[2].bHasImpulse)
            {
                // End:0xF7
                if(IsTimerActive('Fire'))
                {
                    TurnOff();                    
                }
                else
                {
                    TurnOn();
                }
            }
        }
    }
    //return;    
}

function TurnOn()
{
    SetTimer(m_FireMode.GetRefireTime(), true, 'Fire');
    //return;    
}

function TurnOff()
{
    ClearTimer('Fire');
    //return;    
}

function Fire()
{
    local int Idx;
    local array<ImpactInfo> ImpactList;

    CalcDeviceFire(vect(0.0000000, 0.0000000, 0.0000000), vect(0.0000000, 0.0000000, 0.0000000), ImpactList);
    Idx = 0;
    J0x41:

    // End:0xC6 [Loop If]
    if(Idx < ImpactList.Length)
    {
        // End:0xB8
        if(ImpactList[Idx].HitActor != none)
        {
            m_FireMode.ApplyHit(ImpactList[Idx], self);
        }
        Idx++;
        // [Loop Continue]
        goto J0x41;
    }
    //return;    
}

// Export UTgDeviceVolume_Pulse::execFindTouchingActorsFromScript(FFrame&, void* const)
native function FindTouchingActorsFromScript();

simulated function ImpactInfo CalcDeviceFire(Vector StartTrace, Vector EndTrace, optional out array<ImpactInfo> ImpactList)
{
    local TgPawn TouchedActor;
    local ImpactInfo TraceImpact, CurrentImpact;

    // End:0x1CC
    if(m_FireMode != none)
    {
        FindTouchingActorsFromScript();
        // End:0x1CB
        foreach TouchingActors(Class'TgGame.TgPawn', TouchedActor)
        {
            // End:0x1CA
            if(m_FireMode.IsValidTarget(TouchedActor))
            {
                CurrentImpact.bDirectHit = true;
                CurrentImpact.DeviceModeReference = m_FireMode;
                CurrentImpact.HitActor = TouchedActor;
                CurrentImpact.HitLocation = TouchedActor.Location;
                CurrentImpact.HitNormal = Normal(self.Location - TouchedActor.Location);
                CurrentImpact.RayDir = Normal(EndTrace - StartTrace);
                CurrentImpact.StartTrace = StartTrace;
                ImpactList.AddItem(CurrentImpact);
            }            
        }        
    }
    TraceImpact.HitActor = none;
    TraceImpact.StartTrace = StartTrace;
    TraceImpact.HitLocation = EndTrace;
    TraceImpact.HitNormal = vect(0.0000000, 0.0000000, 0.0000000);
    return TraceImpact;
    //return ReturnValue;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgDeviceVolume_Pulse.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bStatic=false
    bForceAllowKismetModification=true
    CollisionComponent=BrushComponent0
}