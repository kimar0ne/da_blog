# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.login                 "mhartl"
  user.firstname             "Michael"
  user.lastname              "Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end


Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.define :blogpost do |blogpost|
  blogpost.content "Foo bar"
  blogpost.title "title"
  blogpost.category "mycategory"
  blogpost.published true
  blogpost.association :user
end