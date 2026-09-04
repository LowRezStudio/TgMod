class TgSeqAct_SelectBestSpawnPoint extends SequenceAction
    forcescriptorder(true)
    hidecategories(Object);

var() array<Object> Points;
var() Actor PlayerReceived;

function Activated()
{
    local array<TgSpawnTeleporterExit> Exits;
    local Object CurrentPoint;
    local TgSpawnTeleporterExit CurrentExit;
    local ExitInfo BestExit;
    local TgPawn PlayerPawn;
    local TgPlayerController TgPC;
    local TgAIController TgAIC;

    PlayerPawn = TgPawn(PlayerReceived);
    // End:0xDE
    if(PlayerPawn == none)
    {
        TgPC = TgPlayerController(PlayerReceived);
        // End:0x82
        if(TgPC != none)
        {
            PlayerPawn = TgPC.GetTgPawn();            
        }
        else
        {
            TgAIC = TgAIController(PlayerReceived);
            // End:0xDE
            if(TgAIC != none)
            {
                PlayerPawn = TgPawn(TgAIC.Pawn);
            }
        }
    }
    // End:0x137
    foreach Points(CurrentPoint)
    {
        CurrentExit = TgSpawnTeleporterExit(CurrentPoint);
        // End:0x136
        if(CurrentExit != none)
        {
            Exits.AddItem(CurrentExit);
        }        
    }    
    BestExit = Class'TgGame.TgSpawnTeleporterEntrance'.static.FindExit(PlayerPawn, Exits);
    // End:0x1C7
    if(BestExit.Exit != none)
    {
        Class'TgGame.TgSpawnTeleporterEntrance'.static.TeleportToExit(PlayerPawn, none, BestExit);
    }
    //return;    
}

defaultproperties
{
    InputLinks[0]=(LinkDesc="Teleport Pawn",bHasImpulse=false,QueuedActivations=0,bDisabled=false,bDisabledPIE=false,LinkedOp=none,DrawY=0,bHidden=false,ActivateDelay=0.0000000,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_ObjectList',LinkedVariables=none,LinkDesc="Spawn Points",LinkVar="None",PropertyName="Points",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    VariableLinks[1]=(ExpectedType=Class'Engine.SeqVar_Object',LinkedVariables=none,LinkDesc="Player",LinkVar="None",PropertyName="PlayerReceived",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Teleport Player To Best Spawn Point"
}