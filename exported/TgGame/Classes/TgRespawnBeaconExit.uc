class TgRespawnBeaconExit extends TgRespawnBeaconBase
    native
    hidecategories(Navigation,SkeletalMeshActor);

enum ERespawnBeaconActiveState
{
    RBAS_Inactive,                  // 0
    RBAS_Carried,                   // 1
    RBAS_Deploying,                 // 2
    RBAS_Active,                    // 3
    RBAS_MAX                        // 4
};

var(BeaconExit) bool m_bChangesYaw;
var bool c_bHiddenToLocalPlayer;
var(BeaconExit) float m_fPercHealthPerSec;
var(BeaconExit) float m_fHealthRegenLockoutTime;
var int r_nRespawnTime;
var float m_fTimeUntilHealTick;
var Rotator m_rInitialRot;
var Vector m_vInitialPos;
var TgRepInfo_Player r_CarrierRepInfo;
var Actor m_SpawnPointOverride;
var TgVisibilityVolume r_CurrentVisibilityVolumes[2];
var TgRespawnBeaconExit.ERespawnBeaconActiveState c_LocalActiveState;
var repnotify TgRespawnBeaconExit.ERespawnBeaconActiveState r_ActiveState;
var repnotify byte r_nPlayTakeHit;
var transient array<TgRespawnBeaconEntrance> m_Entrances;
var transient array< delegate<BeaconStateChanged> > m_CarriedDel;
var transient array< delegate<BeaconStateChanged> > m_DestroyedDel;
var transient array< delegate<BeaconStateChanged> > m_DeployingDel;
var transient array< delegate<BeaconStateChanged> > m_ActiveDel;
var Vector r_nDeathLocation;
var Controller m_LastDamager;
//var delegate<BeaconStateChanged> __BeaconStateChanged__Delegate;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_ActiveState, r_CarrierRepInfo, 
        r_CurrentVisibilityVolumes, r_nDeathLocation, 
        r_nPlayTakeHit, r_nRespawnTime;
}

simulated delegate BeaconStateChanged()
{
    //return;    
}

// Export UTgRespawnBeaconExit::execOnBeaconReset(FFrame&, void* const)
native function OnBeaconReset();

// Export UTgRespawnBeaconExit::execHasAnyEnabledEntrances(FFrame&, void* const)
native final function bool HasAnyEnabledEntrances();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2A
    if(VarName == 'r_ActiveState')
    {
        SetActiveState(r_ActiveState);
    }
    // End:0x4B
    if(VarName == 'r_nPlayTakeHit')
    {
        PlayTakeHitEffect();
    }
    // End:0x8E
    if(((VarName == 'r_nHealth') && r_nHealth > 0) && m_bDestroyed)
    {
        m_bDestroyed = false;
    }
    super(TgDestructible).ReplicatedEvent(VarName);
    //return;    
}

function OnBeaconExitSetRespawn(TgSeqAct_BeaconExitSetRespawn inAction)
{
    // End:0x11
    if(inAction == none)
    {
        return;
    }
    m_SpawnPointOverride = inAction.m_RespawnPoint;
    // End:0x7C
    if(inAction.m_bRespawnImmediately && int(r_ActiveState) != int(1))
    {
        DestroyIt();
    }
    //return;    
}

function AddVisibilityVolume(TgVisibilityVolume Vol)
{
    local int I, arrayPosCandidate;

    arrayPosCandidate = -1;
    I = 0;
    J0x1A:

    // End:0x8A [Loop If]
    if(I < 2)
    {
        // End:0x59
        if(r_CurrentVisibilityVolumes[I] == none)
        {
            arrayPosCandidate = I;            
        }
        else
        {
            // End:0x7C
            if(r_CurrentVisibilityVolumes[I] == Vol)
            {
                return;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x1A;
    }
    // End:0xB6
    if(arrayPosCandidate >= 0)
    {
        r_CurrentVisibilityVolumes[arrayPosCandidate] = Vol;
    }
    //return;    
}

function RemoveVisibilityVolume(TgVisibilityVolume Vol)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x61 [Loop If]
    if(I < 2)
    {
        // End:0x53
        if(r_CurrentVisibilityVolumes[I] == Vol)
        {
            r_CurrentVisibilityVolumes[I] = none;
            return;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated event PostBeginPlay()
{
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;

    super(TgDestructible).PostBeginPlay();
    m_vInitialPos = Location;
    m_rInitialRot = Rotation;
    // End:0x118
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x118
        if(WorldInfo != none)
        {
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x118
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(int(m_nTaskForce));
                // End:0x118
                if(Taskforce != none)
                {
                    Taskforce.r_RespawnBeaconExit = self;
                    Taskforce.bNetDirty = true;
                }
            }
        }
    }
    //return;    
}

simulated event bool AcceptTeleport(TgPawn Incoming, TgRespawnBeaconEntrance Source)
{
    local Rotator NewRot, oldRot;
    local float Mag, HeightOffset;
    local Vector oldDir, NewLocation, oldLocation;
    local Controller C;
    local float fIncomingHeight;

    // End:0x22
    if((Incoming == none) || Source == none)
    {
        return false;
    }
    // End:0x38
    if(int(r_ActiveState) != int(3))
    {
        return false;
    }
    oldLocation = Incoming.Location;
    NewRot = Incoming.Rotation;
    // End:0xF6
    if(m_bChangesYaw)
    {
        oldRot = Incoming.Rotation;
        NewRot.Yaw = Rotation.Yaw;
    }
    // End:0x18B
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x18A
        foreach WorldInfo.AllControllers(Class'Engine.Controller', C)
        {
            // End:0x189
            if(C.Enemy == Incoming)
            {
                C.EnemyJustTeleported();
            }            
        }        
    }
    fIncomingHeight = Incoming.NativeGetCollisionHeight();
    HeightOffset = float(Max(int(Incoming.Location.Z - Source.Location.Z), int(fIncomingHeight)));
    NewLocation = Location;
    NewLocation.Z += HeightOffset;
    // End:0x295
    if(!Incoming.SetLocation(NewLocation))
    {
        return false;
    }
    // End:0x338
    if(int(Role) == int(ROLE_Authority))
    {
        NewRot.Roll = 0;
        Incoming.SetRotation(NewRot);
        Incoming.SetViewRotation(NewRot);
        Incoming.ClientSetRotation(NewRot);
    }
    // End:0x3B5
    if(Incoming.Controller != none)
    {
        Incoming.Controller.MoveTimer = -1.0000000;
        Incoming.SetMoveTarget(self);
    }
    Incoming.FlashPlaySpecialEffect(9, oldLocation);
    // End:0x4FD
    if(m_bChangesYaw)
    {
        // End:0x435
        if(int(Incoming.Physics) == int(1))
        {
            oldRot.Pitch = 0;
        }
        oldDir = Vector(oldRot);
        Mag = Incoming.Velocity Dot oldDir;
        Incoming.Velocity = (Incoming.Velocity - (Mag * oldDir)) + (Mag * Vector(Incoming.Rotation));
    }
    return true;
    //return ReturnValue;    
}

function SetBeaconCollision(bool IsActive)
{
    SetCollision(IsActive, false);
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn TgP;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    TgP = TgPawn(Other);
    // End:0x7E
    if((TgP == none) || !CanBePickedUp(TgPawn(Other)))
    {
        return;
    }
    TgP.TouchingRespawnBeaconExit(self, true);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn TgP;

    super(Actor).UnTouch(Other);
    TgP = TgPawn(Other);
    // End:0x5F
    if(TgP != none)
    {
        TgP.TouchingRespawnBeaconExit(self, false);
    }
    //return;    
}

simulated function bool IsValidTarget(TgPawn TgP)
{
    return (TgP != none) && int(TgP.GetTaskForceNumber()) == int(m_nTaskForce);
    //return ReturnValue;    
}

simulated function bool CanBePickedUp(TgPawn TgP)
{
    return (IsValidTarget(TgP)) && int(r_ActiveState) > int(1);
    //return ReturnValue;    
}

function bool Pickup(TgPawn TgP)
{
    local TgPlayerController TgPC;

    // End:0x1A
    if(!CanBePickedUp(TgP))
    {
        return false;
    }
    r_CarrierRepInfo = TgP.GetPRI();
    TgPC = TgPlayerController(TgP.Controller);
    // End:0xBA
    if((TgPC != none) && int(Role) == int(ROLE_Authority))
    {
        TgPC.ClientRequestHelpText(123);
    }
    SetBeaconCollision(false);
    SetActiveState(1);
    bNetDirty = true;
    ClearTimer('Deployed');
    return true;
    //return ReturnValue;    
}

function Place(TgPawn TgP)
{
    local Vector NewLoc;
    local Rotator NewRot;

    NewLoc = TgP.Location;
    NewLoc.Z -= TgP.GetCollisionHeight();
    SetLocation(NewLoc);
    NewRot = TgP.Rotation;
    NewRot.Roll = 0;
    NewRot.Pitch = 0;
    SetRotation(NewRot);
    PlaceAtLocation(NewLoc, NewRot);
    //return;    
}

function PlaceFromDeploy(TgDeploy_RespawnBeacon TgD)
{
    local Vector NewLoc;
    local Rotator NewRot;

    NewLoc = TgD.Location;
    // End:0x9D
    if(TgD.m_TargetComponent != none)
    {
        NewLoc.Z += TgD.m_TargetComponent.CollisionHeight;
    }
    NewRot = TgD.Rotation;
    NewRot.Pitch = 0;
    NewRot.Roll = 0;
    PlaceAtLocation(NewLoc, NewRot);
    //return;    
}

function PlaceAtLocation(Vector NewLocation, Rotator NewRotation)
{
    r_CarrierRepInfo = none;
    SetLocation(NewLocation);
    SetRotation(NewRotation);
    SetBeaconCollision(true);
    SetActiveState(2);
    r_nDeathLocation = Location;
    m_bDestroyed = false;
    r_nHealth = r_nMaxHealth;
    // End:0x99
    if(m_fDeployTime > 0.0000000)
    {
        SetTimer(m_fDeployTime, false, 'Deployed');        
    }
    else
    {
        Deployed();
    }
    //return;    
}

function Deployed()
{
    local float fDesiredLifeSpan;

    SetBeaconCollision(true);
    SetActiveState(3);
    fDesiredLifeSpan = GetDesiredLifeSpan();
    // End:0x55
    if(fDesiredLifeSpan > 0.0000000)
    {
        SetTimer(fDesiredLifeSpan, false, 'DestroyIt');
    }
    //return;    
}

simulated function DestroyIt(optional bool bSkipFx)
{
    // End:0x10
    if(m_bDestroyed)
    {
        return;
    }
    ClearTimer('DestroyIt');
    super(TgDestructible).DestroyIt(bSkipFx);
    // End:0x10E
    if(int(Role) == int(ROLE_Authority))
    {
        SetBeaconCollision(false);
        // End:0xAB
        if(m_SpawnPointOverride != none)
        {
            SetLocation(m_SpawnPointOverride.Location);
            SetRotation(m_SpawnPointOverride.Rotation);            
        }
        else
        {
            SetLocation(m_vInitialPos);
            SetRotation(m_rInitialRot);
        }
        OnBeaconReset();
        r_CarrierRepInfo = none;
        SetActiveState(0);
        ClearTimer('Deployed');
        BeginRespawnTimer();
        bNetDirty = true;
    }
    //return;    
}

function float GetDesiredLifeSpan()
{
    local TgGame_Paladins Game;

    Game = TgGame_Paladins(WorldInfo.Game);
    return ((Game != none) ? Game.m_fRespawnBeaconLifeSpan : 0.0000000);
    //return ReturnValue;    
}

function BeginRespawnTimer()
{
    //return;    
}

function UpdateRespawnTime()
{
    r_nRespawnTime--;
    // End:0x24
    if(r_nRespawnTime <= 0)
    {
        Respawn();
    }
    //return;    
}

function Respawn()
{
    ClearTimer('UpdateRespawnTime');
    SetActiveState(2);
    SetTimer(m_fDeployTime, false, 'Deployed');
    r_CarrierRepInfo = none;
    SetBeaconCollision(true);
    ForceNetRelevant();
    SetCollision(true, false);
    m_bDestroyed = false;
    r_nHealth = r_nMaxHealth;
    bNetDirty = true;
    //return;    
}

simulated function FXCarried()
{
    local delegate<BeaconStateChanged> beaconStateChangeDelegate;

    // End:0x40
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x3F
        foreach m_CarriedDel(beaconStateChangeDelegate)
        {
            BeaconStateChanged();            
        }        
    }
    // End:0xA7
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportExitPickup', 0);
        m_ActualMeshComponent.FxActivateGroup('TeleportExitPickup', 0);
    }
    m_bDisplayHealth = false;
    SetHidden(true);
    //return;    
}

simulated function FXDestroyed()
{
    local delegate<BeaconStateChanged> beaconStateChangeDelegate;

    // End:0x40
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x3F
        foreach m_DestroyedDel(beaconStateChangeDelegate)
        {
            BeaconStateChanged();            
        }        
    }
    m_bDisplayHealth = false;
    SetHidden(true);
    // End:0xD9
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxSpawnEmitter('Destroyed', 0, r_nDeathLocation, Vector(Rotation));
        m_ActualMeshComponent.FxSpawnSound('Destroyed', 0, r_nDeathLocation);
    }
    //return;    
}

simulated function FXDeploying()
{
    local delegate<BeaconStateChanged> beaconStateChangeDelegate;
    local editinline SkeletalMeshComponent SkelComp;
    local TgAnimBlendByTeleportBeacon Node;

    // End:0x40
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x3F
        foreach m_DeployingDel(beaconStateChangeDelegate)
        {
            BeaconStateChanged();            
        }        
    }
    m_bDisplayHealth = true;
    SetHidden(false);
    // End:0xFB
    if(m_ActualMeshComponent != none)
    {
        SkelComp = SkeletalMeshComponent(m_ActualMeshComponent);
        // End:0xCE
        if(SkelComp != none)
        {
            SkelComp.SetAnimTreeTemplate(SkelComp.AnimTreeTemplate);
        }
        m_ActualMeshComponent.FxActivateGroup('TeleportExitDeploy', 0);
    }
    // End:0x13B
    foreach m_BeaconNodes(Node)
    {
        Node.Deploy(m_fDeployTime);        
    }    
    //return;    
}

simulated function FXActive()
{
    local delegate<BeaconStateChanged> beaconStateChangeDelegate;
    local TgAnimBlendByTeleportBeacon Node;

    // End:0x40
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x3F
        foreach m_ActiveDel(beaconStateChangeDelegate)
        {
            BeaconStateChanged();            
        }        
    }
    m_bDisplayHealth = true;
    SetHidden(false);
    // End:0x93
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxActivateGroup('TeleportExitActive', 0);
    }
    // End:0xF3
    foreach m_BeaconNodes(Node)
    {
        // End:0xF2
        if(!Node.m_bDeployed)
        {
            Node.Deploy(0.0000000);
        }        
    }    
    //return;    
}

simulated function FXEndDeploying()
{
    // End:0x3A
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportExitDeploy', 0);
    }
    //return;    
}

simulated function FXEndActive()
{
    // End:0x3A
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportExitActive', 0);
    }
    //return;    
}

simulated function PlayTakeHitEffect()
{
    // End:0x92
    if((int(WorldInfo.NetMode) != int(NM_DedicatedServer)) && m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportExitHit', 0);
        m_ActualMeshComponent.FxActivateGroup('TeleportExitHit', 0);
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    m_LastDamager = EventInstigator;
    super(TgDestructible).TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
    m_LastDamager = none;
    m_fTimeUntilHealTick = m_fHealthRegenLockoutTime;
    // End:0xA0
    if(r_nHealth > 0)
    {
        r_nPlayTakeHit++;
        PlayTakeHitEffect();
    }
    //return;    
}

simulated function SetActiveState(TgRespawnBeaconExit.ERespawnBeaconActiveState NewState)
{
    local TgPawn P;

    // End:0x44
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x31
        if(int(NewState) == int(r_ActiveState))
        {
            return;
        }
        r_ActiveState = NewState;
    }
    // End:0x192
    if(int(c_LocalActiveState) != int(NewState))
    {
        switch(c_LocalActiveState)
        {
            // End:0x84
            case 2:
                FXEndDeploying();
                // End:0x99
                break;
            // End:0x96
            case 3:
                FXEndActive();
                // End:0x99
                break;
            // End:0xFFFF
            default:
                break;
        }
        switch(NewState)
        {
            // End:0xBE
            case 0:
                FXDestroyed();
                // End:0xF7
                break;
            // End:0xD0
            case 1:
                FXCarried();
                // End:0xF7
                break;
            // End:0xE2
            case 2:
                FXDeploying();
                // End:0xF7
                break;
            // End:0xF4
            case 3:
                FXActive();
                // End:0xF7
                break;
            // End:0xFFFF
            default:
                break;
        }
        // End:0x17F
        if((int(c_LocalActiveState) > int(1)) != (int(NewState) > int(1)))
        {
            // End:0x17E
            foreach TouchingActors(Class'TgGame.TgPawn', P)
            {
                // End:0x17D
                if(IsValidTarget(P))
                {
                    P.TouchingRespawnBeaconExit(self, int(NewState) > int(1));
                }                
            }            
        }
        c_LocalActiveState = NewState;
    }
    //return;    
}

simulated function ClientFlashTeleportFX()
{
    // End:0x16
    if(int(r_ActiveState) != int(3))
    {
        return;
    }
    // End:0x7D
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportFlash', 0);
        m_ActualMeshComponent.FxActivateGroup('TeleportFlash', 0);
    }
    //return;    
}

simulated function SetPendingTeleportFx(bool bIsPendingTeleport)
{
    // End:0x62
    if(bIsPendingTeleport)
    {
        // End:0x23
        if(int(r_ActiveState) != int(3))
        {
            return;
        }
        // End:0x5F
        if(m_ActualMeshComponent != none)
        {
            m_ActualMeshComponent.FxActivateGroup('TeleportPending', 0);
        }        
    }
    else
    {
        // End:0x9C
        if(m_ActualMeshComponent != none)
        {
            m_ActualMeshComponent.FxDeactivateGroup('TeleportPending', 0);
        }
    }
    //return;    
}

defaultproperties
{
    m_bChangesYaw=true
    m_fPercHealthPerSec=0.1500000
    m_fHealthRegenLockoutTime=3.0000000
    m_nMeshAssemblyId=5746
    m_bShouldShowSilhouetteToFriends=true
    r_nMaxHealth=1900
    m_bDisplayHealth=false
    // Reference: SkeletalMeshComponent'TgGame.Default__TgRespawnBeaconExit.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgRespawnBeaconExit.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconExit.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconExit.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgRespawnBeaconExit.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgRespawnBeaconBase.MySilhouette'
    begin object name="MySilhouette"
        SilhouetteColor=(R=0.0780566,G=0.7154654,B=0.8671355,A=0.2500000)
        NearThickness=0.5500000
        FarThickness=4.0000000
        ReplacementPrimitive=none
        TickGroup=ETickingGroup.TG_PostAsyncWork
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgRespawnBeaconExit.FaceAudioComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FaceAudioComponent'
    // Archetype: AudioComponent'TgGame.Default__TgRespawnBeaconBase.FaceAudioComponent'
    begin object name="FaceAudioComponent"
    end object
    FacialAudioComp=FaceAudioComponent
    Components[0]=MyLightEnvironment
    Components[1]=SkeletalMeshComponent0
    Components[2]=MySilhouette
    Components[3]=FaceAudioComponent
    // Reference: CylinderComponent'TgGame.Default__TgRespawnBeaconExit.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgRespawnBeaconBase.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=15.0000000
        ReplacementPrimitive=none
        Translation=(X=0.0000000,Y=0.0000000,Z=15.0000000)
    end object
    Components[4]=CollisionCylinder
    bHidden=true
    CollisionComponent=CollisionCylinder
}