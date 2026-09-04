class ColorScaleVolume extends Volume
    placeable
    hidecategories(Navigation,Object,Movement,Display,Collision,Brush,Attachment,Volume);

var() Vector ColorScale;
var() float InterpTime;

event Touch(Actor Other, PrimitiveComponent OtherComp, Vector HitLocation, Vector HitNormal)
{
    local Pawn P;
    local PlayerController PC;

    super(Actor).Touch(Other, OtherComp, HitLocation, HitNormal);
    P = Pawn(Other);
    // End:0x105
    if(P != none)
    {
        PC = PlayerController(P.Controller);
        // End:0x105
        if((PC != none) && PC.PlayerCamera != none)
        {
            PC.PlayerCamera.SetDesiredColorScale(ColorScale, InterpTime);
        }
    }
    //return;    
}

event UnTouch(Actor Other)
{
    local Pawn P;
    local PlayerController PC;
    local Vector DesiredColorScale;
    local float DesiredInterpTime;
    local int Idx;
    local ColorScaleVolume CSV;

    super(Actor).UnTouch(Other);
    P = Pawn(Other);
    // End:0x23A
    if(P != none)
    {
        PC = PlayerController(P.Controller);
        // End:0x23A
        if((PC != none) && PC.PlayerCamera != none)
        {
            DesiredColorScale = WorldInfo.DefaultColorScale;
            DesiredInterpTime = 1.0000000;
            // End:0x1F4
            if(P.Touching.Length > 0)
            {
                Idx = P.Touching.Length;
                J0x129:

                // End:0x1F4 [Loop If]
                if(Idx >= 0)
                {
                    CSV = ColorScaleVolume(P.Touching[Idx]);
                    // End:0x1E6
                    if((CSV != none) && CSV != self)
                    {
                        DesiredColorScale = CSV.ColorScale;
                        DesiredInterpTime = CSV.InterpTime;
                        // [Explicit Break]
                        goto J0x1F4;
                    }
                    --Idx;
                    // [Loop Continue]
                    goto J0x129;
                }
            }
            J0x1F4:

            PC.PlayerCamera.SetDesiredColorScale(DesiredColorScale, DesiredInterpTime);
        }
    }
    //return;    
}

defaultproperties
{
    ColorScale=(X=1.0000000,Y=1.0000000,Z=1.0000000)
    InterpTime=1.0000000
    // Reference: BrushComponent'Engine.Default__ColorScaleVolume.BrushComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'BrushComponent0'
    // Archetype: BrushComponent'Engine.Default__Volume.BrushComponent0'
    begin object name="BrushComponent0"
        ReplacementPrimitive=none
    end object
    BrushComponent=BrushComponent0
    Components[0]=BrushComponent0
    CollisionComponent=BrushComponent0
}