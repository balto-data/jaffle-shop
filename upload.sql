create or replace table uploaded_manifests (manifest variant);
create temporary stage manifests;
PUT file://target/manifest.json @manifests;
copy into uploaded_manifests from @manifests FILE_FORMAT = (TYPE = 'JSON');
