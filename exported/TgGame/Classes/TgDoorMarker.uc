class TgDoorMarker extends TgTeamBlocker
    native(Navigation)
    placeable
    hidecategories(Navigation);

enum DoorStatus
{
    TGD_NONE,                       // 0
    TGD_LOCKED,                     // 1
    TGD_OPEN,                       // 2
    TGD_CLOSE,                      // 3
    TGD_MAX                         // 4
};

var repnotify TgDoorMarker.DoorStatus r_eStatus;
var() TgDoorMarker.DoorStatus m_eInitStatus;
var TgCollisionProxy s_CollisionProxy;
var() float m_fProximity;
var() int m_nTeamThatControlsDoor;
var() int m_nMeshAssemblyId;
var() export editinline SkeletalMeshComponent m_DoorSMC;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_eStatus;
}

// Export UTgDoorMarker::execLoadMesh(FFrame&, void* const)
native function LoadMesh();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x23
    if(VarName == 'r_eStatus')
    {
        ClientOnStatusChange();
        return;
    }
    super(Actor).ReplicatedEvent(VarName);
    //return;    
}

simulated function PostBeginPlay()
{
    LoadMesh();
    super(TgMeshAssembly).PostBeginPlay();
    //return;    
}

simulated function ClientOnStatusChange()
{
    local AnimNodeSequence AnimNode;
    local float AnimStartTime;

    // End:0x2A8
    if(m_DoorSMC != none)
    {
        AnimNode = AnimNodeSequence(m_DoorSMC.Animations);
        // End:0xED
        if((AnimNode == none) && m_DoorSMC.Animations.IsA('AnimTree'))
        {
            AnimNode = AnimNodeSequence(AnimTree(m_DoorSMC.Animations).Children[0].Anim);
        }
        // End:0x1BF
        if(int(r_eStatus) == int(2))
        {
            m_Mesh.FxActivateGroup('DoorOpening', 0);
            // End:0x1BC
            if(AnimNode != none)
            {
                AnimStartTime = ((AnimNode.bPlaying) ? AnimNode.CurrentTime : 0.0000000);
                AnimNode.PlayAnim(false, 1.0000000, AnimStartTime);
            }            
        }
        else
        {
            // End:0x2A8
            if(int(r_eStatus) == int(3))
            {
                m_Mesh.FxActivateGroup('DoorClosing', 0);
                // End:0x2A8
                if(AnimNode != none)
                {
                    AnimStartTime = ((AnimNode.bPlaying) ? AnimNode.CurrentTime : AnimNode.GetAnimPlaybackLength());
                    AnimNode.PlayAnim(false, -1.0000000, AnimStartTime);
                }
            }
        }
    }
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    CalculateDoorStatus();
    //return;    
}

event UnTouch(Actor Other)
{
    CalculateDoorStatus();
    //return;    
}

function bool ShouldDoorBeOpened()
{
    local bool bShouldOpen;
    local array<int> NearByPlayerTaskforces;
    local int I;

    // End:0x1E
    if(m_nTeamThatControlsDoor == 0)
    {
        bShouldOpen = true;        
    }
    else
    {
        // End:0x56
        if(s_CollisionProxy != none)
        {
            s_CollisionProxy.GetNearByPlayersTaskforce(NearByPlayerTaskforces);
        }
        I = 0;
        J0x61:

        // End:0xB7 [Loop If]
        if(I < NearByPlayerTaskforces.Length)
        {
            // End:0xA9
            if(NearByPlayerTaskforces[I] == m_nTeamThatControlsDoor)
            {
                bShouldOpen = true;
                // [Explicit Break]
                goto J0xB7;
            }
            I++;
            // [Loop Continue]
            goto J0x61;
        }
    }
    J0xB7:

    return bShouldOpen;
    //return ReturnValue;    
}

function bool ShouldDoorBeClosed()
{
    local bool bShouldClose;
    local array<int> NearByPlayerTaskforces;
    local int I;

    // End:0x38
    if(s_CollisionProxy != none)
    {
        s_CollisionProxy.GetNearByPlayersTaskforce(NearByPlayerTaskforces);
    }
    bShouldClose = true;
    // End:0x6E
    if(m_nTeamThatControlsDoor == 0)
    {
        bShouldClose = NearByPlayerTaskforces.Length == 0;        
    }
    else
    {
        I = 0;
        J0x79:

        // End:0xCF [Loop If]
        if(I < NearByPlayerTaskforces.Length)
        {
            // End:0xC1
            if(NearByPlayerTaskforces[I] == m_nTeamThatControlsDoor)
            {
                bShouldClose = false;
                // [Explicit Break]
                goto J0xCF;
            }
            I++;
            // [Loop Continue]
            goto J0x79;
        }
    }
    J0xCF:

    return bShouldClose;
    //return ReturnValue;    
}

function CalculateDoorStatus()
{
    // End:0x16
    if(int(r_eStatus) == int(1))
    {
        return;
    }
    // End:0x46
    if(int(r_eStatus) != int(2))
    {
        // End:0x43
        if(ShouldDoorBeOpened())
        {
            SetDoorStatus(2);
        }        
    }
    else
    {
        // End:0x73
        if(int(r_eStatus) != int(3))
        {
            // End:0x73
            if(ShouldDoorBeClosed())
            {
                SetDoorStatus(3);
            }
        }
    }
    //return;    
}

function SetDoorStatus(TgDoorMarker.DoorStatus eStatus)
{
    local int nStatusEventIndex;
    local AnimNodeSequence AnimNode;
    local float AnimStartTime;

    nStatusEventIndex = -1;
    // End:0x2C
    if(int(r_eStatus) == int(eStatus))
    {
        return;
    }
    // End:0x119
    if(m_DoorSMC != none)
    {
        AnimNode = AnimNodeSequence(m_DoorSMC.Animations);
        // End:0x119
        if((AnimNode == none) && m_DoorSMC.Animations.IsA('AnimTree'))
        {
            AnimNode = AnimNodeSequence(AnimTree(m_DoorSMC.Animations).Children[0].Anim);
        }
    }
    r_eStatus = eStatus;
    ForceNetRelevant();
    switch(eStatus)
    {
        // End:0x1EA
        case 2:
            nStatusEventIndex = 0;
            // End:0x1E7
            if(AnimNode != none)
            {
                AnimStartTime = ((AnimNode.bPlaying) ? AnimNode.CurrentTime : 0.0000000);
                AnimNode.PlayAnim(false, 1.0000000, AnimStartTime);
            }
            // End:0x2AB
            break;
        // End:0x2A5
        case 3:
            nStatusEventIndex = 1;
            // End:0x2A2
            if(AnimNode != none)
            {
                AnimStartTime = ((AnimNode.bPlaying) ? AnimNode.CurrentTime : AnimNode.GetAnimPlaybackLength());
                AnimNode.PlayAnim(false, -1.0000000, AnimStartTime);
            }
            // End:0x2AB
            break;
        // End:0xFFFF
        default:
            // End:0x2AB
            break;
            break;
    }
    // End:0x2DD
    if(nStatusEventIndex > -1)
    {
        TriggerEventClass(Class'TgGame.TgSeqEvent_DoorStatusChanged', self, nStatusEventIndex, false);
    }
    // End:0x310
    if(int(WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        ClientOnStatusChange();
    }
    //return;    
}

defaultproperties
{
    m_nMeshAssemblyId=-1
    // Reference: SkeletalMeshComponent'TgGame.Default__TgDoorMarker.DoorSMC'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'DoorSMC'
    begin object name="DoorSMC" class=Engine.SkeletalMeshComponent
        Animations=AnimNodeSequence'TgGame.Default__TgDoorMarker.AnimNodeSeq0'
        ReplacementPrimitive=none
        RBChannel=ERBCollisionChannel.RBCC_GameplayPhysics
        CollideActors=true
        BlockActors=true
        BlockZeroExtent=true
        BlockNonZeroExtent=true
        BlockRigidBody=true
        RBCollideWithChannels=(Default=true,GameplayPhysics=true,EffectPhysics=true)
    end object
    m_DoorSMC=DoorSMC
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDoorMarker.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgTeamBlocker.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    m_LightEnvironment=MyLightEnvironment
    Components[0]=none
    Components[1]=MyLightEnvironment
    Components[2]=DoorSMC
    bCollideActors=true
    bBlockActors=true
    CollisionComponent=DoorSMC
    SupportedEvents=/* Array type was not detected. */
}