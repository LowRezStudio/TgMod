class TgBotFactory_PointCapture extends TgBotFactory_Leashed
    native(Factory)
    placeable
    hidecategories(Navigation,Advanced,Attachment,Collision,Display,Advanced,Attachment,Collision,Display,Movement);

var transient TgCapturePoint m_CapturePoint;

// Export UTgBotFactory_PointCapture::execBotDied(FFrame&, void* const)
native function BotDied(TgPawn Pawn, TgAIController aic);

defaultproperties
{
    bSpawnAsSquad=true
    bAutoSpawn=false
    // Reference: TgStaticMeshComponent'TgGame.Default__TgBotFactory_PointCapture.RespawnIndicator'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'RespawnIndicator'
    // Archetype: TgStaticMeshComponent'TgGame.Default__TgBotFactory_Leashed.RespawnIndicator'
    begin object name="RespawnIndicator"
        ReplacementPrimitive=none
    end object
    m_RespawnIndicator=RespawnIndicator
    // Reference: SpriteComponent'TgGame.Default__TgBotFactory_PointCapture.WorldIcon'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'WorldIcon'
    // Archetype: SpriteComponent'TgGame.Default__TgBotFactory_Leashed.WorldIcon'
    begin object name="WorldIcon"
        ReplacementPrimitive=none
    end object
    m_WorldIconSprite=WorldIcon
    Components[0]=none
    Components[1]=WorldIcon
    Components[2]=none
    Components[3]=RespawnIndicator
    Components[4]=none
}