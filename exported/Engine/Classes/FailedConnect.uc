class FailedConnect extends LocalMessage
    abstract;

var const localized string FailMessage[4];

static function int GetFailSwitch(string FailString)
{
    // End:0x18
    if(FailString ~= "NEEDPW")
    {
        return 0;
    }
    // End:0x31
    if(FailString ~= "WRONGPW")
    {
        return 1;
    }
    // End:0x4F
    if(FailString ~= "GAMESTARTED")
    {
        return 2;
    }
    return 3;
    //return ReturnValue;    
}

static function string GetString(optional int Switch, optional bool bPRI1HUD, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    return default.FailMessage[Clamp(Switch, 0, 3)];
    //return ReturnValue;    
}

defaultproperties
{
    FailMessage[0]="FAILED TO JOIN GAME.  NEED PASSWORD."
    FailMessage[1]="FAILED TO JOIN GAME.  WRONG PASSWORD."
    FailMessage[2]="FAILED TO JOIN GAME.  GAME HAS STARTED."
    FailMessage[3]="FAILED TO JOIN GAME."
    bIsUnique=true
    DrawColor=(R=255,G=0,B=128,A=255)
    FontSize=1
}