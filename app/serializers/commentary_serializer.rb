class CommentarySerializer < Panko::Serializer
    attributes :id, :content, :post

    def post
        {id: object.post.id, title: object.post.title, content: object.post.content}
    end
end