class TgSeqAct_GiveCredits extends SequenceAction
    native(Kismet)
    forcescriptorder(true)
    hidecategories(Object);

var() int CreditsToGive;

function Activated()
{
    local TgGame_Paladins ChaosGame;
    local Controller TheController;
    local TgPaladinsController TgPC;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(GetWorldInfo().GRI);
    // End:0x13B
    if(!GRI.r_bBlockCreditGain)
    {
        ChaosGame = TgGame_Paladins(GetWorldInfo().Game);
        // End:0x13B
        if(ChaosGame != none)
        {
            // End:0x13A
            foreach GetWorldInfo().AllControllers(Class'Engine.Controller', TheController)
            {
                TgPC = TgPaladinsController(TheController);
                // End:0x139
                if(NotEqual_InterfaceInterface(TgPC, TgPaladinsController(none)))
                {
                    ChaosGame.GiveCredits(TgPC, CreditsToGive);
                }                
            }            
        }
    }
    //return;    
}

defaultproperties
{
    VariableLinks[0]=(ExpectedType=Class'Engine.SeqVar_Int',LinkedVariables=none,LinkDesc="Credits to Give",LinkVar="None",PropertyName="CreditsToGive",bWriteable=false,bSequenceNeverReadsOnlyWritesToThisVar=false,bModifiesLinkedObject=false,bHidden=false,MinVars=1,MaxVars=255,DrawX=0,CachedProperty=none,bAllowAnyType=false,bMoving=false,bClampedMax=false,bClampedMin=false)
    ObjName="Give Credits"
}