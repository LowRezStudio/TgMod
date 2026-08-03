class TgSpectatorController extends TgPlayerController
    native(Pawns)
    config(Game)
    hidecategories(Navigation);

const MAX_BROADCAST_CHANNELS = 4;

enum SpectatorCameraMode
{
    SpecCam_None,                   // 0
    SpecCam_Fly,                    // 1
    SpecCam_FollowThirdPerson,      // 2
    SpecCam_FollowFirstPerson,      // 3
    SpecCam_FollowTopDown,          // 4
    SpecCam_Camera,                 // 5
    SpecCam_Overview,               // 6
    SpecCam_LockedView,             // 7
    SpecCam_MAX                     // 8
};

enum SpectatorCameraCycle
{
    SpecCycle_None,                 // 0
    SpecCycle_PlayerFriendly,       // 1
    SpecCycle_PlayerEnemy,          // 2
    SpecCycle_Player,               // 3
    SpecCycle_TowerFriendly,        // 4
    SpecCycle_TowerEnemy,           // 5
    SpecCycle_Tower,                // 6
    SpecCycle_Cinematic,            // 7
    SpecCycle_Action,               // 8
    SpecCycle_MAX                   // 9
};

enum SpecFlightMode
{
    SFM_Normal,                     // 0
    SFM_Heli,                       // 1
    SFM_HeliNoVert,                 // 2
    SFM_MAX                         // 3
};

enum ESpectatorMode
{
    SPECMODE_Manual,                // 0
    SPECMODE_Director,              // 1
    SPECMODE_Assisted,              // 2
    SPECMODE_Broadcast1,            // 3
    SPECMODE_Broadcast2,            // 4
    SPECMODE_Broadcast3,            // 5
    SPECMODE_Broadcast4,            // 6
    SPECMODE_MAX                    // 7
};

enum EZoomState
{
    ZOOM_None,                      // 0
    ZOOM_In,                        // 1
    ZOOM_Out,                       // 2
    ZOOM_MAX                        // 3
};

struct native SpectatorBookmark
{
    var transient Actor ViewTarget;
    var TgSpectatorController.SpectatorCameraMode ViewMode;
    var TPOV POV;

    structdefaultproperties
    {
        ViewTarget=none
        ViewMode=SpectatorCameraMode.SpecCam_None
        POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000))
    }
};

struct native BroadcastChannel
{
    var TgSpectatorController.ESpectatorMode Channel;
    var int PlayerID;

    structdefaultproperties
    {
        Channel=ESpectatorMode.SPECMODE_Manual
        PlayerID=0
    }
};

var transient TgSpectatorController.SpectatorCameraMode m_CameraMode;
var transient TgSpectatorController.SpectatorCameraCycle m_CurrentCycle;
var transient TgSpectatorController.SpectatorCameraCycle m_PendingCycle;
var transient TgSpectatorController.SpecFlightMode m_eHelicopterFlight;
var transient TgSpectatorController.ESpectatorMode m_CurrentSpectatorMode;
var transient TgSpectatorController.EZoomState m_CurrentZoomState;
var transient TgSpectatorTempCam m_BookmarkCamera;
var transient SpectatorBookmark m_Bookmarks[10];
var float m_fDefaultTweenTime;
var transient bool m_bOutlineCharacters;
var transient bool m_bIsMapSquashed;
var(Performance) config bool m_bIgnoreCullDistanceVolumes;
var() float m_fNameplateFadeMinDist;
var() float m_fNameplateFadeMaxDist;
var() float m_fNameplateFadeMaxAmount;
var() float m_fNameplateScaleMinDist;
var() float m_fNameplateScaleMaxDist;
var() float m_fNameplateScaleMaxAmount;
var() float m_fInterpolateCameraDistance;
var BroadcastChannel m_BroadcastChannels[4];
var config Vector c_vMouseClickDeprojectionExtent;
var() config float m_fOverviewCenterpointOffset;
var() config float m_fMouseCursorVisibleTime;
var transient float m_fRemainingCursorVisibleTime;

// Export UTgSpectatorController::execGetHudClass(FFrame&, void* const)
native function Class<HUD> GetHudClass(Class<HUD> pNewHudType);

// Export UTgSpectatorController::execSetNetTarget(FFrame&, void* const)
native function SetNetTarget(QWord qwId, int nTaskForce);

simulated event PostBeginPlay()
{
    super.PostBeginPlay();
    Class'TgGame.TgSeqEvent_SpectatorReady'.static.TriggerGlobal(self);
    //return;    
}

simulated function ForwardToSpectatingMatch()
{
    // End:0x20
    if(!IsInState('SpectatingMatch'))
    {
        GotoState('SpectatingMatch');
    }
    // End:0x53
    if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
    {
        ClientForwardToSpectatingMatch();
    }
    //return;    
}

reliable client simulated function ClientForwardToSpectatingMatch()
{
    ForwardToSpectatingMatch();
    //return;    
}

exec function SwitchCamera(string sCamera)
{
    //return;    
}

function SpectatorSetViewTarget(Actor VT, optional ViewTargetTransitionParams TransitionParams)
{
    local QWord qwId;
    local TgPawn TgP;

    TgP = TgPawn(GetViewTarget());
    // End:0x4E
    if(TgP != none)
    {
        TgP.m_bUseSmoothNetReceiveRotation = false;
    }
    SetViewTarget(VT, TransitionParams);
    ServerSetViewTarget(VT);
    TgP = TgPawn(GetViewTarget());
    // End:0x19F
    if(TgP != none)
    {
        TgP.UpdateSpectatorStatUI();
        TgP.m_bUseSmoothNetReceiveRotation = true;
        SetTimer(2.0000000, true, 'UpdateViewTargetUI');
        SetNetTarget(TgP.PlayerReplicationInfo.UniqueId.Uid, int(TgP.GetTaskForceNumber()));
        // End:0x19C
        if(TgP.IsGod())
        {
            SetSpectatorCameraMode(3);
        }        
    }
    else
    {
        ClearTimer('UpdateViewTargetUI');
        SetNetTarget(qwId, 0);
    }
    //return;    
}

function UpdateViewTargetUI()
{
    local TgPawn TgP;

    TgP = TgPawn(GetViewTarget());
    // End:0x4B
    if(TgP != none)
    {
        TgP.UpdateSpectatorStatUI();
    }
    //return;    
}

function bool ShouldFlyFromInput()
{
    // End:0x39
    if(PlayerCamera.PendingViewTarget.Target != none)
    {
        return false;
    }
    // End:0x4F
    if(int(m_CurrentSpectatorMode) != int(0))
    {
        return false;
    }
    // End:0x65
    if(int(m_CameraMode) == int(7))
    {
        return false;
    }
    // End:0xC5
    if(int(m_CameraMode) == int(4))
    {
        return (PlayerInput.aStrafe != float(0)) || PlayerInput.aForward != float(0);
    }
    // End:0x140
    if(((PlayerInput.aStrafe != float(0)) || PlayerInput.aForward != float(0)) || PlayerInput.aUp != float(0))
    {
        return true;        
    }
    else
    {
        // End:0x1A4
        if((PlayerInput.aTurn != float(0)) || PlayerInput.aLookUp != float(0))
        {
            // End:0x1A4
            if(int(m_CameraMode) == int(5))
            {
                return true;
            }
        }
    }
    return false;
    //return ReturnValue;    
}

exec function SetNewSpectatorMode(TgSpectatorController.ESpectatorMode NewMode)
{
    local Vector Loc;
    local Rotator Rot;
    local TPOV POV;

    // End:0x214
    if(int(m_CurrentSpectatorMode) != int(NewMode))
    {
        switch(NewMode)
        {
            // End:0x117
            case 0:
                SetSpectatorCameraMode(1, false);
                GetPlayerViewPoint(Loc, Rot);
                PlayerCamera.CameraCache.POV.FOV = Class'TgGame.TgCameraModule_SpectatorOverview'.default.FOV;
                TgCameraModule_Spectator(TgPlayerCamera(PlayerCamera).CurrentCameraMod).BlendCameraToLocation(Loc, 0.3500000, false);
                // End:0x201
                break;
            // End:0xFFFF
            default:
                // End:0x1F4
                if(int(m_CurrentSpectatorMode) == int(0))
                {
                    Rot = Rotation;
                    Rot.Yaw = 0;
                    SetRotation(Rot);
                    POV = PlayerCamera.CameraCache.POV;
                    POV.Rotation = Rot;
                    PlayerCamera.FillCameraCache(POV);
                }
                SetSpectatorCameraMode(6, false);
                break;
        }
        m_CurrentSpectatorMode = NewMode;
    }
    //return;    
}

exec function SetSpectatorCameraMode(TgSpectatorController.SpectatorCameraMode Mode, optional bool bCameraTween = false)
{
    local Class<TgCameraModule> camClass;
    local bool bClipMap;
    local Vector Loc, StartingLocation;
    local Rotator Rot;

    // End:0x2D3
    if(int(Mode) != int(m_CameraMode))
    {
        m_CameraMode = Mode;
        camClass = Class'TgGame.TgCameraModule_Spectator';
        switch(Mode)
        {
            // End:0x80
            case 2:
                bClipMap = false;
                camClass = Class'TgGame.TgCameraModule_SpectatorThirdPerson';
                // End:0x237
                break;
            // End:0xA7
            case 3:
                bClipMap = false;
                camClass = Class'TgGame.TgCameraModule_SpectatorFirstPerson';
                // End:0x237
                break;
            // End:0xCE
            case 4:
                bClipMap = true;
                camClass = Class'TgGame.TgCameraModule_TopDown';
                // End:0x237
                break;
            // End:0xF5
            case 5:
                bClipMap = false;
                camClass = Class'TgGame.TgCameraModule_Cinematic';
                // End:0x237
                break;
            // End:0x175
            case 6:
                // End:0x153
                if(CameraActor(GetViewTarget()) != none)
                {
                    GetPlayerViewPoint(Loc, Rot);
                    SetLocation(Loc);
                    SetRotation(Rot);
                    SetViewTarget(self);
                }
                bClipMap = true;
                camClass = Class'TgGame.TgCameraModule_SpectatorOverview';
                // End:0x237
                break;
            // End:0x1F5
            case 7:
                // End:0x1D3
                if(CameraActor(GetViewTarget()) != none)
                {
                    GetPlayerViewPoint(Loc, Rot);
                    SetLocation(Loc);
                    SetRotation(Rot);
                    SetViewTarget(self);
                }
                bClipMap = true;
                camClass = Class'TgGame.TgCameraModule_SpectatorLockedView';
                // End:0x237
                break;
            // End:0x1FA
            case 1:
            // End:0xFFFF
            default:
                bClipMap = false;
                camClass = Class'TgGame.TgCameraModule_Spectator';
                SetViewTarget(self);
                m_CurrentCycle = 0;
                // End:0x237
                break;
                break;
        }
        // End:0x2BE
        if(camClass != none)
        {
            // End:0x28C
            if(bCameraTween)
            {
                TgPlayerCamera(PlayerCamera).SwitchCameras(camClass, 0.2000000);                
            }
            else
            {
                TgPlayerCamera(PlayerCamera).SwitchCameras(camClass);
            }
        }
        m_bIsMapSquashed = bClipMap;
    }
    // End:0x38F
    if(int(Mode) == int(4))
    {
        StartingLocation = Location;
        StartingLocation.Z = Class'TgGame.TgControlModule_TopDown'.default.DefaultStartHeight;
        SetLocation(StartingLocation);
        TgCameraModule_TopDown(TgPlayerCamera(PlayerCamera).CurrentCameraMod).BlendToTarget(0.3500000);        
    }
    else
    {
        // End:0x3EE
        if(int(Mode) == int(2))
        {
            TgCameraModule_SpectatorThirdPerson(TgPlayerCamera(PlayerCamera).CurrentCameraMod).BlendToTarget(0.0000000);
        }
    }
    //return;    
}

// Export UTgSpectatorController::execToggleSpectatorPlayerIcons(FFrame&, void* const)
native exec function ToggleSpectatorPlayerIcons();

reliable client simulated function ClientSetReadyState(bool bReadyToPlay)
{
    GotoState('SpectatingMatch');
    //return;    
}

exec function SetPendingSpecCycle(TgSpectatorController.SpectatorCameraCycle Mode)
{
    m_PendingCycle = Mode;
    //return;    
}

exec function ClearPendingSpecCycle()
{
    m_PendingCycle = 0;
    //return;    
}

function bool InterceptFlashInput(name ButtonName, Object.EInputEvent Event)
{
    // End:0x41
    if(ControlModule != none)
    {
        return ControlModule.InterceptFlashInput(ButtonName, Event);
    }
    return false;
    //return ReturnValue;    
}

exec function LockedViewCam(bool bEnabled)
{
    // End:0x1D
    if(bEnabled)
    {
        SetSpectatorCameraMode(7, false);        
    }
    else
    {
        SetSpectatorCameraMode(1, false);
    }
    //return;    
}

function SnapViewToHoverTarget(optional bool bUseAltView = false)
{
    local TgPawn P;
    local Vector HitLocation, HitNormal, Start, End, Extent;

    local Rotator ViewRotation;

    GetPlayerViewPoint(Start, ViewRotation);
    End = Start + (Vector(ViewRotation) * float(5000));
    Extent = vect(30.0000000, 30.0000000, 30.0000000);
    // End:0x18A
    foreach TraceActors(Class'TgGame.TgPawn', P, HitLocation, HitNormal, End, Start, Extent,, 1)
    {
        // End:0x189
        if(((int(GetDefaultModeFor(P)) != int(0)) && P.Mesh != none) && P.Mesh.bRecentlyRendered)
        {
            SpectatorSetViewTarget(P, GetBlendParams(P));
            // End:0x168
            if(bUseAltView)
            {
                SetSpectatorCameraMode(2);                
            }
            else
            {
                SetSpectatorCameraMode(GetDefaultModeFor(P));
            }            
            return;
        }        
    }    
    //return;    
}

simulated function bool PingMap(Vector WorldLocation, const out array<ReplicationInfo> worldActorRepInfo, TgObject.PING_TYPE Type)
{
    SnapViewToLocation(WorldLocation, int(Type) == int(0));
    return true;
    //return ReturnValue;    
}

function SetPendingOnDirectorMode()
{
    //return;    
}

function SnapViewToLocation(Vector WorldLocation, bool bUseFocalPoint)
{
    local Vector ViewLoc;
    local Rotator ViewRot;

    GetPlayerViewPoint(ViewLoc, ViewRot);
    SetViewTarget(self);
    // End:0x10E
    if(int(m_CameraMode) == int(6))
    {
        SetPendingOnDirectorMode();
        TgCameraModule_SpectatorOverview(TgPlayerCamera(PlayerCamera).CurrentCameraMod).BlendCameraToLocation(WorldLocation, ((VSize2D(ViewLoc - WorldLocation) < m_fInterpolateCameraDistance) ? 0.3500000 : 0.0000000), true);
        ViewRot = Rotation;
        ViewRot.Yaw = 0;
        SetRotation(ViewRot);        
    }
    else
    {
        SetSpectatorCameraMode(1);
        TgCameraModule_Spectator(TgPlayerCamera(PlayerCamera).CurrentCameraMod).BlendCameraToLocation(WorldLocation, ((VSize2D(ViewLoc - WorldLocation) < m_fInterpolateCameraDistance) ? 0.3500000 : 0.0000000), bUseFocalPoint);
    }
    //return;    
}

function CycleNext(optional bool bSkipIfPresent = false, optional bool bReverse = false)
{
    local array<Actor> potentialViewTargets;
    local int nCurrent, I;
    local Actor BestTarget;
    local float bestTargetVal, val;
    local Vector CurrentLocation;
    local Rotator CurrentRotation;

    potentialViewTargets = GetViewTargetListForMode(m_CurrentCycle);
    // End:0x39
    if(potentialViewTargets.Length == 0)
    {
        return;
    }
    nCurrent = potentialViewTargets.Find(GetViewTarget());
    // End:0x1B3
    if(nCurrent == -1)
    {
        nCurrent = 0;
        GetPlayerViewPoint(CurrentLocation, CurrentRotation);
        BestTarget = potentialViewTargets[I];
        bestTargetVal = VSizeSq(BestTarget.Location - CurrentLocation);
        I = 0;
        J0xF1:

        // End:0x1B0 [Loop If]
        if(I < potentialViewTargets.Length)
        {
            val = VSizeSq(potentialViewTargets[I].Location - CurrentLocation);
            // End:0x1A2
            if(val < bestTargetVal)
            {
                BestTarget = potentialViewTargets[I];
                bestTargetVal = val;
                nCurrent = I;
            }
            I++;
            // [Loop Continue]
            goto J0xF1;
        }        
    }
    else
    {
        // End:0x1C5
        if(bSkipIfPresent)
        {
            return;            
        }
        else
        {
            // End:0x1E0
            if(bReverse)
            {
                nCurrent--;                
            }
            else
            {
                nCurrent++;
            }
        }
    }
    // End:0x211
    if(nCurrent >= potentialViewTargets.Length)
    {
        nCurrent = 0;        
    }
    else
    {
        // End:0x235
        if(nCurrent < 0)
        {
            nCurrent += potentialViewTargets.Length;
        }
    }
    SpectatorSetViewTarget(potentialViewTargets[nCurrent], GetBlendParams(potentialViewTargets[nCurrent]));
    SetSpectatorCameraMode(GetDefaultModeFor(GetViewTarget()));
    //return;    
}

function array<Actor> GetViewTargetListForMode(TgSpectatorController.SpectatorCameraCycle cycle)
{
    local array<Actor> toReturn, tempList;
    local Actor A;
    local CameraActor C;

    switch(cycle)
    {
        // End:0x75
        case 3:
            tempList = GetPlayerList();
            // End:0x71
            foreach tempList(A)
            {
                // End:0x70
                if(A != none)
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0xFE
        case 1:
            tempList = GetPlayerList();
            // End:0xFA
            foreach tempList(A)
            {
                // End:0xF9
                if((A != none) && !A.IsEnemy(self))
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0x185
        case 2:
            tempList = GetPlayerList();
            // End:0x181
            foreach tempList(A)
            {
                // End:0x180
                if((A != none) && A.IsEnemy(self))
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0x1E7
        case 6:
            tempList = GetOutermostTowerList();
            // End:0x1E3
            foreach tempList(A)
            {
                // End:0x1E2
                if(A != none)
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0x263
        case 4:
            tempList = GetOutermostTowerList();
            // End:0x25F
            foreach tempList(A)
            {
                // End:0x25E
                if((A != none) && !IsEnemy(A))
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0x2DD
        case 5:
            tempList = GetOutermostTowerList();
            // End:0x2D9
            foreach tempList(A)
            {
                // End:0x2D8
                if((A != none) && IsEnemy(A))
                {
                    toReturn[toReturn.Length] = A;
                }                
            }            
            // End:0x3A8
            break;
        // End:0x2F9
        case 8:
            toReturn = GetActionList();
            // End:0x3A8
            break;
        // End:0x395
        case 7:
            // End:0x391
            foreach WorldInfo.DynamicActors(Class'Engine.CameraActor', C)
            {
                // End:0x390
                if((C != none) && Left(string(C.Tag), 10) ~= "Cinematic_")
                {
                    toReturn[toReturn.Length] = C;
                }                
            }            
            // End:0x3A8
            break;
        // End:0xFFFF
        default:
            toReturn[0] = self;
            // End:0x3A8
            break;
            break;
    }
    return toReturn;
    //return ReturnValue;    
}

function array<Actor> GetPlayerList()
{
    local array<Actor> toReturn;
    local TgPawn_Character P;

    // End:0x8D
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', P)
    {
        // End:0x8C
        if((P != none) && !P.IsInState('Dying'))
        {
            toReturn[toReturn.Length] = P;
        }        
    }    
    return toReturn;
    //return ReturnValue;    
}

function array<Actor> GetOutermostTowerList()
{
    local array<Actor> toReturn;
    local TgPawn_TowerBase P;

    // End:0xB3
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_TowerBase', P)
    {
        // End:0xB2
        if(((P != none) && !P.IsInState('Dying')) && !P.r_bLocked)
        {
            toReturn[toReturn.Length] = P;
        }        
    }    
    return toReturn;
    //return ReturnValue;    
}

function array<Actor> GetActionList()
{
    local array<Actor> toReturn, tempList;
    local TgPawn P;
    local TgPawn_Character C;
    local Actor A;
    local bool bUnderAttack;

    // End:0x11C
    foreach WorldInfo.AllPawns(Class'TgGame.TgPawn_Character', C)
    {
        // End:0x11B
        if(C.GetPRI() != none)
        {
            bUnderAttack = (FMax(WorldInfo.TimeSeconds - C.GetPRI().c_fLastDamageTime, 0.0000000) < float(5)) && WorldInfo.TimeSeconds > float(10);
            // End:0x11B
            if(bUnderAttack)
            {
                toReturn[toReturn.Length] = C;
            }
        }        
    }    
    tempList = GetOutermostTowerList();
    // End:0x24A
    foreach tempList(A)
    {
        P = TgPawn(A);
        // End:0x249
        if(P.GetPRI() != none)
        {
            bUnderAttack = (FMax(WorldInfo.TimeSeconds - P.GetPRI().c_fLastDamageTime, 0.0000000) < float(5)) && WorldInfo.TimeSeconds > float(10);
            // End:0x249
            if(bUnderAttack)
            {
                toReturn[toReturn.Length] = P;
            }
        }        
    }    
    return toReturn;
    //return ReturnValue;    
}

function TgSpectatorController.SpectatorCameraMode GetDefaultModeFor(Actor Target)
{
    // End:0x4D
    if(Target.IsA('TgPawn') && Target.IsInState('Dying'))
    {
        return 0;
    }
    // End:0x76
    if(Target.IsA('TgPawn_Structure'))
    {
        return 4;        
    }
    else
    {
        // End:0x9F
        if(Target.IsA('TgPawn_Character'))
        {
            return 4;            
        }
        else
        {
            // End:0xC5
            if(Target.IsA('CameraActor'))
            {
                return 5;
            }
        }
    }
    return 0;
    //return ReturnValue;    
}

exec function SpecViewAction()
{
    m_CurrentCycle = 8;
    CycleNext();
    //return;    
}

exec function SpecViewPlayer(string PlayerName)
{
    local array<Actor> PlayerList;
    local Actor A;
    local TgPawn TgP;

    PlayerList = GetViewTargetListForMode(3);
    // End:0x12E
    foreach PlayerList(A)
    {
        TgP = TgPawn(A);
        // End:0x12D
        if(((TgP != none) && TgP.PlayerReplicationInfo != none) && (TgP.PlayerReplicationInfo.PlayerName ~= PlayerName) || TgRepInfo_Player(TgP.PlayerReplicationInfo).c_PlayerNameWithTag ~= PlayerName)
        {
            SpectatorSetViewTarget(A, GetSnapBlendParams());            
            return;
        }        
    }    
    //return;    
}

function ViewTargetTransitionParams GetBlendParams(Actor Target)
{
    // End:0x47
    if(Target.IsA('CameraActor') || CanCameraSeeActorCenter(Target))
    {
        return GetDefaultBlendParams();
    }
    return GetSnapBlendParams();
    //return ReturnValue;    
}

function ViewTargetTransitionParams GetDefaultBlendParams()
{
    return TgSpectatorCamera(PlayerCamera).m_DefaultBlendParams;
    //return ReturnValue;    
}

function ViewTargetTransitionParams GetSnapBlendParams()
{
    return TgSpectatorCamera(PlayerCamera).m_SnapBlendParams;
    //return ReturnValue;    
}

exec function SetSpectatorBookmark(int nNum)
{
    local Vector ViewLoc;
    local Rotator ViewRot;
    local TgPawn TgP;

    m_Bookmarks[nNum].ViewMode = m_CameraMode;
    m_Bookmarks[nNum].POV.FOV = FOVAngle;
    TgP = TgPawn(GetViewTarget());
    // End:0xD2
    if(TgP != none)
    {
        m_Bookmarks[nNum].ViewTarget = TgP;        
    }
    else
    {
        GetPlayerViewPoint(ViewLoc, ViewRot);
        m_Bookmarks[nNum].POV.Location = ViewLoc;
        m_Bookmarks[nNum].POV.Rotation = ViewRot;
    }
    //return;    
}

exec function RecallSpectatorBookmark(int nNum)
{
    local TgRepInfo_Player PRI;

    // End:0x173
    if(m_Bookmarks[nNum].ViewTarget != none)
    {
        PRI = TgRepInfo_Player(m_Bookmarks[nNum].ViewTarget);
        // End:0xDF
        if((PRI != none) && PRI.r_PawnOwner != none)
        {
            m_Bookmarks[nNum].ViewTarget = PRI.r_PawnOwner;
        }
        SetSpectatorCameraMode(m_Bookmarks[nNum].ViewMode);
        SpectatorSetViewTarget(m_Bookmarks[nNum].ViewTarget, GetBlendParams(m_Bookmarks[nNum].ViewTarget));        
    }
    else
    {
        // End:0x2D1
        if(int(m_Bookmarks[nNum].ViewMode) == int(1))
        {
            SetSpectatorCameraMode(1);
            SetLocation(m_Bookmarks[nNum].POV.Location);
            SetRotation(m_Bookmarks[nNum].POV.Rotation);
            // End:0x26E
            if(m_BookmarkCamera == none)
            {
                m_BookmarkCamera = Spawn(Class'TgGame.TgSpectatorTempCam', self,, Location, Rotation,, true);                
            }
            else
            {
                m_BookmarkCamera.SetLocation(Location);
                m_BookmarkCamera.SetRotation(Rotation);
            }
            SpectatorSetViewTarget(self, GetBlendParams(m_BookmarkCamera));            
        }
        else
        {
            // End:0x387
            if(int(m_Bookmarks[nNum].ViewMode) == int(6))
            {
                SetSpectatorCameraMode(6, false);
                SetLocation(m_Bookmarks[nNum].POV.Location);
                SetRotation(m_Bookmarks[nNum].POV.Rotation);
            }
        }
    }
    Velocity = vect(0.0000000, 0.0000000, 0.0000000);
    Acceleration = vect(0.0000000, 0.0000000, 0.0000000);
    //return;    
}

exec function SpecSetFlightMode(TgSpectatorController.SpecFlightMode sfm)
{
    m_eHelicopterFlight = sfm;
    //return;    
}

exec function GotoCinematicCam(string sCamName)
{
    local array<Actor> camList;
    local Actor Cam;

    camList = GetViewTargetListForMode(7);
    // End:0x8E
    foreach camList(Cam)
    {
        // End:0x8D
        if(string(Cam.Tag) ~= ("Cinematic_" $ sCamName))
        {
            SetSpectatorCameraMode(5);
            SpectatorSetViewTarget(Cam);            
        }
        else
        {            
        }
    }    
    //return;    
}

exec function CameraSpeed(float NewSpeed)
{
    SpectatorCameraSpeed = NewSpeed;
    //return;    
}

exec function IncreaseCameraSpeeed()
{
    TgCameraModule_Spectator(TgPlayerCamera(PlayerCamera).CurrentCameraMod).IncreaseCameraSpeeed();
    //return;    
}

exec function DecreaseCameraSpeed()
{
    TgCameraModule_Spectator(TgPlayerCamera(PlayerCamera).CurrentCameraMod).DecreaseCameraSpeed();
    //return;    
}

function string StripClanTag(string PlayerName)
{
    return Split(PlayerName, "] ", true);
    //return ReturnValue;    
}

exec function ToggleOutlineCharacters()
{
    SpectateOutlines(!GetClientSettings().SpectateOutlines);
    //return;    
}

// Export UTgSpectatorController::execSetOutlineCharacters(FFrame&, void* const)
native function SetOutlineCharacters(bool bNewOutlineCharacters);

event float GetFOVAngle()
{
    local TgCameraModule_Spectator CurrentCameraModule;
    local float Angle;

    CurrentCameraModule = TgCameraModule_Spectator(TgPlayerCamera(PlayerCamera).CurrentCameraMod);
    // End:0xCA
    if(CurrentCameraModule != none)
    {
        Angle = CurrentCameraModule.GetFOVAngle();
        PlayerCamera.CameraCache.POV.FOV = Angle;
        return Angle;
    }
    return super.GetFOVAngle();
    //return ReturnValue;    
}

exec function SquashMap()
{
    m_bIsMapSquashed = !m_bIsMapSquashed;
    //return;    
}

exec function SpecTest()
{
    local TgCameraModule_SpectatorOverview OverviewCameraMod;

    OverviewCameraMod = TgCameraModule_SpectatorOverview(TgPlayerCamera(PlayerCamera).CurrentCameraMod);
    // End:0x119
    if(OverviewCameraMod != none)
    {
        m_bIsMapSquashed = !m_bIsMapSquashed;
        // End:0xAF
        if(!m_bIsMapSquashed)
        {
            OverviewCameraMod.WorldViewRotation = Class'TgGame.TgCameraModule_SpectatorOverview'.default.WorldViewRotation;            
        }
        else
        {
            OverviewCameraMod.WorldViewRotation.Pitch = -6000;
            OverviewCameraMod.WorldViewRotation.Yaw = 0;
        }
    }
    //return;    
}

exec function FlipOverviewSides()
{
    // End:0x5A
    if(int(m_CameraMode) == int(6))
    {
        TgCameraModule_SpectatorOverview(TgPlayerCamera(PlayerCamera).CurrentCameraMod).FlipSides();
    }
    //return;    
}

// Export UTgSpectatorController::execGetPawnFrom2DCoordinate(FFrame&, void* const)
native function Pawn GetPawnFrom2DCoordinate(Vector2D Coordinate);

// Export UTgSpectatorController::execGetActorListFrom2DCoordinate(FFrame&, void* const)
native function GetActorListFrom2DCoordinate(Vector2D Coordinate, out array<Actor> ActorList);

exec function SpectateZoomIn(bool bEnabled)
{
    // End:0x1C
    if(bEnabled)
    {
        ChangeZoomState(1);        
    }
    else
    {
        // End:0x3C
        if(int(m_CurrentZoomState) == int(1))
        {
            ChangeZoomState(0);
        }
    }
    //return;    
}

exec function SpectateZoomOut(bool bEnabled)
{
    // End:0x1C
    if(bEnabled)
    {
        ChangeZoomState(2);        
    }
    else
    {
        // End:0x3C
        if(int(m_CurrentZoomState) == int(2))
        {
            ChangeZoomState(0);
        }
    }
    //return;    
}

function ChangeZoomState(TgSpectatorController.EZoomState NewZoomState)
{
    m_CurrentZoomState = NewZoomState;
    //return;    
}

// Export UTgSpectatorController::execUpdateBroadcastChannels(FFrame&, void* const)
native function UpdateBroadcastChannels();

exec function SpectatePlayerIndex(int TaskForceNum, int PlayerIndex)
{
    local string PlayerName;

    PlayerName = TgRepInfo_Game(WorldInfo.GRI).GetTaskForce(TaskForceNum).GetPlayer(PlayerIndex).PlayerName;
    // End:0xA9
    if(Len(PlayerName) > 0)
    {
        SpecViewPlayer(PlayerName);
    }
    //return;    
}

// Export UTgSpectatorController::execGetTgPawn(FFrame&, void* const)
native function TgPawn GetTgPawn();

// Export UTgSpectatorController::execSetViewTarget(FFrame&, void* const)
native function SetViewTarget(Actor NewViewTarget, optional ViewTargetTransitionParams TransitionParams);

state SpectatingMatch extends Spectating
{
    ignores ForwardToSpectatingMatch;

    event BeginState(name PrevStateName)
    {
        local TgPawn OldPawn;

        OldPawn = TgPawn(Pawn);
        super.BeginState(PrevStateName);
        ClientSetRotation(rot(0, 0, 0));
        SetOutlineCharacters(GetClientSettings().SpectateOutlines);
        // End:0x120
        if(int(WorldInfo.NetMode) == int(NM_DedicatedServer))
        {
            // End:0xC1
            if(OldPawn != none)
            {
                OldPawn.Destroy();
            }
            CachedPRI.r_nPawnId = TgGame(WorldInfo.Game).GetNextActorInstanceId();            
        }
        else
        {
            CauseClientEvent('end_spectate');
            SetSpectatorCameraMode(default.m_CameraMode);
        }
        //return;        
    }

    function ProcessMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
    {
        // End:0x55
        if(ControlModule != none)
        {
            ControlModule.ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);            
        }
        else
        {
            super(BaseSpectating).ProcessMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
        }
        //return;        
    }

    function PlayerMove(float DeltaTime)
    {
        // End:0x52
        if(TgPlayerCamera(PlayerCamera) != none)
        {
            TgPlayerCamera(PlayerCamera).ProcessInput(PlayerInput, DeltaTime);
        }
        // End:0x81
        if(ShouldFlyFromInput())
        {
            SetSpectatorCameraMode(1);
            SpectatorSetViewTarget(self, GetSnapBlendParams());
        }
        // End:0xBB
        if(ControlModule != none)
        {
            ControlModule.PlayerMove(DeltaTime);            
        }
        else
        {
            super(BaseSpectating).PlayerMove(DeltaTime);
        }
        //return;        
    }

    function UpdateRotation(float DeltaTime)
    {
        // End:0x3A
        if(ControlModule != none)
        {
            ControlModule.UpdateRotation(DeltaTime);            
        }
        else
        {
            super(PlayerController).UpdateRotation(DeltaTime);
        }
        //return;        
    }

    function ReplicateMove(float DeltaTime, Vector newAccel, Actor.EDoubleClickDir DoubleClickMove, Rotator DeltaRot)
    {
        super(BaseSpectating).ReplicateMove(DeltaTime, newAccel, DoubleClickMove, DeltaRot);
        // End:0x82
        if((PlayerCamera != none) && PlayerCamera.bUseClientSideCameraUpdates)
        {
            PlayerCamera.bShouldSendClientSideCameraUpdate = true;
        }
        //return;        
    }

    exec function OnLeftMousePressed()
    {
        local TgControlModule_Spectator SpecControlModule;

        SpecControlModule = TgControlModule_Spectator(ControlModule);
        // End:0x4A
        if(SpecControlModule != none)
        {
            SpecControlModule.OnLeftMousePressed();
        }
        //return;        
    }

    exec function OnRightMousePressed()
    {
        global.OnRightMousePressed();
        //return;        
    }
    stop;    
}

state RoundEnded
{
    ignores SpecViewPlayer;

    event BeginState(name PreviousStateName)
    {
        // End:0x37
        if((int(m_CameraMode) == int(6)) || int(m_CameraMode) == int(7))
        {
            SetSpectatorCameraMode(1, false);
        }
        super.BeginState(PreviousStateName);
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_CameraMode=SpectatorCameraMode.SpecCam_Fly
    m_eHelicopterFlight=SpecFlightMode.SFM_Heli
    m_Bookmarks[0]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[1]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[2]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[3]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[4]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[5]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[6]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[7]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[8]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_Bookmarks[9]=(ViewTarget=none,ViewMode=SpectatorCameraMode.SpecCam_None,POV=(Location=(X=0.0000000,Y=0.0000000,Z=0.0000000),Rotation=(Pitch=0,Yaw=0,Roll=0),FOV=90.0000000,HUDOffset=(X=0.0000000,Y=0.0000000)))
    m_fDefaultTweenTime=0.3000000
    m_bIgnoreCullDistanceVolumes=true
    m_fNameplateFadeMinDist=4000.0000000
    m_fNameplateFadeMaxDist=8000.0000000
    m_fNameplateFadeMaxAmount=0.4000000
    m_fNameplateScaleMinDist=500.0000000
    m_fNameplateScaleMaxDist=4000.0000000
    m_fNameplateScaleMaxAmount=0.6000000
    m_fInterpolateCameraDistance=4000.0000000
    m_BroadcastChannels[0]=(Channel=ESpectatorMode.SPECMODE_Broadcast1,PlayerID=0)
    m_BroadcastChannels[1]=(Channel=ESpectatorMode.SPECMODE_Broadcast2,PlayerID=0)
    m_BroadcastChannels[2]=(Channel=ESpectatorMode.SPECMODE_Broadcast3,PlayerID=0)
    m_BroadcastChannels[3]=(Channel=ESpectatorMode.SPECMODE_Broadcast4,PlayerID=0)
    c_vMouseClickDeprojectionExtent=(X=3.0000000,Y=3.0000000,Z=3.0000000)
    m_fMouseCursorVisibleTime=2.0000000
    m_bCanHearStealthPawns=true
    DefaultControlModuleClass=Class'TgGame.TgControlModule_Spectator'
    CameraClass=Class'TgGame.TgSpectatorCamera'
    InputClass=Class'TgGame.TgSpectatorInput'
    // Reference: CylinderComponent'TgGame.Default__TgSpectatorController.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPlayerController.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}