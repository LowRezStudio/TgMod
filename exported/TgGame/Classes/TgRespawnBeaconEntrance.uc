class TgRespawnBeaconEntrance extends TgRespawnBeaconBase
    native
    hidecategories(Navigation,SkeletalMeshActor);

enum ERespawnBeaconChargingState
{
    RBCS_Inactive,                  // 0
    RBCS_Waiting,                   // 1
    RBCS_BuildUp,                   // 2
    RBCS_Active,                    // 3
    RBCS_MAX                        // 4
};

struct native PendingTeleportInfo
{
    var Actor PendingActor;
    var float TouchTimestamp;
    var bool HasPlayedPreTeleport;

    structdefaultproperties
    {
        PendingActor=none
        TouchTimestamp=0.0000000
        HasPlayedPreTeleport=false
    }
};

var(BeaconEntrance) TgRespawnBeaconExit ExitBeacon;
var(BeaconEntrance) bool r_bEntranceActive;
var repnotify byte r_nPendingTeleport;
var transient TgRespawnBeaconEntrance.ERespawnBeaconChargingState c_LocalChargingState;
var repnotify TgRespawnBeaconEntrance.ERespawnBeaconChargingState r_ChargingState;
var export editinline TgParticleSystemComponent m_TeleportPSC;
var float m_fChargeDelay;
var float m_fTeleportDelay;
var float m_fPreTeleportFXTime;
var float s_fChargeStateTimeStamp;
var array<PendingTeleportInfo> s_PendingTeleports;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_ChargingState, r_bEntranceActive, 
        r_nPendingTeleport;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x24
    if(VarName == 'r_nPendingTeleport')
    {
        ClientFlashTeleportFX();        
    }
    else
    {
        // End:0x45
        if(VarName == 'r_ChargingState')
        {
            ChargingStateChangedFX();
        }
    }
    //return;    
}

simulated event PostBeginPlay()
{
    super(TgDestructible).PostBeginPlay();
    ConnectToExit();
    SetHidden(!r_bEntranceActive);
    //return;    
}

simulated function ConnectToExit()
{
    local int FoundIndex;

    // End:0x393
    if(ExitBeacon != none)
    {
        FoundIndex = ExitBeacon.m_ActiveDel.Find(BeaconSetActive);
        // End:0x92
        if(FoundIndex == -1)
        {
            ExitBeacon.m_ActiveDel.AddItem(BeaconSetActive);
        }
        FoundIndex = ExitBeacon.m_DeployingDel.Find(EnableBeaconSetupFX);
        // End:0x115
        if(FoundIndex == -1)
        {
            ExitBeacon.m_DeployingDel.AddItem(EnableBeaconSetupFX);
        }
        FoundIndex = ExitBeacon.m_DestroyedDel.Find(DisableBeaconFX);
        // End:0x198
        if(FoundIndex == -1)
        {
            ExitBeacon.m_DestroyedDel.AddItem(DisableBeaconFX);
        }
        FoundIndex = ExitBeacon.m_CarriedDel.Find(DisableBeaconFX);
        // End:0x21B
        if(FoundIndex == -1)
        {
            ExitBeacon.m_CarriedDel.AddItem(DisableBeaconFX);
        }
        FoundIndex = ExitBeacon.m_Entrances.Find(self);
        // End:0x27E
        if(FoundIndex == -1)
        {
            ExitBeacon.m_Entrances.AddItem(self);
        }
        m_fDeployTime = ExitBeacon.m_fDeployTime;
        // End:0x301
        if((int(ExitBeacon.m_nTaskForce) > int(0)) && int(ExitBeacon.m_nTaskForce) != int(m_nTaskForce))
        {
        }
        ExitBeacon.m_nTaskForce = m_nTaskForce;
        // End:0x393
        if(ExitBeacon.m_bInitialized)
        {
            // End:0x393
            if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
            {
                ExitBeacon.NotifyLocalPlayerTeamReceived();
            }
        }
    }
    //return;    
}

function OnBeaconEntranceSetActive(TgSeqAct_BeaconEntranceSetActive inAction)
{
    // End:0x41
    if((inAction == none) || r_bEntranceActive == inAction.m_bSetActive)
    {
        return;
    }
    r_bEntranceActive = inAction.m_bSetActive;
    SetHidden(!r_bEntranceActive);
    // End:0x12F
    if((!r_bEntranceActive && ExitBeacon != none) && !ExitBeacon.HasAnyEnabledEntrances())
    {
        // End:0x10E
        if(!ExitBeacon.m_bDestroyed)
        {
            ExitBeacon.DestroyIt();            
        }
        else
        {
            ExitBeacon.SetActiveState(0);
        }
    }
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x27
    if(int(Role) == int(ROLE_Authority))
    {
        AddPendingTeleport(Other);
    }
    //return;    
}

function bool VerifyCanTeleport(TgPawn Other)
{
    // End:0x6F
    if(((Other == none) || int(Other.GetTaskForceNumber()) != int(m_nTaskForce)) || int(ExitBeacon.r_ActiveState) != int(3))
    {
        return false;
    }
    return true;
    //return ReturnValue;    
}

function bool AddPendingTeleport(Actor Other)
{
    local int I;
    local PendingTeleportInfo pti;
    local TgPawn TgPOther;

    TgPOther = TgPawn(Other);
    // End:0x36
    if(!VerifyCanTeleport(TgPOther))
    {
        return false;
    }
    I = 0;
    J0x41:

    // End:0x9D [Loop If]
    if(I < s_PendingTeleports.Length)
    {
        // End:0x8F
        if(s_PendingTeleports[I].PendingActor == Other)
        {
            return false;
        }
        I++;
        // [Loop Continue]
        goto J0x41;
    }
    pti.PendingActor = Other;
    pti.TouchTimestamp = WorldInfo.TimeSeconds;
    s_PendingTeleports.AddItem(pti);
    return true;
    //return ReturnValue;    
}

function bool RemovePendingTeleport(Actor Other)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x7C [Loop If]
    if(I < s_PendingTeleports.Length)
    {
        // End:0x6E
        if(s_PendingTeleports[I].PendingActor == Other)
        {
            s_PendingTeleports.Remove(I, 1);
            return true;
        }
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    return false;
    //return ReturnValue;    
}

// Export UTgRespawnBeaconEntrance::execGetNextPendingTeleport(FFrame&, void* const)
native function Actor GetNextPendingTeleport();

simulated event PostTouch(Actor Other)
{
    // End:0x22
    if(!r_bEntranceActive || ExitBeacon == none)
    {
        return;
    }
    ExitBeacon.AcceptTeleport(TgPawn(Other), self);
    FlashTeleportFx(TgPawn(Other));
    SetChargingState(2);
    super(Actor).PostTouch(Other);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    super(Actor).UnTouch(Other);
    RemovePendingTeleport(Other);
    //return;    
}

event FlashTeleportFx(TgPawn TgP)
{
    r_nPendingTeleport++;
    bNetDirty = true;
    // End:0x4A
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ClientFlashTeleportFX();
    }
    // End:0x7D
    if(TgP != none)
    {
        TgP.FlashPlaySpecialEffect(10);
    }
    //return;    
}

simulated function ClientFlashTeleportFX()
{
    // End:0x3C
    if((ExitBeacon == none) || int(ExitBeacon.r_ActiveState) != int(3))
    {
        return;
    }
    // End:0xA3
    if(m_ActualMeshComponent != none)
    {
        m_ActualMeshComponent.FxDeactivateGroup('TeleportFlash', 0);
        m_ActualMeshComponent.FxActivateGroup('TeleportFlash', 0);
    }
    ExitBeacon.ClientFlashTeleportFX();
    //return;    
}

private final simulated function ChargingStateChangedFX()
{
    local TgAnimBlendByTeleportBeacon Node;

    // End:0x48
    if((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || int(c_LocalChargingState) == int(r_ChargingState))
    {
        return;
    }
    // End:0x303
    if(m_ActualMeshComponent != none)
    {
        switch(c_LocalChargingState)
        {
            // End:0x9D
            case 1:
                m_ActualMeshComponent.FxDeactivateGroup('TeleportEntranceDeploy', 0);
                // End:0x106
                break;
            // End:0xD0
            case 2:
                m_ActualMeshComponent.FxDeactivateGroup('TeleportEntranceBuildup', 0);
                // End:0x106
                break;
            // End:0x103
            case 3:
                m_ActualMeshComponent.FxDeactivateGroup('TeleportEntranceActive', 0);
                // End:0x106
                break;
            // End:0xFFFF
            default:
                break;
        }
        switch(r_ChargingState)
        {
            // End:0x15E
            case 0:
                // End:0x15A
                foreach m_BeaconNodes(Node)
                {
                    Node.Undeploy(0.5000000);                    
                }                
                // End:0x303
                break;
            // End:0x1D4
            case 1:
                m_ActualMeshComponent.FxActivateGroup('TeleportEntranceDeploy', 0);
                // End:0x1D0
                foreach m_BeaconNodes(Node)
                {
                    Node.Deploy(m_fDeployTime);                    
                }                
                // End:0x303
                break;
            // End:0x26A
            case 2:
                m_ActualMeshComponent.FxActivateGroup('TeleportEntranceBuildup', 0);
                // End:0x266
                foreach m_BeaconNodes(Node)
                {
                    // End:0x265
                    if(!Node.m_bDeployed)
                    {
                        Node.Deploy(0.0000000);
                    }                    
                }                
                // End:0x303
                break;
            // End:0x300
            case 3:
                m_ActualMeshComponent.FxActivateGroup('TeleportEntranceActive', 0);
                // End:0x2FC
                foreach m_BeaconNodes(Node)
                {
                    // End:0x2FB
                    if(!Node.m_bDeployed)
                    {
                        Node.Deploy(0.0000000);
                    }                    
                }                
                // End:0x303
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        c_LocalChargingState = r_ChargingState;
        //return;        
    }
}

private final event SetChargingState(TgRespawnBeaconEntrance.ERespawnBeaconChargingState chargeState)
{
    // End:0x1D
    if(int(r_ChargingState) == int(chargeState))
    {
        return;
    }
    s_fChargeStateTimeStamp = WorldInfo.TimeSeconds;
    r_ChargingState = chargeState;
    bNetDirty = true;
    ChargingStateChangedFX();
    //return;    
}

private final function BeaconSetActive()
{
    local TgPawn TgP;

    SetChargingState(2);
    // End:0x62
    if(int(WorldInfo.NetMode) != int(NM_Client))
    {
        // End:0x61
        foreach TouchingActors(Class'TgGame.TgPawn', TgP)
        {
            AddPendingTeleport(TgP);            
        }        
    }
    //return;    
}

private final function EnableBeaconSetupFX()
{
    SetChargingState(1);
    //return;    
}

private final function DisableBeaconFX()
{
    SetChargingState(0);
    //return;    
}

simulated event bool CanApplyEffects()
{
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    r_bEntranceActive=true
    m_fChargeDelay=2.0000000
    m_fPreTeleportFXTime=0.5000000
    m_nMeshAssemblyId=5744
    m_bDisplayHealth=false
    // Reference: SkeletalMeshComponent'TgGame.Default__TgRespawnBeaconEntrance.SkeletalMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'SkeletalMeshComponent0'
    // Archetype: SkeletalMeshComponent'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0'
    begin object name="SkeletalMeshComponent0"
        // Reference: AnimNodeSequence'TgGame.Default__TgRespawnBeaconEntrance.SkeletalMeshComponent0.AnimNodeSeq0'
        // Archetype: AnimNodeSequence'TgGame.Default__TgRespawnBeaconBase.SkeletalMeshComponent0.AnimNodeSeq0'
        begin object name="AnimNodeSeq0"
        end object
        Animations=AnimNodeSeq0
        ReplacementPrimitive=none
        LightEnvironment=DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconEntrance.MyLightEnvironment'
    end object
    SkeletalMeshComponent=SkeletalMeshComponent0
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconEntrance.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgRespawnBeaconBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: TgSilhouetteComponent'TgGame.Default__TgRespawnBeaconEntrance.MySilhouette'
    // Archetype: TgSilhouetteComponent'TgGame.Default__TgRespawnBeaconBase.MySilhouette'
    begin object name="MySilhouette"
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    // Reference: AudioComponent'TgGame.Default__TgRespawnBeaconEntrance.FaceAudioComponent'
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
    // Reference: CylinderComponent'TgGame.Default__TgRespawnBeaconEntrance.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgRespawnBeaconBase.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    Components[4]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}