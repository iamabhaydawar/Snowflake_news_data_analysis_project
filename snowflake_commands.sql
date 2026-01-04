--create database for news API data
CREATE DATABASE news_api;

use news_api;


--Create storage integration to connect with Google Cloud Storage
CREATE OR REPLACE STORAGE INTEGRATION news_data_gcs_integration
TYPE = EXTERNAL_STAGE
STORAGE_PROVIDER = GCS
ENABLED = TRUE
STORAGE_ALLOWED_LOCATIONS =('gcs://snowflake-projects-test-gds-bucket/news_data_analysis/')

--describe storage integration details
DESC INTEGRATION news_data_gcs_integration 

--service account info for storage integration
-- k98530000@gcpuscentral1-1dfa.iam.gserviceaccount.com
-- -- snowflake_role
-- storage.buckets.list
-- storage.objects.get
-- storage.objects.list

-- create external stage pointing to gcs bucket location 
CREATE OR REPLACE STAGE gcs_raw_data_stage
URL='gcs://snowflake-projects-test-gds-bucket/news_data_analysis/'
STORAGE_INTEGRATION = news_data_gcs_integration 
FILE_FORMAT=(TYPE = 'PARQUET')


-- Create file format for parquet
CREATE FILE FORMAT parquet_format TYPE=parquet;


select count(*) from news_api_data

select * from summary_news
