// Test bed for Lua-implemented natives.
//
// `dllimport` functions of a `DLLBind` class have no UnrealScript body and no
// C++ implementation. Tempest.Scripting binds every such function to a Lua
// handler registered with `tempest.native("TmLuaTest.TmLuaGame.LuaAdd", fn)`;
// unimplemented ones return zero/empty and log once. The DLL name is only a
// label: the Paladins engine never loads it.
//
// Its own package (TmLuaTest.upk, mods/TmLuaTest -> output/TmLuaTest.tempest) so
// it installs without the rest of Tempest Core:
//   TEMPEST_MOD_SPEC=mods/TmLuaTest nu tool.nu
// Try it: `open Shootingrange_P?game=TmLuaTest.TmLuaGame` in the dev console
// with the scripting runtime's dev mod installed (dev/scripts/10_lua_natives.lua).
class TmLuaGame extends TgGame_Paladins_ShootingRange DLLBind(TempestScripting);

var int HeartbeatCount;

// UDK only accepts int, float, byte, bool, string and structs of those as
// dllimport parameters (no object references); the Lua handler still gets
// the calling object as `this`.

// Plain values in, plain value out.
dllimport final function int LuaAdd(int A, int B);

// Strings cross the boundary as engine-owned FStrings.
dllimport final function string LuaGreet(string Who);

// An `out` struct the handler fills in, bool result.
dllimport final function bool LuaOnPlayerSpawned(int PlayerId, out Vector Boost);

// No return value: a periodic callback into Lua.
dllimport final function LuaHeartbeat(float Elapsed, int Count);

// The other way to hand a function to Lua: an ordinary function with a stub
// body. Any UnrealScript types work here, object references included, and
// the body is what runs when no Lua handler is registered.
function string LuaDescribe(Actor A) {
    return "(LuaDescribe not implemented in Lua)";
}

function bool LuaControllerOf(Pawn P, out Controller C) {
    return false;
}

event PostBeginPlay() {
    super.PostBeginPlay();
    `log("TmLuaGame: LuaAdd(2, 3) = " $ LuaAdd(2, 3) $ ", LuaGreet = '" $ LuaGreet("PostBeginPlay") $ "'");
    SetTimer(5.0, true, 'Heartbeat');
}

function Heartbeat() {
    HeartbeatCount++;
    LuaHeartbeat(WorldInfo.TimeSeconds, HeartbeatCount);
}

event PostLogin(PlayerController NewPlayer) {
    super.PostLogin(NewPlayer);
    NewPlayer.ClientMessage("TmLuaGame: LuaAdd(2, 3) = " $ LuaAdd(2, 3));
    NewPlayer.ClientMessage("TmLuaGame: LuaGreet = " $ LuaGreet(NewPlayer.PlayerReplicationInfo.PlayerName));
    NewPlayer.ClientMessage("TmLuaGame: LuaDescribe(PC) = " $ LuaDescribe(NewPlayer));
}

function RestartPlayer(Controller NewPlayer) {
    local Vector Boost;
    local Controller C;

    super.RestartPlayer(NewPlayer);
    if (NewPlayer.Pawn != None && LuaOnPlayerSpawned(NewPlayer.PlayerReplicationInfo.PlayerID, Boost)) {
        NewPlayer.Pawn.Velocity += Boost;
        `log("TmLuaGame: spawn boost " $ Boost.X $ " " $ Boost.Y $ " " $ Boost.Z);
    }
    if (NewPlayer.Pawn != None && LuaControllerOf(NewPlayer.Pawn, C) && PlayerController(NewPlayer) != None) {
        PlayerController(NewPlayer).ClientMessage("TmLuaGame: LuaControllerOf(" $ NewPlayer.Pawn $ ") = " $ C
            $ " (" $ LuaDescribe(NewPlayer.Pawn) $ ")");
    }
}

defaultproperties
{
}
