class TgCollisionProxy_Vortex extends TgCollisionProxy
    native
    placeable
    hidecategories(Navigation);

var() float m_fGroundSpeedStrafePct;
var() float m_fGroundSpeedToVortex;
var() float m_fGroundSpeedPctRetained;
var() float m_fInnerRadius;
var() bool m_bEnabled;
var() bool m_bOnlyAffectCurrentTarget;
var transient Pawn m_LastInstigator;

simulated event Tick(float DeltaTime)
{
    local TgPawn AffectedPawn;

    super(Actor).Tick(DeltaTime);
    ForceClearNearByPlayersList();
    // End:0x4A
    foreach TouchingActors(Class'TgGame.TgPawn', AffectedPawn)
    {
        CheckNearByPlayers(AffectedPawn, true);        
    }    
    //return;    
}

simulated event InstigatorChanged()
{
    local TgPawn aPawn;

    // End:0x47
    if(!m_bForwardOwnerOnly)
    {
        ForceClearNearByPlayersList();
        // End:0x46
        foreach TouchingActors(Class'TgGame.TgPawn', aPawn)
        {
            CheckNearByPlayers(aPawn, true);            
        }        
    }
    //return;    
}

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    // End:0x3D
    if(!m_bOnlyAffectCurrentTarget)
    {
        super.Touch(Other, OtherComp, HitLocation, HitNormal);
    }
    //return;    
}

simulated event UnTouch(Actor Other)
{
    // End:0x22
    if(!m_bOnlyAffectCurrentTarget)
    {
        super.UnTouch(Other);
    }
    //return;    
}

simulated event bool ShouldIgnoreActor(TgPawn aPawn)
{
    local bool bIgnore;

    bIgnore = super.ShouldIgnoreActor(aPawn);
    // End:0x73
    if(!bIgnore && Instigator != none)
    {
        bIgnore = !Instigator.IsEnemy(aPawn);
    }
    // End:0xAE
    if(!bIgnore)
    {
        bIgnore = !aPawn.CanBePulled();
    }
    return bIgnore;
    //return ReturnValue;    
}

simulated function OnPlayerAdded(TgPawn aPawn)
{
    // End:0x56
    if((aPawn != none) && aPawn.CanBeAffectedByVortices())
    {
        aPawn.m_CurrentVortexList.AddItem(self);
    }
    //return;    
}

simulated function OnPlayerRemoved(TgPawn aPawn)
{
    // End:0x32
    if(aPawn != none)
    {
        aPawn.m_CurrentVortexList.RemoveItem(self);
    }
    //return;    
}

defaultproperties
{
    m_fGroundSpeedToVortex=300.0000000
    m_fGroundSpeedPctRetained=80.0000000
    m_fInnerRadius=20.0000000
    m_bEnabled=true
    // Reference: CylinderComponent'TgGame.Default__TgCollisionProxy_Vortex.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    // Archetype: CylinderComponent'TgGame.Default__TgCollisionProxy.CollisionCylinder'
    begin object name="CollisionCylinder"
        CollisionHeight=480.0000000
        CollisionRadius=480.0000000
        ReplacementPrimitive=none
    end object
    Components[0]=CollisionCylinder
    Components[1]=none
    CollisionType=ECollisionType.COLLIDE_TouchAllButWeapons
    bReplicateInstigator=true
    bOnlyDirtyReplication=true
    CollisionComponent=CollisionCylinder
}