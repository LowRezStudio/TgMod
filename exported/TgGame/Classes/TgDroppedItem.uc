class TgDroppedItem extends Actor
    native(Inventory)
    notplaceable
    hidecategories(Navigation);

var float m_fLifeSpan;
var bool m_bFadeOut;
var name m_nmPickUpState;
var repnotify int r_nItemId;
var export editinline MeshComponent c_Mesh;
var array<TgEffectGroup> s_EffectGroupList;

replication
{
    // Pos:0x000
    if((int(Role) == int(ROLE_Authority)) && bNetDirty)
        r_nItemId;
}

// Export UTgDroppedItem::execGetEffectGroup(FFrame&, void* const)
native function TgEffectGroup GetEffectGroup(int nType, out int nIndex);

// Export UTgDroppedItem::execApplyItemSetup(FFrame&, void* const)
native function bool ApplyItemSetup();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x2F
    if(VarName == 'r_nItemId')
    {
        ApplyItemSetup();
        GotoState(m_nmPickUpState);
    }
    super.ReplicatedEvent(VarName);
    //return;    
}

function GiveTo(TgPawn P)
{
    local TgEffectGroup eg;
    local int nIndex;

    J0x00:
    // End:0x94 [Loop If]
    if(nIndex >= 0)
    {
        eg = GetEffectGroup(264, nIndex);
        // End:0x83
        if(eg != none)
        {
            P.r_EffectManager.ProcessEffect(eg);            
        }
        else
        {
            // [Explicit Break]
            goto J0x94;
        }
        nIndex++;
        // [Loop Continue]
        goto J0x00;
    }
    J0x94:

    Destroy();
    //return;    
}

state Pickup
{
    function bool ValidTouch(Pawn Other)
    {
        // End:0x83
        if(((Other == none) || !Other.bCanPickupInventory) || (Other.DrivenVehicle == none) && Other.Controller == none)
        {
            return false;
        }
        // End:0xAD
        if(Other.IsInState('Dying'))
        {
            return false;            
        }
        else
        {
            // End:0xF6
            if((TgPawn(Other) != none) && !TgPawn(Other).CanPickupDroppedItem())
            {
                return false;
            }
        }
        // End:0x14B
        if(((int(Physics) == int(2)) && Other == Instigator) && Velocity.Z > float(0))
        {
            return false;
        }
        // End:0x191
        if(!FastTrace(Other.Location, Location))
        {
            SetTimer(0.5000000, false, 'RecheckValidTouch');
            return false;
        }
        return true;
        //return ReturnValue;        
    }

    event RecheckValidTouch()
    {
        CheckTouching();
        //return;        
    }

    event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
    {
        local TgPawn P;

        P = TgPawn(Other);
        // End:0x56
        if((P != none) && ValidTouch(P))
        {
            GiveTo(P);
        }
        //return;        
    }

    event Timer()
    {
        GotoState('FadeOut');
        //return;        
    }

    function CheckTouching()
    {
        local Pawn P;

        // End:0x43
        foreach TouchingActors(Class'Engine.Pawn', P)
        {
            Touch(P, none, Location, vect(0.0000000, 0.0000000, 1.0000000));            
        }        
        //return;        
    }

    event BeginState(name PreviousStateName)
    {
        SetTimer(m_fLifeSpan - float(1), false);
        SetPhysics(2);
        //return;        
    }
Begin:

    CheckTouching();
    stop;        
}

state FadeOut extends Pickup
{
    simulated event BeginState(name PreviousStateName)
    {
        m_bFadeOut = true;
        RotationRate.Yaw = 60000;
        SetPhysics(5);
        LifeSpan = 1.0000000;
        //return;        
    }
    stop;    
}

defaultproperties
{
    m_fLifeSpan=120.0000000
    m_nmPickUpState="Pickup"
    // Reference: CylinderComponent'TgGame.Default__TgDroppedItem.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=20.0000000
        CollisionRadius=30.0000000
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[0]=CollisionCylinder
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    CollisionType=ECollisionType.COLLIDE_TouchAll
    bPushedByEncroachers=false
    bAlwaysRelevant=true
    bOnlyDirtyReplication=true
    bCollideActors=true
    bCollideWorld=true
    NetUpdateFrequency=8.0000000
    NetPriority=1.4000000
    CollisionComponent=CollisionCylinder
}