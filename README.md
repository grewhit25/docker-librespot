# liberspot standalone - for testing only

This is a fork of [kevineye repo](https://github.com/kevineye/docker-librespot.git)

Please dop not use.
multi-arch testing only.

This container runs a headless [Spotify](https://www.spotify.com/us/) player that can be remote-controlled by any Spotify app. Audio is output to a pipe, which can be consumed in another container or the host system by [alsa](http://www.alsa-project.org/), [pulseaudio](http://pulseaudio.org), [forked-daapd](https://ejurgensen.github.io/forked-daapd/) (to Airplay), [snapserver](https://github.com/badaix/snapcast), etc.

This requires a Spotify premium account, but does not require a Spotify developer key or libspotify binary.

The process run is [librespot](https://github.com/plietar/librespot), an open source client library for Spotify.

### Examples

Play audio to /tmp/spotify-pipe:

    docker run -d \
        -v /tmp/spotify-pipe:/data/fifo
        -e SPOTIFY_NAME=Docker \
        -e SPOTIFY_USER=... \
        -e SPOTIFY_PASSWORD=... \
        kevineye/librespot
