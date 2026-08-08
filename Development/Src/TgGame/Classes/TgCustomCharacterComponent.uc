class TgCustomCharacterComponent extends ActorComponent
    native
    config(Engine);

struct CompositeTextureType {
    var Texture2DComposite CompTexture;
    var name TextureParamName;
    structdefaultproperties {}
};

struct CompositePartInfo {
    var int MeshAsmId;
    var int DestOffsetX;
    var int DestOffsetY;
    var int RegionSizeX;
    var int RegionSizeY;
    structdefaultproperties {}
};

var array<SkeletalMesh> m_SourceMeshList;
var array<CompositeTextureType> m_CompositeTextures;
var int m_nCompositeTextureSizeX;
var int m_nCompositeTextureSizeY;
var () array<CompositePartInfo> m_CompositeParts;
var array<TgSpecialFx> m_CompositeFxList;

native function MergeMeshParts(SkeletalMeshComponent Mesh);  // Export UTgCustomCharacterComponent::execMergeMeshParts(FFrame&, void* const)

native function ComposeCharacter(SkeletalMeshComponent Mesh);  // Export UTgCustomCharacterComponent::execComposeCharacter(FFrame&, void* const)

native function SetupCompositeRegion(int MeshAsmId, int DestOffsetX, int DestOffsetY, int SizeX, int SizeY);  // Export UTgCustomCharacterComponent::execSetupCompositeRegion(FFrame&, void* const)
