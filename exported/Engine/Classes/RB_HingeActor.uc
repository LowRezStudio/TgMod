class RB_HingeActor extends RB_ConstraintActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: RB_HingeSetup'Engine.Default__RB_HingeActor.MyHingeSetup'
    begin object name="MyHingeSetup" class=Engine.RB_HingeSetup
    end object
    ConstraintSetup=MyHingeSetup
    // Reference: RB_ConstraintInstance'Engine.Default__RB_HingeActor.MyConstraintInstance'
    // Archetype: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance"
    end object
    ConstraintInstance=MyConstraintInstance
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_HingeActor.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    // Archetype: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    begin object name="MyConDrawComponent"
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
    Components[2]=none
}