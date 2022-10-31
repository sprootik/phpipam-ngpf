# phpipam-ngpf
Docker container for phpipam with nginx and php-fpm - https://github.com/sprootik/phpipam-ngpf  
Build scripts and dockerfiles for https://hub.docker.com/repository/docker/nixit89/phpipam-ngpf  
Phpipam project - https://github.com/phpipam/phpipam


# Container Images
- `phpipam-ngpf` Frontend Nginx && Php-fpm. Nginx and Php-fpm can be run separately using the enviroment MODE. See [Compose](Compose/phpIPAM_separately.yml)
- `phpipam-ngpf-cron` Cron container for scheduled network discovery jobs.

# Usage
Example full stack deployment via docker-compose.

### Nginx and Php-fpm in one container

    cd /Composer
    # Run
    docker-compose -p phpIPAM_together.yml up -d
    # Stop
    docker-compose -p phpIPAM_together.yml down

### Nginx and Php-fpm in two container

    cd /Composer
    # Run
    docker-compose -p phpIPAM_separately.yml up -d
    # Stop
    docker-compose -p phpIPAM_separately.yml down

# Configuration

### Supported Docker Environment Variables

A subset of available phpIPAM configuration settings in [config.dist.php](https://github.com/phpipam/phpipam/blob/master/config.dist.php) can be configured via Docker Environment variables. Connected the same variables as in the config for the Apache container - https://github.com/phpipam-docker/phpipam-docker

| ENV                          | Default                 | WWW/CRON Container | Description                                                                                     |
|------------------------------|-------------------------|:------------------:|-------------------------------------------------------------------------------------------------|
| **PHP_FPM_HOST**             | "127.0.0.1"             |        ✅ ❌       | Name/address php-fpm server for nginx config
| **TZ**                       | "UTC"                   |        ✅ ✅       | Time Zone (e.g "Asia/Vladivostok")                                                                 |
| **IPAM_DATABASE_HOST** 📂    | "127.0.0.1"             |        ✅ ✅       | MySQL database host                                                                             |
| **IPAM_DATABASE_USER** 📂    | "phpipam"               |        ✅ ✅       | MySQL database user                                                                             |
| **IPAM_DATABASE_PASS** 📂    | "phpipamadmin"          |        ✅ ✅       | MySQL database password                                                                         |
| **IPAM_DATABASE_NAME** 📂    | "phpipam"               |        ✅ ✅       | MySQL database name                                                                             |
| **IPAM_DATABASE_PORT** 📂    | 3306                    |        ✅ ✅       | MySQL database port                                                                             |
| **IPAM_DATABASE_WEBHOST** 📂 | "localhost"             |        ✅ ✅       | MySQL allowed hosts                                                                             |
| **PROXY_ENABLED** 📂         | false                   |        ✅ ✅       | Use proxy                                                                                       |
| **PROXY_SERVER** 📂          | "myproxy.something.com" |        ✅ ✅       | Proxy server                                                                                    |
| **PROXY_PORT** 📂            | 8080                    |        ✅ ✅       | Proxy port                                                                                      |
| **PROXY_USE_AUTH** 📂        | false                   |        ✅ ✅       | Proxy authentication                                                                            |
| **PROXY_USER** 📂            | "USERNAME"              |        ✅ ✅       | Proxy username                                                                                  |
| **PROXY_PASS** 📂            | "PASSWORD"              |        ✅ ✅       | Proxy password                                                                                  |
| **IPAM_DEBUG** 📂            | false                   |        ✅ ✅       | Enable php/application debugging                                                                |
| **OFFLINE_MODE** 📂          | false                   |        ✅ ❌       | Disable server-side Internet requests, avoid timeouts with restricted Internet access (v1.5.0+) |
| **COOKIE_SAMESITE** 📂       | "Lax"                   |        ✅ ❌       | Cookie security policy = None,Lax,Strict. "None" requires HTTPS. (v1.4.5+)                      |
| **IPAM_BASE**                | "/"                     |        ✅ ❌       | For proxy/load-balancers. Path to access phpipam in site URL, http:/url/BASE/                   |
| **IPAM_GMAPS_API_KEY** 📂    | ""                      |        ✅ ❌       | Google Maps and Geocode API Key. (Removed in v1.5.0, replaced by OpenStreetMap)                 |
| **SCAN_INTERVAL**            | "1h"                    |        ❌ ✅       | Network discovery job interval = 5m,10m,15m,30m,1h,2h,4h,6h,12h                                 |


# License  
GNU General Public License v3.0

# Maintainer
Sprootik <sprootik89@gmail.com>
