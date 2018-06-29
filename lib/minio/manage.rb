module Minio
  module Manage
    def self.create(buckets, policy = nil)
      policy ||= Template.policy(bucket)
      connection = Fog::Storage.new(Template.fog_credentials)
      buckets = [buckets] unless buckets.is_a? Array

      buckets.map do |bucket|
        connection.put_bucket(bucket)
        connection.put_bucket_policy(bucket, policy)
      end
    end

    def self.auto_create
      CarrierWaveUploader.descendants
        .map { |uploader| uploader.new.fog_directory }
        .uniq
        .map { |bucket| create(bucket) }
    end
  end
end
