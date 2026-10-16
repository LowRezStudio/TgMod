class TgCTFFlagBase extends Actor
    placeable
    hidecategories(Navigation);

var() const int m_nDefenderTaskForce;
var transient TgCarriedFlag m_SpawnedFlag;
var transient TgGame_CTF m_CTFGame;

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x7E
    if(int(Role) == int(ROLE_Authority))
    {
        m_CTFGame = TgGame_CTF(WorldInfo.Game);
        // End:0x7E
        if(m_CTFGame != none)
        {
            m_CTFGame.RegisterFlagBase(self);
        }
    }
    //return;    
}

function CheckTouching()
{
    local int I;
    local TgPawn_Character TgP;
    local TgRepInfo_Player PRI;

    // End:0x3C
    if((m_CTFGame == none) || int(m_CTFGame.m_eTimerState) != int(3))
    {
        return;
    }
    I = 0;
    J0x47:

    // End:0x1AA [Loop If]
    if(I < Touching.Length)
    {
        TgP = TgPawn_Character(Touching[I]);
        // End:0x19C
        if(TgP != none)
        {
            PRI = TgRepInfo_Player(TgP.PlayerReplicationInfo);
            // End:0x19C
            if(((PRI != none) && PRI.s_CarriedFlag != none) && PRI.s_CarriedFlag.r_nDefenderTaskForce != m_nDefenderTaskForce)
            {
                m_CTFGame.ScoreFlag(TgP);
                PRI.s_CarriedFlag.SendHome();
                // [Explicit Break]
                goto J0x1AA;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x47;
    }
    J0x1AA:

    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn_Character FlagCarrier;

    FlagCarrier = TgPawn_Character(Other);
    // End:0x125
    if(((((FlagCarrier != none) && FlagCarrier.m_CurrentFlag != none) && FlagCarrier.m_CurrentFlag.r_nDefenderTaskForce != m_nDefenderTaskForce) && m_CTFGame != none) && m_SpawnedFlag.r_bIsHome)
    {
        m_CTFGame.ScoreFlag(FlagCarrier);
        FlagCarrier.m_CurrentFlag.SendHome();
    }
    //return;    
}

function SpawnFlag()
{
    // End:0x27
    if(m_SpawnedFlag != none)
    {
        m_SpawnedFlag.Destroy();
    }
    m_SpawnedFlag = Spawn(Class'TgGame.TgCarriedFlag', self,, Location, Rotation,, true);
    m_SpawnedFlag.r_nDefenderTaskForce = m_nDefenderTaskForce;
    m_SpawnedFlag.s_FlagBase = self;
    //return;    
}

function DestroyFlag()
{
    // End:0x11
    if(m_SpawnedFlag == none)
    {
        return;
    }
    m_SpawnedFlag.ClearHolder();
    m_SpawnedFlag.SetHidden(true);
    m_SpawnedFlag.SetCollision(false, false);
    m_SpawnedFlag.Destroy();
    m_SpawnedFlag = none;
    //return;    
}

defaultproperties
{
    m_nDefenderTaskForce=1
    Components[0]=none
    // Reference: CylinderComponent'TgGame.Default__TgCTFFlagBase.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=50.0000000
        CollisionRadius=200.0000000
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[1]=CollisionCylinder
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    bNoDelete=true
    bAlwaysRelevant=true
    bCollideActors=true
    NetPriority=2.0000000
    CollisionComponent=CollisionCylinder
}