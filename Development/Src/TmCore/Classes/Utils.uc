class Utils extends Object
    abstract
    config(Utils);

var config string CachedName;
var config string CachedCharacter;

static function TmProxyActor SetupProxy(TgPlayerController PC) {
    local TmProxyActor ProxyActor;

    ProxyActor = PC.Spawn(Class'TmCore.TmProxyActor', PC);
    if (ProxyActor != none) {
        ProxyActor.SetOwner(PC);

        return ProxyActor;
    } else {
        `LogError('TmCoreUtils', "Failed to spawn proxy actor");
        return none;
    }
}

static function int ToInt(coerce int strNb) {
    return strNb;
}

static function string DecodeURLParam(string encodedParam)
{
    local string decodedParam;
    decodedParam = encodedParam;
    
    decodedParam = Repl(decodedParam, "%spc", " ");
    decodedParam = Repl(decodedParam, "%qtm", "?");
    decodedParam = Repl(decodedParam, "%amp", "&");
    decodedParam = Repl(decodedParam, "%eql", "=");
    decodedParam = Repl(decodedParam, "%hsh", "#");
    decodedParam = Repl(decodedParam, "%prc", "%");
    
    return decodedParam;
}

static function SetupPRI(TgGame Game, TgRepInfo_Player PRI, int Address, string PlayerName, int TaskForce, int MountId) {
    local TgPlayerController PC;
    PC = TgPlayerController(PRI.Owner);

    PC.s_nPlayerId = Address;
    PC.s_qwNetAccessFlags.A = 0xFFFFFFFF;
    PC.s_qwNetAccessFlags.B = 0xFFFFFFFF;

    PRI.UniqueId.Uid.A = PC.s_nPlayerId;
    PRI.r_nPlayerId = PC.s_nPlayerId;
    PRI.PlayerName = PlayerName;

    PC.m_nVoicePackId = 13450;
    PRI.r_nMountSkinId = MountId;

    PRI.SetTaskForceNumber(TaskForce, true);

    PRI.bOnlySpectator = false;
    PRI.bIsSpectator = false;
    PRI.bReadyToPlay = true;
    PRI.bWaitingPlayer = false;
    PRI.bAdmin = true;
}

static function SpawnPawn(TgGame Game, TgPlayerController PC, int BotId, int SkinId, int DeviceSkinId, int HeadId, int MountId) {
    local TgPawn SpawnedPawn;
    local NavigationPoint PlayerStart;
    local Vector OutLocation;
    local Rotator OutRotation;
    local TgPawn_Character CharacterPawn;

    PlayerStart = Game.GetReviveLocation(PC, OutLocation, OutRotation);

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
            CharacterPawn.r_nMountSkinId = MountId;
            CharacterPawn.ApplyPawnSetup();
            CharacterPawn.PostPawnSetup();
            PC.Possess(CharacterPawn, true);
            PC.AcknowledgePossession(CharacterPawn);
        } else {
            `LogError('TmCoreUtils', "Failed to spawn pawn (backup)");
        }     
    } else {
        `LogError('TmCoreUtils', "Failed to spawn pawn");
    }
}