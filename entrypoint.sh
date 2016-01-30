#!/bin/bash
create_user() {
  # ensure home directory is owned by browser
  # and that profile files exist
  if [[ -d /home/${USER} ]]; then
    chown ${USER_UID}:${USER_GID} /home/${USER}
    # copy user files from /etc/skel
    cp /etc/skel/.bashrc /home/$USER
    cp /etc/skel/.bash_logout /home/${USER}
    cp /etc/skel/.profile /home/${USER}
    chown ${USER_UID}:${USER_GID} \
      /home/${USER}/.bashrc \
      /home/${USER}/.profile \
      /home/${USER}/.bash_logout
  fi
  # create group with USER_GID
  if ! getent group ${USER} >/dev/null; then
    groupadd -f -g ${USER_GID} ${USER} 2> /dev/null
  fi

  # create user with USER_UID
  if ! getent passwd ${USER} >/dev/null; then
    adduser --disabled-login --uid ${USER_UID} --gid ${USER_GID} \
      --gecos 'Madness.' ${USER}
  fi
}

grant_access_to_video_devices() {
  for device in /dev/video*
  do
    if [[ -c $device ]]; then
      VIDEO_GID=$(stat -c %g $device)
      break
    fi
  done

  # create video group if requried
  if [[ -n $VIDEO_GID ]]; then
    getent group $VIDEO_GID || groupadd -f -g $VIDEO_GID dockervideo
    adduser ${BROWSER_BOX_USER} dockervideo
  fi
}

create_user
grant_access_to_video_devices
su -c "/usr/bin/chromium --profile-directory=Default --app-id=bikioccmkafdpakkkcpdbppfkghcmihk" ${USER}
