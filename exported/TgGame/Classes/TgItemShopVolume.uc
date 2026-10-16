class TgItemShopVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

var() int TaskforceIndex;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn pPawn;

    pPawn = TgPawn(Other);
    // End:0x4A
    if(pPawn != none)
    {
        pPawn.OnEnterItemShop();
    }
    SetPurchaseFlag(Other, true);
    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

event UnTouch(Actor Other)
{
    local TgPawn pPawn;

    pPawn = TgPawn(Other);
    // End:0x4A
    if(pPawn != none)
    {
        pPawn.OnLeaveItemShop();
    }
    SetPurchaseFlag(Other, false);
    super(Actor).UnTouch(Other);
    //return;    
}

simulated function int GetSupportedTaskforce()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(WorldInfo.GRI);
    // End:0x154
    if(GRI != none)
    {
        // End:0x14A
        if((GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload') || GRI.GameClass == Class'TgGame.TgGame_Paladins_Payload_Practice')
        {
            // End:0x14A
            if(GRI.r_AttackingTaskForce != none)
            {
                // End:0x106
                if(TaskforceIndex == 1)
                {
                    return int(GRI.r_AttackingTaskForce.r_nTaskForce);                    
                }
                else
                {
                    return ((int(GRI.r_AttackingTaskForce.r_nTaskForce) == int(1)) ? 2 : 1);
                }
            }
        }
        return TaskforceIndex;
    }
    //return ReturnValue;    
}

event SetPurchaseFlag(Actor Other, bool bCanPurchase)
{
    local TgAIController_BehaviorGod AIController;
    local TgPlayerController pController;
    local TgPawn aPawn;
    local TgGame_Paladins TgG;
    local TgRepInfo_Game GRI;
    local int I, supportedTaskforce;

    aPawn = TgPawn(Other);
    supportedTaskforce = GetSupportedTaskforce();
    // End:0x378
    if((aPawn != none) && (int(aPawn.GetTaskForceNumber()) == supportedTaskforce) || supportedTaskforce == 0)
    {
        pController = TgPlayerController(aPawn.Controller);
        // End:0x30E
        if(pController != none)
        {
            TgG = TgGame_Paladins(WorldInfo.Game);
            // End:0x211
            if((bCanPurchase || TgG == none) || !TgG.m_bCanPurchaseItemsAnywhere)
            {
                pController.SetCanPurchaseFlag(bCanPurchase);
                // End:0x211
                if(!bCanPurchase)
                {
                    I = 0;
                    J0x179:

                    // End:0x211 [Loop If]
                    if(I < 26)
                    {
                        pController.r_LastPurchasedItems[I].nItemId = 0;
                        pController.r_LastPurchasedItems[I].nCount = 0;
                        I++;
                        // [Loop Continue]
                        goto J0x179;
                    }
                }
            }
            // End:0x2B0
            if(bCanPurchase)
            {
                GRI = TgRepInfo_Game(WorldInfo.GRI);
                // End:0x2AD
                if((GRI == none) || !GRI.r_bSpawnGatesOpenedAtLeastOnce)
                {
                    pController.SetCanChangeLoadout(bCanPurchase);
                }                
            }
            else
            {
                // End:0x30E
                if((TgG == none) || !TgG.m_bDeckSwappingAlwaysEnabled)
                {
                    pController.SetCanChangeLoadout(bCanPurchase);
                }
            }
        }
        AIController = TgAIController_BehaviorGod(aPawn.Controller);
        // End:0x378
        if(AIController != none)
        {
            AIController.bCanPurchaseItems = bCanPurchase;
        }
    }
    //return;    
}

defaultproperties
{
    bPawnsOnly=true
    // Reference: BrushComponent'TgGame.Default__TgItemShopVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}