#!/usr/bin/env bash

package_version_url="http://downloads.slimdevices.com/nightly/?ver=8.1"
service_name="logitechmediaserver"
work_dir="/var/lib/${service_name}"
log_dir="/var/log/${service_name}"
home_dir="/usr/local/share/${service_name}"

logitechmediaserver_user=squeezebox
logitechmediaserver_group=squeezebox

pw groupadd -n $logitechmediaserver_group
pw useradd -n $logitechmediaserver_user -g $logitechmediaserver_group -s /usr/sbin/nologin -c "Logitech Media Server" -d /usr/local/share/logitechmediaserver


# Download the latest 8.1 logitech media sever
curl -o logitechmediaserver.tgz http://downloads-origin.slimdevices.com/nightly$(curl $package_version_url | grep -o '/8.1[^"]*[0-9].tgz')
tar xjf logitechmediaserver.tgz
if [ ! -f "logitechmediaserver.tgz" ]; then
	err 1 "logitechmediaserver.tgz not found."
fi

rm -fr logitechmediaserver.tgz
mv logitechmediaserver-* logitechmediaserver
mv logitechmediaserver /usr/local/share

# Find the perl version x.y or x.yy and place in Logitech Media Server directory.
perl_major_version=$(perl -e 'print "$^V\n"' | cut -c 2- | cut -d "." -f 1)
perl_version=$(perl -e 'print "$^V\n"' | cut -d "." -f 2)
if [ -d "/tmp/${perl_major_version}.${perl_version}" ]; then
    if [ ! -d "${home_dir}/CPAN/arch/${perl_major_version}.${perl_version}" ]; then
        mkdir ${home_dir}/CPAN/arch/${perl_major_version}.${perl_version}
    fi
    mv /tmp/${perl_major_version}.${perl_version}/amd64-freebsd-thread-multi ${home_dir}/CPAN/arch/${perl_major_version}.${perl_version} > /dev/null 2>&1
    rm -fr /tmp/${perl_major_version}.${perl_version}
else
    err 1 "No Binary CPAN matching with your Perl version."
fi

chown -R ${logitechmediaserver_user}:${logitechmediaserver_group} ${home_dir}

# Create work directory
mkdir -p ${work_dir}/cache ${work_dir}/prefs ${work_dir}/playlists
chown -R ${logitechmediaserver_user}:${logitechmediaserver_group} ${work_dir}

mkdir ${log_dir}
chown -R ${logitechmediaserver_user}:${logitechmediaserver_group} ${log_dir}


sysrc -f /etc/rc.conf ${service_name}_logdir=${log_dir} > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_cachedir="${work_dir}/cache" > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_prefsdir="${work_dir}/prefs" > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_playlistdir="${work_dir}/playlists" > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_flags="" > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_charset="UTF-8" > /dev/null 2>&1
sysrc -f /etc/rc.conf ${service_name}_lc_ctype="en_US.UTF-8" > /dev/null 2>&1

# Enable and start Logitech Media Server
chmod +x "/usr/local/etc/rc.d/${service_name}"
sysrc -f /etc/rc.conf ${service_name}_enable="YES"
service "${service_name}" start
