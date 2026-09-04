class TgDeviceVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() bool bPainCausing;
var bool BACKUP_bPainCausing;
var bool s_bDeviceActive;
var Info PainTimer;
var Controller DamageInstigator;
var(Object) editconst int m_nMapObjectId;
var() int s_nDeviceId;
var TgDeviceFire s_DeviceFireMode;
var() byte s_nTaskForce;

// Export UTgDeviceVolume::execSetupDevice(FFrame&, void* const)
native function bool SetupDevice();

simulated event PostBeginPlay()
{
    local TgGame Game;

    // End:0x1A
    if(!SetupDevice())
    {
        s_DeviceFireMode = none;
    }
    // End:0x41
    if(s_DeviceFireMode != none)
    {
        bPainCausing = true;
        s_bDeviceActive = true;
    }
    BACKUP_bPainCausing = bPainCausing;
    // End:0x178
    if(int(Role) == int(ROLE_Authority))
    {
        Game = TgGame(WorldInfo.Game);
        // End:0xCD
        if(Game != none)
        {
            Game.s_DeviceVolumes.AddItem(self);
        }
        // End:0xFD
        if(bPainCausing)
        {
            PainTimer = Spawn(Class'TgGame.TgDeviceVolumeInfo', self);
        }
        // End:0x178
        if((PainTimer != none) && s_DeviceFireMode != none)
        {
            PainTimer.ClearTimer();
            PainTimer.SetTimer(s_DeviceFireMode.GetRefireTime(), true);
        }
    }
    //return;    
}

function Reset()
{
    bPainCausing = BACKUP_bPainCausing;
    bForceNetUpdate = true;
    //return;    
}

simulated function OnToggle(SeqAct_Toggle inAction)
{
    super.OnToggle(inAction);
    // End:0x59
    if(inAction.InputLinks[0].bHasImpulse)
    {
        bPainCausing = true;        
    }
    else
    {
        // End:0x9F
        if(inAction.InputLinks[1].bHasImpulse)
        {
            bPainCausing = false;            
        }
        else
        {
            // End:0xEE
            if(inAction.InputLinks[2].bHasImpulse)
            {
                bPainCausing = !bPainCausing;
            }
        }
    }
    //return;    
}

function TimerPop(TgDeviceVolumeInfo T)
{
    local Actor A;

    // End:0x6B
    if(T == PainTimer)
    {
        // End:0x28
        if(!bPainCausing)
        {
            return;
        }
        // End:0x6A
        foreach TouchingActors(Class'Engine.Actor', A)
        {
            // End:0x69
            if(CanCausePainTo(A))
            {
                CausePainTo(A);
            }            
        }        
    }
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn_Character TgP;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x64
    if(bPainCausing)
    {
        // End:0x64
        if(CanCausePainTo(Other))
        {
            CausePainTo(Other);
        }
    }
    TgP = TgPawn_Character(Other);
    // End:0xE1
    if((TgP != none) && TgP.m_HomeguardVolumes.Find(self) == -1)
    {
        TgP.m_HomeguardVolumes.AddItem(self);
    }
    // End:0x125
    if((TgP != none) && s_nDeviceId == 10986)
    {
        TgP.OnHealingWell(true);
    }
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn_Character TgP;

    super(Actor).UnTouch(Other);
    TgP = TgPawn_Character(Other);
    // End:0xE9
    if(TgP != none)
    {
        TgP.m_HomeguardVolumes.RemoveItem(self);
        // End:0xE9
        if((TgP.m_HomeguardVolumes.Length == 0) && !TgP.r_bInCombatFlag)
        {
            TgP.m_LastHomeguardTime = WorldInfo.TimeSeconds;
        }
    }
    // End:0x12D
    if((TgP != none) && s_nDeviceId == 10986)
    {
        TgP.OnHealingWell(false);
    }
    //return;    
}

function CausePainTo(Actor Other)
{
    ApplyHit(Other);
    //return;    
}

function bool CanCausePainTo(Actor Other)
{
    // End:0x5B
    if(((Other == none) || !Other.bCanBeDamaged) || Other.bStatic)
    {
        return false;
    }
    // End:0x7D
    if(!s_bDeviceActive || s_DeviceFireMode == none)
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

function OnSetDamageInstigator(SeqAct_SetDamageInstigator Action)
{
    DamageInstigator = Action.GetController(Action.DamageInstigator);
    //return;    
}

function ApplyHit(Actor Target)
{
    local ImpactInfo Impact;

    // End:0x11
    if(s_DeviceFireMode == none)
    {
        return;
    }
    // End:0x16F
    if(s_DeviceFireMode != none)
    {
        // End:0x16F
        if(s_DeviceFireMode.IsValidTarget(Target))
        {
            Impact.HitActor = Target;
            Impact.HitLocation = Target.Location;
            Impact.HitNormal = vect(0.0000000, 0.0000000, 0.0000000);
            Impact.RayDir = vect(0.0000000, 0.0000000, 0.0000000);
            // End:0x146
            if(DamageInstigator != none)
            {
                s_DeviceFireMode.ApplyHit(Impact, DamageInstigator);                
            }
            else
            {
                s_DeviceFireMode.ApplyHit(Impact, self);
            }
        }
    }
    //return;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    s_nTaskForce = byte(Action.TaskForceNumber);
    //return;    
}

event int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x15D
    if(GRI != none)
    {
        // End:0x151
        if((GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload') || GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload_Practice')
        {
            // End:0x151
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x10B
                if(int(s_nTaskForce) == int(1))
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    // End:0x14F
                    if(int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1))
                    {
                        return 2;                        
                    }
                    else
                    {
                        return 1;
                    }
                }
            }
        }
        return int(s_nTaskForce);
    }
    //return ReturnValue;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgDeviceVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    bForceAllowKismetModification=true
    CollisionComponent=BrushComponent0
}