class TgCollisionProxy extends Actor
    native
    notplaceable
    hidecategories(Navigation);

var array<TgPawn> m_NearByPlayers;
var bool m_bIgnoreStealthPlayers;
var bool m_bIgnoreNonPlayers;
var bool m_bIgnoreInvulnerablePlayers;
var bool m_bForwardOwnerOnly;
//var delegate<ProxyTouch> __ProxyTouch__Delegate;
//var delegate<ProxyUnTouch> __ProxyUnTouch__Delegate;

delegate ProxyTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    //return;    
}

delegate ProxyUnTouch(Actor Other)
{
    //return;    
}

// Export UTgCollisionProxy::execForwardTouch(FFrame&, void* const)
native function ForwardTouch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal);

// Export UTgCollisionProxy::execForwardUnTouch(FFrame&, void* const)
native function ForwardUnTouch(Actor Other);

// Export UTgCollisionProxy::execDelegatesUpdated(FFrame&, void* const)
native function DelegatesUpdated();

// Export UTgCollisionProxy::execTouchOther(FFrame&, void* const)
native function TouchOther(Actor Other, PrimitiveComponent OtherComp);

simulated event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local TgPawn aPawn;

    // End:0x4E
    if(!m_bForwardOwnerOnly)
    {
        aPawn = TgPawn(Other);
        // End:0x4E
        if(aPawn != none)
        {
            CheckNearByPlayers(aPawn, true);
        }
    }
    ForwardTouch(Other, OtherComp, HitLocation, HitNormal);
    //return;    
}

simulated event UnTouch(Actor Other)
{
    local TgPawn aPawn;

    // End:0x4E
    if(!m_bForwardOwnerOnly)
    {
        aPawn = TgPawn(Other);
        // End:0x4E
        if(aPawn != none)
        {
            CheckNearByPlayers(aPawn, false);
        }
    }
    ForwardUnTouch(Other);
    //return;    
}

simulated event bool ShouldIgnoreActor(TgPawn aPawn)
{
    // End:0xDB
    if(aPawn != none)
    {
        // End:0x49
        if(m_bIgnoreStealthPlayers && int(aPawn.r_eIsStealthed) != int(0))
        {
            return true;
        }
        // End:0x82
        if(m_bIgnoreNonPlayers && aPawn.r_nPhysicalType != 10034)
        {
            return true;
        }
        // End:0xDB
        if((m_bIgnoreInvulnerablePlayers && aPawn.r_EffectManager != none) && aPawn.r_bIsInStasis)
        {
            return true;
        }
    }
    return false;
    //return ReturnValue;    
}

simulated event ForceClearNearByPlayersList()
{
    local int I;

    I = 0;
    J0x0B:

    // End:0x4E [Loop If]
    if(I < m_NearByPlayers.Length)
    {
        OnPlayerRemoved(m_NearByPlayers[I]);
        I++;
        // [Loop Continue]
        goto J0x0B;
    }
    m_NearByPlayers.Length = 0;
    //return;    
}

simulated function Destroyed()
{
    super.Destroyed();
    ForceClearNearByPlayersList();
    //return;    
}

simulated function CheckNearByPlayers(TgPawn aPawn, bool bAdd)
{
    local bool bFound;
    local int I, nLen;

    nLen = m_NearByPlayers.Length;
    I = 0;
    J0x1F:

    // End:0x74 [Loop If]
    if(I < nLen)
    {
        // End:0x66
        if(aPawn == m_NearByPlayers[I])
        {
            bFound = true;
            // [Explicit Break]
            goto J0x74;
        }
        I++;
        // [Loop Continue]
        goto J0x1F;
    }
    J0x74:

    // End:0xF2
    if(bAdd)
    {
        // End:0xEF
        if(!bFound && !ShouldIgnoreActor(aPawn))
        {
            m_NearByPlayers.Insert(nLen, 1);
            m_NearByPlayers[I] = aPawn;
            OnPlayerAdded(aPawn);
        }        
    }
    else
    {
        // End:0x127
        if(bFound)
        {
            m_NearByPlayers.Remove(I, 1);
            OnPlayerRemoved(aPawn);
        }
    }
    //return;    
}

simulated function OnPlayerAdded(TgPawn aPawn)
{
    //return;    
}

simulated function OnPlayerRemoved(TgPawn aPawn)
{
    //return;    
}

simulated function int GetNearByPlayers(optional bool bOnlyValid = true)
{
    local TgPawn P;
    local int nCount, I;

    // End:0x1F
    if(!bOnlyValid)
    {
        return m_NearByPlayers.Length;
    }
    I = 0;
    J0x2A:

    // End:0xA3 [Loop If]
    if(I < m_NearByPlayers.Length)
    {
        P = m_NearByPlayers[I];
        // End:0x71
        if(P == none)
        {            
        }
        else
        {
            // End:0x8A
            if(ShouldIgnoreActor(P))
            {                
            }
            else
            {
                nCount++;
            }
        }
        I++;
        // [Loop Continue]
        goto J0x2A;
    }
    return nCount;
    //return ReturnValue;    
}

simulated function GetNearByPlayersTaskforce(out array<int> NearByPlayerTaskforces, optional bool bEndWhenMultipleFound)
{
    local int I, J, nCurrTaskForce;
    local TgPawn P;
    local bool bFound;

    I = 0;
    J0x0C:

    // End:0x14F [Loop If]
    if(I < m_NearByPlayers.Length)
    {
        bFound = false;
        P = m_NearByPlayers[I];
        // End:0x66
        if(ShouldIgnoreActor(P))
        {            
        }
        else
        {
            nCurrTaskForce = int(P.GetTaskForceNumber());
            J = 0;
            J0x9C:

            // End:0xF2 [Loop If]
            if(J < NearByPlayerTaskforces.Length)
            {
                // End:0xE4
                if(NearByPlayerTaskforces[J] == nCurrTaskForce)
                {
                    bFound = true;
                    // [Explicit Break]
                    goto J0xF2;
                }
                J++;
                // [Loop Continue]
                goto J0x9C;
            }
            J0xF2:

            // End:0x141
            if(!bFound)
            {
                NearByPlayerTaskforces[NearByPlayerTaskforces.Length] = nCurrTaskForce;
                // End:0x141
                if(bEndWhenMultipleFound && NearByPlayerTaskforces.Length > 1)
                {
                    // [Explicit Break]
                    goto J0x14F;
                }
            }
        }
        I++;
        // [Loop Continue]
        goto J0x0C;
    }
    J0x14F:

    //return;    
}

simulated function ForceProximityScan(optional float Radius)
{
    local TgPawn P;

    // End:0x45
    if(Radius == 0.0000000)
    {
        Radius = CylinderComponent(CollisionComponent).CollisionRadius;
    }
    // End:0xA1
    foreach OverlappingActors(Class'TgGame.TgPawn', P, Radius)
    {
        TouchOther(P, P.Mesh);        
    }    
    //return;    
}

// Export UTgCollisionProxy::execSetAux(FFrame&, void* const)
native function SetAux(name AuxBusName, float Level);

defaultproperties
{
    // Reference: CylinderComponent'TgGame.Default__TgCollisionProxy.CollisionCylinder'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'CollisionCylinder'
    begin object name="CollisionCylinder" class=Engine.CylinderComponent
        ReplacementPrimitive=none
        CollideActors=true
        BlockZeroExtent=false
    end object
    Components[0]=CollisionCylinder
    bCollideActors=true
    CollisionComponent=CollisionCylinder
}