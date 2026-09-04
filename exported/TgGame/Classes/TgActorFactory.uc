class TgActorFactory extends Actor
    abstract
    native(Factory)
    notplaceable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display);

enum eSelectionMethod
{
    TGSM_RANDOM,                    // 0
    TGSM_SEQUENTIAL,                // 1
    TGSM_MAX                        // 2
};

var(Object) editconst int m_nMapObjectId;
var() bool s_bAutoSpawn;
var editconst int s_nTeamNumber;
var() byte s_nTaskForce;
var() TgObject.MinimapFactoryType m_MinimapType;
var() TgActorFactory.eSelectionMethod s_eSelectionMethod;
var int s_nSelectionListId;
var int s_nSelectedObjectId;
var int m_nSelectionListPropId;
var int s_nNameId;
var transient int s_nFactoryId;
var transient TgRepInfo_Factory m_FRI;
var Class<TgRepInfo_Factory> m_FRIClass;
var int s_nCurListIndex;
var() export editinline SpriteComponent m_WorldIconSprite;

// Export UTgActorFactory::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

// Export UTgActorFactory::execSpawnObject(FFrame&, void* const)
native function SpawnObject();

// Export UTgActorFactory::execCalcFactoryPlacement(FFrame&, void* const)
native function CalcFactoryPlacement(Vector Extent, bool bCenterOnGround, out Vector OutLocation, out Rotator OutRotation);

// Export UTgActorFactory::execSetTaskForceNumber(FFrame&, void* const)
native function SetTaskForceNumber(int nNewTaskForce);

simulated function PreBeginPlay()
{
    local TgGame Game;

    super.PreBeginPlay();
    LoadObjectConfig();
    Game = TgGame(WorldInfo.Game);
    // End:0xB4
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xB4
        if(Game != none)
        {
            s_nFactoryId = Game.GetNextActorInstanceId();
            Game.s_ActorFactories.AddItem(self);
        }
    }
    //return;    
}

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x8A
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x80
        if(m_FRIClass != none)
        {
            m_FRI = Spawn(m_FRIClass, self,, Location, Rotation);
            m_FRI.InitFor(self);
        }
        SpawnObject();
    }
    //return;    
}

simulated function Destroyed()
{
    // End:0x27
    if(m_FRI != none)
    {
        m_FRI.Destroy();
    }
    super.Destroyed();
    //return;    
}

defaultproperties
{
    s_bAutoSpawn=true
    m_FRIClass=Class'TgGame.TgRepInfo_Factory'
    // Reference: SpriteComponent'TgGame.Default__TgActorFactory.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    begin object name="WorldIcon" class=Engine.SpriteComponent
        bIsScreenSizeScaled=true
        ScreenSize=0.0000100
        ReplacementPrimitive=none
        DepthPriorityGroup=ESceneDepthPriorityGroup.SDPG_Foreground
        HiddenGame=true
        HiddenEditor=true
        Scale=30.0000000
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=none
    Components[2]=WorldIcon
    bNoDelete=true
}