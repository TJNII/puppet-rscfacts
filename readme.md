Rackspace Cloud Facts
=====================

This module provides custom Facter facts for the Rackspace cloud.
rackspace.rb provides the following facts:

* is_rsc: Is Rackspace Cloud
* rsc_region: Datacenter Region
* rsc_instance_id: Instance UUID

These facts and the supporting file are from https://github.com/puppetlabs/facter/pull/436/files
and are to be included in Facter 2.0.0 per http://projects.puppetlabs.com/issues/20468.

All the rsc facts require xe-guest-utilities-xenstore to be installed, it is installed by default on
Rackspace cloud servers.  These facts will not be populated if it is not present.

Next Gen Only Facts
===================

A The following extra fact are also provided:
* rsc_roles: Rackspace server roles
* rsc_sla_status: Rackspace Managed Cloud automation status.  (Only populated on Managed next-gen servers)

These facts are not part of the rsc facts to be included in Facter 2.0.0.
They will only be populated on Next Generation cloud servers

RackConnect Facts
-----------------

In addition, this module also provides three RackConnect facts:

* is_rsc_rc: Is RackConnected
* rsc_rc_status: RackConnect deployment status
* rsc_rc_features: Enabled RackConnect Features

These facts are only available on Next Generation cloud servers.
Furthermore, status and features are only populated on RackConnected servers.