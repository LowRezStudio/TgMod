class ATempestLib extends Actor;
// A collection of useful functions

var int lastWorldTime;
var string OriginalPlayerName;
var string AnimatedPlayerName;
var float NameAnimStartTime;
var bool bNameAnimActive;

public function initTimer() {
    lastWorldTime = WorldInfo.TimeSeconds;
}

public function bool hasTimeElapsed(int seconds, bool reset) {
    if((WorldInfo.TimeSeconds - lastWorldTime) > seconds) {
        if(reset) {
            lastWorldTime = WorldInfo.TimeSeconds;
        }
        return true;
    }
    return false;
}

public function int toInt(coerce int strNb) {
    return strNb;
}

public function string decodeURLParam(string encodedParam)
{
    local string decodedParam;
    decodedParam = encodedParam;
    
    // Decode common URL entities
    decodedParam = Repl(decodedParam, "%spc", " ");
    decodedParam = Repl(decodedParam, "%qtm", "?");
    decodedParam = Repl(decodedParam, "%amp", "&");
    decodedParam = Repl(decodedParam, "%eql", "=");
    decodedParam = Repl(decodedParam, "%hsh", "#");
    decodedParam = Repl(decodedParam, "%prc", "%");
    
    return decodedParam;
}

function string UpdateAnimatedName(string PlayerName)
{
    local string TargetName;
    local int MaxSteps;
    local float ElapsedTime;
    local int CurrentStep;
    local float CycleTime;
    local int CharPos;
    local int VisibleChars;
    
    // Initialize if needed
    if (OriginalPlayerName != PlayerName || !bNameAnimActive)
    {
        OriginalPlayerName = PlayerName;
        NameAnimStartTime = WorldInfo.TimeSeconds;
        bNameAnimActive = true;
    }
    
    // Build target string
    TargetName = "<3 " $ OriginalPlayerName $ " <3";
    MaxSteps = Len(TargetName);
    
    // Calculate elapsed time since animation started
    ElapsedTime = WorldInfo.TimeSeconds - NameAnimStartTime;
    
    // Total cycle time: animation + 2 second pause
    CycleTime = (MaxSteps + 2) * 1; // 4 extra steps for 2 second pause
    
    // Get position within current cycle
    ElapsedTime = ElapsedTime - (int(ElapsedTime / CycleTime) * CycleTime);
    
    // Calculate current step (0.5 seconds per step, but skip spaces)
    CurrentStep = int(ElapsedTime / 1);
    
    // Build display string
    if (CurrentStep == 0)
    {
        AnimatedPlayerName = "";
    }
    else if (CurrentStep <= MaxSteps)
    {
        // Find the actual character position, skipping spaces in timing
        
        VisibleChars = 0;
        for (CharPos = 1; CharPos <= MaxSteps && VisibleChars < CurrentStep; CharPos++)
        {
            if (Mid(TargetName, CharPos - 1, 1) != " ")
            {
                VisibleChars++;
            }
            if (VisibleChars >= CurrentStep)
            {
                AnimatedPlayerName = Left(TargetName, CharPos);
                break;
            }
        }
        
        // If we've processed all characters, show the full string
        if (CharPos > MaxSteps)
        {
            AnimatedPlayerName = TargetName;
        }
    }
    else
    {
        // Show complete name during pause
        AnimatedPlayerName = TargetName;
    }
    
    return AnimatedPlayerName;
}

/*
public function setNextMap() {
    local TgPlayerController TgPC;
    local int rmap;
    local array<MapData> ValidMaps;
    local int i;
    local string Gamemode;
    Gamemode = "Siege";
    for(i = 0; i < allMaps.MapDatabase.Length; i++) {
        if(allMaps.MapDatabase[i].MapGamemodes.Find(Gamemode) != INDEX_NONE) {
            ValidMaps.AddItem(allMaps.MapDatabase[i]);
        }
    }

    if(ValidMaps.Length > 0) {
        rmap = rand(ValidMaps.Length);
        nextMap = ValidMaps[rmap].MapName;

        foreach AllActors(class'TgPlayerController', TgPC) {
            TgPC.ClientMessage("The server will soon restart and your game will close.", , 15);
            TgPC.ClientMessage("The next Map will be:" @ ValidMaps[rmap].MapReadableName, , 15);
        }
    } else {
        rmap = rand(allMaps.MapDatabase.Length);
        nextMap = allMaps.MapDatabase[rmap].MapName;

        foreach AllActors(class'TgPlayerController', TgPC) {
            TgPC.ClientMessage("The server will soon restart and your game will close.", , 15);
            TgPC.ClientMessage("The next Map will be:" @ allMaps.MapDatabase[rmap].MapReadableName, , 15);
        }
    }
}
 */