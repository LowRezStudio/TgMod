class TgCameraModule_FallOutOfWorld extends TgCameraModule_Free;

function UpdateCamera(Pawn P, TgPlayerCamera CameraActor, float DeltaTime, out TViewTarget OutVT)
{
    // End:0xB6
    if(OutVT.Target != none)
    {
        OutVT.POV.Rotation = Rotator(OutVT.Target.Location - OutVT.POV.Location);
    }
    //return;    
}

function Vector GetCamLocationOffset(Pawn P)
{
    local Vector Offset;
    local TgPawn TgP;

    Offset = super.GetCamLocationOffset(P);
    // End:0x7E
    if(!P.IsAliveAndWell())
    {
        Offset.Z -= P.GetCollisionHeight();
    }
    TgP = TgPawn(P);
    // End:0x127
    if((TgP.Mesh != none) && int(TgP.c_LocalPolymorph) == int(0))
    {
        Offset *= TgP.Mesh.Scale;
    }
    return Offset;
    //return ReturnValue;    
}
