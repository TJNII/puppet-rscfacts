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
-------------------

A The following extra fact are also provided:
* rsc_roles: Rackspace server roles
* is_rsc_mc: Is this a Rackspace Managed Service Level server
* rsc_mc_status: Rackspace Managed Cloud automation status.  (Only populated on Managed next-gen servers)

These facts are not part of the rsc facts to be included in Facter 2.0.0.
They will only be populated on Next Generation cloud servers

### RackConnect Facts

In addition, this module also provides three RackConnect facts:

* is_rsc_rc: Is RackConnected
* rsc_rc_status: RackConnect deployment status
* rsc_rc_features: Enabled RackConnect Features

These facts are only available on Next Generation cloud servers.
Furthermore, status and features are only populated on RackConnected servers.

Avoiding Collisions with Rackspace Automation
---------------------------------------------

If you are a Managed Rackspace customer or a RackConnect customer, the following code can help avoid
the potential race conditions with Rackspace Automation on build with Puppet preloaded in your image:

    node "foo.example.com" {
       if $::is_rsc_rc == "true" and $::rsc_rc_status != "DEPLOYED" {
          notify{"Skipping run as Rackspace RackConnect Automation is not complete: $::rsc_rc_status": }
       } else {
          if $::is_rsc_mc == "true" and $::rsc_mc_status != "Complete" {
             notify{"Skipping run as Rackspace Managed Cloud Automation is not complete: $::rsc_mc_status": }
          } else {
	    # Your modules here
          }
       }
    }

This particular example will prevent your modules from being included in the catalog until Rackspace automation is completed.
This is recommended as a safety measure to prevent conflicts if Puppet runs while Rackspace automation is running, and to
prevent Puppet runs if Rackspace automation has failed and Rackspace is troubleshooting.
Be advised this example could result in unacceptable delays before the complete catalog is processed, however.

This metadata is also available via the Servers API as well, see http://docs.rackspace.com/servers/api/v2/cs-devguide/content/MetadataSection.html