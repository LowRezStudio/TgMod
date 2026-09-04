class TgBotFactorySpawnable extends TgBotFactory
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement);

defaultproperties
{
    // Reference: TgStaticMeshComponent'TgGame.Default__TgBotFactorySpawnable.RespawnIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RespawnIndicator'
    // Archetype: TgStaticMeshComponent'TgGame.Default__TgBotFactory.RespawnIndicator'
    begin object name="RespawnIndicator"
        ReplacementPrimitive=none
    end object
    m_RespawnIndicator=RespawnIndicator
    // Reference: SpriteComponent'TgGame.Default__TgBotFactorySpawnable.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgBotFactory.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=WorldIcon
    Components[2]=none
    Components[3]=RespawnIndicator
    Components[4]=none
    bNoDelete=false
}