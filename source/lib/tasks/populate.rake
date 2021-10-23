# frozen_string_literal: true

namespace :populate do
  desc 'Populate all that needs populating'
  task all: :environment do
    Rake::Task['populate:first'].invoke
  end

  desc 'Populates something'
  task first: :environment do
  end
end
