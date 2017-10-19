module VulnerableForum
  module Database
    @mysql_client = Mysql2::Client.new(host: "localhost", username: "root", password: "root") 

    def self.client
      @mysql_client
    end

    def self.ping?
      @mysql_client.ping
    end

    def self.query(string)
      @mysql_client.query(string)
    end

    def self.each_user
      self.query("SELECT * FROM users").each_entry { |user| yield user }
    end

    def self.find_user(**field)
      key, value = field.first
      key = key.to_s
      value = "'#{value}'" unless value.is_a? Integer
      match = "#{key} = #{value}"
      self.query("SELECT * FROM users WHERE #{match} LIMIT 1").entries.first
    end

    def self.login(user, pass)
      q = "SELECT * FROM users WHERE user_name='#{user}' AND password='#{pass}' LIMIT 1"
      if user = self.query(q).entries.first
        return user
      end
      false
    end

    def self.all_users
      self.query("SELECT * FROM users").entries
    end

    def self.total_number_of_users
      self.query("SELECT count(*) as 'number' FROM users").entries[0]["number"]
    end

    def self.each_post
      self.query("SELECT * FROM posts").each_entry { |post| yield post }
    end
    
    def self.all_posts
      self.query("SELECT * FROM posts").entries
    end
    
    def self.total_number_of_posts
      self.query("SELECT count(*) as 'number' FROM posts").entries[0]["number"]
    end

    def self.provision!
      @mysql_client.query("DROP DATABASE IF EXISTS forum")
      @mysql_client.query("CREATE DATABASE IF NOT EXISTS forum")
      @mysql_client.select_db("forum")
      @mysql_client.query("CREATE TABLE IF NOT EXISTS \
        users(id INT PRIMARY KEY AUTO_INCREMENT, 
        first_name VARCHAR(40), 
        last_name VARCHAR(40),
        user_name VARCHAR(40),
        email VARCHAR(40),
        password  VARCHAR(255)
      )")
      @mysql_client.query("CREATE TABLE IF NOT EXISTS \
        posts(id INT PRIMARY KEY AUTO_INCREMENT, 
        user INT,
        title VARCHAR(60),
        content TINYTEXT
      )")
      # Add User
      @mysql_client.query("INSERT INTO users(first_name, last_name, user_name, email, password) \ 
                   VALUES('John', 'Doodle', 'jdoe', 'jdoe@gmail.com', 'lame-password')")
      # Add Posts
      @mysql_client.query("INSERT INTO posts(user, title, content) \ 
                   VALUES(1, 'First Post', 'Hello World 1!')")
      @mysql_client.query("INSERT INTO posts(user, title, content) \ 
                   VALUES(1, 'Second Post', 'Hello World 2!')")
      true
    end
    self.provision!

    module Formatted
      def self.users
        Text::Table.new(head: ["Id", "User", "First", "Last", "E-Mail"], rows: VulnerableForum.db.all_users.collect { |user| [user["id"], user["user_name"], user["first_name"], user["last_name"], user["email"]] }).to_s
      end

      def self.posts
        Text::Table.new(head: ["Id", "Title", "User"], rows: VulnerableForum.db.all_posts.collect { |post| [post["id"], post["title"], post["user"]]}).to_s
      end

      def self.totals
        Text::Table.new(head: ["Users", "Posts"], rows: [[ VulnerableForum.db.total_number_of_users, VulnerableForum.db.total_number_of_posts]]).to_s
      end
    end

    def self.formatted
      Formatted
    end
  end

  def self.db
    Database
  end
end
