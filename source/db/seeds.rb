# frozen_string_literal: true
# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#

Website.create(
  name: 'Localhost',
  domain: 'localhost',
  port: 3000
)

Website.create(
  name: 'google',
  domain: 'google.com'
)

Script.create(
  name: 'hello',
  content: 'alert("hello");'
)

Script.create(
  name: 'question',
  content: 'alert("Who am I?");'
)
