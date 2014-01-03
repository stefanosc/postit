module Slugs
  
  def find_available_slug(slug, n, id)
    if Post.where("slug = ? and id != ?", "#{self.slug}-#{n}", "#{id}").empty?
      n
    else
      find_available_slug(slug, n+1, id)
    end
  end

  def generate_slug (attribute)
    if self.slug.nil? or self.send("#{attribute}_changed?")
      
      self.slug = self.send("#{attribute}").downcase.gsub(/\W+/, "-").gsub(/[-]*$/, "")
      id = (self.id ? self.id : 0 )   
      if Post.where("slug = '#{self.slug}' and id != #{id}").any? 
        n = find_available_slug(self.slug, 1, id)
        self.slug += "-#{n}"
      end
    end
  end

  def to_param
    slug
  end

end