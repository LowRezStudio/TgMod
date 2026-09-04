class ZoneInfo extends Info
    native
    notplaceable
    hidecategories(Navigation,Movement,Collision);

var() float KillZ;
var() float SoftKill;
var() Class<KillZDamageType> KillZDamageType;
var() bool bSoftKillZ;

defaultproperties
{
    KillZ=-262143.0000000
    SoftKill=2500.0000000
    KillZDamageType=Class'Engine.KillZDamageType'
    bStatic=true
    bNoDelete=true
    bGameRelevant=true
}