use OPA_HUB;
-- Set admin password to Passw0rd
INSERT INTO AUTHENTICATION_PWD (authentication_id, password, created_date, status) SELECT AUTHENTICATION.authentication_id, 'Salt,3w6ZGNvGZrPdPBjq8zeioLF00evcgQT4ERB/sX/2rxE=', now(), 1 FROM AUTHENTICATION WHERE AUTHENTICATION.user_name = 'admin';
