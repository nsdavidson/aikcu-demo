users = data_bag('users')

users.each do |username|
  user_data = data_bag_item('users', username)
  
  user_account username do
    comment "#{user_data['first_name']} #{user_data['last_name']}"
    shell user_data['shell']
    ssh_keygen false
  end
end