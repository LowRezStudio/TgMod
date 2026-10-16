class TgDeployableFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display);

var int nCurrentCount;
var float s_fLastSpawnTime;
var() bool s_bSpawnOnce;
var() int s_nDeployableId;
var() float s_fDeployableLifeSpan;

// Export UTgDeployableFactory::execSpawnObject(FFrame&, void* const)
native function SpawnObject();

simulated function PostBeginPlay()
{
    local TgRepInfo_Game GRI;

    super(Actor).PostBeginPlay();
    // End:0xB4
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x9D
        if(int(s_nTaskForce) > int(0))
        {
            GRI = TgRepInfo_Game(WorldInfo.GRI);
            // End:0x9D
            if(GRI != none)
            {
                GRI.GetTaskForce(int(s_nTaskForce), true);
            }
        }
        // End:0xB4
        if(s_bAutoSpawn)
        {
            SpawnObject();
        }
    }
    //return;    
}

function DeployableDied()
{
    nCurrentCount--;
    // End:0x38
    if(s_bAutoSpawn && int(Role) == int(ROLE_Authority))
    {
        SpawnObject();
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        s_bAutoSpawn = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            s_bAutoSpawn = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                s_bAutoSpawn = !s_bAutoSpawn;
            }
        }
    }
    // End:0xF2
    if(s_bAutoSpawn)
    {
        SpawnObject();
    }
    //return;    
}

function OnKillBots(TgSeqAct_KillBots inAction)
{
    local TgDeployable deployable;

    // End:0x73
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x72
        foreach DynamicActors(Class'TgGame.TgDeployable', deployable)
        {
            // End:0x71
            if(deployable.s_DeployFactory == self)
            {
                deployable.DestroyIt();
            }            
        }        
    }
    //return;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    local TgDeployable deployable;

    // End:0xA5
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x7A
        foreach DynamicActors(Class'TgGame.TgDeployable', deployable)
        {
            // End:0x79
            if(deployable.s_DeployFactory == self)
            {
                deployable.OnSetTaskforce(Action);
            }            
        }        
        s_nTaskForce = byte(Action.TaskForceNumber);
    }
    //return;    
}

defaultproperties
{
    s_fLastSpawnTime=-1.0000000
    s_bSpawnOnce=true
    m_nSelectionListPropId=185
    // Reference: SpriteComponent'TgGame.Default__TgDeployableFactory.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgActorFactory.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=none
    Components[2]=WorldIcon
    SupportedEvents=/* Array type was not detected. */
}