class RB_ConstraintActor extends RigidBodyBase
    abstract
    native(Physics)
    placeable
    hidecategories(Navigation);

var() Actor ConstraintActor1;
var() Actor ConstraintActor2;
var() noclear export editinline RB_ConstraintSetup ConstraintSetup;
var() noclear export editinline RB_ConstraintInstance ConstraintInstance;
var() const bool bDisableCollision;
var() bool bUpdateActor1RefFrame;
var() bool bUpdateActor2RefFrame;
var(Pulley) Actor PulleyPivotActor1;
var(Pulley) Actor PulleyPivotActor2;

// Export URB_ConstraintActor::execSetDisableCollision(FFrame&, void* const)
native final function SetDisableCollision(bool NewDisableCollision);

// Export URB_ConstraintActor::execInitConstraint(FFrame&, void* const)
native final function InitConstraint(Actor Actor1, Actor Actor2, optional name Actor1Bone, optional name Actor2Bone, optional float BreakThreshold);

// Export URB_ConstraintActor::execTermConstraint(FFrame&, void* const)
native final function TermConstraint();

simulated function OnDestroy(SeqAct_Destroy Action)
{
    TermConstraint();
    //return;    
}

simulated function OnToggle(SeqAct_Toggle Action)
{
    // End:0xAC
    if(Action.InputLinks[0].bHasImpulse)
    {
        // End:0xA9
        if(int(Physics) != int(10))
        {
            SetPhysics(10);
            InitConstraint(ConstraintActor1, ConstraintActor2, ConstraintSetup.ConstraintBone1, ConstraintSetup.ConstraintBone2);
        }        
    }
    else
    {
        // End:0x109
        if(Action.InputLinks[1].bHasImpulse)
        {
            // End:0x106
            if(int(Physics) != int(0))
            {
                SetPhysics(0);
                TermConstraint();
            }            
        }
        else
        {
            // End:0x1C5
            if(Action.InputLinks[2].bHasImpulse)
            {
                // End:0x167
                if(int(Physics) != int(0))
                {
                    SetPhysics(0);
                    TermConstraint();                    
                }
                else
                {
                    SetPhysics(10);
                    InitConstraint(ConstraintActor1, ConstraintActor2, ConstraintSetup.ConstraintBone1, ConstraintSetup.ConstraintBone2);
                }
            }
        }
    }
    //return;    
}

simulated function OnToggleConstraintDrive(SeqAct_ToggleConstraintDrive Action)
{
    // End:0x148
    if(Action.InputLinks[0].bHasImpulse)
    {
        // End:0x7B
        if(Action.bEnableLinearPositionDrive)
        {
            ConstraintInstance.SetLinearPositionDrive(true, true, true);
        }
        // End:0xBF
        if(Action.bEnableLinearvelocityDrive)
        {
            ConstraintInstance.SetLinearVelocityDrive(true, true, true);
        }
        // End:0x102
        if(Action.bEnableAngularPositionDrive)
        {
            ConstraintInstance.SetAngularPositionDrive(true, true);
        }
        // End:0x145
        if(Action.bEnableAngularVelocityDrive)
        {
            ConstraintInstance.SetAngularVelocityDrive(true, true);
        }        
    }
    else
    {
        // End:0x205
        if(Action.InputLinks[1].bHasImpulse)
        {
            ConstraintInstance.SetLinearPositionDrive(false, false, false);
            ConstraintInstance.SetLinearVelocityDrive(false, false, false);
            ConstraintInstance.SetAngularPositionDrive(false, false);
            ConstraintInstance.SetAngularVelocityDrive(false, false);
        }
    }
    //return;    
}

defaultproperties
{
    // Reference: RB_ConstraintInstance'Engine.Default__RB_ConstraintActor.MyConstraintInstance'
    begin object name="MyConstraintInstance" class=Engine.RB_ConstraintInstance
    end object
    ConstraintInstance=MyConstraintInstance
    bUpdateActor1RefFrame=true
    bUpdateActor2RefFrame=true
    Components[0]=none
    // Reference: RB_ConstraintDrawComponent'Engine.Default__RB_ConstraintActor.MyConDrawComponent'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyConDrawComponent'
    begin object name="MyConDrawComponent" class=Engine.RB_ConstraintDrawComponent
        ReplacementPrimitive=none
    end object
    Components[1]=MyConDrawComponent
    DrawScale=0.5000000
    Physics=EPhysics.PHYS_RigidBody
    TickGroup=ETickingGroup.TG_PostAsyncWork
    bHidden=true
    bNoDelete=true
    bEdShouldSnap=true
    SupportedEvents[0]=Class'Engine.SeqEvent_Touch'
    SupportedEvents[1]=Class'Engine.SeqEvent_Destroyed'
    SupportedEvents[2]=Class'Engine.SeqEvent_TakeDamage'
    SupportedEvents[3]=Class'Engine.SeqEvent_HitWall'
    SupportedEvents[4]=Class'Engine.SeqEvent_AnimNotify'
    SupportedEvents[5]=Class'Engine.SeqEvent_MobileTouch'
    SupportedEvents[6]=Class'Engine.SeqEvent_ConstraintBroken'
}