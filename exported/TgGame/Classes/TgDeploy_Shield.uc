class TgDeploy_Shield extends TgDeployable
    native(Deployable)
    notplaceable
    hidecategories(Navigation);

var bool bBasedOnPawn;

event BaseChange()
{
    local TgPawn TgP;

    // End:0x13A
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0x13A
        if((Instigator == Base) || bBasedOnPawn)
        {
            TgP = TgPawn(Instigator);
            // End:0x13A
            if(TgP != none)
            {
                // End:0xD1
                if((TgP.s_AttachedProjBlocker == self) && Base != TgP)
                {
                    bBasedOnPawn = false;
                    TgP.s_AttachedProjBlocker = none;                    
                }
                else
                {
                    // End:0x13A
                    if((TgP.s_AttachedProjBlocker != self) && Base == TgP)
                    {
                        bBasedOnPawn = true;
                        TgP.s_AttachedProjBlocker = self;
                    }
                }
            }
        }
    }
    //return;    
}

simulated function Destroyed()
{
    local TgPawn TgP;

    // End:0xA2
    if(int(Role) == int(ROLE_Authority))
    {
        // End:0xA2
        if(((Base != none) && bBasedOnPawn) && Base == Instigator)
        {
            TgP = TgPawn(Instigator);
            // End:0xA2
            if(TgP != none)
            {
                TgP.s_AttachedProjBlocker = none;
                bBasedOnPawn = false;
            }
        }
    }
    super.Destroyed();
    //return;    
}

defaultproperties
{
    m_bAdjustMeshToGround=false
    // Reference: DynamicLightEnvironmentComponent'TgGame.Default__TgDeploy_Shield.MyLightEnvironment'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'MyLightEnvironment'
    // Archetype: DynamicLightEnvironmentComponent'TgGame.Default__TgDeployable.MyLightEnvironment'
    begin object name="MyLightEnvironment"
    end object
    LightEnvironment=MyLightEnvironment
    m_CollisionSettings=(mCollisionMode=AdvancedCollisionMode.ACM_Shield,bUseMeshForCollision=true)
    m_nInitHUDOverlayDisplayMask=56
    Components[0]=MyLightEnvironment
    bCollideActors=true
    bProjTarget=true
    bNoEncroachCheck=true
}