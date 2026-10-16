class RB_PulleyJointActor extends RB_ConstraintActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: RB_PulleyJointSetup'Engine.Default__RB_PulleyJointActor.MyPulleyJointSetup'
    begin object name="MyPulleyJointSetup" class=Engine.RB_PulleyJointSetup
    end object
    ConstraintSetup=MyPulleyJointSetup
    // Reference: RB_ConstraintInstance'Engine.Default__RB_PulleyJointActor.MyConstraintInstance'
    // Archetype: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance"
    end object
    ConstraintInstance=MyConstraintInstance
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_PulleyJointActor.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    // Archetype: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    begin object name="MyConDrawComponent"
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
}