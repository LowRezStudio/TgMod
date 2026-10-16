class BroadcastHandler extends Info
    config(Game)
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var int SentText;
var config bool bMuteSpectators;

function UpdateSentText()
{
    SentText = 0;
    //return;    
}

function bool AllowsBroadcast(Actor broadcaster, int InLen)
{
    // End:0x6B
    if((bMuteSpectators && PlayerController(broadcaster) != none) && PlayerController(broadcaster).PlayerReplicationInfo.bOnlySpectator)
    {
        return false;
    }
    SentText += InLen;
    return (WorldInfo.Pauser != none) || SentText < 260;
    //return ReturnValue;    
}

function BroadcastText(PlayerReplicationInfo SenderPRI, PlayerController Receiver, coerce string msg, optional name Type)
{
    Receiver.TeamMessage(SenderPRI, msg, Type);
    //return;    
}

function BroadcastLocalized(Actor Sender, PlayerController Receiver, Class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    Receiver.ReceiveLocalizedMessage(Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
    //return;    
}

function Broadcast(Actor Sender, coerce string msg, optional name Type)
{
    local PlayerController P;
    local PlayerReplicationInfo PRI;

    // End:0x26
    if(!AllowsBroadcast(Sender, Len(msg)))
    {
        return;
    }
    // End:0x72
    if(Pawn(Sender) != none)
    {
        PRI = Pawn(Sender).PlayerReplicationInfo;        
    }
    else
    {
        // End:0xBB
        if(Controller(Sender) != none)
        {
            PRI = Controller(Sender).PlayerReplicationInfo;
        }
    }
    // End:0x11E
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', P)
    {
        BroadcastText(PRI, P, msg, Type);        
    }    
    //return;    
}

function BroadcastTeam(Controller Sender, coerce string msg, optional name Type)
{
    local PlayerController P;

    // End:0x26
    if(!AllowsBroadcast(Sender, Len(msg)))
    {
        return;
    }
    // End:0x109
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', P)
    {
        // End:0x108
        if(P.PlayerReplicationInfo.Team == Sender.PlayerReplicationInfo.Team)
        {
            BroadcastText(Sender.PlayerReplicationInfo, P, msg, Type);
        }        
    }    
    //return;    
}

event AllowBroadcastLocalized(Actor Sender, Class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    local PlayerController P;

    // End:0x82
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', P)
    {
        BroadcastLocalized(Sender, P, Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);        
    }    
    //return;    
}

event AllowBroadcastLocalizedTeam(int TeamIndex, Actor Sender, Class<LocalMessage> Message, optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2, optional Object OptionalObject)
{
    local PlayerController P;

    // End:0x139
    foreach WorldInfo.AllControllers(Class'Engine.PlayerController', P)
    {
        // End:0x138
        if(((P.PlayerReplicationInfo != none) && P.PlayerReplicationInfo.Team != none) && P.PlayerReplicationInfo.Team.TeamIndex == TeamIndex)
        {
            BroadcastLocalized(Sender, P, Message, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);
        }        
    }    
    //return;    
}

defaultproperties
{
    TickGroup=ETickingGroup.TG_DuringAsyncWork
}