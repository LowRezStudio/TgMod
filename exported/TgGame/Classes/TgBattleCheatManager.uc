class TgBattleCheatManager extends PComCheatManager within TgPlayerController
    native
    config(Game);

var TgDemoRecSpectator_Debug m_DebugCameraController;
var array<PlayerStart> m_DebugPlayerStarts;

// Export UTgBattleCheatManager::execSwitchClass(FFrame&, void* const)
native exec function SwitchClass(string godName, optional string skinName, optional string weaponSkinName, optional string headName);

// Export UTgBattleCheatManager::execSwitchWard(FFrame&, void* const)
native exec function SwitchWard(optional string wardSkinName);

// Export UTgBattleCheatManager::execPurchaseGod(FFrame&, void* const)
native exec function PurchaseGod(string godName);

// Export UTgBattleCheatManager::execJoinMatchQueue(FFrame&, void* const)
native exec function JoinMatchQueue(int nQueueId, optional int god1, optional int god2, optional int god3, optional int god4, optional int god5);

// Export UTgBattleCheatManager::execListTickableActors(FFrame&, void* const)
native exec function ListTickableActors(Object.ETickingGroup checkgroup);

// Export UTgBattleCheatManager::execTestPanningRule(FFrame&, void* const)
native exec function TestPanningRule(optional string sPanningRule = "Headphone");

// Export UTgBattleCheatManager::execTestLanguage(FFrame&, void* const)
native exec function TestLanguage(string newLangExt);

// Export UTgBattleCheatManager::execNativeMaxLevel(FFrame&, void* const)
native function NativeMaxLevel();

// Export UTgBattleCheatManager::execSpawnBotByName(FFrame&, void* const)
native function TgPawn SpawnBotByName(string botName, int Taskforce, int nCount, int BotDifficulty, string BehaviorTreeName, int nHeadId);

// Export UTgBattleCheatManager::execSpawnBotAllSkins(FFrame&, void* const)
native function SpawnBotAllSkins(int nBatch);

// Export UTgBattleCheatManager::execToggleLoadFailureOutput(FFrame&, void* const)
native exec function ToggleLoadFailureOutput();

// Export UTgBattleCheatManager::execSpawnDeployable(FFrame&, void* const)
native exec function SpawnDeployable(int dep_id);

// Export UTgBattleCheatManager::execFillEnergy(FFrame&, void* const)
native exec function FillEnergy();

// Export UTgBattleCheatManager::execSetAILevel(FFrame&, void* const)
native function SetAILevel(TgAIController_BehaviorGod aic, int nLevel);

exec function separator()
{
    //return;    
}

exec function sc(string godName, optional string skinName, optional string weaponSkinName, optional string headName)
{
    SwitchClass(godName, skinName, weaponSkinName, headName);
    //return;    
}

exec function echo(string inputString)
{
    //return;    
}

exec function Loc()
{
    Outer.ClientMessage("Current Pawn Location:" @ string(Outer.Pawn.Location));
    //return;    
}

exec function ServerExec(string FSCommand)
{
    Outer.ConsoleCommand(FSCommand);
    //return;    
}

exec function SpawnTestBot(string sName, optional string sDeviceName, optional int nFireMode = 0, optional int nTaskForce = 2, optional int nCount = 1)
{
    local TgPawn TgP;
    local int nDeviceId;

    TgP = SpawnBotByName(sName, nTaskForce, nCount, 1, "BTs_ChaosPets.AI.BT_SimpleRepeater", 0);
    RemoveDeviceFromPawnAt(TgP, 1);
    // End:0xF3
    if((TgP != none) && sDeviceName != "")
    {
        nDeviceId = Outer.GetDeviceIdByName(sDeviceName);
        EquipDeviceOnPawn(TgP, nDeviceId, 1, nFireMode);
    }
    //return;    
}

exec function SpawnEmoteTestBot(string sName, optional int nTaskForce = 2, optional int nCount = 1)
{
    SpawnBotByName(sName, nTaskForce, nCount, 1, "BTs_ChaosPets.AI.BT_SimpleRepeaterEmote", 0);
    //return;    
}

exec function stb(string sName, optional string sDeviceName, optional int nFireMode = 0, optional int nTaskForce = 2, optional int nCount = 1)
{
    SpawnTestBot(sName, sDeviceName, nFireMode, nTaskForce, nCount);
    //return;    
}

exec function _SpawnBot(string sName, optional int nTaskForce = 2, optional int nCount = 1)
{
    Outer.ConsoleCommand("precacheclass" @ sName);
    SpawnBot(sName, nTaskForce, nCount);
    //return;    
}

exec function SpawnBot(string sName, optional int nTaskForce = 2, optional int nCount = 1, optional int BotDifficulty = 1, optional string BehaviorTreeName, optional int nHeadId)
{
    SpawnBotByName(sName, nTaskForce, nCount, BotDifficulty, BehaviorTreeName, nHeadId);
    //return;    
}

exec function TestSkinGallery(optional int nGallery = 0)
{
    SpawnBotAllSkins(nGallery);
    //return;    
}

exec function MaxLevel()
{
    NativeMaxLevel();
    //return;    
}

exec function ML()
{
    MaxLevel();
    //return;    
}

exec function SimNWCondition(int nPktLoss, int nPktLag)
{
    Outer.SetNWCondition(nPktLoss, nPktLag);
    //return;    
}

function CheatLog(string cheatText, bool bOn)
{
    Outer.ClientMessage(cheatText @ string(bOn));
    //return;    
}

simulated exec function God()
{
    super(CheatManager).God();
    CheatLog("God Mode", Outer.bGodMode);
    //return;    
}

simulated exec function energy()
{
    local TgPawn TgPawn;

    TgPawn = TgPawn(Outer.Pawn);
    // End:0xBC
    if(TgPawn != none)
    {
        TgPawn.m_bCheatUseNoEnergy = !TgPawn.m_bCheatUseNoEnergy;
        CheatLog("Unlimited Energy", TgPawn.m_bCheatUseNoEnergy);
    }
    //return;    
}

simulated exec function Cooldown()
{
    local TgPawn TgPawn;
    local int I;
    local TgDevice Dev;

    TgPawn = TgPawn(Outer.Pawn);
    // End:0x163
    if(TgPawn != none)
    {
        TgPawn.m_bCheatNoRecharge = !TgPawn.m_bCheatNoRecharge;
        // End:0x12C
        if(TgPawn.m_bCheatNoRecharge)
        {
            I = 0;
            J0xAE:

            // End:0x12C [Loop If]
            if(I < 33)
            {
                Dev = TgPawn.GetDeviceByEqPoint(I);
                // End:0x11E
                if(Dev != none)
                {
                    Dev.EndCooldown();
                }
                I++;
                // [Loop Continue]
                goto J0xAE;
            }
        }
        CheatLog("No Cooldowns", TgPawn.m_bCheatNoRecharge);
    }
    //return;    
}

simulated exec function ForceToggleMount()
{
    local TgPawn ActualPawn;

    ActualPawn = TgPawn(Outer.Pawn);
    // End:0x61
    if(ActualPawn != none)
    {
        ActualPawn.AutoMount(false, true);
    }
    //return;    
}

exec function MaxPower()
{
    local TgPawn TgPawn;
    local int I;
    local TgDevice Dev;

    TgPawn = TgPawn(Outer.Pawn);
    // End:0x156
    if(TgPawn != none)
    {
        I = 0;
        J0x4B:

        // End:0x136 [Loop If]
        if(I < 33)
        {
            Dev = TgPawn.GetDeviceByEqPoint(I);
            // End:0x128
            if((Dev != none) && Dev.GetTotalDevicePoints() > 0)
            {
                J0xC3:

                // End:0x128 [Loop If]
                if(Dev.GetAllocatedDevicePoints() < Dev.GetTotalDevicePoints())
                {
                    Dev.AllocateDevicePoint();
                    // [Loop Continue]
                    goto J0xC3;
                }
            }
            I++;
            // [Loop Continue]
            goto J0x4B;
        }
        CheatLog("Max Level Abilities", true);
    }
    //return;    
}

exec function HookMeUp()
{
    local TgPawn TgPawn;
    local TgPawn_Character TgP;

    TgPawn = TgPawn(Outer.Pawn);
    // End:0x161
    if(TgPawn != none)
    {
        // End:0x95
        if(!TgPawn.m_bCheatUseNoEnergy)
        {            
            Outer.ConsoleCommand("Energy");
        }
        // End:0xEC
        if(!TgPawn.m_bCheatNoRecharge)
        {            
            Outer.ConsoleCommand("Cooldown");
        }        
        Outer.ConsoleCommand("FillEnergy");
        TgPawn.SetProperty(2, TgPawn.GetMaxEnergy());
    }
    TgP = TgPawn_Character(Outer.Pawn);
    // End:0x1C2
    if(TgP != none)
    {
        TgP.s_bAmmoReloadCheat = true;
    }
    // End:0x214
    if(!Outer.bGodMode)
    {        
        Outer.ConsoleCommand("God");
    }    
    Outer.ConsoleCommand("MaxLevel");    
    Outer.ConsoleCommand("AddGold 100000");
    //return;    
}

exec function GiveRecommendedItems()
{
    local bool bOldCanPurchase, bOldAutoPurchase;

    bOldCanPurchase = Outer.r_bCanPurchaseItems;
    bOldAutoPurchase = Outer.r_bAutoPurchase;
    Outer.r_bCanPurchaseItems = true;
    Outer.r_bAutoPurchase = true;
    AddGold(100000);
    Outer.AutoPurchase();
    Outer.r_bCanPurchaseItems = bOldCanPurchase;
    Outer.r_bAutoPurchase = bOldAutoPurchase;
    //return;    
}

exec function SetGroundspeed(float val)
{
    // End:0x8B
    if(TgPawn(Outer.Pawn) != none)
    {
        TgPawn(Outer.Pawn).GroundSpeed = val;
        CheatLog("Groundspeed", true);
    }
    //return;    
}

exec function SetStealth(bool bOn)
{
    // End:0x7F
    if(TgPawn(Outer.Pawn) != none)
    {
        TgPawn(Outer.Pawn).ApplyStealthServer(((bOn) ? 3 : 0));
    }
    //return;    
}

exec function ShowMoveErrors()
{
    Outer.FlushPersistentDebugLines();
    Outer.bShowMoveErrors = !Outer.bShowMoveErrors;
    Outer.bDebugClientAdjustPosition = Outer.bShowMoveErrors;
    //return;    
}

exec function DebugProjectileLagCompensationServer()
{
    Outer.FlushPersistentDebugLines();
    Outer.bDebugProjectileLagCompensation = !Outer.bDebugProjectileLagCompensation;
    //return;    
}

exec function DebugProjectileLagCompensationClient()
{
    Outer.FlushPersistentDebugLines();
    Outer.bDebugProjectileLagCompensation = !Outer.bDebugProjectileLagCompensation;
    //return;    
}

exec function _SpawnTemplatePlayer(int nProfileId, optional int nSkinId = 0, optional int nWeaponSkinId = 0, optional int nHeadSkinId = 0)
{
    TgGame(Outer.WorldInfo.Game).SpawnTemplatePlayer(Outer, nProfileId, nSkinId, nWeaponSkinId, nHeadSkinId);
    //return;    
}

exec function KillAllMinions()
{
    KillAllPawnsHelper(Class'TgGame.TgPawn_LanePusherBase');
    //return;    
}

function KillAllPawnsHelper(Class<Pawn> PawnClass)
{
    local Pawn P;

    // End:0x6B
    foreach Outer.WorldInfo.AllPawns(PawnClass, P)
    {
        P.Suicide();        
    }    
    //return;    
}

exec function KillAllPawnsByClass(string PawnClassName)
{
    local Class<Pawn> PawnClass;

    PawnClass = Class<Pawn>(FindObject(PawnClassName, Class'Core.Class'));
    // End:0x78
    if(PawnClass == none)
    {
        PawnClass = Class<Pawn>(FindObject("TgGame." $ PawnClassName, Class'Core.Class'));
    }
    // End:0xC8
    if(PawnClass == none)
    {
        PawnClass = Class<Pawn>(FindObject("TgGameContent." $ PawnClassName, Class'Core.Class'));
    }
    // End:0xEA
    if(PawnClass != none)
    {
        KillAllPawnsHelper(PawnClass);
    }
    //return;    
}

simulated exec function ToggleDeviceLog(optional TgObject.TG_EQUIP_POINT eqp = 0)
{
    Outer.m_bDetailedDeviceLogging = !Outer.m_bDetailedDeviceLogging;
    Outer.m_eDetailedDeviceEqp = eqp;
    //return;    
}

simulated exec function ToggleCustomPhysics()
{
    // End:0x70
    if(int(Outer.Pawn.Physics) != int(14))
    {
        Outer.Pawn.SetPhysics(14);        
    }
    else
    {
        Outer.Pawn.SetPhysics(2);
    }
    //return;    
}

exec function ToggleAIDebug(optional bool bAttachAIDebugger = false)
{
    local TgPawn P;
    local TgAIController_Behavior behavior_ai;
    local editinline TgAIObstacleAvoidanceRenderingComponent MapRenderer;
    local bool bFoundRenderer;

    P = TgPawn(Outer.m_aHoverActor);
    // End:0x33B
    if(P != none)
    {
        behavior_ai = TgAIController_Behavior(P.Controller);
        // End:0x33B
        if(behavior_ai != none)
        {
            P.r_bDebugShowAIDebug = !P.r_bDebugShowAIDebug;
            behavior_ai.bBtDebugClientOverlay = P.r_bDebugShowAIDebug;
            behavior_ai.UpdatePawnDebug();
            // End:0x150
            if(bAttachAIDebugger)
            {
                behavior_ai.SpawnDebuggerWindow();
            }
            // End:0x255
            foreach behavior_ai.ComponentList(Class'TgGame.TgAIObstacleAvoidanceRenderingComponent', MapRenderer)
            {
                // End:0x254
                if(((MapRenderer != none) && MapRenderer.ObstacleAvoidance != none) && MapRenderer.ObstacleAvoidance == behavior_ai.ObstacleAvoidance)
                {
                    bFoundRenderer = true;
                    // End:0x254
                    if(!behavior_ai.bBtDebugClientOverlay)
                    {
                        behavior_ai.DetachComponent(MapRenderer);
                    }
                }                
            }            
            // End:0x33B
            if((!bFoundRenderer && behavior_ai.bBtDebugClientOverlay) && behavior_ai.ObstacleAvoidance != none)
            {
                MapRenderer = new (self) Class'TgGame.TgAIObstacleAvoidanceRenderingComponent';
                // End:0x33B
                if(MapRenderer != none)
                {
                    MapRenderer.ObstacleAvoidance = behavior_ai.ObstacleAvoidance;
                    Outer.AttachComponent(MapRenderer);
                }
            }
        }
    }
    //return;    
}

exec function TestObstacleAvoidance(optional int TestType)
{
    local TgAIController_Behavior aic;

    // End:0xD0
    foreach Outer.WorldInfo.AllControllers(Class'TgGame.TgAIController_Behavior', aic)
    {
        // End:0xCF
        if((aic.ObstacleAvoidance != none) && aic.bBtDebugClientOverlay)
        {
            aic.ObstacleAvoidance.TestObstacleAvoidance(TestType);
        }        
    }    
    //return;    
}

exec function RequestRelease()
{
    Outer.Revive();
    //return;    
}

exec function botsgod(optional bool bOn = true)
{
    local AIController aic;

    // End:0x79
    foreach Outer.WorldInfo.AllControllers(Class'Engine.AIController', aic)
    {
        aic.bGodMode = bOn;        
    }    
    //return;    
}

exec function FreezeAI(optional bool bOn = true)
{
    local TgAIController aic;

    // End:0x79
    foreach Outer.WorldInfo.AllControllers(Class'TgGame.TgAIController', aic)
    {
        aic.bIsAIFrozen = bOn;        
    }    
    //return;    
}

exec function botslevel(int nLevel)
{
    local TgAIController_BehaviorGod aic;

    // End:0x66
    foreach Outer.WorldInfo.AllControllers(Class'TgGame.TgAIController_BehaviorGod', aic)
    {
        SetAILevel(aic, nLevel);        
    }    
    //return;    
}

simulated exec function SpectatorCamera(optional bool bOn = true)
{
    local TgCameraModule newCameraMod;

    // End:0x12B
    if(int(Outer.Role) == int(ROLE_Authority))
    {
        // End:0x60
        if(!bOn)
        {
            Outer.SwitchCamera("");
            return;
        }
        // End:0xA3
        if(Outer.PlayerCamera == none)
        {
            Outer.SpawnPlayerCamera();
        }
        newCameraMod = TgPlayerCamera(Outer.PlayerCamera).SwitchCameras(Class'TgGame.TgCameraModule_Spectator');
        // End:0x12B
        if(newCameraMod != none)
        {
            Outer.SwitchControl(Class'TgGame.TgControlModule_Spectator');
        }
    }
    // End:0x29F
    if(int(Outer.WorldInfo.NetMode) != int(NM_DedicatedServer))
    {
        // End:0x29F
        if((TgPawn(Outer.Pawn) != none) && TgPawn(Outer.Pawn).r_EffectManager != none)
        {
            // End:0x22A
            if(!bOn)
            {
                TgPawn(Outer.Pawn).ReapplyLoadoutEffects();                
            }
            else
            {
                TgPawn(Outer.Pawn).r_EffectManager.ApplyStasis(1, Outer.Pawn);
            }
        }
    }
    //return;    
}

exec function ApplyProp(int nPropId, float nValue, optional int nCategory = 0)
{
    local ImpactInfo Impact;

    Impact.bDirectHit = true;
    Impact.DeviceModeReference = none;
    Impact.HitActor = Outer.Pawn;
    Impact.HitLocation = Outer.Pawn.Location;
    Impact.HitNormal = vect(1.0000000, 0.0000000, 0.0000000);
    Impact.StartTrace = Outer.Pawn.Location;
    TgPawn(Outer.Pawn).r_EffectManager.ApplyProperty(nValue, nPropId, Outer.Pawn, Impact, nCategory);
    //return;    
}

exec function BeTheBoss()
{
    HookMeUp();    
    Outer.ConsoleCommand("setgroundspeed 5000");    
    Outer.ConsoleCommand("sctimer 1");
    //return;    
}

exec event ShowFootstepInfo()
{
    Outer.c_bShowFootstepInfoDebug = !Outer.c_bShowFootstepInfoDebug;
    //return;    
}

exec function ToggleAimAssist()
{
    TgPlayerInput(Outer.PlayerInput).bEnableAimAssist = !TgPlayerInput(Outer.PlayerInput).bEnableAimAssist;
    Outer.ClientMessage("Aim Assist is:" @ ((TgPlayerInput(Outer.PlayerInput).ShouldUseAimAssist()) ? "ENABLED" : "DISABLED"));
    //return;    
}

exec function SetAimAssistTargetWeightVars(float CurrentTargetBonus, float NotCurrentTargetPenalty, float MinAccuracyBonus, float MaxAccuracyBonus, float MinInaccuracyPenalty, float MaxInaccuracyPenalty, float MaxWeight)
{
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.CurrentTargetBonus = CurrentTargetBonus;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.NotCurrentTargetPenalty = NotCurrentTargetPenalty;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.MinAccuracyBonus = MinAccuracyBonus;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.MaxAccuracyBonus = MaxAccuracyBonus;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.MinInaccuracyPenalty = MinInaccuracyPenalty;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.MaxInaccuracyPenalty = MaxInaccuracyPenalty;
    TgPlayerInput(Outer.PlayerInput).TargetWeightVars.MaxWeight = MaxWeight;
    //return;    
}

exec function ResetAimAssistValues()
{
    SetAimAssistValues(Class'TgGame.TgDevice'.default.m_AimAssistMagnetScale.X, Class'TgGame.TgDevice'.default.m_AimAssistMagnetScale.Y, Class'TgGame.TgDevice'.default.m_AimAssistFrictionScale.X, Class'TgGame.TgDevice'.default.m_AimAssistFrictionScale.Y, Class'TgGame.TgDevice'.default.m_AimAssistTrackingScale.X, Class'TgGame.TgDevice'.default.m_AimAssistTrackingScale.Y);
    SetAimVectorAssistValues(Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxBoundsScale.X, Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxBoundsScale.Y, Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxAssistanceDegrees.X, Class'TgGame.TgDevice'.default.m_AimVectorAssistMaxAssistanceDegrees.Y);
    //return;    
}

exec function SetAimAssistValues(float MagnetScaleX, float MagnetScaleY, float FrictionScaleX, float FrictionScaleY, float TrackingScaleX, float TrackingScaleY)
{
    local TgDevice TgDevice;

    // End:0x1E6
    foreach Outer.AllActors(Class'TgGame.TgDevice', TgDevice)
    {
        TgDevice.m_AimAssistMagnetScale.X = MagnetScaleX;
        TgDevice.m_AimAssistMagnetScale.Y = MagnetScaleY;
        TgDevice.m_AimAssistFrictionScale.X = FrictionScaleX;
        TgDevice.m_AimAssistFrictionScale.Y = FrictionScaleY;
        TgDevice.m_AimAssistTrackingScale.X = TrackingScaleX;
        TgDevice.m_AimAssistTrackingScale.Y = TrackingScaleY;
        TgDevice.ClientSetAimAssistValues(MagnetScaleX, MagnetScaleY, FrictionScaleX, FrictionScaleY, TrackingScaleX, TrackingScaleY);        
    }    
    //return;    
}

exec function SetAimVectorAssistValues(float BoundsScaleX, float BoundsScaleY, float MaxAngleX, float MaxAngleY)
{
    local TgDevice TgDevice;

    // End:0x15E
    foreach Outer.AllActors(Class'TgGame.TgDevice', TgDevice)
    {
        TgDevice.m_AimVectorAssistMaxBoundsScale.X = BoundsScaleX;
        TgDevice.m_AimVectorAssistMaxBoundsScale.Y = BoundsScaleY;
        TgDevice.m_AimVectorAssistMaxAssistanceDegrees.X = MaxAngleX;
        TgDevice.m_AimVectorAssistMaxAssistanceDegrees.Y = MaxAngleY;
        TgDevice.ClientSetAimVectorAssistValues(BoundsScaleX, BoundsScaleY, MaxAngleX, MaxAngleY);        
    }    
    //return;    
}

exec function AddAimAssistKeyframe(string keyframeType, string KeyframeName, float Distance)
{
    local TgPawn TgP;
    local TgDevice TgD;
    local int I;
    local AimAssistKeyframeData aadata;

    aadata.Distance = Distance;
    aadata.KeyframeName = name(KeyframeName);
    TgP = TgPawn(Outer.Pawn);
    // End:0x6CC
    if(TgP != none)
    {
        TgD = TgP.GetDeviceByEqPoint(1);
        // End:0x6CC
        if(TgD != none)
        {
            // End:0x1A2
            if(keyframeType == "hm")
            {
                I = 0;
                J0xE4:

                // End:0x16B [Loop If]
                if(I < TgD.m_AimAssistKeyframesMagnetHoriz.Length)
                {
                    // End:0x15D
                    if(TgD.m_AimAssistKeyframesMagnetHoriz[I].Distance > Distance)
                    {
                        // [Explicit Break]
                        goto J0x16B;
                    }
                    I++;
                    // [Loop Continue]
                    goto J0xE4;
                }
                J0x16B:

                TgD.m_AimAssistKeyframesMagnetHoriz.InsertItem(I, aadata);                
            }
            else
            {
                // End:0x27D
                if(keyframeType == "vm")
                {
                    I = 0;
                    J0x1BF:

                    // End:0x246 [Loop If]
                    if(I < TgD.m_AimAssistKeyframesMagnetVert.Length)
                    {
                        // End:0x238
                        if(TgD.m_AimAssistKeyframesMagnetVert[I].Distance > Distance)
                        {
                            // [Explicit Break]
                            goto J0x246;
                        }
                        I++;
                        // [Loop Continue]
                        goto J0x1BF;
                    }
                    J0x246:

                    TgD.m_AimAssistKeyframesMagnetVert.InsertItem(I, aadata);                    
                }
                else
                {
                    // End:0x357
                    if(keyframeType == "f")
                    {
                        I = 0;
                        J0x299:

                        // End:0x320 [Loop If]
                        if(I < TgD.m_AimAssistKeyframesFriction.Length)
                        {
                            // End:0x312
                            if(TgD.m_AimAssistKeyframesFriction[I].Distance > Distance)
                            {
                                // [Explicit Break]
                                goto J0x320;
                            }
                            I++;
                            // [Loop Continue]
                            goto J0x299;
                        }
                        J0x320:

                        TgD.m_AimAssistKeyframesFriction.InsertItem(I, aadata);                        
                    }
                    else
                    {
                        // End:0x435
                        if(keyframeType == "htacc")
                        {
                            I = 0;
                            J0x377:

                            // End:0x3FE [Loop If]
                            if(I < TgD.m_AimAssistKeyframesTrackingAccHoriz.Length)
                            {
                                // End:0x3F0
                                if(TgD.m_AimAssistKeyframesTrackingAccHoriz[I].Distance > Distance)
                                {
                                    // [Explicit Break]
                                    goto J0x3FE;
                                }
                                I++;
                                // [Loop Continue]
                                goto J0x377;
                            }
                            J0x3FE:

                            TgD.m_AimAssistKeyframesTrackingAccHoriz.InsertItem(I, aadata);                            
                        }
                        else
                        {
                            // End:0x513
                            if(keyframeType == "htang")
                            {
                                I = 0;
                                J0x455:

                                // End:0x4DC [Loop If]
                                if(I < TgD.m_AimAssistKeyframesTrackingAngleHoriz.Length)
                                {
                                    // End:0x4CE
                                    if(TgD.m_AimAssistKeyframesTrackingAngleHoriz[I].Distance > Distance)
                                    {
                                        // [Explicit Break]
                                        goto J0x4DC;
                                    }
                                    I++;
                                    // [Loop Continue]
                                    goto J0x455;
                                }
                                J0x4DC:

                                TgD.m_AimAssistKeyframesTrackingAngleHoriz.InsertItem(I, aadata);                                
                            }
                            else
                            {
                                // End:0x5F1
                                if(keyframeType == "vtacc")
                                {
                                    I = 0;
                                    J0x533:

                                    // End:0x5BA [Loop If]
                                    if(I < TgD.m_AimAssistKeyframesTrackingAccVert.Length)
                                    {
                                        // End:0x5AC
                                        if(TgD.m_AimAssistKeyframesTrackingAccVert[I].Distance > Distance)
                                        {
                                            // [Explicit Break]
                                            goto J0x5BA;
                                        }
                                        I++;
                                        // [Loop Continue]
                                        goto J0x533;
                                    }
                                    J0x5BA:

                                    TgD.m_AimAssistKeyframesTrackingAccVert.InsertItem(I, aadata);                                    
                                }
                                else
                                {
                                    // End:0x6CC
                                    if(keyframeType == "vtang")
                                    {
                                        I = 0;
                                        J0x611:

                                        // End:0x698 [Loop If]
                                        if(I < TgD.m_AimAssistKeyframesTrackingAngleVert.Length)
                                        {
                                            // End:0x68A
                                            if(TgD.m_AimAssistKeyframesTrackingAngleVert[I].Distance > Distance)
                                            {
                                                // [Explicit Break]
                                                goto J0x698;
                                            }
                                            I++;
                                            // [Loop Continue]
                                            goto J0x611;
                                        }
                                        J0x698:

                                        TgD.m_AimAssistKeyframesTrackingAngleVert.InsertItem(I, aadata);
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //return;    
}

exec function ResetAimAssistKeyframes(string keyframeType)
{
    local TgPawn TgP;
    local TgDevice TgD;

    TgP = TgPawn(Outer.Pawn);
    // End:0x1FB
    if(TgP != none)
    {
        TgD = TgP.GetDeviceByEqPoint(1);
        // End:0x1FB
        if(TgD != none)
        {
            // End:0xAF
            if(keyframeType == "hm")
            {
                TgD.m_AimAssistKeyframesMagnetHoriz.Length = 0;                
            }
            else
            {
                // End:0xE5
                if(keyframeType == "vm")
                {
                    TgD.m_AimAssistKeyframesMagnetVert.Length = 0;                    
                }
                else
                {
                    // End:0x11A
                    if(keyframeType == "f")
                    {
                        TgD.m_AimAssistKeyframesFriction.Length = 0;                        
                    }
                    else
                    {
                        // End:0x153
                        if(keyframeType == "htacc")
                        {
                            TgD.m_AimAssistKeyframesTrackingAccHoriz.Length = 0;                            
                        }
                        else
                        {
                            // End:0x18C
                            if(keyframeType == "htang")
                            {
                                TgD.m_AimAssistKeyframesTrackingAngleHoriz.Length = 0;                                
                            }
                            else
                            {
                                // End:0x1C5
                                if(keyframeType == "vtacc")
                                {
                                    TgD.m_AimAssistKeyframesTrackingAccVert.Length = 0;                                    
                                }
                                else
                                {
                                    // End:0x1FB
                                    if(keyframeType == "vtang")
                                    {
                                        TgD.m_AimAssistKeyframesTrackingAngleVert.Length = 0;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //return;    
}

exec function RefillAmmo()
{
    local TgInventoryManager InvMgr;
    local TgPawn TgP;
    local int I;
    local TgDevice Dev;

    TgP = TgPawn(Outer.Pawn);
    // End:0x16D
    if(TgP != none)
    {
        InvMgr = TgInventoryManager(TgP.InvManager);
        // End:0x16D
        if(InvMgr != none)
        {
            I = 0;
            J0x8B:

            // End:0x16D [Loop If]
            if(I < 33)
            {
                Dev = TgP.GetDeviceByEqPoint(I);
                // End:0x15F
                if((Dev != none) && Dev.r_nMaxAmmoClipCount > 0)
                {
                    Dev.SetAmmo(Dev.r_nMaxAmmoClipCount, Dev.r_nMaxAmmoClipCount);
                }
                I++;
                // [Loop Continue]
                goto J0x8B;
            }
        }
    }
    //return;    
}

exec function SetMaxAmmo(int MaxAmmo)
{
    local TgPawn TgP;
    local TgDevice TgD;

    TgP = TgPawn(Outer.Pawn);
    // End:0xAC
    if(TgP != none)
    {
        TgD = TgP.GetDeviceByEqPoint(1);
        // End:0xAC
        if(TgD != none)
        {
            TgD.SetAmmo(MaxAmmo, MaxAmmo);
        }
    }
    //return;    
}

exec function ChangeTaskForce(byte nTaskForce)
{
    // End:0x78
    if((Outer.CachedPRI != none) && int(nTaskForce) >= int(0))
    {
        Outer.CachedPRI.SetTaskForceNumber(nTaskForce);
    }
    //return;    
}

exec function ct(byte nTaskForce)
{
    // End:0x78
    if((Outer.CachedPRI != none) && int(nTaskForce) >= int(0))
    {
        Outer.CachedPRI.SetTaskForceNumber(nTaskForce);
    }
    //return;    
}

exec function ToggleTaskForce()
{
    local int nCurrentTaskForce;

    // End:0xAE
    if(Outer.CachedPRI != none)
    {
        nCurrentTaskForce = int(Outer.CachedPRI.GetTaskForceNumber());
        Outer.CachedPRI.SetTaskForceNumber(((nCurrentTaskForce == 1) ? 2 : 1));
    }
    //return;    
}

function RemoveDeviceFromPawnAt(TgPawn TgP, int nEquipPointId)
{
    local TgInventoryManager InvMgr;
    local TgDevice pDevice;

    // End:0x11
    if(TgP == none)
    {
        return;
    }
    InvMgr = TgInventoryManager(TgP.InvManager);
    // End:0xCF
    if(InvMgr != none)
    {
        pDevice = TgP.GetDeviceByEqPoint(nEquipPointId);
        // End:0xCF
        if(pDevice != none)
        {
            InvMgr.RemoveDevice(pDevice.s_InventoryObject);
        }
    }
    //return;    
}

function EquipDeviceOnPawn(TgPawn TgP, int nDeviceId, int nEquipPointId, optional int FireMode = 0)
{
    local TgInventoryManager InvMgr;
    local TgDevice pDevice;

    // End:0x16
    if(TgP == none)
    {
        return;
    }
    // End:0x27
    if(nDeviceId <= 0)
    {
        return;
    }
    InvMgr = TgInventoryManager(TgP.InvManager);
    // End:0x192
    if(InvMgr != none)
    {
        pDevice = TgP.GetDeviceByEqPoint(nEquipPointId);
        // End:0x13D
        if(pDevice != none)
        {
            // End:0x13A
            if(nDeviceId > 0)
            {
                InvMgr.RemoveDevice(pDevice.s_InventoryObject);
                pDevice = InvMgr.AddDevice(nDeviceId, nEquipPointId, none, true, FireMode);
            }            
        }
        else
        {
            // End:0x192
            if(nDeviceId > 0)
            {
                pDevice = InvMgr.AddDevice(nDeviceId, nEquipPointId, none, true, FireMode);
            }
        }
    }
    //return;    
}

exec function TargetEquipDevice(int nDeviceId, int nEquipPointId, optional int FireMode = 0)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn HitPawn;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    HitPawn = TgPawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0xE8
    if(HitPawn != none)
    {
        EquipDeviceOnPawn(HitPawn, nDeviceId, nEquipPointId, FireMode);
    }
    //return;    
}

exec function TED(int nDeviceId, int nEquipPointId, optional int FireMode = 0)
{
    TargetEquipDevice(nDeviceId, nEquipPointId, FireMode);
    //return;    
}

exec function TargetEquipDeviceByName(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    local int nDeviceId;

    nDeviceId = Outer.GetDeviceIdByName(sDeviceName);
    // End:0x6B
    if(nDeviceId >= 0)
    {
        TargetEquipDevice(nDeviceId, nEquipPointId, FireMode);
    }
    //return;    
}

exec function TEDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    TargetEquipDeviceByName(sDeviceName, nEquipPointId, FireMode);
    //return;    
}

exec function EquipDeviceByName(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    local int nDeviceId;

    nDeviceId = Outer.GetDeviceIdByName(sDeviceName);
    // End:0x6B
    if(nDeviceId >= 0)
    {
        EquipDevice(nDeviceId, nEquipPointId, FireMode);
    }
    //return;    
}

exec function EDBN(string sDeviceName, int nEquipPointId, optional int FireMode = 1)
{
    EquipDeviceByName(sDeviceName, nEquipPointId, FireMode);
    //return;    
}

exec function EquipDevice(int nDeviceId, int nEquipPointId, optional int FireMode = 0)
{
    local TgInventoryManager InvMgr;
    local TgDevice pDevice;
    local int nSetPoints;

    // End:0x409
    if((TgPawn(Outer.Pawn) != none) && TgInventoryManager(TgPawn(Outer.Pawn).InvManager) != none)
    {
        InvMgr = TgInventoryManager(TgPawn(Outer.Pawn).InvManager);
        pDevice = TgPawn(Outer.Pawn).GetDeviceByEqPoint(nEquipPointId);
        // End:0x2BB
        if(pDevice != none)
        {
            // End:0x2B8
            if(nDeviceId > 0)
            {
                InvMgr.RemoveDevice(pDevice.s_InventoryObject);
                pDevice = InvMgr.AddDevice(nDeviceId, nEquipPointId, none, true, FireMode);
                // End:0x2B8
                if(pDevice.IsOffhand())
                {
                    nSetPoints = ((pDevice.GetTotalDevicePoints() > 0) ? Clamp(FireMode, 1, pDevice.GetTotalDevicePoints()) : 0);
                    // End:0x2B8
                    if(nSetPoints > 0)
                    {
                        pDevice.r_nPointsAllocated = nSetPoints - 1;
                        pDevice.AllocateDevicePoint();
                        pDevice.bNetDirty = true;
                    }
                }
            }            
        }
        else
        {
            // End:0x409
            if(nDeviceId > 0)
            {
                pDevice = InvMgr.AddDevice(nDeviceId, nEquipPointId, none, true, FireMode);
                // End:0x409
                if(pDevice.IsOffhand())
                {
                    nSetPoints = ((pDevice.GetTotalDevicePoints() > 0) ? Clamp(FireMode, 1, pDevice.GetTotalDevicePoints()) : 0);
                    // End:0x409
                    if(nSetPoints > 0)
                    {
                        pDevice.r_nPointsAllocated = nSetPoints - 1;
                        pDevice.AllocateDevicePoint();
                        pDevice.bNetDirty = true;
                    }
                }
            }
        }
    }
    //return;    
}

exec function ED(int nDeviceId, int nEquipPointId, optional int FireMode = 0)
{
    EquipDevice(nDeviceId, nEquipPointId, FireMode);
    //return;    
}

exec function UnequipDevice(int nDeviceId)
{
    local TgInventoryManager InvMgr;
    local TgPawn TgP;
    local int I;
    local TgDevice Dev;

    TgP = TgPawn(Outer.Pawn);
    // End:0x153
    if(TgP != none)
    {
        InvMgr = TgInventoryManager(TgP.InvManager);
        // End:0x153
        if(InvMgr != none)
        {
            I = 0;
            J0x8B:

            // End:0x153 [Loop If]
            if(I < 33)
            {
                Dev = TgP.GetDeviceByEqPoint(I);
                // End:0x145
                if(Dev != none)
                {
                    // End:0x145
                    if(Dev.r_nDeviceId == nDeviceId)
                    {
                        InvMgr.RemoveDevice(Dev.s_InventoryObject);
                    }
                }
                I++;
                // [Loop Continue]
                goto J0x8B;
            }
        }
    }
    //return;    
}

exec function UD(int nDeviceId)
{
    UnequipDevice(nDeviceId);
    //return;    
}

exec function RemoveDevice(int nDeviceId)
{
    UnequipDevice(nDeviceId);
    //return;    
}

exec function UnequipDeviceAt(int nEquipPointId)
{
    local TgInventoryManager InvMgr;
    local TgPawn TgP;
    local TgDevice Dev;

    TgP = TgPawn(Outer.Pawn);
    // End:0xFE
    if(TgP != none)
    {
        InvMgr = TgInventoryManager(TgP.InvManager);
        // End:0xFE
        if(InvMgr != none)
        {
            Dev = TgP.GetDeviceByEqPoint(nEquipPointId);
            // End:0xFE
            if(Dev != none)
            {
                InvMgr.RemoveDevice(Dev.s_InventoryObject);
            }
        }
    }
    //return;    
}

exec function RemoveDeviceAt(int nDeviceId)
{
    UnequipDeviceAt(nDeviceId);
    //return;    
}

exec function RemoveAllCards()
{
    UnequipDeviceAt(5);
    UnequipDeviceAt(22);
    UnequipDeviceAt(21);
    UnequipDeviceAt(20);
    UnequipDeviceAt(19);
    UnequipDeviceAt(25);
    //return;    
}

exec function RemoveAllItems()
{
    UnequipDeviceAt(8);
    UnequipDeviceAt(9);
    UnequipDeviceAt(10);
    UnequipDeviceAt(11);
    //return;    
}

exec function AddGold(int nCurrency)
{
    // End:0xF4
    if(int(Outer.Role) == int(ROLE_Authority))
    {
        Outer.r_nCurrency += nCurrency;
        Outer.bNetDirty = true;
        // End:0xF4
        if((int(Outer.WorldInfo.NetMode) != int(NM_DedicatedServer)) && Outer.IsLocalPlayerController())
        {
            Outer.SendUICurrencyChange();
        }
    }
    //return;    
}

exec function Obama(int nCurrency)
{
    AddGold(nCurrency);
    //return;    
}

exec function SetMeLevel(int nLevel)
{
    Outer.SetLevel(nLevel);
    //return;    
}

exec function SL(int nLevel)
{
    SetMeLevel(nLevel);
    //return;    
}

exec function QuickEndGame(bool bWin)
{
    // End:0x81
    if(bWin)
    {
        TgGame_Mission(Outer.WorldInfo.Game).QuickEndGame(Outer.GetTaskForceNumber());        
    }
    else
    {
        // End:0xFD
        if(Outer.GetTaskForceNumber() == 1)
        {
            TgGame_Mission(Outer.WorldInfo.Game).QuickEndGame(2);            
        }
        else
        {
            TgGame_Mission(Outer.WorldInfo.Game).QuickEndGame(1);
        }
    }
    //return;    
}

exec function QEG(optional bool bWin = true)
{
    QuickEndGame(bWin);
    //return;    
}

exec function SetEnergy(float Value)
{
    local TgPawn TgPawn;
    local TgProperty EnergyProperty;

    TgPawn = TgPawn(Outer.Pawn);
    // End:0xBA
    if(TgPawn != none)
    {
        EnergyProperty = TgPawn.GetProperty(22);
        TgPawn.SetProperty(22, FClamp(Value, 0.0000000, EnergyProperty.m_fMaximum));
    }
    //return;    
}

exec function TestShowInventory()
{
    TgInventoryManager(Outer.Pawn.InvManager).TestShowInventory();
    //return;    
}

exec function TestStunEffect(float fDuration)
{
    // End:0xAA
    if(TgPawn(Outer.Pawn) != none)
    {
        TgPawn(Outer.Pawn).r_EffectManager.ApplyStun(fDuration, Outer.Pawn);
    }
    //return;    
}

exec function TestStun(Controller.EStunType Type)
{
    // End:0x5E
    if(int(Type) != int(0))
    {
        TgPawn(Outer.Pawn).Stun(true, Type);        
    }
    else
    {
        TgPawn(Outer.Pawn).Stun(false);
    }
    //return;    
}

exec function ShowPlayerCircles(bool bEnabled)
{
    Outer.m_bShowPlayerCircles = bEnabled;
    //return;    
}

exec function ToggleSpectatorCamera()
{
    local Vector CamLoc;
    local Rotator CamRot;
    local PlayerController PC;
    local TgDemoRecSpectator_Debug DebugController;

    // End:0xE8
    foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
    {
        // End:0xE7
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            DebugController = TgDemoRecSpectator_Debug(PC);
            // End:0xE4
            if((DebugController != none) && DebugController.m_OriginalPlayerController == none)
            {
                continue;                
            }
            // End:0xE8
            break;
        }        
    }    
    // End:0x1B9
    if(((DebugController != none) && DebugController.m_OriginalPlayerController != none) && DebugController.m_OriginalPlayer != none)
    {
        DebugController.m_OriginalPlayer.SwitchController(DebugController.m_OriginalPlayerController);
        DebugController.m_OriginalPlayerController = none;        
    }
    else
    {
        // End:0x25F
        if(((Outer.Player != none) && Outer.Pawn != none) && Outer.IsLocalPlayerController())
        {
            m_DebugCameraController = Outer.Spawn(Class'TgGame.TgDemoRecSpectator_Debug');
        }
        m_DebugCameraController.m_OriginalPlayer = Outer.Player;
        m_DebugCameraController.m_OriginalPlayerController = Outer;
        Outer.GetPlayerViewPoint(CamLoc, CamRot);
        m_DebugCameraController.SetLocation(CamLoc);
        m_DebugCameraController.SetRotation(CamRot);
        m_DebugCameraController.PlayerCamera.UpdateCamera(0.0000000);
        Outer.Player.SwitchController(m_DebugCameraController);
        m_DebugCameraController.ForwardToSpectatingMatch();
    }
    //return;    
}

exec function InvisMe(bool bInvis)
{
    local TgPawn TgP;

    TgP = TgPawn(Outer.Pawn);
    // End:0xBA
    if((int(Outer.Role) == int(ROLE_Authority)) && TgP != none)
    {
        TgP.m_bIsInvisibleToAI = bInvis;
        CheatLog("AI Invisibility", bInvis);
    }
    //return;    
}

exec function capturePoint()
{
    local TgRepInfo_TaskForce Taskforce;
    local TgChaosCapturePoint capturePoint, PointToCapture;

    // End:0x225
    if(TgRepInfo_Game(Outer.WorldInfo.GRI).r_LanePusher == none)
    {
        Taskforce = TgRepInfo_Game(Outer.WorldInfo.GRI).GetTaskForce(Outer.GetTaskForceNumber());
        Taskforce.r_fSecondaryScore = TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fSecondaryGoalScore;
        // End:0x1C6
        foreach Outer.WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            // End:0x1C5
            if(int(capturePoint.r_eStatus) == int(1))
            {
                PointToCapture = capturePoint;
                // End:0x1C6
                break;
            }            
        }        
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).CheckCorePower(PointToCapture);        
    }
    //return;    
}

exec function EnemyCapturePoint()
{
    local TgRepInfo_TaskForce Taskforce;
    local TgChaosCapturePoint capturePoint, PointToCapture;
    local int otherTaskforce;

    // End:0x24E
    if(TgRepInfo_Game(Outer.WorldInfo.GRI).r_LanePusher == none)
    {
        // End:0x8B
        if(Outer.GetTaskForceNumber() == 1)
        {
            otherTaskforce = 2;            
        }
        else
        {
            otherTaskforce = 1;
        }
        Taskforce = TgRepInfo_Game(Outer.WorldInfo.GRI).GetTaskForce(otherTaskforce);
        Taskforce.r_fSecondaryScore = TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fSecondaryGoalScore;
        // End:0x1EF
        foreach Outer.WorldInfo.DynamicActors(Class'TgGame.TgChaosCapturePoint', capturePoint)
        {
            // End:0x1EE
            if(int(capturePoint.r_eStatus) == int(1))
            {
                PointToCapture = capturePoint;
                // End:0x1EF
                break;
            }            
        }        
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).CheckCorePower(PointToCapture);        
    }
    //return;    
}

exec function ToggleCapturePointOvertime()
{
    local TgGame_PaladinsExtended CSGame;

    CSGame = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x95
    if(CSGame != none)
    {
        CSGame.SetCapturePointOvertimeEnabled(!CSGame.m_bCapturePointContestDurationEnabled);
    }
    //return;    
}

exec function PickPoint(optional int Index = -1)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_nForcedObjectiveIndex = Index;
    //return;    
}

exec function SetSiegeSpeed(float fSpeed)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).SetLanePusherSpeedScale(fSpeed);
    //return;    
}

exec function SetRespawnIncrease(float fIncrease)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fRespawnIncreaseOverTime = fIncrease;
    //return;    
}

exec function SetDefenseRespawn(float fDuration)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fDefenseRespawnIncrease = fDuration;
    //return;    
}

exec function SetAttackRespawn(float fDuration)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fAttackRespawnIncrease = fDuration;
    //return;    
}

exec function SetRespawnCap(float fDuration)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fRespawnTimeCap = fDuration;
    //return;    
}

exec function SetCardCooldownIncrease(float fIncrease)
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_fCardCooldownIncrease = fIncrease;
    //return;    
}

exec function ForceRespawnAll()
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).RespawnAllPlayers(true, true, true, true);
    //return;    
}

exec function SetHealth(int Health)
{
    local TgPawn TgP;

    TgP = TgPawn(Outer.Pawn);
    // End:0x68
    if(TgP != none)
    {
        TgP.SetHealth(Health);
    }
    //return;    
}

exec function SetMana(int mana)
{
    local TgPawn TgP;

    TgP = TgPawn(Outer.Pawn);
    // End:0x6C
    if(TgP != none)
    {
        TgP.SetPropCurrentValue(22, float(mana));
    }
    //return;    
}

exec function DamageHealth(optional int DamageAmount)
{
    // End:0x50
    if(DamageAmount <= 0)
    {
        DamageAmount = Outer.Pawn.Health - 1;
    }
    Outer.Pawn.TakeDamage(DamageAmount, none, Outer.Pawn.Location, vect(0.0000000, 0.0000000, 0.0000000), Class'Engine.DamageType');
    //return;    
}

exec function Heal(optional int HealAmount)
{
    local TgPawn TgP;

    // End:0x1F
    if(HealAmount <= 0)
    {
        HealAmount = 10000;
    }
    TgP = TgPawn(Outer.Pawn);
    // End:0xC5
    if(TgP != none)
    {
        // End:0xC5
        if(TgP.r_EffectManager != none)
        {
            TgP.r_EffectManager.ApplyHealth(HealAmount);
        }
    }
    //return;    
}

exec function DamageTarget(optional int DamageAmount = -1)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local Pawn HitPawn;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    HitPawn = Pawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x14F
    if(HitPawn != none)
    {
        HitPawn.TakeDamage(((DamageAmount > 0) ? DamageAmount : HitPawn.Health - 1), none, HitPawn.Location, vect(0.0000000, 0.0000000, 0.0000000), Class'Engine.DamageType');
    }
    //return;    
}

exec function HealTarget(optional int HealAmount = -1)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn HitPawn;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    HitPawn = TgPawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x13A
    if(HitPawn != none)
    {
        // End:0x13A
        if(HitPawn.r_EffectManager != none)
        {
            HitPawn.r_EffectManager.ApplyHealth(((HealAmount > 0) ? HealAmount : 10000));
        }
    }
    //return;    
}

exec function ShieldTarget(optional int Amount = 1000)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn HitPawn;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    HitPawn = TgPawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x158
    if((HitPawn != none) && HitPawn.r_EffectManager != none)
    {
        HitPawn.SetProperty(HitPawn.GetPropIndex(1598), float(HitPawn.GetPropIndex(1598) + Amount));
    }
    //return;    
}

exec function StopHP5()
{
    local TgPawn TgP;

    TgP = TgPawn(Outer.Pawn);
    // End:0xB2
    if(TgP != none)
    {
        TgP.SetProperty(20, 0.0000000);
        TgP.SetProperty(89, 0.0000000);
        TgP.SetProperty(90, 0.0000000);
    }
    //return;    
}

exec function SkipSetup()
{
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).EndPreRoundSetup();
    //return;    
}

exec function ShowProjectileDebug(bool bEnabled)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_bShowProjectileProximityDistance = bEnabled;
    //return;    
}

exec function DisableProximity(bool bEnabled)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_bDisableProjectileProximityDistance = bEnabled;
    //return;    
}

exec function GiveCard(int nDeviceId)
{
    Outer.ServerGiveCard(nDeviceId);
    //return;    
}

exec function ForceLanePusher()
{
    local TgRepInfo_Game GRI;
    local Actor TargetActor;
    local Vector NewLocation;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x143
    if((GRI != none) && GRI.r_LanePusher != none)
    {
        TargetActor = TgAIController_BehaviorLaneNpc(GRI.r_LanePusher.Controller).LaneMoveTarget;
        // End:0x143
        if(TargetActor != none)
        {
            NewLocation = TargetActor.Location;
            GRI.r_LanePusher.SetLocation(NewLocation);
        }
    }
    //return;    
}

exec function EnableScoring()
{
    local TgGame_PaladinsExtended Game;

    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x76
    if(Game != none)
    {
        Game.m_bScoringEnabled = true;
    }
    //return;    
}

exec function DisableScoring()
{
    local TgGame_PaladinsExtended Game;

    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x76
    if(Game != none)
    {
        Game.m_bScoringEnabled = false;
    }
    //return;    
}

exec function SetScore(optional int tf1Score = 0, optional int tf2Score = 0)
{
    local TgGame_PaladinsExtended Game;

    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x116
    if(Game != none)
    {
        Game.SetScore(1, Game.m_nWinningScore - tf1Score);
        // End:0x116
        if(Game.m_nTF1Score > 0)
        {
            Game.SetScore(2, Game.m_nWinningScore - tf2Score);
        }
    }
    //return;    
}

exec function EndGame()
{
    TgGame_Paladins(Outer.WorldInfo.Game).EndTheGame();
    //return;    
}

exec function HelpMe()
{
    TgInventoryManager(Outer.Pawn.InvManager).ServerSetInventoryDirty();
    //return;    
}

exec function QuickSiege()
{
    local TgPawn_LanePusherBase siege;

    // End:0x72
    foreach Outer.WorldInfo.AllPawns(Class'TgGame.TgPawn_LanePusherBase', siege)
    {
        siege.SetProperty(8, 1000.0000000);        
    }    
    //return;    
}

exec function ReinforceDoors(optional int healthAmt = 20000000)
{
    local TgGame_PaladinsExtended Game;
    local TgPawn_SiegeWall Wall;

    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    Wall = Game.m_TF1InnerWall;
    // End:0xDE
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    Wall = Game.m_TF1OuterWall;
    // End:0x16D
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    Wall = Game.m_TF1BaseObjective;
    // End:0x1FC
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    Wall = Game.m_TF2InnerWall;
    // End:0x28B
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    Wall = Game.m_TF2OuterWall;
    // End:0x31A
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    Wall = Game.m_TF2BaseObjective;
    // End:0x3A9
    if(Wall != none)
    {
        Wall.SetProperty(17, float(healthAmt));
        Wall.SetProperty(19, float(healthAmt));
    }
    //return;    
}

exec function ReinforceSiege(optional int healthAmt = 20000000)
{
    local TgPawn_LanePusherBase siege;

    // End:0xAD
    foreach Outer.WorldInfo.AllPawns(Class'TgGame.TgPawn_LanePusherBase', siege)
    {
        siege.SetProperty(17, float(healthAmt));
        siege.SetProperty(19, float(healthAmt));        
    }    
    //return;    
}

exec function SetGameEnvironmentRule(TgObject.EGameEnvironmentRule Rule)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).SetGameEnvironmentRule(Rule);
    //return;    
}

exec function SetGameRespawnRule(TgObject.EGameRespawnRule Rule)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).SetGameRespawnRule(Rule);
    //return;    
}

exec function SetGameMode(TgObject.EGameMode Mode)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).SetGameMode(Mode);
    TgGame_PaladinsExtended(Outer.WorldInfo.Game).ResetGameMode();
    //return;    
}

exec function SetAirFriction(float frictionAmt)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fGlobalFrictionFlying = frictionAmt;
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fGlobalFrictionFalling = frictionAmt;
    TgRepInfo_Game(Outer.WorldInfo.GRI).bNetDirty = true;
    //return;    
}

exec function SetFallingFriction(float frictionAmt)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fGlobalFrictionFalling = frictionAmt;
    TgRepInfo_Game(Outer.WorldInfo.GRI).bNetDirty = true;
    //return;    
}

exec function SetFlyingFriction(float frictionAmt)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fGlobalFrictionFlying = frictionAmt;
    TgRepInfo_Game(Outer.WorldInfo.GRI).bNetDirty = true;
    //return;    
}

exec function TestSpawnPoints(optional float PauseTime = 3.0000000)
{
    local PlayerStart PS;

    // End:0x69
    foreach Outer.WorldInfo.AllNavigationPoints(Class'Engine.PlayerStart', PS)
    {
        m_DebugPlayerStarts.AddItem(PS);        
    }    
    Outer.SetTimer(PauseTime, true, 'DebugNextPlayerStart');
    //return;    
}

exec function SetInstantFireMeshTrace(bool bEnabled)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    GRI.r_bUseInstantFireMeshTrace = bEnabled;
    Outer.ClientMessage("InstantFire Mesh Trace is:" @ ((GRI.r_bUseInstantFireMeshTrace) ? "ENABLED" : "DISABLED"));
    //return;    
}

exec function ToggleWeaponLagPrediction()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    GRI.r_bAllowWeaponLagPrediction = !GRI.r_bAllowWeaponLagPrediction;
    Outer.ClientMessage("Weapon Lag Prediction is:" @ ((GRI.r_bAllowWeaponLagPrediction) ? "ENABLED" : "DISABLED"));
    //return;    
}

exec function SetMaximumLagPrediction(float NewMaximum)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    GRI.r_fWeaponMaxLagCompensation = NewMaximum;
    Outer.ClientMessage("New Maximum lag prediction is:" @ string(NewMaximum));
    //return;    
}

exec function DumpWeaponPredictionStats()
{
    local string AimValidationStats, InstantFirePredictionStats, ProjectilePredictionStats;

    AimValidationStats = Class'TgGame.TgDevice'.static.GetAimValidationStats();
    InstantFirePredictionStats = Class'TgGame.TgDevice'.static.GetInstantFirePredictionStats();
    ProjectilePredictionStats = Class'TgGame.TgDevice'.static.GetProjectilePredictionStats();
    Outer.ClientMessage("===== Weapon Prediction Stats ====");
    Outer.ClientMessage(AimValidationStats);
    Outer.ClientMessage(InstantFirePredictionStats);
    Outer.ClientMessage(ProjectilePredictionStats);
    //return;    
}

exec function DumpLastServerAims()
{
    local string UsedAimStats;

    UsedAimStats = Class'TgGame.TgDevice'.static.GetLastUsedAimStats();
    Outer.ClientMessage("===== Last Server Aims ====");
    Outer.ClientMessage(UsedAimStats);
    //return;    
}

exec function DumpLastClientAims()
{
    local string UsedAimStats;

    UsedAimStats = Class'TgGame.TgDevice'.static.GetLastUsedAimStats();
    Outer.ClientMessage("===== Last Client Aims ====");
    Outer.ClientMessage(UsedAimStats);
    //return;    
}

exec function SetDamageMultiplier(float NewMult)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fServerFlagDamageMultiplier = NewMult;
    //return;    
}

exec function SetGroundSpeedMultiplier(float NewMult)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fServerFlagGroundSpeedModifier = NewMult;
    //return;    
}

exec function SetAutoHealingMultiplier(float NewMult)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_fServerFlagAutoHealingMultiplier = NewMult;
    //return;    
}

exec function ToggleSiegeEngineRequiresAllies()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x96
    if(GRI != none)
    {
        GRI.r_bSiegeEngineRequiresAlliesToMove = !GRI.r_bSiegeEngineRequiresAlliesToMove;
    }
    //return;    
}

exec function SetVaultImmuneHealth(float fHealth)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x7D
    if(GRI != none)
    {
        GRI.m_fVaultImmuneToSiegeEngineHealth = fHealth;
    }
    //return;    
}

exec function SetVisibilityRanges(optional float fNormal = -1.0000000, optional float fInVolume = -1.0000000)
{
    // End:0x15F
    if(fNormal >= 0.0000000)
    {
        // End:0xC2
        if(TgGame_Paladins(Outer.WorldInfo.Game) != none)
        {
            TgGame_Paladins(Outer.WorldInfo.Game).m_fPlayerViewDistance = fNormal;
        }
        // End:0x15F
        if(TgRepInfo_Game(Outer.WorldInfo.GRI) != none)
        {
            TgRepInfo_Game(Outer.WorldInfo.GRI).r_fPlayerViewDistance = fNormal;
        }
    }
    // End:0x2AC
    if(fInVolume >= 0.0000000)
    {
        // End:0x20F
        if(TgGame_Paladins(Outer.WorldInfo.Game) != none)
        {
            TgGame_Paladins(Outer.WorldInfo.Game).m_fVisibilityVolumeViewDistance = fInVolume;
        }
        // End:0x2AC
        if(TgRepInfo_Game(Outer.WorldInfo.GRI) != none)
        {
            TgRepInfo_Game(Outer.WorldInfo.GRI).r_fVisibilityVolumeViewDistance = fInVolume;
        }
    }
    //return;    
}

exec function ForceRoundSetupEnd()
{
    local TgGame_Mission mission;

    // End:0x94
    if(TgGame_Paladins(Outer.WorldInfo.Game) != none)
    {
        TgGame_Paladins(Outer.WorldInfo.Game).StartMatch();
    }
    // End:0x299
    if(TgGame_PaladinsExtended(Outer.WorldInfo.Game) != none)
    {
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'PickNextObjective');
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).ClearTimer('ResetAllPlayersNotInSpawnRoom');
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).ClearTimer('ResetAttackersNotInSpawnRoom');
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).ClearTimer('ResetDefendersNotInSpawnRoom');
        TgGame_PaladinsExtended(Outer.WorldInfo.Game).m_bResetPlayersNotInSpawnRoomDisabled = true;
    }
    // End:0x44A
    if(TgGame_Paladins_Payload(Outer.WorldInfo.Game) != none)
    {
        TgGame_Paladins_Payload(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'OpenAttackersSpawnGates');
        TgGame_Paladins_Payload(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'OpenDefendersSpawnGates');
        TgGame_Paladins_Payload(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'AutoMountAttackers');
        TgGame_Paladins_Payload(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'AutoMountDefenders');        
    }
    else
    {
        // End:0x545
        if(TgGame_Paladins_Siege(Outer.WorldInfo.Game) != none)
        {
            TgGame_Paladins_Siege(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'OpenSpawnGates');
            TgGame_Paladins_Siege(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'AutoMountAllPlayers');            
        }
        else
        {
            // End:0x640
            if(TgGame_Paladins_TeamDeathMatch(Outer.WorldInfo.Game) != none)
            {
                TgGame_Paladins_TeamDeathMatch(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'OpenSpawnGates');
                TgGame_Paladins_TeamDeathMatch(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'AutoMountAllPlayers');                
            }
            else
            {
                // End:0x6DD
                if(TgGame_PaladinsExtended(Outer.WorldInfo.Game) != none)
                {
                    TgGame_PaladinsExtended(Outer.WorldInfo.Game).SetTimer(0.5000000, false, 'AutoMountAllPlayers');
                }
            }
        }
    }
    mission = TgGame_Mission(Outer.WorldInfo.Game);
    // End:0x7C4
    if((mission != none) && int(mission.m_eTimerState) <= int(2))
    {
        // End:0x7A5
        if(int(mission.m_eTimerState) == int(1))
        {
            mission.AllPlayersReady();
        }
        mission.MissionTimer();
    }
    //return;    
}

exec function FRSE()
{
    ForceRoundSetupEnd();
    //return;    
}

exec function LevelAim()
{
    local Controller Controller;
    local Rotator NewRot;

    Controller = Outer.GetALocalPlayerController();
    // End:0x315
    if(Controller != none)
    {
        NewRot = Controller.Rotation;
        NewRot.Pitch = 0;
        J0x7E:

        // End:0xCA [Loop If]
        if(NewRot.Yaw > 65535)
        {
            NewRot.Yaw -= 65536;
            // [Loop Continue]
            goto J0x7E;
        }
        J0xCA:

        // End:0x112 [Loop If]
        if(NewRot.Yaw < 0)
        {
            NewRot.Yaw += 65536;
            // [Loop Continue]
            goto J0xCA;
        }
        // End:0x17D
        if((NewRot.Yaw > 0) && NewRot.Yaw < 8192)
        {
            NewRot.Yaw = 0;            
        }
        else
        {
            // End:0x1F0
            if((NewRot.Yaw >= 8192) && NewRot.Yaw < 24576)
            {
                NewRot.Yaw = 16384;                
            }
            else
            {
                // End:0x263
                if((NewRot.Yaw >= 24576) && NewRot.Yaw < 40960)
                {
                    NewRot.Yaw = 32768;                    
                }
                else
                {
                    // End:0x2D6
                    if((NewRot.Yaw >= 40960) && NewRot.Yaw < 57344)
                    {
                        NewRot.Yaw = 49152;                        
                    }
                    else
                    {
                        NewRot.Yaw = 0;
                    }
                }
            }
        }
        Controller.SetRotation(NewRot);
    }
    //return;    
}

exec function Set1p(optional bool bForce1P = true)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x86
    if(GRI != none)
    {
        GRI.r_bForce3P = !bForce1P;
    }
    //return;    
}

exec function Set3p(optional bool bForce3P = true)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x84
    if(GRI != none)
    {
        GRI.r_bForce3P = bForce3P;
    }
    //return;    
}

exec function Toggle3p()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x96
    if(GRI != none)
    {
        GRI.r_bForce3P = !GRI.r_bForce3P;
    }
    //return;    
}

exec function GainXP(int xpAmount)
{
    Outer.SetRewardValues(xpAmount, 0, Outer.Pawn, 19);
    //return;    
}

exec function GainCredits(int creditsAmount)
{
    local TgGame_Paladins ChaosGame;

    ChaosGame = TgGame_Paladins(Outer.WorldInfo.Game);
    // End:0x8F
    if(ChaosGame != none)
    {
        ChaosGame.GiveCredits(TgPaladinsController(Outer), creditsAmount);
    }
    //return;    
}

exec function GainTickets(int ticketsAmount)
{
    local TgGame_PaladinsExtended ChaosGame;

    ChaosGame = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0xA0
    if(ChaosGame != none)
    {
        ChaosGame.GainTickets(Outer.GetTaskForceNumber(), float(ticketsAmount), 7);
    }
    //return;    
}

exec function EndRound(optional int nTaskForce = 0)
{
    local TgGame_Paladins_Siege Cap;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce Taskforce;
    local bool bEndRound;
    local TgObjective Objective;

    // End:0x3D
    if(nTaskForce == 0)
    {
        nTaskForce = Outer.GetTaskForceNumber();
    }
    Cap = TgGame_Paladins_Siege(Outer.WorldInfo.Game);
    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x3BC
    if(Cap != none)
    {
        bEndRound = true;
        // End:0x11D
        if(GRI != none)
        {
            GRI.r_nLastRoundWinner = byte(nTaskForce);
        }
        // End:0x207
        if((nTaskForce == 1) || nTaskForce == 2)
        {
            Cap.GainPoints(nTaskForce, Cap.m_nPointsForPayload, 3);
            // End:0x207
            if(GRI != none)
            {
                Taskforce = GRI.GetTaskForce(nTaskForce);
                // End:0x207
                if(Taskforce != none)
                {
                    // End:0x207
                    if(Taskforce.r_nScore <= 0)
                    {
                        bEndRound = false;
                    }
                }
            }
        }
        // End:0x3BC
        if(bEndRound)
        {
            GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
            // End:0x39D
            if(GRI != none)
            {
                // End:0x2F8
                if(int(GRI.r_GameMode) == int(0))
                {
                    // End:0x2F7
                    foreach Outer.WorldInfo.DynamicActors(Class'TgGame.TgObjective', Objective)
                    {
                        Objective.SetStatus(0);                        
                    }                    
                }
                // End:0x39D
                if(!Cap.IsInState('AttackDefend'))
                {
                    Cap.StartNewObjectiveRound(false);
                    Cap.StartBroadcastTimer();
                    Cap.ResetScores();
                    GRI.UpdateAttackingTaskforce(none);
                }
            }
            Cap.OnRoundEnded();
        }
    }
    //return;    
}

exec function OpenSpawnGates()
{
    local TgGame_PaladinsExtended Game;

    Game = TgGame_Paladins_Payload(Outer.WorldInfo.Game);
    // End:0x7F
    if(Game != none)
    {
        TgGame_Paladins_Payload(Game).OpenAttackersSpawnGates();
        return;
    }
    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0xF3
    if(Game != none)
    {
        Game.OpenSpawnGates();
    }
    //return;    
}

exec function CloseSpawnGates()
{
    local TgGame_PaladinsExtended Game;

    Game = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x74
    if(Game != none)
    {
        Game.CloseSpawnGates();
    }
    //return;    
}

exec function SetCAPOvertime(float overtimeDuration, optional float overtimeWarning = -1.0000000)
{
    local TgGame_Paladins_Siege Cap;

    Cap = TgGame_Paladins_Siege(Outer.WorldInfo.Game);
    // End:0x8F
    if(Cap != none)
    {
        Cap.SetOvertime(overtimeDuration, overtimeWarning);
    }
    //return;    
}

exec function PayloadForever()
{
    //return;    
}

exec function SetAIAccuracy(float DegreeMissed, float MissLikelihood)
{
    local TgPawn P;
    local TgAIController_Behavior behavior_ai;

    P = TgPawn(Outer.m_aHoverActor);
    // End:0xD0
    if(P != none)
    {
        behavior_ai = TgAIController_Behavior(P.Controller);
        // End:0xD0
        if(behavior_ai != none)
        {
            behavior_ai.m_fMissLikelihood = MissLikelihood;
            behavior_ai.m_fDegreeMissedMagnitude = DegreeMissed;
        }
    }
    //return;    
}

exec function EnableThreat(bool bEnabled)
{
    TgPlayerController(Outer.GetALocalPlayerController()).m_bThreatSystemEnabled = bEnabled;
    //return;    
}

exec function EnableOcclusion(bool bEnabled)
{
    local Actor A;

    TgPlayerController(Outer.GetALocalPlayerController()).m_bOcclusionSystemEnabled = bEnabled;
    // End:0xC1
    if(!bEnabled)
    {
        // End:0xC0
        foreach Outer.WorldInfo.DynamicActors(Class'Engine.Actor', A)
        {
            A.m_fOcclusionAmount = 0.0000000;            
        }        
    }
    //return;    
}

exec function DisplayThreatParams()
{
    local TgPlayerController PPC;

    PPC = TgPlayerController(Outer.GetALocalPlayerController());
    // End:0x61
    if(PPC.m_DebugThreatSystemChannel == "damaged")
    {        
    }
    else
    {
        // End:0x91
        if(PPC.m_DebugThreatSystemChannel == "distance")
        {            
        }
        else
        {
            // End:0xC2
            if(PPC.m_DebugThreatSystemChannel == "occlusion")
            {                
            }
            else
            {
                // End:0xF0
                if(PPC.m_DebugThreatSystemChannel == "seenby")
                {                    
                }
                else
                {
                    // End:0x11E
                    if(PPC.m_DebugThreatSystemChannel == "shotat")
                    {                        
                    }
                    else
                    {
                        // End:0x151
                        if(PPC.m_DebugThreatSystemChannel == "sizeofenemy")
                        {                            
                        }
                        else
                        {
                            // End:0x184
                            if(PPC.m_DebugThreatSystemChannel == "sizetoenemy")
                            {                                
                            }
                            else
                            {
                                // End:0x1AF
                                if(PPC.m_DebugThreatSystemChannel == "ult")
                                {                                    
                                }
                                else
                                {
                                    // End:0x1DD
                                    if(PPC.m_DebugThreatSystemChannel == "behind")
                                    {                                        
                                    }
                                    else
                                    {
                                        // End:0x21A
                                        if(InStr(PPC.m_DebugThreatSystemChannel, "binnedocclu") != -1)
                                        {                                            
                                        }
                                        else
                                        {
                                            // End:0x251
                                            if(InStr(PPC.m_DebugThreatSystemChannel, "ineff") != -1)
                                            {                                                
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    //return;    
}

exec function ShowThreats(bool bEnabled, optional string ChannelName)
{
    TgPlayerController(Outer.GetALocalPlayerController()).m_bDebugThreatSystem = bEnabled;
    TgPlayerController(Outer.GetALocalPlayerController()).m_DebugThreatSystemChannel = Locs(ChannelName);
    // End:0xB3
    if(ChannelName != "levels")
    {
        DisplayThreatParams();
    }
    //return;    
}

exec function AllNoah(optional string ChannelName)
{
    Outer.ConsoleCommand("DisplayClear");
    // End:0x9F
    if(ChannelName == "")
    {        
        Outer.ConsoleCommand("DisplayAll tgpawn c_flastthreatlevelvalue");        
    }
    else
    {
        // End:0xB8
        if(ChannelName == "levels")
        {            
        }
        else
        {            
            Outer.ConsoleCommand("DisplayAll tgpawn c_fthreat" $ ChannelName);
        }
    }
    ShowThreats(true, ChannelName);
    //return;    
}

exec function AllowHeadShots(optional bool bEnable = true)
{
    local TgGame Game;

    Game = TgGame(Outer.WorldInfo.Game);
    // End:0x83
    if(Game != none)
    {
        Game.SetEnableHeadshots(bEnable);
    }
    //return;    
}

exec function LiveRespawn(optional bool bResetHealth = true, optional bool bResetDevices = true)
{
    // End:0x4C
    if(Outer != none)
    {
        Outer.LiveRespawn(bResetHealth, bResetDevices);
    }
    //return;    
}

exec function SetBodyMesh(int nBodyMeshID)
{
    local TgPawn TgP;

    // End:0xF6
    if(nBodyMeshID > 0)
    {
        TgP = TgPawn(Outer.Pawn);
        // End:0xF3
        if(TgP != none)
        {
            TgP.r_nBodyMeshOverride = nBodyMeshID;
            // End:0xF3
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TgP.ReloadMeshAssemblies();
                TgP.SwapToLiveMesh();
            }
        }        
    }
    //return;    
}

exec function SBM(int nBodyMeshID)
{
    SetBodyMesh(nBodyMeshID);
    //return;    
}

exec function SetBodyMeshByName()
{
    //return;    
}

exec function SBMBN()
{
    SetBodyMeshByName();
    //return;    
}

exec function SetHeadMesh(int nHeadMeshID)
{
    local TgPawn_Character TgPC;

    // End:0xD7
    if(nHeadMeshID > 0)
    {
        TgPC = TgPawn_Character(Outer.Pawn);
        // End:0xD4
        if(TgPC != none)
        {
            TgPC.r_nHeadMeshOverride = nHeadMeshID;
            // End:0xD4
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TgPC.ShowHeadMesh();
            }
        }        
    }
    //return;    
}

exec function SHM(int nHeadMeshID)
{
    SetHeadMesh(nHeadMeshID);
    //return;    
}

exec function SetHeadMeshByName()
{
    //return;    
}

exec function SHBN()
{
    SetHeadMeshByName();
    //return;    
}

exec function RemoveHeadMesh()
{
    local TgPawn_Character TgPC;

    TgPC = TgPawn_Character(Outer.Pawn);
    // End:0xC1
    if(TgPC != none)
    {
        TgPC.r_nHeadMeshOverride = -1;
        // End:0xC1
        if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
        {
            TgPC.ShowHeadMesh();
        }
    }
    //return;    
}

exec function rhm()
{
    RemoveHeadMesh();
    //return;    
}

exec function decapitate()
{
    RemoveHeadMesh();
    //return;    
}

exec function EnableHeadMesh(bool bEnabled)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x141
    if(GRI != none)
    {
        GRI.r_bShowHeadMesh = bEnabled;
        GRI.bNetDirty = true;
        // End:0x141
        if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
        {
            // End:0x122
            if(GRI.r_bShowHeadMesh)
            {
                GRI.ShowHeadMesh();                
            }
            else
            {
                GRI.HideHeadMesh();
            }
        }
    }
    //return;    
}

exec function ToggleHeadMesh()
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x158
    if(GRI != none)
    {
        GRI.r_bShowHeadMesh = !GRI.r_bShowHeadMesh;
        GRI.bNetDirty = true;
        // End:0x158
        if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
        {
            // End:0x139
            if(GRI.r_bShowHeadMesh)
            {
                GRI.ShowHeadMesh();                
            }
            else
            {
                GRI.HideHeadMesh();
            }
        }
    }
    //return;    
}

exec function TargetSetMeshes(int nBodyMeshID, optional int nHeadMeshID = 0)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn TargetPawn;
    local TgPawn_Character TargetPawnCharacter;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    TargetPawn = TgPawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x21D
    if(TargetPawn != none)
    {
        // End:0x16D
        if(nBodyMeshID > 0)
        {
            TargetPawn.r_nBodyMeshOverride = nBodyMeshID;
            // End:0x16D
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TargetPawn.ReloadMeshAssemblies();
                TargetPawn.SwapToLiveMesh();
            }
        }
        TargetPawnCharacter = TgPawn_Character(TargetPawn);
        // End:0x21D
        if(TargetPawnCharacter != none)
        {
            TargetPawnCharacter.r_nHeadMeshOverride = nHeadMeshID;
            // End:0x21D
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TargetPawnCharacter.ShowHeadMesh();
            }
        }
    }
    //return;    
}

exec function TSM(int nBodyMeshID, optional int nHeadMeshID = 0)
{
    TargetSetMeshes(nBodyMeshID, nHeadMeshID);
    //return;    
}

exec function TargetSetBodyMesh(int nBodyMeshID)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn TargetPawn;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    TargetPawn = TgPawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x16B
    if(TargetPawn != none)
    {
        // End:0x16B
        if(nBodyMeshID >= 0)
        {
            TargetPawn.r_nBodyMeshOverride = nBodyMeshID;
            // End:0x168
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TargetPawn.ReloadMeshAssemblies();
                TargetPawn.SwapToLiveMesh();
            }            
        }
    }
    //return;    
}

exec function TSBM(int nBodyMeshID)
{
    TargetSetBodyMesh(nBodyMeshID);
    //return;    
}

exec function TargetSetHeadMesh(int nHeadMeshID)
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local TgPawn_Character TargetPawnCharacter;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    TargetPawnCharacter = TgPawn_Character(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x14C
    if(TargetPawnCharacter != none)
    {
        // End:0x14C
        if(nHeadMeshID >= 0)
        {
            TargetPawnCharacter.r_nHeadMeshOverride = nHeadMeshID;
            // End:0x149
            if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
            {
                TargetPawnCharacter.ShowHeadMesh();
            }            
        }
    }
    //return;    
}

exec function TSHM(int nHeadMeshID)
{
    TargetSetHeadMesh(nHeadMeshID);
    //return;    
}

exec function AllowMount(optional bool bEnabled = true)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_bAllowPlayerMounting = bEnabled;
    //return;    
}

exec function PlayPotG()
{
    local TgPlayerController PC;

    // End:0xAF
    foreach Outer.WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
    {
        // End:0xAE
        if(PC.bIsPlayer && PC.IsLocalPlayerController())
        {
            PC.ClientDebugPlayPotg();
        }        
    }    
    //return;    
}

exec function PlayPotGForAll()
{
    local TgPlayerController PC;

    // End:0x8B
    foreach Outer.WorldInfo.AllControllers(Class'TgGame.TgPlayerController', PC)
    {
        // End:0x8A
        if(PC.bIsPlayer)
        {
            PC.ClientDebugPlayPotg();
        }        
    }    
    Outer.SetTimer(0.1000000, false, 'DebugDisableAllAI');
    Outer.SetTimer(25.0000000, false, 'DebugEnableAllAI');
    //return;    
}

exec function ResetPotG()
{
    TgGame(Outer.WorldInfo.Game).ResetPlayOfTheGame();
    //return;    
}

exec function LockPotG(bool bLocked)
{
    TgGame(Outer.WorldInfo.Game).LockPlayOfTheGame(bLocked);
    //return;    
}

exec function EnableAI(bool bEnabled)
{
    // End:0x38
    if(bEnabled)
    {
        Outer.SetTimer(0.1000000, false, 'DebugEnableAllAI');        
    }
    else
    {
        Outer.SetTimer(0.1000000, false, 'DebugDisableAllAI');
    }
    //return;    
}

exec function KillProjectiles()
{
    local TgGame_PaladinsExtended ChaosSiege;

    ChaosSiege = TgGame_PaladinsExtended(Outer.WorldInfo.Game);
    // End:0x74
    if(ChaosSiege != none)
    {
        ChaosSiege.KillAllProjectiles();
    }
    //return;    
}

exec function ToggleAIDifficultyAdjust()
{
    local TgGame_Paladins ChaosGame;

    ChaosGame = TgGame_Paladins(Outer.WorldInfo.Game);
    // End:0xE6
    if((ChaosGame != none) && ChaosGame.AIDirector != none)
    {
        ChaosGame.AIDirector.m_bFreezeAIDifficulty = !ChaosGame.AIDirector.m_bFreezeAIDifficulty;
    }
    //return;    
}

exec function EnableGhostMounting(bool bEnabled)
{
    TgRepInfo_Game(Outer.WorldInfo.GRI).r_bGhostMountingEnabled = bEnabled;
    TgRepInfo_Game(Outer.WorldInfo.GRI).bNetDirty = true;
    //return;    
}

exec function StopFog()
{
    local TgGame_Paladins_Survival Survival;
    local TgChaosCapturePoint Point;

    Survival = TgGame_Paladins_Survival(Outer.WorldInfo.Game);
    // End:0x127
    if(Survival != none)
    {
        Survival.ClearTimer('StartFogConverging');
        Survival.ClearTimer('ConvergeFog');
        Survival.ClearTimer('ResumeConvergeCompletely');
        Point = Survival.m_LastActiveCapturePoint;
        // End:0x127
        if(Point != none)
        {
            Point.SetFogActive(false);
        }
    }
    //return;    
}

exec function ResumeFog()
{
    local TgGame_Paladins_Survival Survival;
    local TgChaosCapturePoint Point;
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    Survival = TgGame_Paladins_Survival(Outer.WorldInfo.Game);
    // End:0x144
    if((Survival != none) && GRI != none)
    {
        Survival.SetTimer(GRI.r_fFogConvergeInterval, true, 'ConvergeFog');
        Point = Survival.m_LastActiveCapturePoint;
        // End:0x144
        if(Point != none)
        {
            Point.SetFogActive(true);
        }
    }
    //return;    
}

exec function SetFogDistance(int Distance)
{
    local TgRepInfo_Game GRI;

    GRI = TgRepInfo_Game(Outer.WorldInfo.GRI);
    // End:0x7F
    if(GRI != none)
    {
        GRI.r_fConvergeDistance = float(Distance);
    }
    //return;    
}

exec function PlayIntroAnim()
{
    TgPlayerController(Outer.GetALocalPlayerController()).ClientPlayIntro();
    //return;    
}

exec function SetMountSkin(int nSkinId)
{
    local TgPawn_Character TgP;

    TgP = TgPawn_Character(Outer.Pawn);
    // End:0x87
    if(TgP != none)
    {
        TgP.r_nMountSkinId = nSkinId;
        TgP.ApplyPawnSetup();
    }
    //return;    
}

exec function toggleDiminishingReturns()
{
    local TgGame_Paladins PaladinsGame;

    PaladinsGame = TgGame_Paladins(Outer.WorldInfo.Game);
    // End:0x96
    if(PaladinsGame != none)
    {
        PaladinsGame.m_bDiminishingReturnsOnCCEnabled = !PaladinsGame.m_bDiminishingReturnsOnCCEnabled;
    }
    //return;    
}

defaultproperties
{
    DebugCameraControllerClassName="TgGame.TgDebugCameraController"
}