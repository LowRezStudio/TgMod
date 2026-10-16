class TgBotFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement);

const BOT_ENCOUNTER_DESPAWN_TIME = 60;

enum eBotSelection
{
    BS_RANDOM,                      // 0
    BS_SEQUENTIAL,                  // 1
    BS_MAX                          // 2
};

struct native SpawnQueueEntry
{
    var float fSpawnTime;
    var int nBotId;
    var int nSkinId;
    var int nWeaponSkinId;
    var int nSpawnTableDetailId;
    var name BehaviorTreeOverride;

    structdefaultproperties
    {
        fSpawnTime=0.0000000
        nBotId=0
        nSkinId=0
        nWeaponSkinId=0
        nSpawnTableDetailId=0
        BehaviorTreeOverride="None"
    }
};

var() TgBotFactory.eBotSelection LocationSelection;
var(BotFactory) const array<NavigationPoint> LocationList;
var int s_nCurLocationIndex;
var(BotFactory) NavigationPoint SafetyLocation;
var(BotFactory) bool ShouldTraceSpawnLocationToFloor;
var(BotFactory) bool bUseSmiteStaggerSpawning;
var(BotFactory) bool bSpawnAsSquad;
var bool bAutoSpawn;
var bool m_bFirstSpawn;
var() bool bBulkSpawn;
var() bool bRespawn;
var(Introduction) bool bStartBotsInIntroState;
var(Introduction) bool bHasDifferentInitialIntro;
var bool m_bFirstSpawnWave;
var() bool m_bIgnoreCollisionOnSpawn;
var() bool m_bUseCollisionHeightForSpawnPlacement;
var int nBotCount;
var int nCurrentCount;
var(BotFactory) int nActiveCount;
var int nTotalSpawns;
var(BotFactory) int nLane;
var(BotFactory) int nNavPointsToSkipForPathing;
var(BotFactory) float fStaggerSpawnDelay;
var transient TgAISquad s_CurrentSquad;
var Class<TgAISquad> m_SquadClass;
var() int m_nLocationId;
var() int nSpawnTableId;
var() int nDefaultSpawnTableId;
var() float fSpawnDelay;
var array<SpawnQueueEntry> m_SpawnQueue;
var TgBotEncounterVolume m_SpawnVolume;
var int m_nLastGroup;
var() float fSpawnHealthPercent;
var(Introduction) float fIntroductionDuration;
var(Introduction) float fInitialIntroductionDuration;
var(LanePusher) TgSplineActor m_StartingSpline;
var() export editinline StaticMeshComponent m_RespawnIndicator;
var transient MaterialInstanceConstant m_RespawnIndicatorMIC;
var Texture2D m_TextureNormal;
var float fLastKillTime;
var() float fRespawnDelay;

// Export UTgBotFactory::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

// Export UTgBotFactory::execResetQueue(FFrame&, void* const)
native function ResetQueue();

// Export UTgBotFactory::execBuildQueue(FFrame&, void* const)
native function BuildQueue();

// Export UTgBotFactory::execClearQueue(FFrame&, void* const)
native function ClearQueue();

// Export UTgBotFactory::execSpawnBot(FFrame&, void* const)
native function Actor SpawnBot();

// Export UTgBotFactory::execSpawnNextBot(FFrame&, void* const)
native function Actor SpawnNextBot();

// Export UTgBotFactory::execSpawnBotId(FFrame&, void* const)
native function Actor SpawnBotId(int nBotId, int nSkinId);

// Export UTgBotFactory::execSpawnBotAdjusted(FFrame&, void* const)
native function Actor SpawnBotAdjusted(SpawnQueueEntry Entry);

// Export UTgBotFactory::execCalcFactoryPlacement(FFrame&, void* const)
native function CalcFactoryPlacement(Vector Extent, bool bCenterOnGround, out Vector OutLocation, out Rotator OutRotation);

// Export UTgBotFactory::execUseSpawnTable(FFrame&, void* const)
native function Actor UseSpawnTable();

// Export UTgBotFactory::execBotDied(FFrame&, void* const)
native function BotDied(TgPawn Pawn, TgAIController aic);

// Export UTgBotFactory::execSquadDied(FFrame&, void* const)
native function SquadDied(TgAISquad squad);

// Export UTgBotFactory::execKillCurrentSquad(FFrame&, void* const)
native function KillCurrentSquad();

// Export UTgBotFactory::execGetRemainingTotalSpawns(FFrame&, void* const)
native function int GetRemainingTotalSpawns();

// Export UTgBotFactory::execGetStaggerSpawnTime(FFrame&, void* const)
native function float GetStaggerSpawnTime();

simulated function PostBeginPlay()
{
    super.PostBeginPlay();
    // End:0x52
    if(int(Role) == int(ROLE_Authority))
    {
        ResetQueue();
        // End:0x3F
        if(bAutoSpawn)
        {
            SpawnNextBot();
        }
        nDefaultSpawnTableId = nSpawnTableId;
    }
    // End:0x8B
    if(m_RespawnIndicator != none)
    {
        m_RespawnIndicatorMIC = m_RespawnIndicator.CreateAndSetMaterialInstanceConstant(0);
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bAutoSpawn = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bAutoSpawn = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bAutoSpawn = !bAutoSpawn;
            }
        }
    }
    // End:0xFC
    if(bAutoSpawn)
    {
        ResetQueue();
        SpawnNextBot();
    }
    //return;    
}

function OnKillBots(TgSeqAct_KillBots inAction)
{
    KillBots(false);
    //return;    
}

function OnDespawnBots(TgSeqAct_DespawnBots inAction)
{
    Despawn();
    //return;    
}

event EndEncounter()
{
    // End:0x2C
    if(!IsTimerActive('Despawn'))
    {
        SetTimer(60.0000000, false, 'Despawn');
    }
    //return;    
}

event ContinueEncounter()
{
    ClearTimer('Despawn');
    //return;    
}

event StartEncounter(TgBotEncounterVolume Volume)
{
    ClearTimer('Despawn');
    m_SpawnVolume = Volume;
    bAutoSpawn = true;
    ResetQueue();
    SpawnNextBot();
    //return;    
}

function Despawn()
{
    bAutoSpawn = false;
    ClearQueue();
    KillBots(true);
    //return;    
}

event KillBots(bool bDespawn)
{
    local TgAIController aic;
    local TgPawn Pawn;

    // End:0x10A
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController', aic)
    {
        // End:0x109
        if(aic.m_pFactory == self)
        {
            Pawn = TgPawn(aic.Pawn);
            // End:0x9C
            if(Pawn == none)
            {
                continue;                
            }
            // End:0xCB
            if(bDespawn)
            {
                aic.Despawn();                
            }
            else
            {
                Pawn.Suicide();
            }
            Pawn.KillPets();
        }        
    }    
    //return;    
}

simulated function OnTriggerBots(TgSeqAct_TriggerBots Action)
{
    local TgAIController aic;

    // End:0x81
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController', aic)
    {
        // End:0x80
        if(aic.m_pFactory == self)
        {
            aic.OnTriggerBots(Action);
        }        
    }    
    //return;    
}

simulated function OnSetTaskforce(TgSeqAct_SetTaskforce Action)
{
    local TgAIController aic;

    // End:0x81
    foreach WorldInfo.AllControllers(Class'TgGame.TgAIController', aic)
    {
        // End:0x80
        if(aic.m_pFactory == self)
        {
            aic.OnSetTaskforce(Action);
        }        
    }    
    //return;    
}

function OnGetBot(TgSeqAct_GetBot inAction)
{
    local TgAIController aic;
    local int nCount;

    // End:0x213
    if(((inAction != none) && inAction.VariableLinks.Length >= 3) && inAction.VariableLinks[2].LinkedVariables.Length >= 1)
    {
        SeqVar_Object(inAction.VariableLinks[2].LinkedVariables[0]).SetObjectValue(none);
        // End:0x213
        if(inAction.InputLinks[0].bHasImpulse)
        {
            nCount = 0;
            // End:0x212
            foreach WorldInfo.AllControllers(Class'TgGame.TgAIController', aic)
            {
                // End:0x211
                if(aic.m_pFactory == self)
                {
                    // End:0x206
                    if(nCount == inAction.m_nBotNumber)
                    {
                        SeqVar_Object(inAction.VariableLinks[2].LinkedVariables[0]).SetObjectValue(aic.Pawn);                        
                        return;
                    }
                    nCount++;
                }                
            }            
        }
    }
    //return;    
}

function OnBotDamaged(TgPawn Bot, Controller DamageInstigator, Class<DamageType> DamageType, int DamageAmount)
{
    local int Idx;
    local SeqEvent_TakeDamage dmgEvent;

    Idx = 0;
    J0x0B:

    // End:0xA9 [Loop If]
    if(Idx < GeneratedEvents.Length)
    {
        dmgEvent = SeqEvent_TakeDamage(GeneratedEvents[Idx]);
        // End:0x9B
        if(dmgEvent != none)
        {
            dmgEvent.HandleDamage(Bot, DamageInstigator, DamageType, DamageAmount);
        }
        Idx++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

simulated function UpdateRespawnTimeIndicator(float fPct)
{
    // End:0xA3
    if(m_RespawnIndicator != none)
    {
        // End:0x83
        if(fPct > float(0))
        {
            m_RespawnIndicator.SetHidden(false);
            // End:0x80
            if(m_RespawnIndicatorMIC != none)
            {
                m_RespawnIndicatorMIC.SetScalarParameterValue('Perc', fPct);
            }            
        }
        else
        {
            m_RespawnIndicator.SetHidden(true);
        }
    }
    //return;    
}

function OnKillCurrentSquad(TgSeqAct_KillCurrentSquad killSquadAction)
{
    KillCurrentSquad();
    //return;    
}

defaultproperties
{
    LocationSelection=eBotSelection.BS_SEQUENTIAL
    s_nCurLocationIndex=-1
    ShouldTraceSpawnLocationToFloor=true
    bAutoSpawn=true
    m_bFirstSpawn=true
    m_bFirstSpawnWave=true
    nLane=-1
    nNavPointsToSkipForPathing=3
    m_SquadClass=Class'TgGame.TgAISquad'
    fSpawnDelay=0.2000000
    fSpawnHealthPercent=1.0000000
    // Reference: TgStaticMeshComponent'TgGame.Default__TgBotFactory.RespawnIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RespawnIndicator'
    begin object name="RespawnIndicator" class=TgGame.TgStaticMeshComponent
        ReplacementPrimitive=none
        HiddenGame=true
    end object
    m_RespawnIndicator=RespawnIndicator
    m_TextureNormal=Texture2D'TgEditorAssets.BotIconTemp'
    fLastKillTime=-1.0000000
    fRespawnDelay=0.2000000
    m_nSelectionListPropId=179
    s_nCurListIndex=-1
    // Reference: SpriteComponent'TgGame.Default__TgBotFactory.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgActorFactory.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=WorldIcon
    Components[2]=none
    Components[3]=RespawnIndicator
    Components[4]=none
    SupportedEvents=/* Array type was not detected. */
}