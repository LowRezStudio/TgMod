class RB_ConstraintActorSpawnable extends RB_ConstraintActor
    notplaceable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: RB_ConstraintSetup'Engine.Default__RB_ConstraintActorSpawnable.MyConstraintSetup'
    begin object name="MyConstraintSetup" class=Engine.RB_ConstraintSetup
    end object
    ConstraintSetup=MyConstraintSetup
    // Reference: RB_ConstraintInstance'Engine.Default__RB_ConstraintActorSpawnable.MyConstraintInstance'
    // Archetype: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance"
    end object
    ConstraintInstance=MyConstraintInstance
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActorSpawnable.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    // Archetype: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    begin object name="MyConDrawComponent"
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
    bNoDelete=false
}