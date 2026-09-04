class LocalMessage extends Object
    abstract;

var bool bIsSpecial;
var bool bIsUnique;
var bool bIsPartiallyUnique;
var bool bIsConsoleMessage;
var bool bBeep;
var bool bCountInstances;
var float Lifetime;
var Color DrawColor;
var float PosY;
var int FontSize;

static function ClientReceive(PlayerController P, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    local string MessageString;

    MessageString = GetString(Switch, RelatedPRI_1 == P.PlayerReplicationInfo, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    // End:0x2B1
    if(MessageString != "")
    {
        // End:0x1B8
        if(P.myHUD != none)
        {
            P.myHUD.LocalizedMessage(default.Class, RelatedPRI_1, RelatedPRI_2, MessageString, Switch, GetPos(Switch, P.myHUD), GetLifeTime(Switch), GetFontSize(Switch, RelatedPRI_1, RelatedPRI_2, P.PlayerReplicationInfo), GetColor(Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject), OptionalObject);
        }
        // End:0x2B1
        if(((IsConsoleMessage(Switch)) && LocalPlayer(P.Player) != none) && LocalPlayer(P.Player).ViewportClient != none)
        {
            LocalPlayer(P.Player).ViewportClient.ViewportConsole.OutputText(MessageString);
        }
    }
    //return;    
}

static function string GetString(optional int Switch, optional bool bPRI1HUD, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    // End:0x61
    if(Class<Actor>(OptionalObject) != none)
    {
        return Class<Actor>(OptionalObject).static.GetLocalString(Switch, RelatedPRI_1, RelatedPRI_2);
    }
    return "";
    //return ReturnValue;    
}

static function Color GetConsoleColor(PlayerReplicationInfo RelatedPRI_1)
{
    return default.DrawColor;
    //return ReturnValue;    
}

static function Color GetColor(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    return default.DrawColor;
    //return ReturnValue;    
}

static function float GetPos(int Switch, HUD myHUD)
{
    return default.PosY;
    //return ReturnValue;    
}

static function int GetFontSize(int Switch, PlayerReplicationInfo RelatedPRI1, PlayerReplicationInfo RelatedPRI2, PlayerReplicationInfo LocalPlayer)
{
    return default.FontSize;
    //return ReturnValue;    
}

static function float GetLifeTime(int Switch)
{
    return default.Lifetime;
    //return ReturnValue;    
}

static function bool IsConsoleMessage(int Switch)
{
    return default.bIsConsoleMessage;
    //return ReturnValue;    
}

static function bool PartiallyDuplicates(int Switch1, int Switch2, Object OptionalObject1, Object OptionalObject2)
{
    return Switch1 == Switch2;
    //return ReturnValue;    
}

defaultproperties
{
    bIsSpecial=true
    bIsConsoleMessage=true
    Lifetime=3.0000000
    DrawColor=(R=255,G=255,B=255,A=255)
    PosY=0.8300000
}