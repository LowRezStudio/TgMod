class TgDestructibleFactory extends TgActorFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display);

var() const editconst export editinline LightEnvironmentComponent LightEnvironment;

// Export UTgDestructibleFactory::execSpawnObject(FFrame&, void* const)
native function SpawnObject();

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDestructibleFactory.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    begin object name="MyLightEnvironment" class=Engine.DynamicLightEnvironmentComponent
    end object
    LightEnvironment=MyLightEnvironment
    m_nSelectionListPropId=188
    // Reference: SpriteComponent'TgGame.Default__TgDestructibleFactory.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgActorFactory.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=none
    Components[2]=WorldIcon
    Components[3]=MyLightEnvironment
}