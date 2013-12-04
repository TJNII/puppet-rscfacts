Rackspace Cloud Facts
=====================

This module provides custom Facter facts for the Rackspace cloud.
rackspace.rb provides the following facts:

* is_rsc: Is Rackspace Cloud
* rsc_region: Datacenter Region
* rsc_instance_id: Instance UUID

These facts and the supporting file are from https://github.com/puppetlabs/facter/pull/436/files
and are to be included in Facter 2.0.0 per http://projects.puppetlabs.com/issues/20468.

A 4th roles fact is also provided:
* rsc_roles: Rackspace server roles

This fact is not part of the rsc facts to be included in Facter 2.0.0.

All the rsc facts require xe-guest-utilities-xenstore to be installed, it is installed by default on
Rackspace cloud servers.  A helper installer class is not provided for xenstore at this time.

RackConnect Facts
-----------------

In addition, this module also provides two RackConnect facts:

* is_rsc_rc: Is RackConnected
* rsc_rc_status: RackConnect deployment status

The rsc_rc_status fact requires the Ruby rest-client module.
The rscfacts class is provided to handle this dependency.

Due to the rest-client dependency these facts may not be available until after the first Puppet run.
On RedHat/CentOS this dependency requires the Epel repo.
