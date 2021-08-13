# iocage-plugin-logitechmediaserver
Artifact file(s) for Logitech Media Server

# Logitech Media Server
**Logitech Media Server** (formerly SlimServer, SqueezeCenter and Squeezebox Server) is a [streaming audio](https://en.wikipedia.org/wiki/Streaming_audio "Streaming audio") server supported by [Logitech](https://en.wikipedia.org/wiki/Logitech "Logitech") (formerly [Slim Devices](https://en.wikipedia.org/wiki/Slim_Devices "Slim Devices")), developed in particular to support their [Squeezebox](https://en.wikipedia.org/wiki/Squeezebox_(network_music_player) "Squeezebox (network music player)") range of digital audio receivers. [Wikipedia](https://en.wikipedia.org/wiki/Logitech_Media_Server)

## Version
LMS community provides 3 versions :
-   `latest`: the latest release version, currently v8.1.1
-   `stable`: the  [bug fix branch](https://github.com/Logitech/slimserver/tree/public/8.1)  based on the latest release, currently v8.1.2 **( Plugin build on this version )**
-   `dev`: the  [development version](https://github.com/Logitech/slimserver/), with new features, and potentially less stability, currently v8.2.0

## How to use

### Add your library on LMS

- Stop the jail
- Add a mount point for your media library and check "Read-only"
- Add a second mount point for your playlists
- Start the jail 
- Open the browser at this address : http://\<JAIL ADDRESS>:9000
- Settings / Add your mount points /Apply

### Autodiscovery on players :
- [piCorePlayer](https://www.picoreplayer.org/)
- Squeezebox players
- Slimdevices players

## Issues known

Some plugins don't work because binaries are not compiled for this platform:

- Chromecast Bridge
-  Local Player

**Don't install ShairTunes2 (fork) and AirPlay bridge plugins in same times, LMS will stop working.**
If LMS is broken delete ShairTunes2W or RaopBridge folder in /var/lib/logitechmediaserver/cache/InstalledPlugins/Plugins and restart your jail.

## Source ...

Instruction for build : [https://audiodigitale.eu/?p=87](https://audiodigitale.eu/?p=87)\
Docker repository : [https://hub.docker.com/r/lmscommunity/logitechmediaserver](https://hub.docker.com/r/lmscommunity/logitechmediaserver)\
Forum : [https://forums.slimdevices.com/](https://forums.slimdevices.com/)