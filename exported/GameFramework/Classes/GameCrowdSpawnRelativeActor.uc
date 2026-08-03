class GameCrowdSpawnRelativeActor extends Actor
    native
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: SpriteComponent'GameFramework.Default__GameCrowdSpawnRelativeActor.Sprite'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'Sprite'
    begin object name="Sprite" class=Engine.SpriteComponent
        ReplacementPrimitive=none
        AlwaysLoadOnClient=false
        AlwaysLoadOnServer=false
    end object
    Components[0]=Sprite
}