class TextureMovie extends Texture
    native(Texture)
    hidecategories(Object);

enum EMovieStreamSource
{
    MovieStream_File,               // 0
    MovieStream_Memory,             // 1
    MovieStream_MAX                 // 2
};

var const int SizeX;
var const int SizeY;
var const Texture.EPixelFormat Format;
var() Texture.TextureAddress AddressX;
var() Texture.TextureAddress AddressY;
var() TextureMovie.EMovieStreamSource MovieStreamSource;
var const Class<CodecMovie> DecoderClass;
var const transient CodecMovie Decoder;
var const transient bool Paused;
var const transient bool Stopped;
var() bool Looping;
var() bool ResetOnLastFrame;
var() bool AutoPlay;
var native const UntypedBulkData_Mirror Data;
var native const transient Pointer ReleaseCodecFence;

// Export UTextureMovie::execPlay(FFrame&, void* const)
native function Play();

// Export UTextureMovie::execPause(FFrame&, void* const)
native function Pause();

// Export UTextureMovie::execStop(FFrame&, void* const)
native function Stop();

defaultproperties
{
    MovieStreamSource=EMovieStreamSource.MovieStream_Memory
    DecoderClass=Class'Engine.CodecMovieFallback'
    Looping=true
    AutoPlay=true
    NeverStream=true
}