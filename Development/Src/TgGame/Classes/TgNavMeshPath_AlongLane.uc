class TgNavMeshPath_AlongLane extends NavMeshPathConstraint
    native(Navigation)
    config(Engine);

var int m_nLane;

function bool AlongLane(NavigationHandle NavHandle, int nLane) { }

function Recycle() { }
