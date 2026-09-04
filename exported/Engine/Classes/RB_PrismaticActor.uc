class RB_PrismaticActor extends RB_ConstraintActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: RB_PrismaticSetup'Engine.Default__RB_PrismaticActor.MyPrismaticSetup'
    begin object name="MyPrismaticSetup" class=Engine.RB_PrismaticSetup
    end object
    ConstraintSetup=MyPrismaticSetup
    // Reference: RB_ConstraintInstance'Engine.Default__RB_PrismaticActor.MyConstraintInstance'
    // Archetype: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance"
    end object
    ConstraintInstance=MyConstraintInstance
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_PrismaticActor.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    // Archetype: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    begin object name="MyConDrawComponent"
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
    Components[2]=none
}