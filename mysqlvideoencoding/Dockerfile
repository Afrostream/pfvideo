FROM mysql:5.5
COPY 10.video_encoding_schema.sql /docker-entrypoint-initdb.d/
COPY 20.video_encoding_profiles.sql /docker-entrypoint-initdb.d/
COPY 30.video_encoding_presets.sql /docker-entrypoint-initdb.d/
