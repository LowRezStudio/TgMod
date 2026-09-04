class TgTeleportPlayerVolume extends Volume
    native(Volumes)
    hidecategories(Navigation,Object,Movement,Display);

enum TgTeleportVolumeType
{
    Inactive,                       // 0
    Respawn,                        // 1
    TgTeleportVolumeType_MAX        // 2
};

var() TgTeleportPlayerVolume.TgTeleportVolumeType TeleportLocation;
var() int nMessageId;
var() bool bTeleportBots;
var() bool bTeleportPlayers;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn Pawn;
    local TgPlayerController PC;
    local TgAIController aic;
    local NavigationPoint navPoint;
    local Rotator Rot;
    local Vector Loc;
    local bool bTeleport;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    bTeleport = false;
    Pawn = TgPawn(Other);
    // End:0x1AE
    if(Pawn != none)
    {
        PC = TgPlayerController(Pawn.Controller);
        aic = TgAIController(Pawn.Controller);
        switch(TeleportLocation)
        {
            // End:0x1AB
            case 1:
                navPoint = WorldInfo.Game.FindPlayerStart(Pawn.Controller);
                // End:0x1A8
                if(navPoint != none)
                {
                    Loc = navPoint.Location;
                    Rot = navPoint.Rotation;
                    bTeleport = true;
                }
                // End:0x1AE
                break;
            // End:0xFFFF
            default:
                break;
        }
    }
    else
    {
        bTeleport = bTeleport && (bTeleportBots && aic != none) || bTeleportPlayers && PC != none;
        // End:0x2F7
        if(bTeleport)
        {
            Pawn.SetLocation(Loc);
            Pawn.SetRotation(Rot);
            // End:0x2F7
            if(PC != none)
            {
                Pawn.SetDesiredRotation(Rot);
                PC.ClientSetRotationAndDesired(Rot);
                // End:0x2F7
                if(nMessageId > 0)
                {
                    PC.AddAlertScript(2, 4, 5.0000000, nMessageId, true);
                }
            }
        }
        //return;        
    }
}

defaultproperties
{
    TeleportLocation=TgTeleportVolumeType.Respawn
    bTeleportBots=true
    bTeleportPlayers=true
    // Reference: BrushComponent'TgGame.Default__TgTeleportPlayerVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}