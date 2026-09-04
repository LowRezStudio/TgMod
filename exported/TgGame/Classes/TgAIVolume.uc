class TgAIVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display);

var() int LaneIndex;
var() int TaskforceIndex;
var() bool bEnabled;

// Export UTgAIVolume::execGetRandomPointInAIVolume(FFrame&, void* const)
native function Vector GetRandomPointInAIVolume(optional float CollisionRadius = 0.0000000);

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0x46
    if(Action.InputLinks[0].bHasImpulse)
    {
        bEnabled = true;        
    }
    else
    {
        // End:0x8C
        if(Action.InputLinks[1].bHasImpulse)
        {
            bEnabled = false;            
        }
        else
        {
            // End:0xDB
            if(Action.InputLinks[2].bHasImpulse)
            {
                bEnabled = !bEnabled;
            }
        }
    }
    //return;    
}

event PostBeginPlay()
{
    local TgGame Game;

    super.PostBeginPlay();
    Game = TgGame(WorldInfo.Game);
    // End:0x1B8
    if((int(Role) == int(ROLE_Authority)) && Game != none)
    {
        Game.s_AIVolumes.AddItem(self);
        // End:0xD9
        if(TaskforceIndex == 1)
        {
            Game.s_Taskforce1AIVolumesIndices.AddItem(Game.s_AIVolumes.Length - 1);            
        }
        else
        {
            // End:0x130
            if(TaskforceIndex == 2)
            {
                Game.s_Taskforce2AIVolumesIndices.AddItem(Game.s_AIVolumes.Length - 1);                
            }
            else
            {
                Game.s_Taskforce1AIVolumesIndices.AddItem(Game.s_AIVolumes.Length - 1);
                Game.s_Taskforce2AIVolumesIndices.AddItem(Game.s_AIVolumes.Length - 1);
            }
        }
    }
    //return;    
}

defaultproperties
{
    TaskforceIndex=-1
    bEnabled=true
    // Reference: BrushComponent'TgGame.Default__TgAIVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionType=ECollisionType.COLLIDE_NoCollision
    bStatic=false
    CollisionComponent=BrushComponent0
}