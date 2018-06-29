namespace :minio do
  desc 'Manage minio buckets'
  namespace :buckets do
    task :create do
      Minio::Manage::auto_create unless ARGV[1]

      buckets = ARGV[1].split(',')
      buckets.each do |bucket|
        Minio::Manage.create(bucket)
      end
    end
  end
end
