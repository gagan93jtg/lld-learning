module Splitwise
  module Services
    class UserService
      attr_accessor :users, :groups

      def initialize
        self.users = []
        self.groups = []
      end

      def create_user(id:, name:, image_url:)
        user = Splitwise::Models::User.new(id: id, name: name, image_url: image_url)
        users << user

        user
      end

      def create_group(id:, name:, image_url:, users:)
        group = Splitwise::Models::Group.new(id: id, name: name, image_url: image_url, users: users)
        groups << group

        group
      end
    end
  end
end
