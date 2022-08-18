# frozen_string_literal: true

# This file should contain all the record creation
# needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed
# command (or created alongside the database with db:setup).
#

module WithSeeder
  class Seeder
    attr_reader :klass, :clause

    def initialize(klass, clause = {})
      @klass = klass
      @clause = clause
    end

    def or_create_with(attributes = {})
      klass.find_by(clause) || klass.create(clause.merge(attributes))
    end
  end

  def self.include_in(*classes)
    classes.each { |klass| klass.extend(self) }
  end

  def find_with(clause = {})
    Seeder.new(self, clause)
  end
end

WithSeeder.include_in(User, Website, Script)

User
  .find_with(email: 'email@srv.com')
  .or_create_with(
    login: 'user',
    name: 'user',
    password: '123456'
  )

Website.find_with(name: 'Localhost')
  .or_create_with(
    domain: 'localhost',
    port: 3000
  )

Website.find_with(name: 'google')
  .or_create_with(
    domain: 'google.com'
  )

Script.find_with(name: 'hello')
  .or_create_with(
    content: 'alert("hello");'
  )

Script.find_with(name: 'question')
  .or_create_with(
    content: 'alert("Who am I?");'
  )
