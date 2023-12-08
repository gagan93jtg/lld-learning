module Splitwise
  module Models
    class Group
      attr_accessor :id, :image_url, :name, :users

      def initialize(id:, name:, image_url:, users:)
        self.id = id
        self.name = name
        self.image_url = image_url
        self.users = users
      end
    end
  end
end
