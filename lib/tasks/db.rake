namespace :db do
  desc 'Drop, create and migrate the database'
  task restart: [:drop, :create, :migrate]
end