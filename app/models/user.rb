class User
  include Mongoid::Document

  def self.strip_id(url)
    url.split("/").last
  end

  field :steamid,       type: String
  field :username,      type: String
end
