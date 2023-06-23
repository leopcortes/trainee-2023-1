class FeedbackSerializer < Panko::Serializer
    attributes :id, :like, :post

    def post
        {id: object.post.id, title: object.post.title, content: object.post.content}
    end
end