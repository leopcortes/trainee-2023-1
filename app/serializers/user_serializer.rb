class UserSerializer < Panko::Serializer
    attributes :id, :name, :email, :is_admin
end