Docker-signal
===

This repo provides a docker container that aims to run the Signal chrome app in a docker container.
This makes it possible to easily have a different chromium instance without a google account to use for browsing.
Note that browser updates are still in the hands of the user.

This repo is inspired by:
* [jfrazelle/dockerfiles](https://github.com/jfrazelle/dockerfiles)
* [hurricanehrndz/docker-browser-box](https://github.com/hurricanehrndz/docker-browser-box)

For instructions on running this container please consult [run.sh](https://github.com/runjak/docker-signal/blob/master/run.sh).

When running the container the first time or mounting a volume to `/home/$USER` that doesn't have chromium settings + signal installed,
a normal chromium session will appear. Once you've installed signal future starts will remember your settings.
