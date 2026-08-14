CREATE OR REPLACE FILE FORMAT csv_format
TYPE = 'CSV'
FIELD_DELIMITER = ','
SKIP_HEADER = 1
ERROR_ON_COLUMN_COUNT_MISMATCH = FALSE;

SHOW FILE FORMATS;

CREATE OR REPLACE STAGE snowstage
FILE_FORMAT = csv_format
URL = 'your_bucket_url';

SHOW STAGES;

COPY INTO BOOKINGS
FROM @snowstage
FILES=('bookings.csv')
CREDENTIALS=(aws_key_id = 'your_aws_key', aws_secret_key = 'your_aws_secret_key');

COPY INTO LISTINGS
FROM @snowstage
FILES=('listings.csv')
CREDENTIALS=(aws_key_id = 'your_aws_key', aws_secret_key = 'your_aws_secret_key');

COPY INTO HOSTS
FROM @snowstage
FILES=('hosts.csv')
CREDENTIALS=(aws_key_id = 'your_aws_key', aws_secret_key = 'your_aws_secret_key');
