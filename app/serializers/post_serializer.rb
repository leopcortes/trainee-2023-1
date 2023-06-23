class PostSerializer < Panko::Serializer
    attributes :id, :title, :content, :user

    def user
        {email: object.user.email}
    end
end