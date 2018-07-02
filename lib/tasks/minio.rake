namespace :minio do
  desc 'Manage minio buckets'
  namespace :buckets do
    task :create do
      Minio::Manage.auto_create
    end
  end
end
