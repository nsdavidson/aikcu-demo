# # encoding: utf-8

# Inspec test for recipe aikcu-demo::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/
if os.redhat?
  apache_name = 'httpd'
  port = '8080'
else
  apache_name = 'apache2'
  port = '8081'
end

describe package(apache_name) do
  it { should be_installed }
end

describe service(apache_name) do
  it { should be_enabled }
  it { should be_running }
end

describe http("http://localhost:#{port}") do
  its('status') { should cmp 200 }
  its('body') { should include 'Hello world!' }
end

users = ['nolan', 'walter']
users.each do |username|
  describe user(username) do
    it { should exist }
    its('home') { should eq "/home/#{username}"}
  end
end
