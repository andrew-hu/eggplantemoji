class Folder < ApplicationRecord
  belongs_to :user
  acts_as_tree
end

#class Folder < ActiveRecord::Base
 # acts_as_tree

#end