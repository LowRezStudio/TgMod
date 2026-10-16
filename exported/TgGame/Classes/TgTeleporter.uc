class TgTeleporter extends Teleporter
    native(Navigation)
    hidecategories(Navigation,Lighting,LightColor,Force);

var(Object) int m_nMapObjectId;
var(MapInstance) int m_nMapId;
var(MapInstance) bool m_nPreload;
var(Taskforce) bool m_bSetTaskForce;
var(Taskforce) bool m_bBalanceTaskForce;
var(Taskforce) bool m_bIgnoreNonMembers;
var(Taskforce) bool m_bUsePlayerStart;
var(Taskforce) bool m_bRequestMission;
var() byte m_nStartGroup;
var(Taskforce) byte m_nTaskForce;

// Export UTgTeleporter::execHandlePostTouch(FFrame&, void* const)
native function bool HandlePostTouch(Actor Other);

// Export UTgTeleporter::execLoadObjectConfig(FFrame&, void* const)
native function LoadObjectConfig();

simulated function PreBeginPlay()
{
    super(Actor).PreBeginPlay();
    LoadObjectConfig();
    //return;    
}

function PostBeginPlay()
{
    // End:0x3B
    if((URL ~= "") && m_bUsePlayerStart)
    {
        URL = "UsingPlayerStart";
    }
    super.PostBeginPlay();
    //return;    
}

simulated function PostTouch(Actor Other)
{
    // End:0x30
    if((InStr(URL, "/") >= 0) || InStr(URL, "#") >= 0)
    {
    }
    // End:0x59
    if(HandlePostTouch(Other))
    {
        super.PostTouch(Other);
    }
    //return;    
}

event bool UsePlayerStart(Actor Other)
{
    local NavigationPoint Start;
    local Rotator NewRot;
    local Pawn P;

    P = Pawn(Other);
    // End:0x2D
    if(P == none)
    {
        return false;
    }
    // End:0xB6
    if(int(m_nStartGroup) != int(0))
    {
        Start = TgGame(WorldInfo.Game).FindPlayerGroupStart(P.Controller, int(m_nStartGroup));        
    }
    else
    {
        Start = WorldInfo.Game.FindPlayerStart(P.Controller);
    }
    // End:0x125
    if(Start == none)
    {
        return true;
    }
    NewRot.Yaw = Start.Rotation.Yaw;
    // End:0x1B0
    if(!P.SetLocation(Start.Location))
    {
        return true;
    }
    P.SetRotation(NewRot);
    P.SetViewRotation(NewRot);
    P.ClientSetRotation(NewRot);
    // End:0x2CE
    if(P.Controller != none)
    {
        P.Controller.MoveTimer = -1.0000000;
        P.SetAnchor(Start);
        P.SetMoveTarget(Start);
    }
    P.PlayTeleportEffect(false, true);
    return false;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgTeleporter.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'Engine.Default__Teleporter.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=none
    Components[1]=none
    Components[2]=none
    Components[3]=CollisionCylinder
    Components[4]=none
    CollisionComponent=CollisionCylinder
}