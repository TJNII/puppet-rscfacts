# Purpose: Determine information about Rackspace Cloud Servers
#
# Resolution:
#   If this is a Rackspace Cloud instance, populates rsc_ facts
#   This module provides facts that are NOT slated for inclusion
#     in Facter 2.0.0
#
# Caveats:
#   Depends on Xenstore
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

# confine has issues with fact dependency ordering
if Facter.value('is_rsc') == "true"
  require 'rubygems'
  require 'json'

  result = JSON.parse(Facter::Util::Resolution.exec("/usr/bin/xenstore-read vm-data/provider_data/roles"))
  
  Facter.add(:rsc_roles) do
    setcode do
      if result:
          result.join(",")
      end
    end
  end

  Facter.add(:is_rsc_rc) do
    setcode do
      # This is mostly matching the code from rackspace.rb
      # I know Facter will treat everything as strings when passing them to manifests
      # (http://projects.puppetlabs.com/issues/3704) but in this code both seem to work
      # Using strings for consistency.
      if result.include?("rack_connect")
        "true"
      else
        "false"
      end
    end
  end
end
