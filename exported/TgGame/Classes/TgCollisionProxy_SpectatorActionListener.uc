class TgCollisionProxy_SpectatorActionListener extends TgCollisionProxy_Cylinder
    transient
    native
    notplaceable
    hidecategories(Navigation);

//var delegate<ProxyDeviceOnStartFire> __ProxyDeviceOnStartFire__Delegate;

delegate ProxyDeviceOnStartFire(TgPawn FiringPawn, int nEquipSlot)
{
    //return;    
}

// Export UTgCollisionProxy_SpectatorActionListener::execForwardDeviceOnStartFire(FFrame&, void* const)
native function ForwardDeviceOnStartFire(TgPawn FiringPawn, int nEquipSlot);

// Export UTgCollisionProxy_SpectatorActionListener::execHasMixedTaskforcePlayersNearby(FFrame&, void* const)
native function bool HasMixedTaskforcePlayersNearby();

simulated event PostDemoRewind()
{
    super(Actor).PostDemoRewind();
    ForceProximityScan();
    //return;    
}

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgCollisionProxy_SpectatorActionListener.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgCollisionProxy_Cylinder.CollisionCylinder'
    begin object name="CollisionCylinder"
        ReplacementPrimitive=none
    end object
    m_CollisionCylinder=CollisionCylinder
    Components[0]=CollisionCylinder
    CollisionComponent=CollisionCylinder
}