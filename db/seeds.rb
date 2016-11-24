# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#
email     = shell.ask "Which email do you want use for logging into admin?"
password  = shell.ask "Tell me the password to use:", :echo => false

shell.say ""

account = Account.new(:email => email, :name => "Foo", :surname => "Bar", :password => password, :password_confirmation => password, :role => "admin")

if account.valid?
  account.save
  shell.say "================================================================="
  shell.say "Account has been successfully created, now you can login with:"
  shell.say "================================================================="
  shell.say "   email: #{email}"
  shell.say "   password: #{?* * password.length}"
  shell.say "================================================================="
else
  shell.say "Sorry, but something went wrong!"
  shell.say ""
  account.errors.full_messages.each { |m| shell.say "   - #{m}" }
end

shell.say ""

name = shell.ask '设置网站的分享账号元节点的用户名'
pass = shell.ask '设置其密码'
user  = User.new
user.username = name
user.password = pass
user.password_confirmation = pass

shell.say "你的账号为 #{name}"
shell.say "你的密码为 #{pass}"
user.save

shell.say '设置网站的元分享节点'
shell.say '删除已存在的根节点'

ShareNode.where(is_root: true).destroy

share_node = ShareNode.new

share_node.user = user
share_node.is_root = true

share_node.save!

shell.say '已经成功建立网站元节点'
