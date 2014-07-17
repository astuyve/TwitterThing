class User < ActiveRecord::Base

  def self.from_omniauth(auth)
    where(auth.slice("provider", "uid")).first || create_from_omniauth(auth)
  end

  def self.create_from_omniauth(auth)
    create! do |user|
      user.provider = auth["provider"]
      user.uid = auth["uid"]
      auth["info"].each do |attr, val|
        if user.has_attribute?("#{attr}")
          user.update_attribute("#{attr}", val)
        end
      end
    end
  end
end
