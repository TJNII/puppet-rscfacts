# This class defined dependencies for custom Rackspace Cloud Server facts
class rscfacts {
  # http://projects.puppetlabs.com/issues/3704
  if $is_rsc == "true" {
    # Rackspace Cloud Server
    # Include Ruby dependencies to query the RackConnect API
    
    # This will need to be moved to something like https://github.com/TJNII/puppet-commonpackages
    # when published

    # This is also a gem, but it currently has dependency issues:
    # mime-types requires Ruby version >= 1.9.2.
    package { "rubygem-rest-client":
      ensure   => installed,
      require => Yumrepo["epel"],
    }
  }
}
