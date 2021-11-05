# frozen_string_literal: true

# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#

Website.find_or_create_by(
  name: 'Localhost',
  domain: 'localhost',
  port: 3000
)

Website.find_or_create_by(
  name: 'google',
  domain: 'google.com'
)

Script.find_or_create_by(
  name: 'hello',
  content: 'alert("hello");'
)

Script.find_or_create_by(
  name: 'question',
  content: 'alert("Who am I?");'
)
