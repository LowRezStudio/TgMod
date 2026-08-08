class OnlineImageDownloaderWebHelper extends Object
    native
    config(Engine);

native function bool LoadImageFromTempDir(const string Filename, out array<byte> ImageData);  // Export UOnlineImageDownloaderWebHelper::execLoadImageFromTempDir(FFrame&, void* const)

native function bool SaveImageToTempDir(const string Filename, const array<byte> ImageData);  // Export UOnlineImageDownloaderWebHelper::execSaveImageToTempDir(FFrame&, void* const)
