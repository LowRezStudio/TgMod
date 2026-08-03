class TgProj_DarklordChain3 extends TgProj_DarklordBase
    native(ChampDarklord)
    hidecategories(Navigation);

simulated function float GetDecalRotationOffset()
{
    return super.GetDecalRotationOffset() + 90.0000000;
    //return ReturnValue;    
}

simulated function Vector GetCollisionOffsetDir()
{
    return MatrixGetAxis(MakeRotationMatrix(Rotation), 4);
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DarklordChain3.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgProj_DarklordBase.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    // Reference: CylinderComponent'TgGame.Default__TgProj_DarklordChain3.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgProj_DarklordBase.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    CylinderComponent=CollisionCylinder
    Components[0]=CollisionCylinder
    Components[1]=MyLightEnvironment
    CollisionComponent=CollisionCylinder
}