{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "ApplicationObjectLifecycleOnly",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:DeleteObjectVersion",
        "s3:GetObject"
      ],
      "Resource": "arn:aws:s3:::toab-jitsi-web-dev*/*"
    },
    {
      "Sid": "AllowBucketDiscoveryForSync",
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation"
      ],
      "Resource": "arn:aws:s3:::toab-jitsi-web-dev*"
    }
  ]
}