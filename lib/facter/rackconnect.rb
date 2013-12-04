# Purpose: Determine information about Rackspace RackConnect status
#
# Resolution:
#   If this is a Rackspace Cloud instance, populates rsc_rc facts
#
# Caveats:
#   Depends on Ruby json and rest-client modules
#   Utilizes the is_rsc fact for confinement
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

if Facter.value('is_rsc') == "true"
  begin
    require 'rubygems'
    require 'json'
    require 'rest_client'
    loadFailure = false
  rescue
    loadFailure = true
  end

  # Avoiding nested exceptions
  if loadFailure == false
    # This is a somewhat janky way to populate the is_rsc_rc variable
    # Basically, if the API knows us then we're RackConnected
    # If it throws an exception, then we're not.
    # Crude, but should be effective.
    begin
      # http://www.rackspace.com/knowledge_center/article/the-rackconnect-api
      # Authentication is host based; no passwords or tokens are needed.
      rcStatus = JSON.parse(RestClient.get("https://#{Facter.rsc_region}.api.rackconnect.rackspace.com/v1/automation_status?format=JSON", {:accept => :json}))
      is_rsc_rc = true
      Facter.add(:rsc_rc_status) do
        setcode do
          rcStatus['automation_status']
        end
      end
    rescue
      is_rsc_rc = false
    end
    
    Facter.add(:is_rsc_rc) do
      setcode do
        is_rsc_rc
      end
    end
  end
end
