class TgAITaskforceBlockingVolume extends Volume
    native
    hidecategories(Navigation,Object,Movement,Display);

var() int BlockTaskforce;
var bool m_bHasRegisteredObstacle;

// Export UTgAITaskforceBlockingVolume::execRegisterObstacle(FFrame&, void* const)
native function RegisterObstacle();

// Export UTgAITaskforceBlockingVolume::execUnRegisterObstacle(FFrame&, void* const)
native function UnRegisterObstacle();

event PostBeginPlay()
{
    // End:0x1E
    if(int(Role) == int(ROLE_Authority))
    {
        RegisterObstacle();
    }
    //return;    
}

defaultproperties
{
    // Reference: BrushComponent'TgGame.Default__TgAITaskforceBlockingVolume.BrushComponent0'
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