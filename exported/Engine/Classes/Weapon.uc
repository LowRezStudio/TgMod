class Weapon extends Inventory
    abstract
    native
    notplaceable
    hidecategories(Navigation);

var AIController AIController;

// Export UWeapon::execNativeIsFiring(FFrame&, void* const)
native function bool NativeIsFiring();

simulated event bool StartFire()
{
    //return ReturnValue;    
}

simulated function StopFire()
{
    //return;    
}

reliable server function ServerStopFire()
{
    //return;    
}

simulated event bool IsFiring()
{
    return NativeIsFiring();
    //return ReturnValue;    
}

simulated function DumpWeaponDebugToLog()
{
    //return;    
}

simulated function Activate()
{
    //return;    
}

function HolderDied()
{
    //return;    
}

simulated function bool DenyClientWeaponSet()
{
    return false;
    //return ReturnValue;    
}

simulated function bool TryPutDown()
{
    return true;
    //return ReturnValue;    
}

simulated function bool HasAnyAmmo()
{
    return true;
    //return ReturnValue;    
}

simulated function float GetWeaponRating()
{
    return -1.0000000;
    //return ReturnValue;    
}

function float GetAIRating()
{
    return 0.0000000;
    //return ReturnValue;    
}

defaultproperties
{
    ItemName="Weapon"
    Components=none
    bReplicateInstigator=true
    bOnlyDirtyReplication=false
}