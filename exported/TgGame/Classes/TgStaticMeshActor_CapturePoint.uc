class TgStaticMeshActor_CapturePoint extends StaticMeshActor
    native(Pawns)
    hidecategories(Navigation);

var(capturePoint) const LinearColor UncontestedCaptureColor;
var(capturePoint) const LinearColor FriendlyCaptureColor;
var(capturePoint) const LinearColor EnemyCaptureColor;
var(capturePoint) const name EmissiveColorParameterName;
var(capturePoint) const name CapturePercentParameterName;
var transient array<MaterialInterface> InitialMaterialList;
var const bool bInstancedAllMaterials;
var int CurrentCaptureStatus;
var float CurrentCapturePercent;

// Export UTgStaticMeshActor_CapturePoint::execSetEmissiveColor(FFrame&, void* const)
native final function SetEmissiveColor(LinearColor NewColor, float fPercent, optional float fRampTime = 1.0000000);

// Export UTgStaticMeshActor_CapturePoint::execSetCapturePercent(FFrame&, void* const)
native final function SetCapturePercent(float fNewPercent, optional float bRampTime = 1.0000000);

final simulated event SetCaptureStatus(int nCaptureStatus, float fPercent)
{
    // End:0xCA
    if(nCaptureStatus != CurrentCaptureStatus)
    {
        switch(nCaptureStatus)
        {
            // End:0x4E
            case 1:
                SetEmissiveColor(FriendlyCaptureColor, fPercent);
                // End:0xA1
                break;
            // End:0x73
            case 2:
                SetEmissiveColor(EnemyCaptureColor, fPercent);
                // End:0xA1
                break;
            // End:0xFFFF
            default:
                SetEmissiveColor(UncontestedCaptureColor, 0.0000000);
                fPercent = 0.0000000;
                // End:0xA1
                break;
                break;
        }
        CurrentCaptureStatus = nCaptureStatus;
        CurrentCapturePercent = fPercent;        
    }
    else
    {
        // End:0x119
        if((nCaptureStatus > 0) && fPercent != CurrentCapturePercent)
        {
            SetCapturePercent(fPercent);
            CurrentCapturePercent = fPercent;
        }
    }
    //return;    
}

defaultproperties
{
    UncontestedCaptureColor=(R=0.4100000,G=0.4100000,B=0.4100000,A=1.0000000)
    FriendlyCaptureColor=(R=0.0400000,G=0.3300000,B=1.0000000,A=1.0000000)
    EnemyCaptureColor=(R=1.2300000,G=0.1200000,B=0.0000000,A=1.0000000)
    EmissiveColorParameterName="Emissive_Color"
    CapturePercentParameterName="CapturePercent"
    // Reference: StaticMeshComponent'TgGame.Default__TgStaticMeshActor_CapturePoint.StaticMeshComponent0'
    // TemplateOwnerClass: none
    // TemplateOwnerName: 'StaticMeshComponent0'
    // Archetype: StaticMeshComponent'Engine.Default__StaticMeshActor.StaticMeshComponent0'
    begin object name="StaticMeshComponent0"
        ReplacementPrimitive=none
    end object
    StaticMeshComponent=StaticMeshComponent0
    // Reference: TgSilhouetteComponent'TgGame.Default__TgStaticMeshActor_CapturePoint.MySilhouette'
    // Archetype: TgSilhouetteComponent'Engine.Default__StaticMeshActor.MySilhouette'
    begin object name="MySilhouette"
        MeshComponent=StaticMeshComponent'TgGame.Default__TgStaticMeshActor_CapturePoint.StaticMeshComponent0'
        ReplacementPrimitive=none
    end object
    Silhouette=MySilhouette
    Components[0]=StaticMeshComponent0
    Components[1]=MySilhouette
    CollisionComponent=StaticMeshComponent0
}