# This class defined dependencies for custom Rackspace Cloud Server facts
#
# Copyright 2013 Rackspace
# Initial revision Tom Noonan II
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
class rscfacts {
  # http://projects.puppetlabs.com/issues/3704
  if $is_rsc_rc == "true" {
    # Rackspace Cloud Server
    # Include Ruby dependencies to query the RackConnect API
    
    # This will need to be moved to something like https://github.com/TJNII/puppet-commonpackages
    # when published

    # This is also a gem, but it currently has dependency issues, at least on Cent:
    # "mime-types requires Ruby version >= 1.9.2."
    case $operatingsystem {
      debian, ubuntu: {
        package { 'librestclient-ruby':
          ensure => installed,
        }
      }
      centos, redhat: {
        package { "rubygem-rest-client":
          ensure   => installed,
          require => Yumrepo["epel"],
        }
      }
      default: {
        fail("OS $operatingsystem not defined in rscfacts list")
      }
    }   
  }
}
