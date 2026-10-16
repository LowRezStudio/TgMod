class TgPickupFactory_Item extends TgPickupFactory
    abstract
    hidecategories(Navigation,Lighting,LightColor,Force,Display,Collision)
    config(Engine);

var SoundCue PickupSound;
var const localized string PickupMessage;
var float RespawnTime;

simulated function InitializePickup() { }

static function string GetLocalString(optional int Switch, optional PlayerReplicationInfo RelatedPRI_1, optional PlayerReplicationInfo RelatedPRI_2) { }

function SpawnCopyFor(Pawn Recipient) { }

function SetRespawn() { }

function float GetRespawnTime() { }

function float BotDesireability(Pawn P) { }

defaultproperties
{}
