# Purpose: Determine information about Rackspace RackConnect status
#
# Resolution:
#   If this is a Rackspace Cloud instance, populates rsc_rc facts
#
# Caveats:
#   Depends on Ruby json and rest-client modules
#   Utilizes the is_rsc fact for confinement

if Facter.value('is_rsc') == "true":
    begin
      Facter.add(:rsc_rc_status) do
         require 'rubygems'
         require 'json'
         require 'rest_client'

         rcStatus = JSON.parse(RestClient.get("https://#{Facter.rsc_region}.api.rackconnect.rackspace.com/v1/automation_status?format=JSON", {:accept => :json}))

         setcode do
           rcStatus['automation_status']
         end
       end
    rescue
    end
end
