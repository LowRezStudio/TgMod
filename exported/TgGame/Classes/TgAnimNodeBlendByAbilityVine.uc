class TgAnimNodeBlendByAbilityVine extends TgAnimNodeBlendList
    native(Anim)
    hidecategories(Object,Object,Object,Object);

enum EBlendVine
{
    BLENDVINE_Inactive,             // 0
    BLENDVINE_Throw,                // 1
    BLENDVINE_ThrowLoop,            // 2
    BLENDVINE_Pull,                 // 3
    BLENDVINE_HitPostFire,          // 4
    BLENDVINE_MissPostFire,         // 5
    BLENDVINE_MAX                   // 6
};

function VineThrow()
{
    SetActiveChild(1, GetBlendTime(1));
    //return;    
}

function VinePull()
{
    SetActiveChild(3, GetBlendTime(3));
    //return;    
}

function VineHitPost()
{
    // End:0x3D
    if(Children[4].Anim != none)
    {
        SetActiveChild(4, GetBlendTime(4));
    }
    //return;    
}

function VinePost()
{
    // End:0x50
    if(ActiveChildIndex == 3)
    {
        // End:0x4D
        if(Children[4].Anim != none)
        {
            SetActiveChild(4, GetBlendTime(4));
        }        
    }
    else
    {
        SetActiveChild(5, GetBlendTime(5));
    }
    //return;    
}

function VineInactive()
{
    SetActiveChild(0, GetBlendTime(0));
    //return;    
}

defaultproperties
{
    Children=/* Array type was not detected. */
    NodeName="VineAbilityBlendNode"
}