module Minio
  class Manage
    def self.create(buckets, policy = nil)
      connection = Fog::Storage.new(Template.fog_credentials)
      buckets = [buckets] unless buckets.is_a? Array

      buckets.map do |bucket|
        policy ||= Template.policy(bucket)
        connection.put_bucket(bucket)
        connection.put_bucket_policy(bucket, policy)
      rescue Exception => e
        puts "Bucket '#{bucket}' can't be created : #{e.message}"
      end
    end

    def self.auto_create
      Uploader
        .descendants
        .map { |uploader| uploader.new.fog_directory }
        .uniq
        .map { |bucket| create(bucket) }
    end
  end
end
