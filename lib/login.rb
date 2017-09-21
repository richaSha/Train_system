class Login
  attr_reader :ADMIN_NAME, :ADMIN_PASSWORD
  attr_accessor :username, :password, :currentuser

  ADMIN_NAME = 'snow_richa'
  ADMIN_PASSWORD  = '123snow_richa'

  def initialize(attributes)
    @username = (attributes.key?(:username) ? attributes.fetch(:username) : nil)
    @password = (attributes.key?(:password) ? attributes.fetch(:password) : nil)
    @currentuser = (attributes.key?(:currentuser) ? attributes.fetch(:currentuser) : false)
  end

  def save()
    result = DB.exec("INSERT INTO login_info (username, password, currentuser) VALUES ('#{username}', '#{password}', '#{currentuser}'); ")
  end

  def self.is_creditial_exist?(username, password)
    result = DB.exec("SELECT * FROM login_info;")
    result.each do |info|
      if (info['username'] == username) && (info['password'] == password)
        DB.exec("UPDATE login_info SET currentuser = true WHERE username = '#{username}' AND password = '#{password}';")
        return true
      end
    end
    false
  end

  def self.is_admin?(username, password)
    if (username == ADMIN_NAME) && (password == ADMIN_PASSWORD)
      return true
    end
    false
  end

  def self.find_current_user()
    result = DB.exec("SELECT username FROM login_info WHERE currentuser = true;")
    result[0]['username']
  end

  def self.logout(username)
    DB.exec("UPDATE login_info SET currentuser = false WHERE username = '#{username}';")
  end

  def self.is_username_unique?(username)
    result = DB.exec("SELECT * FROM login_info;")
    result.each do |info|
      if (info['username'] == username) || (ADMIN_NAME == username)
        return false
      end
    end
    true
  end
end
