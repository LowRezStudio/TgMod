class DecalManager extends Actor
    native(Decal)
    config(Game)
    notplaceable
    hidecategories(Navigation);

struct native ActiveDecalInfo
{
    var export editinline DecalComponent Decal;
    var float LifetimeRemaining;

    structdefaultproperties
    {
        Decal=none
        LifetimeRemaining=0.0000000
    }
};

var protected export editinline DecalComponent DecalTemplate;
var export editinline array<export editinline DecalComponent> PoolDecals;
var globalconfig float DecalLifeSpan;
var float DecalDepthBias;
var float OrbisDecalDepthBias;
var Vector2D DecalBlendRange;
var array<ActiveDecalInfo> ActiveDecals;

// Export UDecalManager::execAreDynamicDecalsEnabled(FFrame&, void* const)
native static final function bool AreDynamicDecalsEnabled();

// Export UDecalManager::execGetMaxActiveDecals(FFrame&, void* const)
native static final function int GetMaxActiveDecals();

event DecalFinished(DecalComponent Decal)
{
    // End:0x4C
    if(Decal != none)
    {
        Decal.ResetToDefaults();
        PoolDecals[PoolDecals.Length] = Decal;
    }
    //return;    
}

function bool CanSpawnDecals()
{
    return AreDynamicDecalsEnabled();
    //return ReturnValue;    
}

static final function SetDecalParameters(DecalComponent TheDecal, MaterialInterface DecalMaterial, Vector DecalLocation, Rotator DecalOrientation, float Width, float Height, float Thickness, bool bNoClip, float DecalRotation, PrimitiveComponent HitComponent, bool bProjectOnTerrain, bool bProjectOnSkeletalMeshes, name HitBone, int HitNodeIndex, int HitLevelIndex, int InFracturedStaticMeshComponentIndex, float DepthBias, float OrbisDepthBias, Vector2D BlendRange)
{
    TheDecal.Location = DecalLocation;
    TheDecal.Orientation = DecalOrientation;
    TheDecal.DecalRotation = DecalRotation;
    TheDecal.Width = Width;
    TheDecal.Height = Height;
    TheDecal.FarPlane = Thickness * 0.5000000;
    TheDecal.NearPlane = -TheDecal.FarPlane;
    TheDecal.bNoClip = bNoClip;
    TheDecal.HitComponent = HitComponent;
    TheDecal.HitBone = HitBone;
    TheDecal.HitNodeIndex = HitNodeIndex;
    TheDecal.HitLevelIndex = HitLevelIndex;
    TheDecal.SetDecalMaterial(DecalMaterial);
    TheDecal.bProjectOnTerrain = bProjectOnTerrain;
    TheDecal.bProjectOnSkeletalMeshes = bProjectOnSkeletalMeshes;
    TheDecal.FracturedStaticMeshComponentIndex = InFracturedStaticMeshComponentIndex;
    TheDecal.DepthBias = DepthBias;
    TheDecal.OrbisDepthBias = OrbisDepthBias;
    TheDecal.BlendRange = BlendRange;
    //return;    
}

protected function DecalComponent GetPooledComponent()
{
    local int I;
    local editinline DecalComponent Result;
    local int MaxActiveDecals;

    J0x00:
    // End:0xC8 [Loop If]
    if(PoolDecals.Length > 0)
    {
        I = PoolDecals.Length - 1;
        Result = PoolDecals[I];
        PoolDecals.Remove(I, 1);
        // End:0xBA
        if(((Result != none) && !Result.IsPendingKill()) && !Result.IsWaitingForResetToDefaultsToComplete())
        {
            // [Explicit Break]
            goto J0xC8;            
        }
        else
        {
            Result = none;
        }
        // [Loop Continue]
        goto J0x00;
    }
    J0xC8:

    // End:0x19D
    if(Result == none)
    {
        MaxActiveDecals = GetMaxActiveDecals();
        // End:0x168
        if((MaxActiveDecals > 0) && ActiveDecals.Length >= MaxActiveDecals)
        {
            Result = ActiveDecals[0].Decal;
            Result.ResetToDefaults();
            ActiveDecals.Remove(0, 1);
        }
        Result = new (self) DecalTemplate.Class (DecalTemplate);
    }
    return Result;
    //return ReturnValue;    
}

function DecalComponent SpawnDecal(bool bUsePool, MaterialInterface DecalMaterial, Vector DecalLocation, Rotator DecalOrientation, float Width, float Height, float Thickness, bool bNoClip, optional float DecalRotation = -1.0000000, optional PrimitiveComponent HitComponent, optional bool bProjectOnTerrain = true, optional bool bProjectOnSkeletalMeshes, optional name HitBone, optional int HitNodeIndex = -1, optional int HitLevelIndex = -1, optional float InDecalLifeSpan = DecalLifeSpan, optional int InFracturedStaticMeshComponentIndex = -1, optional float InDepthBias = DecalDepthBias, optional float InOrbisDepthBias = OrbisDecalDepthBias, optional Vector2D InBlendRange = DecalBlendRange)
{
    local editinline DecalComponent Result;
    local ActiveDecalInfo DecalInfo;

    // End:0x71
    if(!CanSpawnDecals())
    {
        return none;
    }
    // End:0x95
    if(bUsePool)
    {
        Result = GetPooledComponent();        
    }
    else
    {
        Result = new (self) Class'Engine.DecalComponent';
    }
    // End:0xD1
    if(DecalRotation < float(0))
    {
        DecalRotation = FRand() * 360.0000000;
    }
    SetDecalParameters(Result, DecalMaterial, DecalLocation, DecalOrientation, Width, Height, Thickness, bNoClip, DecalRotation, HitComponent, bProjectOnTerrain, bProjectOnSkeletalMeshes, HitBone, HitNodeIndex, HitLevelIndex, -1, InDepthBias, InOrbisDepthBias, InBlendRange);
    AttachComponent(Result);
    // End:0x207
    if(bUsePool)
    {
        DecalInfo.Decal = Result;
        DecalInfo.LifetimeRemaining = InDecalLifeSpan;
        ActiveDecals.AddItem(DecalInfo);
    }
    return Result;
    //return ReturnValue;    
}

defaultproperties
{
    // Reference: DecalComponent'Engine.Default__DecalManager.BaseDecal'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BaseDecal'
    begin object name="BaseDecal" class=Engine.DecalComponent
        ReplacementPrimitive=none
        bIgnoreOwnerHidden=true
    end object
    DecalTemplate=BaseDecal
    DecalLifeSpan=30.0000000
    DecalDepthBias=-0.0000600
    OrbisDecalDepthBias=-1.6000000
    DecalBlendRange=(X=89.5000000,Y=180.0000000)
    TickGroup=ETickingGroup.TG_DuringAsyncWork
}