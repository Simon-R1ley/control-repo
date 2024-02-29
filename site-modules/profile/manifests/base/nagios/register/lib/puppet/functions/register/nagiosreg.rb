# frozen_string_literal: true

# https://github.com/puppetlabs/puppet-specifications/blob/master/language/func-api.md#the-4x-api
Puppet::Functions.create_function(:"register::nagiosreg") do
 # frozen_string_literal: true
  dispatch :register_node do
    param 'String', :server
    param 'String', :apikey
    param 'String', :hostname
    param 'String', :ipaddress
    return_type 'String'
  end
  # the function below is called by puppet and and must match
  # the name of the puppet function above. You can set your
  # required parameters below and puppet will enforce these
  # so change x to suit your needs although only one parameter is required
  # as defined in the dispatch method.
  def register_node(server, apikey, hostname, ipaddress)
    uri = URI("https://#{server}/post")
    res = Net::HTTP.post_form(uri, 'apikey' => apikey, 'address' => ipaddress, 'host_name' => hostname)
    # puts res.body if res.is_a?(Net::HTTPSuccess)
    res.body
  end

  # you can define other helper methods in this code block as well
end