class TmProxyActor extends Actor;

simulated reliable client function ClientAddCheats() {
    local TgPlayerController PC;
    PC = TgPlayerController(Owner);

    PC.CheatClass = Class'TgGame.TgBattleCheatManager';
    if(PC.CheatManager == none) {
        PC.CheatManager = new (PC) Class'TgGame.TgBattleCheatManager';
        if(PC.CheatManager != none) {
            PC.CheatManager.InitCheatManager();
            `LogInfo('TmProxyActor', (("CheatManager successfully created and initialized : " @ string(PC.CheatManager.Name)) @ ":") @ string(PC.CheatManager.Outer.Name));                
        } else {
            `LogError('TmProxyActor', "Failed to create CheatManager!");
        }
    }
}

function ServerAddCheats() {
    if (Role == ROLE_Authority) {
        ClientAddCheats();
    }
    ClientAddCheats();
}

simulated reliable client function ClientConsoleCommand(string Command, optional bool WriteToLog) {
    local TgBattleCheatManager CM;

    CM = TgBattleCheatManager(TgPlayerController(Owner).CheatManager);
    if (CM != none) {
        CM.Outer.ConsoleCommand(Command, WriteToLog);
    } else {
        `Log("TempestProxyActor: No cheat manager found");
    }
}

simulated reliable client function ClientPrecacheClass(string GodName, optional string SkinName, optional string WeaponSkinName) {
    ClientConsoleCommand("PrecacheClass" @ GodName @ SkinName @ WeaponSkinName);
}

simulated reliable client function ClientTestPrecache(int BotId, int SkinId, int WeaponSkinId, int HeadId) {
    ClientConsoleCommand("TestPrecache" @ BotId @ SkinId @ WeaponSkinId @ HeadId @ "true");
}

public simulated reliable client function talkToClient(string message) {
    `LogInfo('TmProxyActor', "The server said to me :" @ message);
}

defaultproperties {
    bOnlyRelevantToOwner=true
}