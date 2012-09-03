class OldUser < ActiveRecord::Base
  establish_connection(
    :adapter  => 'mysql',
    :database => 'realalehunter_forum_2',
    :host     => 'localhost',
    :username => 'root',
  )
  self.table_name = 'phpbb_users'
end

class AddDeviseToUsers < ActiveRecord::Migration
  def self.up
    #change_table(:users) do |t|
    #  ## Database authenticatable
    #  t.string :encrypted_password, :null => false, :default => ""

    #  ## Recoverable
    #  t.string   :reset_password_token
    #  t.datetime :reset_password_sent_at

    #  ## Rememberable
    #  t.datetime :remember_created_at

    #  ## Trackable
    #  t.integer  :sign_in_count, :default => 0
    #  t.datetime :current_sign_in_at
    #  t.datetime :last_sign_in_at
    #  t.string   :current_sign_in_ip
    #  t.string   :last_sign_in_ip

    #  ## Confirmable
    #  t.string   :confirmation_token
    #  t.datetime :confirmed_at
    #  t.datetime :confirmation_sent_at
    #   t.string   :unconfirmed_email # Only if using reconfirmable

    #  ## Lockable
    #  # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts
    #  # t.string   :unlock_token # Only if unlock strategy is :email or :both
    #  # t.datetime :locked_at

    #  ## Token authenticatable
    #  # t.string :authentication_token


    #  # Uncomment below if timestamps were not included in your original model.
    #  # t.timestamps
    #end

    #change_column :users, :email, :string, :null => false, :default => ""

    #User.all.each do |u|
    #  if u.ratings.count == 0 && u.visits.count == 0 && u.ratings.count == 0 && u.pubs.count == 0 && u.images.count == 0
    #    u.delete
    #  end
    #end


    User.all.each do |u|
      old_user = OldUser.find_by_username(u.username)
      if old_user
        u.email = old_user.user_email
        u.encrypted_password = old_user.user_password
      else
        puts "could not find #{u.username}"
        u.email = "unknown#{rand(1000)}@unknown.com"
      end
      u.save
      u.confirm!
    end


    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    # add_index :users, :authentication_token, :unique => true
  end

  def self.down
    # By default, we don't want to make any assumption about how to roll back a migration when your
    # model already existed. Please edit below which fields you would like to remove in this migration.
    raise ActiveRecord::IrreversibleMigration
  end
end
