class Photo < ApplicationRecord
  include ImageUploader::Attachment(:image)
  
  belongs_to :entry, optional: true
end
