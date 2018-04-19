namespace :app do

  desc 'Force Remove All Postgres Sessions'
  task destroy_pg_sessions: :environment do

    ActiveRecord::Base.connection.execute <<-eos
      SELECT
        pg_terminate_backend(pid)
      FROM
        pg_stat_activity
      WHERE
        -- don't kill my own connection!
        pid <> pg_backend_pid()
        -- don't kill the connections to other databases
      AND
        datname = '#{ActiveRecord::Base.connection.current_database}'
      ;
    eos

  end

  desc 'clear app for dev'
  task reset: :environment do
    Rake::Task['tmp:clear'].invoke
    Rake::Task['log:clear'].invoke
    Rake::Task['tmp:create'].invoke
    Rake::Task['app:destroy_pg_sessions'].invoke
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
    Rake::Task['db:seed'].invoke
    Rake::Task['import:all'].invoke
  end

end