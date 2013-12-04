Rackspace Cloud Facts
=====================

This module provides custom Facter facts for the Rackspace cloud.
rackspace.rb provides the following facts:

* is_rsc: Is Rackspace Cloud
* rsc_region: Datacenter Region
* rsc_instance_id: Instance UUID

These facts and the supporting file are from https://github.com/puppetlabs/facter/pull/436/files
and are to be included in Facter 2.0.0 per http://projects.puppetlabs.com/issues/20468.

RackConnect Facts
=================

In addition, this module also provides two RackConnect facts:

* is_rsc_rc: Is RackConnected
* rsc_rc_status: RackConnect deployment status

The rsc_rc_status fact requires the Ruby rest-client module.
The rscfacts class is provided to handle this dependency.
