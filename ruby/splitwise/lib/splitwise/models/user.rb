module Splitwise
  module Models
    class User
      attr_accessor :id, :image_url, :name

      def initialize(id:, name:, image_url:)
        self.id = id
        self.name = name
        self.image_url = image_url
      end
    end
  end
end
