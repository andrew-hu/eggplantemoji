class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
# Setup accessible (or protected) attributes for your model 
  ##attr_accessible :email, :name, :password, :password_confirmation, :remember_me
  
    ##validates :email, :presence => true, :uniqueness => true
  has_many :assets
  has_many :folders
#this is for folders which this user has shared
  has_many :shared_folders, :dependent => :destroy

#this is for folders which the user has been shared by other users
  has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id", :dependent => :destroy

  after_create :check_and_assign_shared_ids_to_shared_folders

#this is to make sure the new user ,of which the email addresses already used to share folders by others, to have access to those folders
  def check_and_assign_shared_ids_to_shared_folders
    #First checking if the new user's email exists in any of ShareFolder records
    shared_folders_with_same_email = SharedFolder.find_all_by_shared_email(self.email)

    if shared_folders_with_same_email
      #loop and update the shared user id with this new user id
      shared_folders_with_same_email.each do |shared_folder|
        shared_folder.shared_user_id = self.id
        shared_folder.save
      end
    end
  end

end
