class OnlinePlaylistProvider extends UIResourceDataProvider
    transient
    native(UIPrivate)
    config(Playlist)
    perobjectconfig
    hidecategories(Object,UIRoot);

var config int PlaylistId;
var config array<config name> PlaylistGameTypeNames;
var const config localized string DisplayName;
var config int Priority;
