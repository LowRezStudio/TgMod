class TgCarriedFlag extends Actor
    placeable
    hidecategories(Navigation);

var transient int r_nDefenderTaskForce;
var transient TgCTFFlagBase s_FlagBase;
var repnotify transient bool r_bIsHome;
var transient TgPawn_Character m_Holder;
var repnotify transient TgRepInfo_Player r_HolderPRI;
var transient TgPawn_Character m_OldHolder;
var Controller m_FirstTouch;
var array<Controller> m_Assists;
var float m_fMaxDropTime;
var transient float m_fDefaultRadius;
var transient float m_fDefaultHeight;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_HolderPRI, r_bIsHome, 
        r_nDefenderTaskForce;
}

function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x84
    if(CylinderComponent(CollisionComponent) != none)
    {
        m_fDefaultRadius = CylinderComponent(CollisionComponent).CollisionRadius;
        m_fDefaultHeight = CylinderComponent(CollisionComponent).CollisionHeight;
    }
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    CheckTouching();
    //return;    
}

function CheckTouching()
{
    local int I;
    local TgGame_CTF CTFGame;
    local TgPawn TgP;

    CTFGame = TgGame_CTF(WorldInfo.Game);
    // End:0x6D
    if((CTFGame == none) || int(CTFGame.m_eTimerState) != int(3))
    {
        return;
    }
    I = 0;
    J0x78:

    // End:0x1C8 [Loop If]
    if(I < Touching.Length)
    {
        // End:0x13B
        if(ValidHolder(Touching[I]))
        {
            // End:0x138
            if(PlayerController(Pawn(Touching[I]).Controller) != none)
            {
                SetHolder(Pawn(Touching[I]).Controller);
                m_OldHolder = none;
                return;
            }            
        }
        else
        {
            // End:0x1BA
            if(!r_bIsHome)
            {
                TgP = TgPawn(Touching[I]);
                // End:0x1BA
                if((TgP != none) && int(TgP.GetTaskForceNumber()) == r_nDefenderTaskForce)
                {
                    SendHome();
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x78;
    }
    //return;    
}

function bool ValidHolder(Actor Other)
{
    local TgPawn TgP;

    TgP = TgPawn(Other);
    // End:0x92
    if((((TgP == none) || TgP.Health <= 0) || !TgP.IsPlayerPawn()) || TgP == m_OldHolder)
    {
        return false;
    }
    // End:0x10D
    if(((int(TgP.GetTaskForceNumber()) == int(1)) && r_nDefenderTaskForce == 2) || (int(TgP.GetTaskForceNumber()) == int(2)) && r_nDefenderTaskForce == 1)
    {
        return true;
    }
    return false;
    //return ReturnValue;    
}

function SetHolder(Controller C)
{
    local int I;

    m_Holder = TgPawn_Character(C.Pawn);
    r_HolderPRI = TgRepInfo_Player(m_Holder.PlayerReplicationInfo);
    r_HolderPRI.SetFlag(self);
    r_HolderPRI.bForceNetUpdate = true;
    GotoState('Held');
    // End:0xD3
    if(m_FirstTouch == none)
    {
        m_FirstTouch = C;
    }
    I = 0;
    J0xDE:

    // End:0x127 [Loop If]
    if(I < m_Assists.Length)
    {
        // End:0x119
        if(m_Assists[I] == C)
        {
            return;
        }
        I++;
        // [Loop Continue]
        goto J0xDE;
    }
    m_Assists.Length = m_Assists.Length + 1;
    m_Assists[m_Assists.Length - 1] = C;
    //return;    
}

function ClearHolder()
{
    // End:0x11
    if(m_Holder == none)
    {
        return;
    }
    m_Holder.m_CurrentFlag = none;
    // End:0xC9
    if(m_Holder.PlayerReplicationInfo != none)
    {
        TgRepInfo_Player(m_Holder.PlayerReplicationInfo).SetFlag(none);
        m_Holder.PlayerReplicationInfo.bForceNetUpdate = true;
    }
    m_Holder = none;
    r_HolderPRI = none;
    //return;    
}

function SendHome()
{
    m_OldHolder = none;
    ClearHolder();
    m_FirstTouch = none;
    J0x20:

    // End:0x40 [Loop If]
    if(m_Assists.Length != 0)
    {
        m_Assists.Remove(0, 1);
        // [Loop Continue]
        goto J0x20;
    }
    // End:0x91
    if(s_FlagBase != none)
    {
        SetLocation(s_FlagBase.Location);
        SetRotation(s_FlagBase.Rotation);
    }
    GotoState('Home');
    //return;    
}

function Score()
{
    //return;    
}

function AutoSendHome()
{
    SendHome();
    //return;    
}

function CheckFit()
{
    //return;    
}

event Drop(optional Controller Killer, optional bool bNoThrow)
{
    m_OldHolder = m_Holder;
    BaseBoneName = 'None';
    BaseSkelComponent = none;
    SetLocation(m_Holder.Location);
    GotoState('Dropped');
    //return;    
}

function ClearOldHolder()
{
    m_OldHolder = none;
    //return;    
}

auto state Home
{
    ignores Drop, Score, SendHome;

    function BeginState(name PreviousStateName)
    {
        bCollideWorld = true;
        SetCollisionSize(m_fDefaultRadius, m_fDefaultHeight);
        SetCollision(true, false);
        r_bIsHome = true;
        // End:0xA3
        if(s_FlagBase != none)
        {
            SetLocation(s_FlagBase.Location);
            SetRotation(s_FlagBase.Rotation);
            s_FlagBase.CheckTouching();
        }
        //return;        
    }

    function EndState(name NextStateName)
    {
        r_bIsHome = false;
        //return;        
    }
Begin:

    Sleep(0.0500000);
    CheckTouching();
    stop;        
}

state Held
{
    ignores SetHolder;

    function BeginState(name PreviousStateName)
    {
        TgRepInfo_Game(WorldInfo.GRI).SetFlagHeldEnemy(r_nDefenderTaskForce);
        WorldInfo.GRI.bForceNetUpdate = true;
        bCollideWorld = false;
        SetCollision(false, false);
        SetLocation(m_Holder.Location);
        // End:0xDE
        if(m_Holder != none)
        {
            m_Holder.HoldFlag(self);
        }
        bForceNetUpdate = true;
        //return;        
    }

    function EndState(name NextStateName)
    {
        ClearHolder();
        SetBase(none);
        SetHardAttach(false);
        bForceNetUpdate = true;
        //return;        
    }
    stop;    
}

state Dropped
{
    ignores Drop;

    function CheckFit()
    {
        local Vector X, Y, Z;

        GetAxes(m_OldHolder.Rotation, X, Y, Z);
        SetRotation(Rotator(float(-1) * X));
        // End:0x1C2
        if((!SetLocation((m_OldHolder.Location - ((float(2) * m_OldHolder.GetCollisionRadius()) * X)) + (m_OldHolder.GetCollisionHeight() * vect(0.0000000, 0.0000000, 0.5000000))) && !SetLocation(m_OldHolder.Location)) && m_OldHolder.GetCollisionRadius() > float(0))
        {
            SetCollisionSize(FMin(m_fDefaultRadius, 0.8000000 * m_OldHolder.GetCollisionRadius()), FMin(m_fDefaultHeight, 0.8000000 * m_OldHolder.GetCollisionHeight()));
            // End:0x1C2
            if(!SetLocation(m_OldHolder.Location))
            {
                AutoSendHome();
                return;
            }
        }
        //return;        
    }

    event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
    {
        local TgPawn TgP;

        TgP = TgPawn(Other);
        // End:0x69
        if((TgP != none) && int(TgP.GetTaskForceNumber()) == r_nDefenderTaskForce)
        {
            SendHome();            
        }
        else
        {
            global.Touch(Other, OtherComp, HitLocation, HitNormal);
        }
        //return;        
    }

    function CheckPain()
    {
        // End:0x17
        if(IsInPain())
        {
            AutoSendHome();
        }
        //return;        
    }

    function Timer()
    {
        AutoSendHome();
        //return;        
    }

    function BeginState(name PreviousStateName)
    {
        TgRepInfo_Game(WorldInfo.GRI).SetFlagDown(int(GetTeamNum()));
        WorldInfo.GRI.bForceNetUpdate = true;
        SetTimer(m_fMaxDropTime, false);
        SetTimer(10.0000000, false, 'ClearOldHolder');
        SetPhysics(2);
        bCollideWorld = true;
        SetCollisionSize(m_fDefaultRadius, m_fDefaultHeight);
        SetCollision(true, false);
        CheckFit();
        //return;        
    }

    function EndState(name NextStateName)
    {
        SetPhysics(0);
        bForceNetUpdate = true;
        bCollideWorld = false;
        SetCollisionSize(m_fDefaultRadius, m_fDefaultHeight);
        ClearTimer();
        //return;        
    }
Begin:

    Sleep(0.0500000);
    CheckTouching();
    stop;        
}

defaultproperties
{
    m_fMaxDropTime=30.0000000
    // Reference: CylinderComponent'TgGame.Default__TgCarriedFlag.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=50.0000000
        CollisionRadius=50.0000000
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[0]=CollisionCylinder
    // Reference: StaticMeshComponent'TgGame.Default__TgCarriedFlag.FlagMesh'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'FlagMesh'
    begin object name="FlagMesh" class=Engine.StaticMeshComponent
        ReplacementPrimitive=none
        Translation=(X=0.0000000,Y=0.0000000,Z=-45.0000000)
    end object
    Components[1]=FlagMesh
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bIgnoreRigidBodyPawns=true
    bAlwaysRelevant=true
    bUpdateSimulatedPosition=true
    bCollideActors=true
    bCollideWorld=true
    NetPriority=2.0000000
    CollisionComponent=CollisionCylinder
}