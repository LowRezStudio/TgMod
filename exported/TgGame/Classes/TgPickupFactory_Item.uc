class TgPickupFactory_Item extends TgPickupFactory
    abstract
    hidecategories(Navigation,Lighting,LightColor,Force,Display,Collision);

var SoundCue PickupSound;
var const localized string PickupMessage;
var float RespawnTime;

simulated function InitializePickup()
{
    //return;    
}

static function string GetLocalString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2)
{
    return default.PickupMessage;
    //return ReturnValue;    
}

function SpawnCopyFor(Pawn Recipient)
{
    Recipient.PlaySound(PickupSound);
    // End:0xAC
    if(PlayerController(Recipient.Controller) != none)
    {
        PlayerController(Recipient.Controller).ReceiveLocalizedMessage(MessageClass,,,, Class);
    }
    //return;    
}

function SetRespawn()
{
    // End:0x45
    if(WorldInfo.Game.ShouldRespawn(self))
    {
        StartSleeping();        
    }
    else
    {
        GotoState('Disabled');
    }
    //return;    
}

function float GetRespawnTime()
{
    return RespawnTime;
    //return ReturnValue;    
}

function float BotDesireability(Pawn P)
{
    return 0.0000000;
    //return ReturnValue;    
}

defaultproperties
{
    RespawnTime=30.0000000
    // Reference: CylinderComponent'TgGame.Default__TgPickupFactory_Item.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgPickupFactory.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=CollisionCylinder
    Components[3]=none
    CollisionComponent=CollisionCylinder
}