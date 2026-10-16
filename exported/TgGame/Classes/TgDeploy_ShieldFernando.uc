class TgDeploy_ShieldFernando extends TgDeploy_Shield
    native(ChampFernando)
    notplaceable
    hidecategories(Navigation);

var int m_nLargeShieldMeshID;
var export editinline MeshComponent m_SmallMesh;
var export editinline MeshComponent m_LargeMesh;
var repnotify int r_nToweringBarrierHealth;
var repnotify int r_nAegisBonusHealth;
var bool m_bHasHeatTransfer;
var bool m_bHasRattle;
var TgPawn_Fernando m_CachedFernandoOwner;

replication
{
    // Pos:0x000
    if(int(Role) == int(ROLE_Authority))
        r_nAegisBonusHealth, r_nToweringBarrierHealth;
}

// Export UTgDeploy_ShieldFernando::execToggleLargeMesh(FFrame&, void* const)
native function ToggleLargeMesh();

simulated event ReplicatedEvent(name VarName)
{
    // End:0x21
    if(VarName == 'r_nToweringBarrierHealth')
    {
        ToggleLargeMesh();
    }
    super(TgDeployable).ReplicatedEvent(VarName);
    //return;    
}

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn PawnOwner;
    local TgDevice_Rattle RattleDevice;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    // End:0x10D
    if((Other != none) && r_Owner != none)
    {
        PawnOwner = TgPawn(r_Owner.Owner);
        // End:0x10D
        if(PawnOwner != none)
        {
            // End:0x10D
            if(m_bHasRattle)
            {
                RattleDevice = TgDevice_Rattle(PawnOwner.GetActiveDeviceByClass('TgDevice_Rattle'));
                // End:0x10D
                if(RattleDevice != none)
                {
                    RattleDevice.ApplyTouchEffect(Other);
                }
            }
        }
    }
    //return;    
}

event TakeDamage(int Damage, Controller EventInstigator, Vector HitLocation, Vector Momentum, Class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
    local TgPawn TgPOwner;
    local TgDevice_HeatTransfer HeatTransferCard;

    // End:0x164
    if(r_bTakeDamage)
    {
        super(TgDeployable).TakeDamage(Damage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
        // End:0x164
        if(r_Owner != none)
        {
            TgPOwner = TgPawn(r_Owner.Owner);
            // End:0x164
            if(TgPOwner != none)
            {
                // End:0x13A
                if(int(Role) == int(ROLE_Authority))
                {
                    // End:0x13A
                    if(m_bHasHeatTransfer)
                    {
                        HeatTransferCard = TgDevice_HeatTransfer(TgPOwner.GetDeviceByClass(Class'TgGame.TgDevice_HeatTransfer'));
                        // End:0x13A
                        if(HeatTransferCard != none)
                        {
                            HeatTransferCard.RespondToDamageTaken(Damage);
                        }
                    }
                }
                TgPOwner.EnterCombat(DamageCauser, self);
            }
        }
    }
    //return;    
}

defaultproperties
{
    m_nLargeShieldMeshID=5503
    m_bMovableProjBlocker=true
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_ShieldFernando.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    Components[0]=MyLightEnvironment
}