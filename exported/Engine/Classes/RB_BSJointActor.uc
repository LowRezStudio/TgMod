class RB_BSJointActor extends RB_ConstraintActor
    placeable
    hidecategories(Navigation);

defaultproperties
{
    // Reference: RB_BSJointSetup'Engine.Default__RB_BSJointActor.MyBSJointSetup'
    begin object name="MyBSJointSetup" class=Engine.RB_BSJointSetup
    end object
    ConstraintSetup=MyBSJointSetup
    // Reference: RB_ConstraintInstance'Engine.Default__RB_BSJointActor.MyConstraintInstance'
    // Archetype: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance"
    end object
    ConstraintInstance=MyConstraintInstance
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_BSJointActor.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    // Archetype: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    begin object name="MyConDrawComponent"
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
}