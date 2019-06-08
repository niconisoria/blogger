class Article < ApplicationRecord
    has_many :comments
    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings
    has_one_attached :image
    validates :image, blob: { content_type: ['image/png', 'image/jpg', 'image/jpeg'], size_range: 1..2.megabytes }
    
    def tag_list
        self.tags.collect do |tag|
          tag.name
        end.join(", ")
    end

    def tag_list=(tags_string)
        tag_names = tags_string.split(",").collect{|s| s.strip.downcase}.uniq
        new_or_found_tags = tag_names.collect { |name| Tag.find_or_create_by(name: name) }
        self.tags = new_or_found_tags
    end

    def count_view
        self.update_attribute(:views, self.views+=1)
    end
end
