class CloudStorageBase extends PlatformInterfaceBase
    transient
    native(PlatformInterface);

enum ECloudStorageDelegate
{
    CSD_KeyValueReadComplete,       // 0
    CSD_KeyValueWriteComplete,      // 1
    CSD_ValueChanged,               // 2
    CSD_DocumentQueryComplete,      // 3
    CSD_DocumentReadComplete,       // 4
    CSD_DocumentWriteComplete,      // 5
    CSD_DocumentConflictDetected,   // 6
    CSD_MAX                         // 7
};

var array<string> LocalCloudFiles;
var bool bSuppressDelegateCalls;

// Export UCloudStorageBase::execInit(FFrame&, void* const)
native event Init();

// Export UCloudStorageBase::execIsUsingLocalStorage(FFrame&, void* const)
native function bool IsUsingLocalStorage();

// Export UCloudStorageBase::execReadKeyValue(FFrame&, void* const)
native event bool ReadKeyValue(string KeyName, PlatformInterfaceBase.EPlatformInterfaceDataType Type, out PlatformInterfaceDelegateResult Value);

// Export UCloudStorageBase::execReadKeyValueFromLocalStore(FFrame&, void* const)
native event bool ReadKeyValueFromLocalStore(string KeyName, PlatformInterfaceBase.EPlatformInterfaceDataType Type, out PlatformInterfaceDelegateResult Value);

// Export UCloudStorageBase::execWriteKeyValue(FFrame&, void* const)
native event bool WriteKeyValue(string KeyName, const out PlatformInterfaceData Value);

// Export UCloudStorageBase::execQueryForCloudDocuments(FFrame&, void* const)
native event bool QueryForCloudDocuments();

// Export UCloudStorageBase::execGetNumCloudDocuments(FFrame&, void* const)
native event int GetNumCloudDocuments(optional bool bIsForConflict);

// Export UCloudStorageBase::execGetCloudDocumentName(FFrame&, void* const)
native event string GetCloudDocumentName(int Index);

// Export UCloudStorageBase::execCreateCloudDocument(FFrame&, void* const)
native event int CreateCloudDocument(string Filename);

// Export UCloudStorageBase::execDeleteAllCloudDocuments(FFrame&, void* const)
native event DeleteAllCloudDocuments();

// Export UCloudStorageBase::execReadCloudDocument(FFrame&, void* const)
native event bool ReadCloudDocument(int Index, optional bool bIsForConflict);

// Export UCloudStorageBase::execParseDocumentAsString(FFrame&, void* const)
native event string ParseDocumentAsString(int Index, optional bool bIsForConflict);

// Export UCloudStorageBase::execParseDocumentAsBytes(FFrame&, void* const)
native event ParseDocumentAsBytes(int Index, out array<byte> ByteData, optional bool bIsForConflict);

// Export UCloudStorageBase::execParseDocumentAsObject(FFrame&, void* const)
native event Object ParseDocumentAsObject(int Index, Class ObjectClass, int ExpectedVersion, optional bool bIsForConflict);

// Export UCloudStorageBase::execWriteCloudDocument(FFrame&, void* const)
native event bool WriteCloudDocument(int Index);

// Export UCloudStorageBase::execSaveDocumentWithString(FFrame&, void* const)
native event bool SaveDocumentWithString(int Index, string StringData);

// Export UCloudStorageBase::execSaveDocumentWithBytes(FFrame&, void* const)
native event bool SaveDocumentWithBytes(int Index, array<byte> ByteData);

// Export UCloudStorageBase::execSaveDocumentWithObject(FFrame&, void* const)
native event bool SaveDocumentWithObject(int Index, Object ObjectData, int SaveVersion);

// Export UCloudStorageBase::execIsStillWritingFiles(FFrame&, void* const)
native event bool IsStillWritingFiles();

// Export UCloudStorageBase::execWaitForWritesToFinish(FFrame&, void* const)
native event bool WaitForWritesToFinish(optional float MaxTimeSeconds);

// Export UCloudStorageBase::execResolveConflictWithNewestDocument(FFrame&, void* const)
native event bool ResolveConflictWithNewestDocument();

// Export UCloudStorageBase::execResolveConflictWithVersionIndex(FFrame&, void* const)
native event bool ResolveConflictWithVersionIndex(int Index);

// Export UCloudStorageBase::execUpgradeLocalStorageToCloud(FFrame&, void* const)
native event bool UpgradeLocalStorageToCloud(CloudStorageUpgradeHelper UpgradeHelper, optional bool bForceSearchAgain);
