# Using Concerns
module Slugable
  extend ActiveSupport::Concern

  included do
    after_validation :generate_slug!
    class_attribute :slug_column
  end

  def generate_slug!
    str = to_slug(self.send(self.class.slug_column.to_sym))
    count = 2
    obj = self.class.where(slug: str).first
    while obj && obj != self
      str = str + "-" + count.to_s
      obj = self.class.where(slug: str).first
      count += 1
    end
    self.slug = str.downcase
  end

  def to_slug(name)
    #strip the string
    ret = name.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric with dash
     ret.gsub! /\s*[^A-Za-z0-9]\s*/, '-'

     #convert double dashes to single
     ret.gsub! /-+/,"-"

     #strip off leading/trailing dash
     ret.gsub! /\A[-\.]+|[-\.]+\z/,""

     ret
  end

  def to_param
    self.slug
  end

  module ClassMethods
    def sluggable_column(col_name)
      self.slug_column = col_name
    end
  end
end






# module Slugable
  
#   extend ActiveSupport::Concern

#   included do
#     after_validation :generate_slug!
#     class_attribute :slug_column
#   end

#   def find_available_slug(slug, n, id)
#     if (self.class).where("slug = ? and id != ?", "#{slug}-#{n}", "#{id}").empty?
#       n
#     else
#       find_available_slug(slug, n+1, id)
#     end
#   end

#   def generate_slug (attribute)
#     if self.slug.nil? or self.send("#{attribute}_changed?")
      
#       id = (self.id ? self.id : 0 ) 
#       self.slug = self.send("#{attribute}").downcase.gsub(/\W+/, "-").gsub(/[-]*$/, "")
        
#       if (self.class).where("slug = '#{self.slug}' and id != #{id}").any? 
#         n = find_available_slug(self.slug, 1, id)
#         self.slug += "-#{n}"
#       end
#     end
#   end

#   def to_param
#     slug
#   end

#   module ClassMethods
#     def sluggable_column(col_name)
#       self.slug_column = col_name
#     end
#   end

# end