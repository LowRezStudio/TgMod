class CheatManager extends Object within PlayerController
    native;

var const localized string ViewingFrom;
var const localized string OwnCamera;

exec function FXPlay(Class<Pawn> aClass, string FXAnimPath)
{
    local Pawn P, ClosestPawn;
    local float ThisDistance, ClosestPawnDistance;
    local string FxAnimGroup, FxAnimName;
    local int dotPos;

    // End:0x2A2
    if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
    {
        ClosestPawn = none;
        ClosestPawnDistance = 10000000.0000000;
        // End:0x1BA
        foreach Outer.DynamicActors(Class'Engine.Pawn', P)
        {
            // End:0x1B9
            if(ClassIsChildOf(P.Class, aClass) && P != PlayerController(Outer.Owner).Pawn)
            {
                ThisDistance = VSize(P.Location - PlayerController(Outer.Owner).Pawn.Location);
                // End:0x1B9
                if(ThisDistance < ClosestPawnDistance)
                {
                    ClosestPawn = P;
                    ClosestPawnDistance = ThisDistance;
                }
            }            
        }        
        // End:0x2A2
        if(ClosestPawn.Mesh != none)
        {
            dotPos = InStr(FXAnimPath, ".");
            // End:0x2A2
            if(dotPos != -1)
            {
                FxAnimGroup = Left(FXAnimPath, dotPos);
                FxAnimName = Right(FXAnimPath, (Len(FXAnimPath) - dotPos) - 1);
                ClosestPawn.Mesh.PlayFaceFXAnim(none, FxAnimName, FxAnimGroup, none, none);
            }
        }
    }
    //return;    
}

exec function FXStop(Class<Pawn> aClass)
{
    local Pawn P, ClosestPawn;
    local float ThisDistance, ClosestPawnDistance;

    // End:0x213
    if(int(Outer.WorldInfo.NetMode) == int(NM_Standalone))
    {
        ClosestPawn = none;
        ClosestPawnDistance = 10000000.0000000;
        // End:0x1BA
        foreach Outer.DynamicActors(Class'Engine.Pawn', P)
        {
            // End:0x1B9
            if(ClassIsChildOf(P.Class, aClass) && P != PlayerController(Outer.Owner).Pawn)
            {
                ThisDistance = VSize(P.Location - PlayerController(Outer.Owner).Pawn.Location);
                // End:0x1B9
                if(ThisDistance < ClosestPawnDistance)
                {
                    ClosestPawn = P;
                    ClosestPawnDistance = ThisDistance;
                }
            }            
        }        
        // End:0x213
        if(ClosestPawn.Mesh != none)
        {
            ClosestPawn.Mesh.StopFaceFXAnim();
        }
    }
    //return;    
}

exec function DebugAI(coerce optional name Category)
{
    //return;    
}

exec function EditAIByTrace()
{
    local Vector CamLoc;
    local Rotator CamRot;
    local Vector HitLocation, HitNormal;
    local Pawn HitPawn;
    local Controller C;

    Outer.GetPlayerViewPoint(CamLoc, CamRot);
    HitPawn = Pawn(Outer.Trace(HitLocation, HitNormal, CamLoc + (Vector(CamRot) * float(10000)), CamLoc, true, vect(10.0000000, 10.0000000, 10.0000000)));
    // End:0x1BA
    if(HitPawn != none)
    {
        C = HitPawn.Controller;
        // End:0x14F
        if((C == none) && HitPawn.DrivenVehicle != none)
        {
            C = HitPawn.DrivenVehicle.Controller;
        }
        // End:0x1BA
        if(C != none)
        {            
            Outer.ConsoleCommand("EDITACTOR NAME=" $ string(C.Name), true);
        }
    }
    //return;    
}

exec function DebugPause()
{
    Outer.WorldInfo.Game.DebugPause();
    //return;    
}

exec function ListDynamicActors()
{
    //return;    
}

exec function FreezeFrame(float Delay)
{
    Outer.WorldInfo.Game.SetPause(Outer, Outer.CanUnpause);
    Outer.WorldInfo.PauseDelay = Outer.WorldInfo.TimeSeconds + Delay;
    //return;    
}

exec function WriteToLog(string Param)
{
    //return;    
}

exec function KillViewedActor()
{
    // End:0x12E
    if(Outer.ViewTarget != none)
    {
        // End:0xE0
        if((Pawn(Outer.ViewTarget) != none) && Pawn(Outer.ViewTarget).Controller != none)
        {
            Pawn(Outer.ViewTarget).Controller.Destroy();
        }
        Outer.ViewTarget.Destroy();
        Outer.SetViewTarget(none);
    }
    //return;    
}

exec function Teleport()
{
    local Actor HitActor;
    local Vector HitNormal, HitLocation, ViewLocation;
    local Rotator ViewRotation;

    Outer.GetPlayerViewPoint(ViewLocation, ViewRotation);
    HitActor = Outer.Trace(HitLocation, HitNormal, ViewLocation + (float(1000000) * Vector(ViewRotation)), ViewLocation, true);
    // End:0xBB
    if(HitActor != none)
    {
        HitLocation += (HitNormal * 4.0000000);
    }
    Outer.ViewTarget.SetLocation(HitLocation);
    //return;    
}

exec function ChangeSize(float F)
{
    Outer.Pawn.CylinderComponent.SetCylinderSize(Outer.Pawn.default.CylinderComponent.CollisionRadius * F, Outer.Pawn.default.CylinderComponent.CollisionHeight * F);
    Outer.Pawn.SetDrawScale(F);
    Outer.Pawn.SetLocation(Outer.Pawn.Location);
    //return;    
}

exec function EndPath()
{
    //return;    
}

exec function Amphibious()
{
    Outer.Pawn.UnderWaterTime = 999999.0000000;
    //return;    
}

exec function Fly()
{
    // End:0xD9
    if((Outer.Pawn != none) && Outer.Pawn.CheatFly())
    {
        Outer.ClientMessage("You feel much lighter");
        Outer.bCheatFlying = true;
        Outer.GotoState('PlayerFlying');
    }
    //return;    
}

exec function Walk()
{
    Outer.bCheatFlying = false;
    // End:0x9E
    if((Outer.Pawn != none) && Outer.Pawn.CheatWalk())
    {
        Outer.Restart(false);
    }
    //return;    
}

exec function Ghost()
{
    // End:0xA4
    if((Outer.Pawn != none) && Outer.Pawn.CheatGhost())
    {
        Outer.bCheatFlying = true;
        Outer.GotoState('PlayerFlying');        
    }
    else
    {
        Outer.bCollideWorld = false;
    }
    Outer.ClientMessage("You feel ethereal");
    //return;    
}

exec function AllAmmo()
{
    //return;    
}

exec function God()
{
    // End:0x74
    if(Outer.bGodMode)
    {
        Outer.bGodMode = false;
        Outer.ClientMessage("God mode off");
        return;
    }
    Outer.bGodMode = true;
    Outer.ClientMessage("God Mode on");
    //return;    
}

exec function Slomo(float T)
{
    Outer.WorldInfo.Game.SetGameSpeed(T);
    //return;    
}

exec function SetJumpZ(float F)
{
    Outer.Pawn.JumpZ = F;
    //return;    
}

exec function SetGravity(float F)
{
    Outer.WorldInfo.WorldGravityZ = F;
    //return;    
}

exec function SetSpeed(float F)
{
    Outer.Pawn.GroundSpeed = Outer.Pawn.default.GroundSpeed * F;
    Outer.Pawn.WaterSpeed = Outer.Pawn.default.WaterSpeed * F;
    //return;    
}

exec function KillAll(Class<Actor> aClass)
{
    local Actor A;

    // End:0x36
    if(ClassIsChildOf(aClass, Class'Engine.Pawn'))
    {
        KillAllPawns(Class<Pawn>(aClass));
        return;
    }
    // End:0xAA
    foreach Outer.DynamicActors(Class'Engine.Actor', A)
    {
        // End:0xA9
        if(ClassIsChildOf(A.Class, aClass))
        {
            A.Destroy();
        }        
    }    
    //return;    
}

function KillAllPawns(Class<Pawn> aClass)
{
    local Pawn P;

    // End:0xEB
    foreach Outer.DynamicActors(Class'Engine.Pawn', P)
    {
        // End:0xEA
        if(ClassIsChildOf(P.Class, aClass) && !P.IsPlayerPawn())
        {
            // End:0xD2
            if(P.Controller != none)
            {
                P.Controller.Destroy();
            }
            P.Destroy();
        }        
    }    
    //return;    
}

exec function KillPawns()
{
    KillAllPawns(Class'Engine.Pawn');
    //return;    
}

exec function Avatar(name ClassName)
{
    local Pawn P, TargetPawn, FirstPawn, OldPawn;
    local bool bPickNextPawn;

    // End:0xD2
    foreach Outer.DynamicActors(Class'Engine.Pawn', P)
    {
        // End:0x69
        if(P == Outer.Pawn)
        {
            bPickNextPawn = true;
            // End:0xD1
            continue;
        }
        // End:0xD1
        if(P.IsA(ClassName))
        {
            // End:0xAE
            if(FirstPawn == none)
            {
                FirstPawn = P;
            }
            // End:0xD1
            if(bPickNextPawn)
            {
                TargetPawn = P;
                // End:0xD2
                break;
            }
        }        
    }    
    // End:0xF5
    if(TargetPawn == none)
    {
        TargetPawn = FirstPawn;
    }
    // End:0x1FF
    if(TargetPawn != none)
    {
        TargetPawn.DetachFromController(true);
        // End:0x1A5
        if(Outer.Pawn != none)
        {
            OldPawn = Outer.Pawn;
            Outer.Pawn.DetachFromController();
        }
        Outer.Possess(TargetPawn, false);
        // End:0x1FC
        if(OldPawn != none)
        {
            OldPawn.SpawnDefaultController();
        }        
    }
    //return;    
}

exec function Summon(string ClassName)
{
    local Class<Actor> NewClass;
    local Vector SpawnLoc;

    NewClass = Class<Actor>(DynamicLoadObject(ClassName, Class'Core.Class'));
    // End:0x13E
    if(NewClass != none)
    {
        // End:0xA3
        if(Outer.Pawn != none)
        {
            SpawnLoc = Outer.Pawn.Location;            
        }
        else
        {
            SpawnLoc = Outer.Location;
        }
        Outer.Spawn(NewClass,,, (SpawnLoc + (float(72) * Vector(Outer.Rotation))) + (vect(0.0000000, 0.0000000, 1.0000000) * float(15)));
    }
    //return;    
}

exec function Weapon GiveWeapon(string WeaponClassStr)
{
    local Weapon Weap;
    local Class<Weapon> WeaponClass;

    WeaponClass = Class<Weapon>(DynamicLoadObject(WeaponClassStr, Class'Core.Class'));
    Weap = Weapon(Outer.Pawn.FindInventoryType(WeaponClass));
    // End:0x9A
    if(Weap != none)
    {
        return Weap;
    }
    return Weapon(Outer.Pawn.CreateInventory(WeaponClass));
    //return ReturnValue;    
}

exec function PlayersOnly()
{
    // End:0xDF
    if(Outer.WorldInfo.bPlayersOnly || Outer.WorldInfo.bPlayersOnlyPending)
    {
        Outer.WorldInfo.bPlayersOnly = false;
        Outer.WorldInfo.bPlayersOnlyPending = false;        
    }
    else
    {
        Outer.WorldInfo.bPlayersOnlyPending = !Outer.WorldInfo.bPlayersOnlyPending;
    }
    //return;    
}

exec function SuspendAI()
{
    Outer.WorldInfo.bSuspendAI = !Outer.WorldInfo.bSuspendAI;
    //return;    
}

exec function DestroyFractures(optional float Radius)
{
    local FracturedStaticMeshActor FracActor;

    // End:0x23
    if(Radius == 0.0000000)
    {
        Radius = 256.0000000;
    }
    // End:0x11A
    foreach Outer.CollidingActors(Class'Engine.FracturedStaticMeshActor', FracActor, Radius, Outer.Pawn.Location, true)
    {
        // End:0x119
        if(int(FracActor.Physics) == int(0))
        {
            FracActor.BreakOffPartsInRadius(Outer.Pawn.Location, Radius, 500.0000000, true);
        }        
    }    
    //return;    
}

exec function FractureAllMeshes()
{
    local FracturedStaticMeshActor FracActor;

    // End:0x4E
    foreach Outer.AllActors(Class'Engine.FracturedStaticMeshActor', FracActor)
    {
        FracActor.HideOneFragment();        
    }    
    //return;    
}

exec function FractureAllMeshesToMaximizeMemoryUsage()
{
    local FracturedStaticMeshActor FracActor;

    // End:0x4E
    foreach Outer.AllActors(Class'Engine.FracturedStaticMeshActor', FracActor)
    {
        FracActor.HideFragmentsToMaximizeMemoryUsage();        
    }    
    //return;    
}

exec function RememberSpot()
{
    // End:0x7A
    if(Outer.Pawn != none)
    {
        Outer.SetDestinationPosition(Outer.Pawn.Location);        
    }
    else
    {
        Outer.SetDestinationPosition(Outer.Location);
    }
    //return;    
}

exec function ViewSelf(optional bool bQuiet)
{
    Outer.ResetCameraMode();
    // End:0x85
    if(Outer.Pawn != none)
    {
        Outer.SetViewTarget(Outer.Pawn);        
    }
    else
    {
        Outer.SetViewTarget(Outer);
    }
    // End:0xEF
    if(!bQuiet)
    {
        Outer.ClientMessage(OwnCamera, 'Event');
    }
    Outer.FixFOV();
    //return;    
}

exec function ViewPlayer(string S)
{
    local Controller P;

    // End:0xB2
    foreach Outer.WorldInfo.AllControllers(Class'Engine.Controller', P)
    {
        // End:0xB1
        if(P.bIsPlayer && P.PlayerReplicationInfo.PlayerName ~= S)
        {
            // End:0xB2
            break;
        }        
    }    
    // End:0x17C
    if(P.Pawn != none)
    {
        Outer.ClientMessage(ViewingFrom @ P.PlayerReplicationInfo.PlayerName, 'Event');
        Outer.SetViewTarget(P.Pawn);
    }
    //return;    
}

exec function ViewActor(name actorName)
{
    local Actor A;

    // End:0xAF
    foreach Outer.AllActors(Class'Engine.Actor', A)
    {
        // End:0xAE
        if(A.Name == actorName)
        {
            Outer.SetViewTarget(A);
            Outer.SetCameraMode('ThirdPerson');            
            return;
        }        
    }    
    //return;    
}

exec function ViewBot()
{
    local Actor first;
    local bool bFound;
    local AIController C;

    // End:0x122
    foreach Outer.WorldInfo.AllControllers(Class'Engine.AIController', C)
    {
        // End:0x121
        if((C.Pawn != none) && C.PlayerReplicationInfo != none)
        {
            // End:0xD4
            if(bFound || first == none)
            {
                first = C;
                // End:0xD4
                if(bFound)
                {
                    // End:0x122
                    break;
                }
            }
            // End:0x121
            if(C.PlayerReplicationInfo == Outer.RealViewTarget)
            {
                bFound = true;
            }
        }        
    }    
    // End:0x1A5
    if(first != none)
    {
        Outer.SetViewTarget(first);
        Outer.SetCameraMode('ThirdPerson');
        Outer.FixFOV();        
    }
    else
    {
        ViewSelf(true);
    }
    //return;    
}

exec function ViewClass(Class<Actor> aClass)
{
    local Actor Other, first;
    local bool bFound;

    first = none;
    // End:0xB3
    foreach Outer.AllActors(aClass, Other)
    {
        // End:0x7A
        if(bFound || first == none)
        {
            first = Other;
            // End:0x7A
            if(bFound)
            {
                // End:0xB3
                break;
            }
        }
        // End:0xB2
        if(Other == Outer.ViewTarget)
        {
            bFound = true;
        }        
    }    
    // End:0x1BB
    if(first != none)
    {
        // End:0x131
        if(Pawn(first) != none)
        {
            Outer.ClientMessage(ViewingFrom @ first.GetHumanReadableName(), 'Event');            
        }
        else
        {
            Outer.ClientMessage(ViewingFrom @ string(first), 'Event');
        }
        Outer.SetViewTarget(first);
        Outer.FixFOV();        
    }
    else
    {
        ViewSelf(false);
    }
    //return;    
}

exec function Loaded()
{
    // End:0x40
    if(int(Outer.WorldInfo.NetMode) != int(NM_Standalone))
    {
        return;
    }
    AllWeapons();
    AllAmmo();
    //return;    
}

exec function AllWeapons()
{
    //return;    
}

function SetLevelStreamingStatus(name PackageName, bool bShouldBeLoaded, bool bShouldBeVisible)
{
    local PlayerController PC;
    local int I;

    // End:0xA2
    if(PackageName != 'All')
    {
        // End:0x9E
        foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
        {
            PC.ClientUpdateLevelStreamingStatus(PackageName, bShouldBeLoaded, bShouldBeVisible, false);            
        }                
    }
    else
    {
        // End:0x1CD
        foreach Outer.WorldInfo.AllControllers(Class'Engine.PlayerController', PC)
        {
            I = 0;
            J0xF6:

            // End:0x1CC [Loop If]
            if(I < Outer.WorldInfo.StreamingLevels.Length)
            {
                PC.ClientUpdateLevelStreamingStatus(Outer.WorldInfo.StreamingLevels[I].PackageName, bShouldBeLoaded, bShouldBeVisible, false);
                I++;
                // [Loop Continue]
                goto J0xF6;
            }            
        }        
    }
    //return;    
}

exec function StreamLevelIn(name PackageName)
{
    SetLevelStreamingStatus(PackageName, true, true);
    //return;    
}

exec function OnlyLoadLevel(name PackageName)
{
    SetLevelStreamingStatus(PackageName, true, false);
    //return;    
}

exec function StreamLevelOut(name PackageName)
{
    SetLevelStreamingStatus(PackageName, false, false);
    //return;    
}

exec function TestLevel()
{
    local Actor A, Found;
    local bool bFoundErrors;

    // End:0x99
    foreach Outer.AllActors(Class'Engine.Actor', A)
    {
        bFoundErrors = bFoundErrors || A.CheckForErrors();
        // End:0x98
        if(bFoundErrors && Found == none)
        {
            Found = A;
        }        
    }    
    // End:0xAC
    if(bFoundErrors)
    {
        // DebugMode: 0
        assert(false);
    }
    //return;    
}

exec function SetOnlineDebugLevel(int DebugLevel)
{
    // End:0x61
    if(Outer.OnlineSub != none)
    {
        Outer.OnlineSub.SetDebugSpewLevel(DebugLevel);
    }
    //return;    
}

exec function TestNavMeshPath(optional bool bDrawPath = true)
{
    local Actor HitActor;
    local Vector HitLoc, HitNorm, Start, End;
    local Rotator Rot;

    // End:0x5E
    if(Outer.NavigationHandle == none)
    {
        Outer.NavigationHandle = new (Outer) Class'Engine.NavigationHandle';
    }
    Outer.GetPlayerViewPoint(Start, Rot);
    End = Start + (Vector(Rot) * float(10000));
    HitActor = Outer.Trace(HitLoc, HitNorm, End, Start, false);
    // End:0x3FF
    if(HitActor != none)
    {
        Class'Engine.NavMeshPath_Toward'.static.TowardPoint(Outer.NavigationHandle, HitLoc);
        Class'Engine.NavMeshGoal_At'.static.AtLocation(Outer.NavigationHandle, HitLoc);
        Outer.NavigationHandle.bDebugConstraintsAndGoalEvals = true;
        Outer.NavigationHandle.bUltraVerbosePathDebugging = true;
        // End:0x2FF
        if(Outer.NavigationHandle.FindPath())
        {
            Outer.DrawDebugLine(HitLoc, Start, 0, 255, 0, true);
            Outer.DrawDebugCoordinateSystem(HitLoc, rot(0, 0, 0), 25.0000000, true);
            // End:0x2FC
            if(bDrawPath)
            {
                Outer.NavigationHandle.DrawPathCache(,, true);
            }            
        }
        else
        {
            Outer.DrawDebugLine(HitLoc, Start, 255, 0, 0, true);
            Outer.DrawDebugCoordinateSystem(HitLoc, rot(0, 0, 0), 25.0000000, true);
            Outer.DrawDebugBox(Outer.Pawn.Location, Outer.Pawn.GetCollisionExtent(), 255, 0, 0, true);
        }
    }
    //return;    
}

exec function TestPylonConnectivity()
{
    local Pylon Py;

    // End:0x4E
    foreach Outer.AllActors(Class'Engine.Pylon', Py)
    {
        Py.VerifyTopLevelConnections();        
    }    
    //return;    
}

exec function VerbosePathDebug()
{
    local Vector HitLoc, HitNorm, Start, End;
    local Rotator Rot;
    local Pawn P;

    Outer.GetPlayerViewPoint(Start, Rot);
    End = Start + (Vector(Rot) * float(10000));
    // End:0x1E2
    foreach Outer.TraceActors(Class'Engine.Pawn', P, HitLoc, HitNorm, End, Start, vect(1.0000000, 1.0000000, 1.0000000))
    {
        Outer.Pawn.MessagePlayer("Verbosepathdebug trace hit" @ string(P));
        // End:0x1E1
        if((P != none) && P.Controller != none)
        {
            P.Controller.NavigationHandle.bUltraVerbosePathDebugging = !P.Controller.NavigationHandle.bUltraVerbosePathDebugging;
        }        
    }    
    //return;    
}

function InitCheatManager()
{
    //return;    
}

// Export UCheatManager::execLogPlaySoundCalls(FFrame&, void* const)
native exec function LogPlaySoundCalls(bool bShouldLog);

// Export UCheatManager::execLogParticleActivateSystemCalls(FFrame&, void* const)
native exec function LogParticleActivateSystemCalls(bool bShouldLog);

// Export UCheatManager::execVerifyNavMeshObjects(FFrame&, void* const)
native exec function VerifyNavMeshObjects();

// Export UCheatManager::execDrawUnsupportingEdges(FFrame&, void* const)
native exec function DrawUnsupportingEdges(coerce string PawnClassName);

exec function NavMeshVerification(optional float interval = 0.5000000)
{
    // End:0x4E
    if(interval < float(0))
    {
        Outer.ClearTimer('VerifyNavMeshObjects', Outer);        
    }
    else
    {
        Outer.SetTimer(interval, true, 'VerifyNavMeshObjects', Outer);
    }
    //return;    
}

// Export UCheatManager::execPrintAllPathObjectEdges(FFrame&, void* const)
native exec function PrintAllPathObjectEdges();

// Export UCheatManager::execPrintNavMeshObstacles(FFrame&, void* const)
native exec function PrintNavMeshObstacles();

// Export UCheatManager::execVerifyNavMeshCoverRefs(FFrame&, void* const)
native exec function VerifyNavMeshCoverRefs();

// Export UCheatManager::execSuppressAILog(FFrame&, void* const)
native exec function SuppressAILog();

// Export UCheatManager::execUnsuppressAILog(FFrame&, void* const)
native exec function UnsuppressAILog();

exec function ToggleAILogging()
{
    local Engine Eng;

    Eng = Class'Engine.Engine'.static.GetEngine();
    // End:0x123
    if(Outer.Pawn != none)
    {
        // End:0xCA
        if(Eng.bDisableAILogging)
        {
            Outer.Pawn.MessagePlayer("OK! AI logging is now ON");
            UnsuppressAILog();            
        }
        else
        {
            Outer.Pawn.MessagePlayer("OK! AI logging is now OFF");
            SuppressAILog();
        }
    }
    Eng.bDisableAILogging = !Eng.bDisableAILogging;
    //return;    
}

exec function DebugIniLocPatcher()
{
    // End:0xA8
    if((Outer.OnlineSub != none) && Outer.OnlineSub.Patcher != none)
    {
        Outer.OnlineSub.Patcher.DownloadFiles();
    }
    //return;    
}

exec function DebugDownloadTitleFile(string Filename, optional bool bFromCache)
{
    // End:0x22C
    if(Outer.OnlineSub != none)
    {
        // End:0x130
        if(bFromCache)
        {
            // End:0x12D
            if(NotEqual_InterfaceInterface(Outer.OnlineSub.TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
            {
                Outer.OnlineSub.TitleFileCacheInterface.AddLoadTitleFileCompleteDelegate(OnLoadComplete);
                Outer.OnlineSub.TitleFileCacheInterface.LoadTitleFile(Filename);                
            }            
        }
        else
        {
            // End:0x22C
            if(NotEqual_InterfaceInterface(Outer.OnlineSub.TitleFileInterface, OnlineTitleFileInterface(none)))
            {
                Outer.OnlineSub.TitleFileInterface.AddReadTitleFileCompleteDelegate(OnDownloadComplete);
                Outer.OnlineSub.TitleFileInterface.ReadTitleFile(Filename);                
            }
        }
    }
    //return;    
}

function OnDownloadComplete(bool bWasSuccessful, string Filename)
{
    Outer.OnlineSub.TitleFileInterface.ClearReadTitleFileCompleteDelegate(OnDownloadComplete);
    // End:0x7B
    if(bWasSuccessful)
    {
        DebugSaveTitleFile(Filename);
    }
    //return;    
}

function OnLoadComplete(bool bWasSuccessful, string Filename)
{
    Outer.OnlineSub.TitleFileCacheInterface.ClearLoadTitleFileCompleteDelegate(OnLoadComplete);
    DebugDownloadTitleFile(Filename, false);
    //return;    
}

exec function DebugSaveTitleFile(string Filename)
{
    local array<byte> FileContents;

    // End:0x1E5
    if(Outer.OnlineSub != none)
    {
        // End:0xD3
        if(NotEqual_InterfaceInterface(Outer.OnlineSub.TitleFileInterface, OnlineTitleFileInterface(none)))
        {
            // End:0xD0
            if(Outer.OnlineSub.TitleFileInterface.GetTitleFileContents(Filename, FileContents))
            {                
            }            
        }
        // End:0x1E5
        if(NotEqual_InterfaceInterface(Outer.OnlineSub.TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
        {
            Outer.OnlineSub.TitleFileCacheInterface.AddSaveTitleFileCompleteDelegate(OnSaveComplete);
            Outer.OnlineSub.TitleFileCacheInterface.SaveTitleFile(Filename, "TestName.ini", FileContents);            
        }
    }
    //return;    
}

function OnSaveComplete(bool bWasSuccessful, string Filename)
{
    Outer.OnlineSub.TitleFileCacheInterface.ClearSaveTitleFileCompleteDelegate(OnSaveComplete);
    //return;    
}

exec function DebugDeleteTitleFiles()
{
    // End:0xC6
    if(Outer.OnlineSub != none)
    {
        // End:0xC6
        if(NotEqual_InterfaceInterface(Outer.OnlineSub.TitleFileCacheInterface, OnlineTitleFileCacheInterface(none)))
        {
            // End:0xC3
            if(Outer.OnlineSub.TitleFileCacheInterface.DeleteTitleFiles(0.0000000))
            {                
            }            
        }
    }
    //return;    
}

exec function DebugEmsDownload()
{
    // End:0xA8
    if((Outer.OnlineSub != none) && Outer.OnlineSub.Patcher != none)
    {
        Outer.OnlineSub.Patcher.DownloadFiles();
    }
    //return;    
}

// Export UCheatManager::execDumpCoverStats(FFrame&, void* const)
native exec function DumpCoverStats();

exec function DrawLocation(Vector Loc)
{
    Outer.DrawDebugCoordinateSystem(Loc, rot(0, 0, 0), 50.0000000, true);
    //return;    
}

exec function DrawLocationXYZ(float X, float Y, float Z)
{
    local Vector DrawSpot;

    DrawSpot.X = X;
    DrawSpot.Y = Y;
    DrawSpot.Z = Z;
    Outer.DrawDebugCoordinateSystem(DrawSpot, rot(0, 0, 0), 150.0000000, true);
    //return;    
}

exec function DebugNotification(string MessageBody, int SecondsFromNow)
{
    local AppNotificationsBase AppNotification;
    local NotificationInfo NotificationInfo;
    local NotificationMessageInfo MessageInfo;

    AppNotification = Class'Engine.PlatformInterfaceBase'.static.GetAppNotificationsInterface();
    // End:0x1D3
    if(AppNotification != none)
    {
        NotificationInfo.BadgeNumber = 1;
        NotificationInfo.MessageBody = MessageBody;
        MessageInfo.Key = "test key 1";
        MessageInfo.Value = "test val 1";
        NotificationInfo.MessageInfo.AddItem(MessageInfo);
        MessageInfo.Key = "test key 2";
        MessageInfo.Value = "test val 2";
        NotificationInfo.MessageInfo.AddItem(MessageInfo);
        AppNotification.__OnReceivedLocalNotification__Delegate = OnReceivedLocalNotificationDebug;
        AppNotification.ScheduleLocalNotification(NotificationInfo, SecondsFromNow);
    }
    //return;    
}

private final function OnReceivedLocalNotificationDebug(const out NotificationInfo Notification, bool bWasAppActive)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAppNotificationsInterface().DebugLogNotification(Notification);
    //return;    
}

exec function DebugQueryUserFiles(string UserId)
{
    // End:0x11E
    if((Outer.OnlineSub != none) && NotEqual_InterfaceInterface(Outer.OnlineSub.UserCloudInterface, UserCloudFileInterface(none)))
    {
        Outer.OnlineSub.UserCloudInterface.AddEnumerateUserFileCompleteDelegate(OnEnumerateUserFilesComplete);
        Outer.OnlineSub.UserCloudInterface.EnumerateUserFiles(UserId);
    }
    //return;    
}

private final function OnEnumerateUserFilesComplete(bool bWasSuccessful, string UserId)
{
    Outer.OnlineSub.UserCloudInterface.ClearEnumerateUserFileCompleteDelegate(OnEnumerateUserFilesComplete);    
    Outer.ConsoleCommand("obj dump" @ string(Outer.OnlineSub.UserCloudInterface.Name));
    //return;    
}

exec function DebugWriteUserFile(string UserId, string Filename)
{
    local int Idx;
    local array<byte> FileContents;

    // End:0x17B
    if((Outer.OnlineSub != none) && NotEqual_InterfaceInterface(Outer.OnlineSub.UserCloudInterface, UserCloudFileInterface(none)))
    {
        Idx = 0;
        J0x7B:

        // End:0xBB [Loop If]
        if(Idx < 1000)
        {
            FileContents[Idx] = byte(Idx);
            Idx++;
            // [Loop Continue]
            goto J0x7B;
        }
        Outer.OnlineSub.UserCloudInterface.AddWriteUserFileCompleteDelegate(OnWriteUserFileComplete);
        Outer.OnlineSub.UserCloudInterface.WriteUserFile(UserId, Filename, FileContents);
    }
    //return;    
}

private final function OnWriteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    Outer.OnlineSub.UserCloudInterface.ClearWriteUserFileCompleteDelegate(OnWriteUserFileComplete);    
    Outer.ConsoleCommand("obj dump" @ string(Outer.OnlineSub.UserCloudInterface.Name));
    //return;    
}

exec function DebugReadUserFile(string UserId, string Filename)
{
    // End:0x127
    if((Outer.OnlineSub != none) && NotEqual_InterfaceInterface(Outer.OnlineSub.UserCloudInterface, UserCloudFileInterface(none)))
    {
        Outer.OnlineSub.UserCloudInterface.AddReadUserFileCompleteDelegate(OnReadUserFileComplete);
        Outer.OnlineSub.UserCloudInterface.ReadUserFile(UserId, Filename);
    }
    //return;    
}

private final function OnReadUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    local array<byte> FileContents;

    Outer.OnlineSub.UserCloudInterface.ClearReadUserFileCompleteDelegate(OnReadUserFileComplete);
    Outer.OnlineSub.UserCloudInterface.GetFileContents(UserId, Filename, FileContents);    
    Outer.ConsoleCommand("obj dump" @ string(Outer.OnlineSub.UserCloudInterface.Name));
    //return;    
}

exec function DebugDeleteUserFile(string UserId, string Filename)
{
    // End:0x129
    if((Outer.OnlineSub != none) && NotEqual_InterfaceInterface(Outer.OnlineSub.UserCloudInterface, UserCloudFileInterface(none)))
    {
        Outer.OnlineSub.UserCloudInterface.AddDeleteUserFileCompleteDelegate(OnDeleteUserFileComplete);
        Outer.OnlineSub.UserCloudInterface.DeleteUserFile(UserId, Filename, true, true);
    }
    //return;    
}

private final function OnDeleteUserFileComplete(bool bWasSuccessful, string UserId, string Filename)
{
    Outer.OnlineSub.UserCloudInterface.ClearDeleteUserFileCompleteDelegate(OnDeleteUserFileComplete);    
    Outer.ConsoleCommand("obj dump" @ string(Outer.OnlineSub.UserCloudInterface.Name));
    //return;    
}

exec function TestHttp(string Verb, string Payload, string URL, optional bool bSendParallelRequest)
{
    local HttpRequestInterface R;

    R = Class'Engine.HttpFactory'.static.CreateRequest();
    R.__OnProcessRequestComplete__Delegate = OnRequestComplete;
    R.SetURL(URL);
    // End:0xBE
    if(Len(Verb) > 0)
    {
        R.SetVerb(Verb);        
    }
    // End:0xFA
    if(Len(Payload) > 0)
    {
        R.SetContentAsString(Payload);        
    }
    // End:0x121
    if(!R.ProcessRequest())
    {        
    }
    // End:0x200
    if(bSendParallelRequest)
    {
        // End:0x200
        if(!Class'Engine.HttpFactory'.static.CreateRequest().SetURL("http://www.epicgames.com").SetVerb("GET").SetHeader("Test", "Value").SetProcessRequestCompleteDelegate(OnRequestComplete).ProcessRequest())
        {            
        }
    }
    //return;    
}

function OnRequestComplete(HttpRequestInterface OriginalRequest, HttpResponseInterface Response, bool bDidSucceed)
{
    local array<string> Headers;
    local string Header, Payload;
    local int PayloadIndex;

    // End:0xD3
    if(Response != none)
    {
        Headers = Response.GetHeaders();
        // End:0x50
        foreach Headers(Header)
        {            
        }        
        Payload = Response.GetContentAsString();
        // End:0xD3
        if(Len(Payload) > 1024)
        {
            PayloadIndex = 0;
            J0x9A:

            // End:0xD0 [Loop If]
            if(PayloadIndex < Len(Payload))
            {
                PayloadIndex = PayloadIndex + 1024;
                // [Loop Continue]
                goto J0x9A;
            }            
        }
    }
    //return;    
}

exec function SendAnalyticsEvent(string EventName, optional string AttributeName, optional string AttributeValue)
{
    local AnalyticEventsBase Analytics;

    Analytics = Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface();
    // End:0x7A
    if(Len(AttributeName) > 0)
    {
        Analytics.LogStringEventParam(EventName, AttributeName, AttributeValue, false);        
    }
    else
    {
        Analytics.LogStringEvent(EventName, false);
    }
    //return;    
}

exec function SendAnalyticsUserAttributeEvent(string AttributeName, string AttributeValue)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().LogUserAttributeUpdate(AttributeName, AttributeValue);
    //return;    
}

exec function SendAnalyticsItemPurchaseEvent(string ItemId, string Currency, int PerItemCost, int ItemQuantity)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().LogItemPurchaseEvent(ItemId, Currency, PerItemCost, ItemQuantity);
    //return;    
}

exec function SendAnalyticsCurrencyPurchaseEvent(string GameCurrencyType, int GameCurrencyAmount, string RealCurrencyType, float RealMoneyCost, string PaymentProvider)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().LogCurrencyPurchaseEvent(GameCurrencyType, GameCurrencyAmount, RealCurrencyType, RealMoneyCost, PaymentProvider);
    //return;    
}

exec function SendAnalyticsCurrencyGivenEvent(string GameCurrencyType, int GameCurrencyAmount)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().LogCurrencyGivenEvent(GameCurrencyType, GameCurrencyAmount);
    //return;    
}

exec function SendAnalyticsCachedEvents()
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().SendCachedEvents();
    //return;    
}

exec function SetAnalyticsUserId(string UserId)
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().SetUserId(UserId);
    //return;    
}

// Export UCheatManager::execGetAnalyticsUserId(FFrame&, void* const)
native exec function GetAnalyticsUserId();

exec function AnalyticsStartSession()
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().StartSession();
    //return;    
}

exec function AnalyticsEndSession()
{
    Class'Engine.PlatformInterfaceBase'.static.GetAnalyticEventsInterface().EndSession();
    //return;    
}

defaultproperties
{
    ViewingFrom="Now viewing from"
    OwnCamera="Now viewing from own camera"
}