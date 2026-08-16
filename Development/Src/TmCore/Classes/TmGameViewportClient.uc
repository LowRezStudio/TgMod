class TmGameViewportClient extends TgGameViewportClient within Engine
    config(TmConfig);

var TgPlayerController PC;
var TmProxyActor PA;

var float StartTime;
var bool bHasStarted;

var config Guid PlayerGuid;

// Ability-bar text keys for the 5 slots shown to a spectator.
const AB_SLOTS = 5;

function PostRender(Canvas Canvas)
{
    local TmSpectatorController SPC;
    local int i;
    local float x, y, w, h, gap, slotX, slotY, barH;

    super.PostRender(Canvas);

    // Access TimeSeconds from PlayerController's WorldInfo
    PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    if (PC == None || PC.WorldInfo == None)
        return;

    // Set StartTime once
    if (!bHasStarted)
    {
        StartTime = PC.WorldInfo.TimeSeconds;
        bHasStarted = true;
    }

    // Only draw for 20 seconds
    if (`TimeSinceEx(PC, StartTime) < 20)
    {
        Canvas.SetDrawColor(0,255,0,255);
        Canvas.SetPos(49, 50);
        Canvas.DrawText("TEMPEST LAUNCHER");
        Canvas.SetPos(50, 65);
        Canvas.DrawText("F1: ENTER SHOOTING RANGE");
        Canvas.SetPos(50, 80);
        Canvas.DrawText("F2: OPEN CONSOLE");
    }

    findPCAndAttachCM();

    // Abilities bar
    SPC = TmSpectatorController(PC);
    if (SPC == none || Canvas == none)
        return;

    w = 54.0;
    h = 54.0;
    gap = 6.0;
    barH = 6.0;
    x = (Canvas.ClipX - (w * 5.0 + gap * 4.0)) * 0.5;
    y = Canvas.ClipY - h - barH - 16.0;

    for (i = 0; i < AB_SLOTS; i++) {
        slotX = x + i * (w + gap);
        slotY = y;

        Canvas.SetDrawColor(0, 0, 0, 160);
        Canvas.SetPos(slotX, slotY);
        Canvas.DrawRect(w, h);

        if (SPC.Abilities[i].DeviceName == "")
            continue;

        // Input label.
        Canvas.DrawColor = MakeColor(255, 200, 120, 255);
        Canvas.Font = Class'Engine.Engine'.static.GetTinyFont();
        Canvas.SetPos(slotX + 4, slotY + 3);
        Canvas.DrawText(GetAbilityKey(i), false);

        // Ability name.
        Canvas.DrawColor = MakeColor(255, 255, 255, 255);
        Canvas.SetPos(slotX + 4, slotY + 16);
        Canvas.DrawText(Left(SPC.Abilities[i].DeviceName, 12), false);

        if (SPC.Abilities[i].MaxAmmo > 0) {
            Canvas.DrawColor = MakeColor(255, 255, 255, 255);
            Canvas.SetPos(slotX + 4, slotY + h - 20);
            Canvas.DrawText(SPC.Abilities[i].CurrentAmmo @ "/" @ SPC.Abilities[i].MaxAmmo, false);
        }

        // Cooldown bar.
        Canvas.SetDrawColor(0, 0, 0, 200);
        Canvas.SetPos(slotX, slotY + h);
        Canvas.DrawRect(w, barH);
        Canvas.DrawColor = MakeColor(255, 120, 60, 255);
        Canvas.SetPos(slotX, slotY + h);
        Canvas.DrawRect(w * (1.0 - SPC.Abilities[i].CooldownPct), barH);
    }
}

static final function string GetAbilityKey(int i) {
    if (i == 0) return "LMB";
    if (i == 1) return "RMB";
    if (i == 2) return "Q";
    if (i == 3) return "F";
    if (i == 4) return "E";
    return "";
}

event bool Init(out string OutError)
{
    // Create the viewport's console.
	ViewportConsole = new(Self) class'Engine.Console';

	if (InsertInteraction(ViewportConsole) == -1)
	{
		OutError = "Failed to add interaction to GlobalInteractions array:" @ ViewportConsole;
		return false;
	}

    SetConsoleTarget(0);

    if(PlayerGuid.A == 0) {
        PlayerGuid = CreateGuid();
        SaveConfig();
    }

    return super.Init(OutError);
}

/**
 * Sets the player which console commands will be executed in the context of.
 */
exec function SetConsoleTarget(int PlayerIndex)
{
	if (ViewportConsole != none)
	{
		if(PlayerIndex >= 0 && PlayerIndex < GamePlayers.Length)
		{
			ViewportConsole.ConsoleTargetPlayer = GamePlayers[PlayerIndex];
		}
		else
		{
			ViewportConsole.ConsoleTargetPlayer = None;
		}
	}
}

public function findPCAndAttachCM() {
	PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    
    if (PC.CheatManager == None) {
        PA = `UTILS.SetupProxy(PC);
        
        PC.CheatClass = class'TmCheatManager';
        PC.CheatManager = new(PC) class'TmCheatManager';
        if (PC.CheatManager != None) {
            PC.CheatManager.InitCheatManager();
			PC.ConsoleCommand("changetaskforce 1");
        } else {
            `LogError('TmGameViewport', "Failed to create CheatManager!");
        }
    }
}