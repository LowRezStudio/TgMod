class TmGameViewportClient extends TgGameViewportClient within Engine
    config(TmConfig);

var TgPlayerController PC;
var TmProxyActor PA;

var float StartTime;
var bool bHasStarted;

var config Guid PlayerGuid;

function PostRender(Canvas Canvas)
{
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