class TgDeploy_Illusion extends TgDeployable
    native(ChampYing)
    notplaceable
    hidecategories(Navigation)
    implements(TgInterface_YingIllusion);

var private native const noexport Pointer VfTable_ITgInterface_YingIllusion;
var repnotify float r_fShatterDelay;
var const int m_nShatterDeviceID;
var TgDeviceFire_ShatterExplosion m_ShatterFiremode;
var int s_nNumBeamHits;
var Vector s_BeamAimDir;
var Actor s_BeamTargetActor;
var repnotify Vector r_BeamTargetPos;
var repnotify byte r_nPlayShatterFX;
var array< delegate<DestroyedEvent> > s_OnDestroyDelegates;
//var delegate<DestroyedEvent> __DestroyedEvent__Delegate;

replication
{
    // Pos:0x000
    if(bNetDirty && int(Role) == int(ROLE_Authority))
        r_BeamTargetPos, r_fShatterDelay, 
        r_nPlayShatterFX;
}

delegate DestroyedEvent(Actor destroyedActor)
{
    //return;    
}

function TryBeamFire()
{
    // End:0x31
    if(AcquireTarget())
    {
        s_BeamAimDir = vect(0.0000000, 0.0000000, 0.0000000);
        StartBeamFire();        
    }
    else
    {
        SetTimer(0.5000000, false, 'TryBeamFire');
    }
    //return;    
}

// Export UTgDeploy_Illusion::execAcquireTarget(FFrame&, void* const)
native function bool AcquireTarget();

function StartBeamFire()
{
    // End:0x11
    if(m_FireMode == none)
    {
        return;
    }
    s_nNumBeamHits = 5;
    BeamFireAtTarget();
    SetTimer(m_FireMode.GetCustomValue1(), true, 'BeamFireAtTarget');
    //return;    
}

function BeamFireAtTarget()
{
    InstantFireDeployable();
    s_nNumBeamHits--;
    // End:0x77
    if(s_nNumBeamHits <= 0)
    {
        ClearTimer('BeamFireAtTarget');
        SetTimer(m_FireMode.m_fFirePostHitDelay, false, 'TryBeamFire');
        SetTimer(0.5000000, false, 'ClearBeamTarget');
    }
    //return;    
}

function ClearBeamTarget()
{
    s_BeamAimDir = vect(0.0000000, 0.0000000, 0.0000000);
    s_BeamTargetActor = none;
    r_BeamTargetPos = vect(0.0000000, 0.0000000, 0.0000000);
    bNetDirty = true;
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    // End:0x5A
    if(m_FireMode != none)
    {
        super.TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    }
    //return;    
}

function FireShatterDevice()
{
    local AimData Aim;
    local array<ImpactInfo> ImpactList;
    local int Idx;

    Aim.StartTrace = Location;
    Aim.EndTrace = Location;
    // End:0x12A
    if(m_ShatterFiremode != none)
    {        
        m_ShatterFiremode.CalcWeaponModeFire(self, Aim, ImpactList);
        Idx = 0;
        J0xA5:

        // End:0x12A [Loop If]
        if(Idx < ImpactList.Length)
        {
            // End:0x11C
            if(ImpactList[Idx].HitActor != none)
            {
                m_ShatterFiremode.ApplyHit(ImpactList[Idx], self);
            }
            Idx++;
            // [Loop Continue]
            goto J0xA5;
        }
    }
    //return;    
}

simulated function BeamUpdateFireFXTarget()
{
    // End:0x3C
    if((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || c_Mesh == none)
    {
        return;
    }
    // End:0x79
    if(IsZero(r_BeamTargetPos))
    {
        c_Mesh.FxDeactivateGroup('Fire', 0);        
    }
    else
    {
        BeamUpdatePSC();
        c_Mesh.FxActivateGroup('Fire', 0);
    }
    //return;    
}

simulated function BeamUpdatePSC()
{
    local TgSpecialFx Fx;
    local int I;
    local array<Object> beamFX;

    beamFX = c_Mesh.FxGetAll('Fire', 0);
    I = 0;
    J0x41:

    // End:0xC6 [Loop If]
    if(I < beamFX.Length)
    {
        Fx = TgSpecialFx(beamFX[I]);
        // End:0xB8
        if(Fx != none)
        {
            Fx.UpdateBeamFx(r_BeamTargetPos);
        }
        I++;
        // [Loop Continue]
        goto J0x41;
    }
    //return;    
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x75
    if(VarName == 'r_fShatterDelay')
    {
        // End:0x72
        if(((r_fShatterDelay > float(0)) && Instigator != none) && !Instigator.IsLocallyControlled())
        {
            TriggerShatter(r_fShatterDelay);
        }        
    }
    else
    {
        // End:0x99
        if(VarName == 'r_BeamTargetPos')
        {
            BeamUpdateFireFXTarget();            
        }
        else
        {
            // End:0xBD
            if(VarName == 'r_nPlayShatterFX')
            {
                PlayShatterFX();                
            }
            else
            {
                super.ReplicatedEvent(VarName);
            }
        }
    }
    //return;    
}

simulated event DestroyIt(optional bool bPlayShatter)
{
    local TgPawn_Ying yingOwner;
    local Vector vRotation;
    local delegate<DestroyedEvent> onEventDelegate;

    // End:0x10
    if(m_bInDestroyedState)
    {
        return;
    }
    // End:0xC5
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x50
        foreach s_OnDestroyDelegates(onEventDelegate)
        {
            DestroyedEvent(self);            
        }        
        // End:0xC5
        if(!bPlayShatter)
        {
            yingOwner = TgPawn_Ying(Instigator);
            // End:0xC5
            if((yingOwner != none) && yingOwner.r_bHasCompensate)
            {
                bPlayShatter = true;
                FireShatterDevice();
            }
        }
    }
    // End:0x153
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && bPlayShatter)
    {
        vRotation = Normal(Vector(Rotation));
        c_Mesh.FxActivateIndependant('IllusionShattered', 0, Location, vRotation);
    }
    super.DestroyIt(bPlayShatter);
    //return;    
}

simulated function TriggerShatter(float fDelay)
{
    //return;    
}

simulated event Shatter()
{
    // End:0x0F
    if(m_bInDestroyedState)
    {
        return;
    }
    FireShatterDevice();
    PlayShatterFX();
    //return;    
}

simulated function PlayShatterFX()
{
    local Vector vRotation;

    // End:0x2B
    if(int(Role) == int(ROLE_Authority))
    {
        r_nPlayShatterFX++;
        bNetDirty = true;
    }
    // End:0xAA
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        vRotation = Normal(Vector(Rotation));
        c_Mesh.FxActivateIndependant('IllusionShattered', 0, Location, vRotation);
    }
    //return;    
}

function AddOnDestroyDelegate(delegate<DestroyedEvent> delDestroy)
{
    // End:0x36
    if(s_OnDestroyDelegates.Find(delDestroy) == -1)
    {
        s_OnDestroyDelegates.AddItem(delDestroy);
    }
    //return;    
}

// Export UTgDeploy_Illusion::execGetActorFromInterface(FFrame&, void* const)
native function Actor GetActorFromInterface();

// Export UTgDeploy_Illusion::execIsNotDestroyed(FFrame&, void* const)
native function bool IsNotDestroyed();

simulated function PlayDimensionalLinkFX()
{
    // End:0x78
    if((c_Mesh != none) && !m_bInDestroyedState)
    {
        c_Mesh.FxDeactivateGroup('YingDimensionalLink', 0);
        c_Mesh.FxActivateGroup('YingDimensionalLink', 0);
    }
    //return;    
}

function TgPawn_Ying GetOwningYing()
{
    // End:0x37
    if(r_Owner != none)
    {
        return TgPawn_Ying(r_Owner.Instigator);
    }
    return none;
    //return ReturnValue;    
}

simulated state Deploy
{
    simulated function BeginState(name PreviousStateName)
    {
        super.BeginState(PreviousStateName);
        // End:0xA0
        if(c_Mesh != none)
        {
            SetCollision(false, false, false);
            c_Mesh.SetHidden(true);
            c_Mesh.FxDeactivateGroup('WhileAlive', 0);
            c_Mesh.FxActivateGroup('RiftIllusionSpawned', 0, 0, 0, true);
        }
        //return;        
    }

    simulated function EndState(name NextStateName)
    {
        super.EndState(NextStateName);
        // End:0xCD
        if(c_Mesh != none)
        {
            c_Mesh.SetHidden(false);
            c_Mesh.FxDeactivateGroup('RiftIllusionSpawned', 0);
            c_Mesh.FxActivateGroup('IllusionSpawned', 0, 0, 0, true);
            c_Mesh.FxActivateGroup('WhileAlive', 0, 0, 0, true);
            SetCollision(true, true, false);
        }
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_nShatterDeviceID=13284
    m_bAdjustMeshToGround=false
    m_InitHUDOverlayIcon=DeployableOverlayIcon.DOI_ILLUSION
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Illusion.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_nInitHUDOverlayDisplayMask=33
    Components[0]=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgDeploy_Illusion.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockActors=true
    end object
    Components[1]=CollisionCylinder
    bCollideActors=true
    bBlockActors=true
    bProjTarget=true
    CollisionComponent=CollisionCylinder
}