class SeqAct_GameCrowdPopulationManagerToggle extends SequenceAction
    native
    forcescriptorder(true)
    hidecategories(Object)
    implements(GameCrowdSpawnerInterface);

var() float WarmupPopulationPct;
var() GameCrowd_ListOfAgents CrowdAgentList;
var() bool bClearOldArchetypes;
var() bool bEnableCrowdLightEnvironment;
var() bool bCastShadows;
var bool bFillPotentialSpawnPoints;
var() bool bForceObstacleChecking;
var() bool bForceNavMeshPathing;
var bool bIndividualSpawner;
var() int MaxAgents;
var() float SpawnRate;
var LightingChannelContainer AgentLightingChannel;
var() float MaxSpawnDist;
var float MinBehindSpawnDist;
var array<GameCrowdDestination> PotentialSpawnPoints;
var float AgentWarmupTime;
var() int NumAgentsToTickPerFrame;
var array<GameCrowdAgent> LastSpawnedList;

static event int GetObjClassVersion()
{
    return super(SequenceObject).GetObjClassVersion() + 5;
    //return ReturnValue;    
}

event FillCrowdSpawnInfoItem(out CrowdSpawnInfoItem out_Item, GameCrowdPopulationManager PopMgr)
{
    local int I;

    // End:0x2C
    if(bClearOldArchetypes)
    {
        out_Item.AgentArchetypes.Length = 0;
    }
    // End:0xE4
    if(CrowdAgentList != none)
    {
        I = 0;
        J0x46:

        // End:0xE4 [Loop If]
        if(I < CrowdAgentList.ListOfAgents.Length)
        {
            out_Item.AgentArchetypes[out_Item.AgentArchetypes.Length] = CrowdAgentList.ListOfAgents[I];
            I++;
            // [Loop Continue]
            goto J0x46;
        }
    }
    out_Item.MaxSpawnDist = MaxSpawnDist;
    out_Item.MaxSpawnDistSq = out_Item.MaxSpawnDist * out_Item.MaxSpawnDist;
    out_Item.MinBehindSpawnDist = FMin(MinBehindSpawnDist, out_Item.MaxSpawnDist * 0.0625000);
    out_Item.MinBehindSpawnDistSq = out_Item.MinBehindSpawnDist * out_Item.MinBehindSpawnDist;
    out_Item.AgentWarmupTime = AgentWarmupTime;
    out_Item.bCastShadows = bCastShadows;
    out_Item.bEnableCrowdLightEnvironment = bEnableCrowdLightEnvironment;
    out_Item.SpawnRate = SpawnRate;
    out_Item.SpawnNum = MaxAgents;
    // End:0x344
    if(Class'Engine.Engine'.static.IsSplitScreen())
    {
        out_Item.SpawnNum = int(PopMgr.SplitScreenNumReduction * float(out_Item.SpawnNum));
    }
    out_Item.bForceObstacleChecking = bForceObstacleChecking;
    out_Item.bForceNavMeshPathing = bForceNavMeshPathing;
    out_Item.NumAgentsToTickPerFrame = NumAgentsToTickPerFrame;
    out_Item.LastAgentTickedIndex = -1;
    // End:0x40F
    if(bFillPotentialSpawnPoints)
    {
        out_Item.PotentialSpawnPoints = PotentialSpawnPoints;
    }
    //return;    
}

function float GetMaxSpawnDist()
{
    return MaxSpawnDist;
    //return ReturnValue;    
}

function AgentDestroyed(GameCrowdAgent Agent)
{
    local GameCrowdPopulationManager PopMgr;

    PopMgr = GameCrowdPopulationManager(Agent.WorldInfo.PopulationManager);
    // End:0x7D
    if(PopMgr != none)
    {
        PopMgr.AgentDestroyed(Agent);
    }
    //return;    
}

defaultproperties
{
    bForceNavMeshPathing=true
    MaxAgents=700
    SpawnRate=50.0000000
    AgentLightingChannel=(bInitialized=true,BSP=false,Static=false,Dynamic=false,CompositeDynamic=false,Skybox=false,Unnamed_1=false,Unnamed_2=false,Unnamed_3=false,Unnamed_4=false,Unnamed_5=false,Unnamed_6=false,Cinematic_1=false,Cinematic_2=false,Cinematic_3=false,Cinematic_4=false,Cinematic_5=false,Cinematic_6=false,Cinematic_7=false,Cinematic_8=false,Cinematic_9=false,Cinematic_10=false,Gameplay_1=false,Gameplay_2=false,Gameplay_3=false,Gameplay_4=false,Crowd=true)
    MaxSpawnDist=10000.0000000
    MinBehindSpawnDist=5000.0000000
    AgentWarmupTime=2.0000000
    NumAgentsToTickPerFrame=10
    bCallHandler=false
    bLatentExecution=true
    InputLinks[0]=(LinkDesc="Start",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[1]=(LinkDesc="Stop",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[2]=(LinkDesc="Warmup",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[3]=(LinkDesc="Kill Agents",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    InputLinks[4]=(LinkDesc="Stop & Kill",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    OutputLinks[0]=(Links=none,LinkDesc="Spawned",bHasImpulse=false,bDisabled=false,bDisabledPIE=false,LinkedOp=none,ActivateDelay=0.0000000,DrawY=0,bHidden=false,bMoving=false,bClampedMax=false,bClampedMin=false,bIsActivated=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_ObjectList',LinkedVariables=none,LinkDesc="Spawned List",LinkVar="None",PropertyName="LastSpawnedList",bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=1,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Population Manager Toggle"
}