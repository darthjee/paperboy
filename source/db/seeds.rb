# frozen_string_literal: true

# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#

Zyra
  .register(User, find_by: :email)
  .on(:build) { |user| user.password = SecureRandom.hex(10) }

Zyra.register(Script, find_by: :name)
Zyra.register(Website, find_by: :name)
Zyra.register(WebsiteScript, :website_script, find_by: %i[website script])

Zyra.find_or_create(
  :user,
  email: 'email@srv.com',
  login: 'user',
  name: 'user',
  password: '123456'
)

hello_script = Zyra.find_or_create(
  :script,
  name: 'hello',
  content: 'alert("hello");'
)

question_script = Zyra.find_or_create(
  :script,
  name: 'question',
  content: 'alert("Who am I?");'
)

Zyra.find_or_create(
  :website,
  name: 'Localhost',
  domain: 'localhost',
  port: 3000
) do |site|
  Zyra.find_or_create(
    :website_script,
    website: site,
    script: hello_script,
    path: 'websites'
  )
  Zyra.find_or_create(
    :website_script,
    website: site,
    script: question_script
  )
end

Zyra.find_or_create(
  :website,
  name: 'google',
  domain: 'google.com'
) do |site|
  Zyra.find_or_create(
    :website_script,
    website: site,
    script: question_script
  )
end
