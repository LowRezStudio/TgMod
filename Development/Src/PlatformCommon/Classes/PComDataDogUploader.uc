class PComDataDogUploader extends Object
    native;

enum METRIC_TYPE
{
    DD_COUNT,
    DD_GAUGE,
    DD_RATE
};

struct native DataDogMetricsConfig
{
    var init string DD_API_TOKEN;
    var init string serverLink;
    var init string URL;
    var init string hostnameTag;
    var init string baseSeriesName;
    var int sendIntervalSeconds;
    var int writeIntervalTicks;
    var init array<init string> tags;

    structdefaultproperties
    {
        DD_API_TOKEN=""
        serverLink=""
        URL=""
        hostnameTag=""
        baseSeriesName=""
        sendIntervalSeconds=0
        writeIntervalTicks=0
        tags=()
    }
};

struct native MetricPoint
{
    var QWord unixUTCTimestamp;
    var float Value;

    structdefaultproperties
    {
        unixUTCTimestamp=()
        Value=0.0000000
    }
};

struct native Metric
{
    var PComDataDogUploader.METRIC_TYPE Type;
    var init array<init MetricPoint> Points;

    structdefaultproperties
    {
        Type=DD_COUNT
        Points=()
    }
};

var private native const noexport Pointer VfTable_FTickableObject;
var float m_NextUpdateInSeconds;
var int m_nNextWrite;
var string m_fsBaseSeriesName;
var DataDogMetricsConfig m_Config;
var init native map{VOID,VOID} m_Metrics;
var Pointer DDUploadSyncObject;
