class TempestUtils extends Object
    abstract
    config(TempestUtils);

var config string CachedName;
var config string CachedCharacter;

static function TempestProxyActor SetupProxy(TgPlayerController PC) {
    local TempestProxyActor ProxyActor;

    ProxyActor = PC.Spawn(Class'TgMod.TempestProxyActor', PC);
    if (ProxyActor != none) {
        ProxyActor.SetOwner(PC);

        return ProxyActor;
    } else {
        `log("Failed to spawn proxy actor");
        return none;
    }
}

static event NavigationPoint GetReviveLocation(TgGame Game, Controller Player, out Vector OutLocation, out Rotator OutRotation)
{
    local NavigationPoint RestartNavPoint;
    local TgTeamPlayerStart TPS;
    local Vector Forward;

    RestartNavPoint = Game.FindPlayerStart(Player);
    // End:0x117
    if(RestartNavPoint != none)
    {
        OutLocation = RestartNavPoint.Location;
        OutRotation = RestartNavPoint.Rotation;
        // End:0x114
        if(Player.Pawn != none)
        {
            TPS = TgTeamPlayerStart(RestartNavPoint);
            // End:0x114
            if(TPS != none)
            {
                OutRotation = TPS.GetSpawnRotationFor(Player.Pawn);
            }
        }        
    }

    // End:0x1B8
    if(Player.Pawn != none)
    {
        OutLocation = Player.Pawn.Location;
        OutRotation = Player.Pawn.Rotation;            
    }
    else
    {
        // End:0x217
        if(Player != none)
        {
            OutLocation = Player.Location;
            OutRotation = Player.Rotation;
        }
    }
    
    Forward = Vector(OutRotation);
    // End:0x26C
    if(Forward.Z < 1.0000000)
    {
        OutRotation = Rotator(Normal2D(Forward));        
    }
    else
    {
        OutRotation = MakeRotator(0, 0, 0);
    }
    return RestartNavPoint;
    //return ReturnValue;    
}

static function SetupPRI(TgGame Game, TgRepInfo_Player PRI, int Address, string PlayerName, int taskforce, int mountId, int titleId, optional bool spectator) {
    local TgPlayerController PC;
    PC = TgPlayerController(PRI.Owner);

    if(taskforce == 3) spectator = true;

    PC.s_nPlayerId = Address;
    PC.s_qwNetAccessFlags.A = 0xFFFFFFFF;
    PC.s_qwNetAccessFlags.B = 0xFFFFFFFF;

    PRI.UniqueId.Uid.A = PC.s_nPlayerId;
    PRI.r_nPlayerId = PC.s_nPlayerId;
    PRI.PlayerName = PlayerName;
    //PRI.r_nPawnId = PC.s_nPlayerId;

    PC.m_nVoicePackId = 13450;
    PRI.r_nMountSkinId = mountId;
    PRI.r_nEquippedTitleId = titleId;
    //PRI.r_nVoicePackId = 13450;

    PRI.SetTaskForceNumber(taskforce, true);

    PRI.bOnlySpectator = false;
    PRI.bIsSpectator = false;
    PRI.bReadyToPlay = true;
    PRI.bWaitingPlayer = false;
    PRI.bAdmin = true;
}

static function SetupSpectatorPRI(TgDemoRecSpectator PC, TgRepInfo_Player PRI, int Address, string PlayerName, int taskforce) {

    PC.s_nPlayerId = Address;
    PC.s_qwNetAccessFlags.A = 0xFFFFFFFF;
    PC.s_qwNetAccessFlags.B = 0xFFFFFFFF;

    PRI.UniqueId.Uid.A = PC.s_nPlayerId;
    PRI.r_nPlayerId = PC.s_nPlayerId;
    PRI.PlayerName = PlayerName;
    //PRI.r_nPawnId = PC.s_nPlayerId;

    PRI.SetTaskForceNumber(255, true);

    PRI.bOnlySpectator = true;
    PRI.bIsSpectator = true;
    PRI.bReadyToPlay = true;
    PRI.bWaitingPlayer = false;
}

static function SpawnPawn(TgGame Game, TgPlayerController PC, int BotId, int SkinId, int DeviceSkinId, int HeadId, int mountId) {
    local TgPawn SpawnedPawn;
    local NavigationPoint PlayerStart;
    local Vector OutLocation;
    local Rotator OutRotation;
    local TgPawn_Character CharacterPawn;

    PlayerStart = GetReviveLocation(Game, PC, OutLocation, OutRotation);

    Game.EnsureBotPrecache(BotId, SkinId, HeadId, DeviceSkinId);
    SpawnedPawn = TgPawn(Game.SpawnDefaultPawnFor(PC, PlayerStart));
    SpawnedPawn.PostPawnSetupServer();

    if(SpawnedPawn != none) {
        PC.Possess(SpawnedPawn, true);
        PC.AcknowledgePossession(SpawnedPawn);

        PC.WorldInfo.NetMode = NM_Standalone;
        SpawnedPawn = Game.SpawnTemplatePlayer(PC, BotId, SkinId, DeviceSkinId, HeadId);
        PC.WorldInfo.NetMode = NM_DedicatedServer;

        if(SpawnedPawn != none) {
            CharacterPawn = TgPawn_Character(SpawnedPawn);
            CharacterPawn.r_nMountSkinId = mountId;
            //CharacterPawn.r_nVoicePackId = 13450;
            CharacterPawn.ApplyPawnSetup();
            CharacterPawn.PostPawnSetup();
            PC.Possess(CharacterPawn, true);
            PC.AcknowledgePossession(CharacterPawn);
        } else {
            `log("TempestUtils: Failed to spawn pawn 2");
        }     
    } else {
        `log("TempestUtils: Failed to spawn pawn");
    }
}