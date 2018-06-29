module Minio
  module Template
    def self.policy(bucket = 'default')
      {
        "Version" => "2012-10-17",
        "Statement" => [
          {
            "Action" => ["s3:GetBucketLocation","s3:ListBucket"],
            "Effect" => "Allow",
            "Principal" => {"AWS" => ["*"]},
            "Resource" => ["arn:aws:s3:::#{bucket}"],
            "Sid" => ""
          },
          {
            "Action" => ["s3:GetObject"],
            "Effect" => "Allow",
            "Principal" => {"AWS" => ["*"]},
            "Resource" => ["arn:aws:s3:::#{bucket}/*"],
            "Sid" => ""
          }
        ]
      }
    end

    def self.fog_config
      {
        provider:              'AWS',
        aws_access_key_id:     ENV['AWS_ACCESS_KEY'] || ENV['MINIO_ACCESS_KEY'],
        aws_secret_access_key: ENV['AWS_SECRET_KEY'] || ENV['MINIO_SECRET_KEY'],
        region:                ENV['AWS_REGION'] || ENV['MINIO_REGION'],
        host:                  ENV['AWS_HOST'] || ENV['MINIO_HOST'],
        endpoint:              ENV['AWS_ENDPOINT'] || ENV['MINIO_ENDPOINT'],
        path_style:          	 true,
      }
    end
  end
end
