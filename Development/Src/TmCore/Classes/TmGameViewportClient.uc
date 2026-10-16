class TmGameViewportClient extends TgGameViewportClient within Engine
    config(TmConfig);

var TgPlayerController PC;
var TmProxyActor PA;

var float StartTime;
var bool bHasStarted;

function PostRender(Canvas Canvas)
{
    super.PostRender(Canvas);

    PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    if (PC == none || PC.WorldInfo == none)
        return;

    if (!bHasStarted)
    {
        StartTime = PC.WorldInfo.TimeSeconds;
        bHasStarted = true;
    }

    if (`TimeSinceEx(PC, StartTime) < 20)
    {
        Canvas.SetDrawColor(0, 255, 0, 255);
        Canvas.SetPos(49, 50);
        Canvas.DrawText("TEMPEST LAUNCHER");
        Canvas.SetPos(50, 65);
        Canvas.DrawText("F1: ENTER SHOOTING RANGE");
        Canvas.SetPos(50, 80);
        Canvas.DrawText("F2: OPEN CONSOLE");
    }

    findPCAndAttachCM();

    if (TmSpectatorController(PC) != none)
        TmSpectatorController(PC).TickSpectatorHUD();
}

event bool Init(out string OutError)
{
    ViewportConsole = new(Self) class'Engine.Console';
    if (InsertInteraction(ViewportConsole) == -1)
    {
        OutError = "Failed to add interaction to GlobalInteractions array:" @ ViewportConsole;
        return false;
    }
    SetConsoleTarget(0);
    return super.Init(OutError);
}

exec function SetConsoleTarget(int PlayerIndex)
{
    if (ViewportConsole != none)
    {
        if (PlayerIndex >= 0 && PlayerIndex < GamePlayers.Length)
            ViewportConsole.ConsoleTargetPlayer = GamePlayers[PlayerIndex];
        else
            ViewportConsole.ConsoleTargetPlayer = none;
    }
}

// Client-side cheat-manager bootstrap: spawn the proxy and install
// TmCheatManager through the single install seam in Utils.
public function findPCAndAttachCM()
{
    PC = TgPlayerController(self.GetPlayerOwner(0).Actor);
    if (PC.CheatManager == none)
    {
        PA = `UTILS.SetupProxy(PC);
        if (`UTILS.InstallCheatManager(PC, class'TmCheatManager') != none)
        {
            // Bind the proxy now; the server-side ClientAddCheats may not
            // arrive for a while (or at all), and GM execs need the link.
            TmCheatManager(PC.CheatManager).Proxy = PA;
            PC.ConsoleCommand("changetaskforce 1");
        }
    }
}
