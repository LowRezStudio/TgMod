class InventoryManager extends Actor
    native
    notplaceable
    hidecategories(Navigation);

var Inventory InventoryChain;
var Weapon PendingWeapon;
var Weapon LastAttemptedSwitchToWeapon;
var bool bMustHoldWeapon;
var private array<int> PendingFire;

replication
{
    // Pos:0x000
    if((((!bSkipActorPropertyReplication || bNetInitial) && int(Role) == int(ROLE_Authority)) && bNetDirty) && bNetOwner)
        InventoryChain;
}

event PostBeginPlay()
{
    super.PostBeginPlay();
    Instigator = Pawn(Owner);
    //return;    
}

simulated function int GetPendingFireLength(Weapon InWeapon)
{
    return PendingFire.Length;
    //return ReturnValue;    
}

simulated function SetPendingFire(Weapon InWeapon, int InFiringMode)
{
    // End:0x2D
    if(InFiringMode < PendingFire.Length)
    {
        PendingFire[InFiringMode] = 1;
    }
    //return;    
}

simulated function ClearPendingFire(Weapon InWeapon, int InFiringMode)
{
    // End:0x2D
    if(InFiringMode < PendingFire.Length)
    {
        PendingFire[InFiringMode] = 0;
    }
    //return;    
}

final simulated function bool IsPendingFire(Weapon InWeapon, int InFiringMode)
{
    return bool(PendingFire[InFiringMode]);
    //return ReturnValue;    
}

simulated function ClearAllPendingFire(Weapon InWeapon)
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x46 [Loop If]
    if(I < PendingFire.Length)
    {
        PendingFire[I] = 0;
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    //return;    
}

// Export UInventoryManager::execInventoryActors(FFrame&, void* const)
native final iterator function InventoryActors(Class<Inventory> BaseClass, out Inventory Inv);

function SetupFor(Pawn P)
{
    Instigator = P;
    SetOwner(P);
    //return;    
}

event Destroyed()
{
    //return;    
}

function bool HandlePickupQuery(Class<Inventory> ItemClass, Actor Pickup)
{
    local Inventory Inv;

    // End:0x11
    if(InventoryChain == none)
    {
        return true;
    }
    // End:0x68
    foreach InventoryActors(Class'Engine.Inventory', Inv)
    {
        // End:0x67
        if(Inv.DenyPickupQuery(ItemClass, Pickup))
        {            
            return false;
        }        
    }    
    return true;
    //return ReturnValue;    
}

simulated event Inventory FindInventoryType(Class<Inventory> DesiredClass, optional bool bAllowSubclass)
{
    local Inventory Inv;

    // End:0x67
    foreach InventoryActors(DesiredClass, Inv)
    {
        // End:0x66
        if(bAllowSubclass || Inv.Class == DesiredClass)
        {            
            return Inv;
        }        
    }    
    return none;
    //return ReturnValue;    
}

simulated function Inventory CreateInventory(Class<Inventory> NewInventoryItemClass, optional bool bDoNotActivate)
{
    local Inventory Inv;

    // End:0x92
    if(NewInventoryItemClass != none)
    {
        Inv = Spawn(NewInventoryItemClass, Owner);
        // End:0x92
        if(Inv != none)
        {
            // End:0x8F
            if(!AddInventory(Inv, bDoNotActivate))
            {
                Inv.Destroy();
                Inv = none;
            }            
        }
    }
    return Inv;
    //return ReturnValue;    
}

simulated function bool AddInventory(Inventory NewItem, optional bool bDoNotActivate)
{
    local Inventory Item, LastItem;

    // End:0x1CD
    if((NewItem != none) && !NewItem.bDeleteMe)
    {
        // End:0x5B
        if(InventoryChain == none)
        {
            InventoryChain = NewItem;            
        }
        else
        {
            Item = InventoryChain;
            J0x6E:

            // End:0xD4 [Loop If]
            if(Item != none)
            {
                // End:0x96
                if(Item == NewItem)
                {
                    return false;
                }
                LastItem = Item;
                Item = Item.Inventory;
                // [Loop Continue]
                goto J0x6E;
            }
            LastItem.Inventory = NewItem;
        }
        NewItem.SetOwner(Instigator);
        NewItem.Instigator = Instigator;
        NewItem.InvManager = self;
        NewItem.GivenTo(Instigator, bDoNotActivate);
        Instigator.TriggerEventClass(Class'Engine.SeqEvent_GetInventory', NewItem);
        return true;
    }
    return false;
    //return ReturnValue;    
}

simulated event RemoveFromInventory(Inventory ItemToRemove)
{
    local Inventory Item;
    local bool bFound;

    // End:0x282
    if(ItemToRemove != none)
    {
        // End:0x5D
        if(InventoryChain == ItemToRemove)
        {
            bFound = true;
            InventoryChain = ItemToRemove.Inventory;            
        }
        else
        {
            Item = InventoryChain;
            J0x70:

            // End:0x122 [Loop If]
            if(Item != none)
            {
                // End:0xF7
                if(Item.Inventory == ItemToRemove)
                {
                    bFound = true;
                    Item.Inventory = ItemToRemove.Inventory;
                    // [Explicit Break]
                    goto J0x122;
                }
                Item = Item.Inventory;
                // [Loop Continue]
                goto J0x70;
            }
        }
        J0x122:

        // End:0x168
        if(bFound)
        {
            ItemToRemove.SetOwner(none);
            ItemToRemove.Inventory = none;
        }
        // End:0x1B4
        if(ItemToRemove == Instigator.Weapon)
        {
            Instigator.Weapon = none;
        }
        // End:0x282
        if((Instigator.Health > 0) && Instigator.Weapon == none)
        {
            // End:0x229
            if((PendingWeapon != none) && PendingWeapon != ItemToRemove)
            {                
            }
            else
            {
                // End:0x282
                if(Instigator.Controller != none)
                {
                    Instigator.Controller.ClientSwitchToBestWeapon(true);
                }
            }
        }
    }
    //return;    
}

simulated event DiscardInventory()
{
    local Inventory Inv;
    local Vector TossVelocity;
    local bool bBelowKillZ;

    bBelowKillZ = (Instigator == none) || Instigator.Location.Z < WorldInfo.KillZ;
    // End:0x1AB
    foreach InventoryActors(Class'Engine.Inventory', Inv)
    {
        // End:0x192
        if(Inv.bDropOnDeath && !bBelowKillZ)
        {
            TossVelocity = Vector(Instigator.GetViewRotation());
            TossVelocity = ((TossVelocity * ((Instigator.Velocity Dot TossVelocity) + 500.0000000)) + (250.0000000 * VRand())) + vect(0.0000000, 0.0000000, 250.0000000);
            Inv.DropFrom(Instigator.Location, TossVelocity);
            // End:0x1AA
            continue;
        }
        Inv.Destroy();        
    }    
    Instigator.Weapon = none;
    //return;    
}

function OwnerDied()
{
    Destroy();
    // End:0x47
    if(Instigator.InvManager == self)
    {
        Instigator.InvManager = none;
    }
    //return;    
}

simulated function DrawHUD(HUD H)
{
    //return;    
}

simulated function float GetWeaponRatingFor(Weapon W)
{
    local float Rating;

    // End:0x2A
    if(!W.HasAnyAmmo())
    {
        return -1.0000000;
    }
    // End:0x118
    if(!Instigator.IsHumanControlled())
    {
        Rating = W.GetAIRating();
        // End:0x115
        if(((W == Instigator.Weapon) && Instigator.Controller != none) && Instigator.Controller.Enemy != none)
        {
            Rating += 0.2100000;
        }        
    }
    else
    {
        Rating = 1.0000000;
    }
    return Rating;
    //return ReturnValue;    
}

simulated function Weapon GetBestWeapon(optional bool bForceADifferentWeapon)
{
    local Weapon W, BestWeapon;
    local float Rating, BestRating;

    // End:0xF9
    foreach InventoryActors(Class'Engine.Weapon', W)
    {
        // End:0xF8
        if(W.HasAnyAmmo())
        {
            // End:0x81
            if(bForceADifferentWeapon && W == Instigator.Weapon)
            {
                continue;                
            }
            Rating = W.GetWeaponRating();
            // End:0xF8
            if((BestWeapon == none) || Rating > BestRating)
            {
                BestWeapon = W;
                BestRating = Rating;
            }
        }        
    }    
    return BestWeapon;
    //return ReturnValue;    
}

simulated function SwitchToBestWeapon(optional bool bForceADifferentWeapon)
{
    //return;    
}

simulated function PrevWeapon()
{
    //return;    
}

simulated function NextWeapon()
{
    //return;    
}

private final simulated function InternalSetCurrentWeapon(Weapon DesiredWeapon)
{
    local Weapon PrevWeapon;

    PrevWeapon = Instigator.Weapon;
    // End:0xCB
    if(((PrevWeapon != none) && DesiredWeapon == PrevWeapon) && !PrevWeapon.IsInState('WeaponPuttingDown'))
    {
        // End:0xCB
        if(!DesiredWeapon.IsInState('Inactive') && !DesiredWeapon.IsInState('PendingClientWeaponSet'))
        {
            return;
        }
    }
    SetPendingWeapon(DesiredWeapon);
    // End:0x177
    if((((PrevWeapon != none) && PrevWeapon != DesiredWeapon) && !PrevWeapon.bDeleteMe) && !PrevWeapon.IsInState('Inactive'))
    {
        PrevWeapon.TryPutDown();        
    }
    else
    {
        ChangedWeapon();
    }
    //return;    
}

simulated function SetPendingWeapon(Weapon DesiredWeapon)
{
    PendingWeapon = DesiredWeapon;
    //return;    
}

simulated function bool CancelWeaponChange()
{
    // End:0x46
    if((PendingWeapon == none) && bMustHoldWeapon)
    {
        PendingWeapon = Instigator.Weapon;
    }
    return false;
    //return ReturnValue;    
}

simulated function ClearPendingWeapon()
{
    // End:0x3D
    if(PendingWeapon != none)
    {
        PendingWeapon.GotoState('Inactive');
        PendingWeapon = none;
    }
    //return;    
}

simulated function ChangedWeapon()
{
    local Weapon OldWeapon;

    OldWeapon = Instigator.Weapon;
    // End:0x87
    if((PendingWeapon == none) && bMustHoldWeapon)
    {
        // End:0x87
        if(OldWeapon != none)
        {
            OldWeapon.Activate();
            PendingWeapon = OldWeapon;
        }
    }
    Instigator.Weapon = PendingWeapon;
    Instigator.PlayWeaponSwitch(OldWeapon, PendingWeapon);
    // End:0x18B
    if(PendingWeapon != none)
    {
        PendingWeapon.Instigator = Instigator;
        // End:0x161
        if(WorldInfo.Game != none)
        {
            Instigator.MakeNoise(0.1000000, 'ChangedWeapon');
        }
        PendingWeapon.Activate();
        PendingWeapon = none;
    }
    // End:0x20A
    if(Instigator.Controller != none)
    {
        Instigator.Controller.NotifyChangedWeapon(OldWeapon, Instigator.Weapon);
    }
    //return;    
}

simulated function ClientWeaponSet(Weapon NewWeapon, bool bOptionalSet, optional bool bDoNotActivate)
{
    local Weapon OldWeapon;

    // End:0x28F
    if(!bDoNotActivate)
    {
        OldWeapon = Instigator.Weapon;
        // End:0x94
        if(((OldWeapon == none) || OldWeapon.bDeleteMe) || OldWeapon.IsInState('Inactive'))
        {
            return;
        }
        // End:0xD5
        if(OldWeapon == NewWeapon)
        {
            // End:0xD3
            if(NewWeapon.IsInState('PendingClientWeaponSet'))
            {                
            }
            return;
        }
        // End:0x180
        if(bOptionalSet)
        {
            // End:0x180
            if(OldWeapon.DenyClientWeaponSet() || Instigator.IsHumanControlled() && PlayerController(Instigator.Controller).bNeverSwitchOnPickup)
            {
                LastAttemptedSwitchToWeapon = NewWeapon;
                return;
            }
        }
        // End:0x28F
        if(((PendingWeapon == none) || !PendingWeapon.HasAnyAmmo()) || PendingWeapon.GetWeaponRating() < NewWeapon.GetWeaponRating())
        {
            // End:0x28F
            if(!Instigator.Weapon.HasAnyAmmo() || Instigator.Weapon.GetWeaponRating() < NewWeapon.GetWeaponRating())
            {
                return;
            }
        }
    }
    NewWeapon.GotoState('Inactive');
    //return;    
}

simulated function UpdateController()
{
    //return;    
}

defaultproperties
{
    RemoteRole=ENetRole.ROLE_SimulatedProxy
    TickGroup=ETickingGroup.TG_DuringAsyncWork
    bHidden=true
    bOnlyRelevantToOwner=true
    bReplicateInstigator=true
    bReplicateMovement=false
    bOnlyDirtyReplication=true
    NetPriority=1.4000000
}