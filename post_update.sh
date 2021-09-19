#!/usr/bin/env bash

package_version_url="http://downloads.slimdevices.com/nightly/?ver=8.1"
service_name="logitechmediaserver"
work_dir="/var/lib/${service_name}"
log_dir="/var/log/${service_name}"
home_dir="/usr/local/share/${service_name}"

logitechmediaserver_user=squeezebox
logitechmediaserver_group=squeezebox

chmod +x "/usr/local/etc/rc.d/${service_name}"
service "${service_name}" start
if [[ $? -ne 0 ]]; then
    # Find the perl version x.y or x.yy
    perl_major_version=$(perl -e 'print "$^V\n"' | cut -c 2- | cut -d "." -f 1)
    perl_version=$(perl -e 'print "$^V\n"' | cut -d "." -f 2)
    if [ -d "/tmp/${perl_major_version}.${perl_version}" ]; then
        chown -R ${logitechmediaserver_user}:${logitechmediaserver_group} /tmp/${perl_major_version}.${perl_version}
        cp -a /tmp/${perl_major_version}.${perl_version}/* ${home_dir}/CPAN/arch/${perl_major_version}.${perl_version}
        rm -fr /tmp/${perl_major_version}.${perl_version}
    else
        echo "No Binary CPAN matching to your Perl version."
        exit 1
    fi
    service "${service_name}" start
    if [[ $? -ne 0 ]]; then
        exit $?
    fi
fi
