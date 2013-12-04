# Purpose: Determine information about Rackspace RackConnect status
#
# Resolution:
#   If this is a Rackspace Cloud instance, populates rsc_rc facts
#
# Caveats:
#   Depends on Ruby json and rest-client modules
#   Utilizes the is_rsc fact for confinement

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
