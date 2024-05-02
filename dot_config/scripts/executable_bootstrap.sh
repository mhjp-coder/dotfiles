
# enable, start, configure tuned
sudo systemctl enable --now tuned
# get current profile: tuned-adm active
# options are ouput of: tuned-adm list
sudo tuned-adm profile virtual-host
