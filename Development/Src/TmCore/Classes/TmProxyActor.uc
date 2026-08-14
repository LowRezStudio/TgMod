class TmProxyActor extends Actor;

var TmCheatManager OwnedCheatManager;   // CheatManager this proxy created/bound on its client
var TgDemoRecSpectator RecPC;

simulated reliable client function ClientAddCheats() {
    local TgPlayerController PC;
    local TmCheatManager CM;

    PC = TgPlayerController(Owner);
    if (PC == none) {
        return;
    }

    CM = TmCheatManager(PC.CheatManager);
    if (CM == none) {
        PC.CheatClass = Class'TmCheatManager';
        CM = new (PC) Class'TmCheatManager';
        PC.CheatManager = CM;
    }

    if (CM != none) {
        CM.InitCheatManager();
        CM.Proxy = self;
        OwnedCheatManager = CM;
        `LogInfo('TmProxyActor', (("CheatManager successfully created and initialized : " @ string(CM.Name)) @ ":") @ string(CM.Outer.Name));
    } else {
        `LogError('TmProxyActor', "Failed to create CheatManager!");
    }
}

function ServerAddCheats() {
    if (Role == ROLE_Authority) {
        ClientAddCheats();
    }
    ClientAddCheats();
}


// CLIENT -> SERVER

// Dumb way of executing arbitrary commands on the server using one Hi-Rez's whitelisted Server commands
reliable server function ServerVerifyVehiclePhys(string Command) {
    local TgPlayerController PC;

    if (Role == ROLE_Authority) {
        PC = TgPlayerController(Owner);
        if (PC != none) {
            PC.ConsoleCommand(Command);
        }
    }
}

// Same thing
reliable server function ServerToggleVehicleJets(string command, optional string option) {
    local TgPlayerController PC;

    PC = TgPlayerController(Owner);

    if (command ~= "help") {
        PC.ClientMessage("Admin help");
    }
}

// SERVER -> CLIENT

simulated reliable client function ClientLog(string message) {
    `LogInfo('TmProxyActor', message);
}

simulated reliable client function ClientConsoleCommand(string Command, optional bool WriteToLog) {
    local TmCheatManager CM;

    CM = TmCheatManager(TgPlayerController(Owner).CheatManager);
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

function string GetOwnerName() {
    local TgPlayerController PC;

    PC = TgPlayerController(Owner);
    if (PC != none && PC.PlayerReplicationInfo != none) {
        return PC.PlayerReplicationInfo.PlayerName;
    }
    return string(Owner);
}

defaultproperties {
    bOnlyRelevantToOwner=true
}