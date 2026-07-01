class TempestProxyActor extends Actor;

simulated reliable client function ClientAddCheats() {
    local TgPlayerController PC;
    PC = TgPlayerController(Owner);

    PC.CheatClass = Class'TgGame.TgBattleCheatManager';
    if(PC.CheatManager == none) {
        PC.CheatManager = new (PC) Class'TgGame.TgBattleCheatManager';
        if(PC.CheatManager != none) {
            PC.CheatManager.InitCheatManager();
            `Log((("TempestProxyActor: CheatManager successfully created and initialized : " @ string(PC.CheatManager.Name)) @ ":") @ string(PC.CheatManager.Outer.Name));                
        } else {
            `Log("TempestProxyActor: Failed to create CheatManager!");
        }
    }
}

function ServerAddCheats() {
    if (Role == ROLE_Authority) {
        ClientAddCheats();
    }
    ClientAddCheats();
}

simulated reliable client function ClientConsoleCommand(string Command, optional bool bWriteToLog) {
    local TgBattleCheatManager CM;

    CM = TgBattleCheatManager(TgPlayerController(Owner).CheatManager);
    if (CM != none) {
        CM.Outer.ConsoleCommand(Command, bWriteToLog);
    } else {
        `Log("TempestProxyActor: No cheat manager found");
    }
}

simulated reliable client function ClientPrecacheClass(string godName, optional string skinName, optional string weaponSkinName) {
    ClientConsoleCommand("PrecacheClass" @ godName @ skinName @ weaponSkinName);
}

simulated reliable client function ClientTestPrecache(int nBotId, int nSkinId, int nWeaponSkinId, int nHeadId, optional bool bAll = false) {
    ClientConsoleCommand("TestPrecache" @ nBotId @ nSkinId @ nWeaponSkinId @ nHeadId @ "true");
}

public simulated reliable client function talkToClient(string message) {
    `log("The server said to me :" @ message);
}

defaultproperties {
    bOnlyRelevantToOwner=true
}