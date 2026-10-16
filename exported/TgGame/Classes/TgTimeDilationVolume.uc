class TgTimeDilationVolume extends PhysicsVolume
    hidecategories(Navigation,Object,Movement,Display);

var float m_fTimeMultiplier;
var bool m_bAffectInstigator;
var array<Actor> m_AffectedActors;
var array<Pawn> m_AffectedPawns;

simulated event PostBeginPlay()
{
    local Actor Touched;

    super.PostBeginPlay();
    // End:0x42
    foreach Touching(Touched)
    {
        Touched.SetZone(false);        
    }    
    //return;    
}

event ActorEnteredVolume(Actor Other)
{
    // End:0x35
    if((Other == none) || Other.bStatic)
    {
        return;
    }
    // End:0xBC
    if(((Other != Instigator) || m_bAffectInstigator) && m_AffectedActors.Find(Other) == -1)
    {
        Other.CustomTimeDilation *= m_fTimeMultiplier;
        m_AffectedActors.AddItem(Other);
    }
    //return;    
}

event ActorLeavingVolume(Actor Other)
{
    // End:0x35
    if((Other == none) || Other.bStatic)
    {
        return;
    }
    // End:0xBC
    if(((Other != Instigator) || m_bAffectInstigator) && m_AffectedActors.Find(Other) != -1)
    {
        Other.CustomTimeDilation /= m_fTimeMultiplier;
        m_AffectedActors.RemoveItem(Other);
    }
    //return;    
}

event PawnEnteredVolume(Pawn Other)
{
    local TgPawn OtherTgPawn;

    // End:0x35
    if((Other == none) || Other.bStatic)
    {
        return;
    }
    // End:0x14D
    if(((Other != Instigator) || m_bAffectInstigator) && m_AffectedPawns.Find(Other) == -1)
    {
        OtherTgPawn = TgPawn(Other);
        // End:0x10E
        if(OtherTgPawn != none)
        {
            OtherTgPawn.AdjustDevicesForNewDilation(OtherTgPawn.CustomTimeDilation, OtherTgPawn.CustomTimeDilation * m_fTimeMultiplier);
        }
        Other.CustomTimeDilation *= m_fTimeMultiplier;
        m_AffectedPawns.AddItem(Other);
    }
    //return;    
}

event PawnLeavingVolume(Pawn Other)
{
    local TgPawn OtherTgPawn;

    // End:0x35
    if((Other == none) || Other.bStatic)
    {
        return;
    }
    // End:0x14D
    if(((Other != Instigator) || m_bAffectInstigator) && m_AffectedPawns.Find(Other) != -1)
    {
        OtherTgPawn = TgPawn(Other);
        // End:0x10E
        if(OtherTgPawn != none)
        {
            OtherTgPawn.AdjustDevicesForNewDilation(OtherTgPawn.CustomTimeDilation, OtherTgPawn.CustomTimeDilation / m_fTimeMultiplier);
        }
        Other.CustomTimeDilation /= m_fTimeMultiplier;
        m_AffectedPawns.RemoveItem(Other);
    }
    //return;    
}

event Destroyed()
{
    local int I;

    I = m_AffectedActors.Length - 1;
    J0x17:

    // End:0x51 [Loop If]
    if(I >= 0)
    {
        ActorLeavingVolume(m_AffectedActors[I]);
        I--;
        // [Loop Continue]
        goto J0x17;
    }
    I = m_AffectedPawns.Length - 1;
    J0x68:

    // End:0xA2 [Loop If]
    if(I >= 0)
    {
        PawnLeavingVolume(m_AffectedPawns[I]);
        I--;
        // [Loop Continue]
        goto J0x68;
    }
    //return;    
}

defaultproperties
{
    m_fTimeMultiplier=0.2500000
    bMoveProjectiles=true
    // Reference: BrushComponent'TgGame.Default__TgTimeDilationVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__PhysicsVolume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    // Reference: CylinderComponent'TgGame.Default__TgTimeDilationVolume.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        CollisionHeight=200.0000000
        CollisionRadius=480.0000000
        ReplacementPrimitive=none
        CollideActors=true
    end object
    Components[0]=CollisionCylinder
    bStatic=false
    bNoDelete=false
    bReplicateInstigator=true
    bSkipActorPropertyReplication=false
    CollisionComponent=CollisionCylinder
}