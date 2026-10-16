class TgEmitter extends Emitter
    native(FX)
    hidecategories(Navigation);

var repnotify name BoneName;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        BoneName;
}

simulated event ReplicatedEvent(name VarName)
{
    // End:0x86
    if(VarName == 'BoneName')
    {
        // End:0x83
        if((Pawn(Base) != none) && Pawn(Base).Mesh != none)
        {
            AttachTo(Pawn(Base), BoneName);
        }        
    }
    else
    {
        super.ReplicatedEvent(VarName);
    }
    //return;    
}

function AttachTo(Pawn P, name NewBoneName)
{
    BoneName = NewBoneName;
    // End:0x67
    if((int(WorldInfo.NetMode) == int(NM_DedicatedServer)) || NewBoneName == 'None')
    {
        SetBase(P);        
    }
    else
    {
        SetBase(P,, P.Mesh, BoneName);
    }
    //return;    
}

simulated function ScaleEmitter(float ScaleFactor)
{
    SetDrawScale(ScaleFactor);
    //return;    
}

defaultproperties
{
    // Reference: ParticleSystemComponent'TgGame.Default__TgEmitter.ParticleSystemComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'ParticleSystemComponent0'
    // Archetype: ParticleSystemComponent'Engine.Default__Emitter.ParticleSystemComponent0'
    begin object name="ParticleSystemComponent0"
        ReplacementPrimitive=none
    end object
    ParticleSystemComponent=ParticleSystemComponent0
    bDestroyOnSystemFinish=true
    Components[0]=ParticleSystemComponent0
    bNoDelete=false
    LifeSpan=60.0000000
}