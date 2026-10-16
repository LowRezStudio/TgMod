class TgSpawnTeleporterEntrance extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

const ENEMY_DISTANCE_RADIUS = 800.0f;

struct native ExitInfo
{
    var TgSpawnTeleporterExit Exit;
    var float Rating;
    var bool bEnemyHasLOS;
    var bool bIsOpenSpot;

    structdefaultproperties
    {
        Exit=none
        Rating=999999.0000000
        bEnemyHasLOS=false
        bIsOpenSpot=false
    }
};

var() bool bEnabled;

static function int CompareExitInfo(ExitInfo EI1, ExitInfo EI2)
{
    // End:0x6B
    if(EI1.bEnemyHasLOS != EI2.bEnemyHasLOS)
    {
        return ((EI1.bEnemyHasLOS) ? -1 : 1);        
    }
    else
    {
        // End:0xD6
        if(EI1.bIsOpenSpot != EI2.bIsOpenSpot)
        {
            return ((EI1.bIsOpenSpot) ? 1 : -1);            
        }
        else
        {
            // End:0x118
            if(EI1.Rating > EI2.Rating)
            {
                return 1;                
            }
            else
            {
                // End:0x15E
                if(EI1.Rating < EI2.Rating)
                {
                    return -1;                    
                }
                else
                {
                    // End:0x1A9
                    if((EI2.Exit == none) || EI1.Exit == none)
                    {
                        return 0;                        
                    }
                    else
                    {
                        // End:0x215
                        if(EI1.Exit.nPriority > EI2.Exit.nPriority)
                        {
                            return 1;                            
                        }
                        else
                        {
                            // End:0x282
                            if(EI1.Exit.nPriority < EI2.Exit.nPriority)
                            {
                                return -1;
                            }
                        }
                    }
                }
            }
        }
    }
    return 0;
    //return ReturnValue;    
}

static function bool CanTeleport(Actor Other)
{
    return (Other != none) && TgPawn_Character(Other) != none;
    //return ReturnValue;    
}

static function ExitInfo FindExit(TgPawn TgP, out array<TgSpawnTeleporterExit> Exits)
{
    local array<TgRepInfo_Player> EnemyPRIs;
    local array<ExitInfo> ExitData;
    local TgRepInfo_Game GRI;
    local TgRepInfo_TaskForce EnemyTF;
    local TgRepInfo_Player EnemyPRI;
    local ExitInfo CurrentExitData;
    local TgSpawnTeleporterExit CurrentExit;
    local int FriendlyTF;
    local float fDistanceFromExit;

    // End:0x4C4
    if((TgP != none) && TgP.WorldInfo != none)
    {
        FriendlyTF = int(TgP.GetTaskForceNumber());
        GRI = TgRepInfo_Game(TgP.WorldInfo.GRI);
        // End:0x4C4
        if(GRI != none)
        {
            EnemyTF = GRI.GetTaskForce(((FriendlyTF == 1) ? 2 : 1));
            // End:0x4C4
            if(EnemyTF != none)
            {
                EnemyTF.GetPlayers(EnemyPRIs);
                // End:0x2CE
                foreach Exits(CurrentExit)
                {
                    // End:0x154
                    if(CurrentExit == none)
                    {
                        continue;                        
                    }
                    else
                    {
                        CurrentExitData.Exit = CurrentExit;
                        CurrentExitData.Rating = 0.0000000;
                        CurrentExitData.bEnemyHasLOS = false;
                        // End:0x2B6
                        foreach EnemyPRIs(EnemyPRI)
                        {
                            // End:0x21C
                            if(EnemyPRI.r_PawnOwner == none)
                            {
                                CurrentExitData.Rating += 800.0000000;                                
                            }
                            else
                            {
                                fDistanceFromExit = VSize2D(EnemyPRI.r_PawnOwner.Location - CurrentExit.Location);
                                CurrentExitData.Rating += float(Min(int(fDistanceFromExit), 800));
                            }                            
                        }                        
                        ExitData.AddItem(CurrentExitData);                        
                    }
                }                
                ExitData.Sort(CompareExitInfo);
                // End:0x461
                foreach ExitData(CurrentExitData)
                {
                    // End:0x3B7
                    foreach EnemyPRIs(EnemyPRI)
                    {
                        // End:0x3B6
                        if((EnemyPRI.r_PawnOwner != none) && EnemyPRI.r_PawnOwner.LineOfSightTo(CurrentExitData.Exit))
                        {
                            CurrentExitData.bEnemyHasLOS = true;                            
                        }
                        else
                        {                            
                        }
                    }                    
                    // End:0x460
                    if(!CurrentExitData.bEnemyHasLOS)
                    {
                        CurrentExitData.bIsOpenSpot = !CurrentExitData.Exit.HasRoomForPawn(TgP);
                        // End:0x460
                        if(CurrentExitData.bIsOpenSpot)
                        {                            
                            return CurrentExitData;
                        }
                    }                    
                }                
                // End:0x4A7
                foreach ExitData(CurrentExitData)
                {
                    // End:0x4A6
                    if(!CurrentExitData.bEnemyHasLOS)
                    {                        
                        return CurrentExitData;
                    }                    
                }                
                // End:0x4C4
                if(ExitData.Length > 0)
                {
                    return ExitData[0];
                }
            }
        }
    }
    CurrentExitData.Exit = none;
    CurrentExitData.bEnemyHasLOS = true;
    CurrentExitData.Rating = 999999.0000000;
    return CurrentExitData;
    //return ReturnValue;    
}

static function TeleportToExit(TgPawn TgP, TgSpawnTeleporterEntrance From, ExitInfo To)
{
    local Vector OriginalActorLocation;
    local Rotator DesiredRotation, AppliedRotation;

    // End:0x279
    if((TgP != none) && To.Exit != none)
    {
        OriginalActorLocation = TgP.Location;
        TgP.SetLocation(To.Exit.Location);
        DesiredRotation = TgP.Rotation;
        DesiredRotation.Yaw = To.Exit.Rotation.Yaw;
        AppliedRotation = DesiredRotation - TgP.Rotation;
        TgP.Velocity = QuatRotateVector(QuatFromRotator(AppliedRotation), TgP.Velocity);
        TgP.SetRotation(DesiredRotation);
        TgP.ClientSetRotation(DesiredRotation);
        TgP.SetViewRotation(DesiredRotation);
        TgP.PawnOnTeleported(From, To.Exit, OriginalActorLocation);
    }
    //return;    
}

simulated function Touch(Actor WantsTeleport, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local ExitInfo Exit;
    local TgGame TgG;
    local array<TgSpawnTeleporterExit> ValidExits;
    local TgPawn TgP;

    super(Actor).Touch(WantsTeleport, OtherComp, HitLocation, HitNormal);
    // End:0x14F
    if((bEnabled && int(Role) == int(ROLE_Authority)) && CanTeleport(WantsTeleport))
    {
        TgP = TgPawn(WantsTeleport);
        TgG = TgGame(WorldInfo.Game);
        // End:0x14F
        if(((TgG != none) && TgP != none) && TgG.FindValidSpawnPoints(TgP, ValidExits))
        {
            Exit = FindExit(TgP, ValidExits);
            TeleportToExit(TgP, self, Exit);
        }
    }
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    super.OnToggle(Action);
    // End:0x59
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x9F
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xEE
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    //return;    
}

defaultproperties
{
    bEnabled=true
    // Reference: BrushComponent'TgGame.Default__TgSpawnTeleporterEntrance.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    Components[1]=none
    bStatic=false
    CollisionComponent=BrushComponent0
}