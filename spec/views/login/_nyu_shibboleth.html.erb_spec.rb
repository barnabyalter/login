require 'spec_helper'

describe "login/_nyu_shibboleth.html.erb" do
  subject { render; rendered }
  it do
    should match(/<div id="shibboleth">/)
    should match(/<h2>\s+Login with an NYU NetID/)
    should match(/href="\/users\/auth\/shibboleth\?institute=NYU"/)
    should match('Click to Login')
  end
end
