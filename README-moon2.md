Generate the CA Key and Certificate:
```
openssl req -x509 -sha256 -newkey rsa:4096 -keyout ca.key -out ca.crt -days 356 -nodes -subj '/CN=My Cert Authority'
```
Generate the Server Key, and Certificate request and Sign with the CA Certificate:
```
openssl req -new -newkey rsa:4096 -keyout server.key -out server.csr -nodes -subj '/CN=moon.aerokube.local'
openssl x509 -req -sha256 -days 365 -in server.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out server.crt
```

Generate the Server Key, and Certificate request with config:
```
cat > config.cnf << EOF
[req]
distinguished_name = req_distinguished_name
req_extensions = req_ext

[req_distinguished_name]
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name (full name)
localityName                    = Locality Name (eg, city)
organizationalUnitName          = Organizational Unit Name (eg, section)
commonName                      = Common Name (eg, your name or your server\'s hostname)
emailAddress                    = Email Address

[req_ext]
subjectAltName = @alt_names

[alt_names]
IP.1 = 172.16.160.5
EOF
```
```
openssl req -new -newkey rsa:4096 -keyout server.key -out server.csr -nodes -subj '/CN=moon.aerokube.local' -config config.cnf
```
Add host for ingress:
```
$ grep moon.aerokube.local /etc/hosts
172.16.160.5    moon.aerokube.local
```
Override values:
```
$ cat values.yaml 
ingress:
  host: moon aerokube.local

deployment:
  moonTag: dev-latest
  moonConfTag: dev-latest
  moonUITag: dev-latest

configs:
  default:
    containers:
      defender:
        version: dev-latest
      x-server:
        version: dev-latest
      vnc-server:
        version: dev-latest
      ca-certs:
        version: dev-latest
      video-recorder:

browsers:
  default:
    selenium:
      MicrosoftEdge:
        default: "98.0"
      chrome:
        default: "92.0"
      firefox:
        default: "89.0"

###
### Multinamespace:
###

#quota:
#  moon: null
#  alfa-team:
#    namespace: alfa
#  beta-team:
#    namespace: beta
```

Install Moon:
```
helm upgrade --install --set ingress.host=moon.aerokube.local --set-file ingress.tlsCert=server.crt --set-file ingress.tlsKey=server.key -f values.yaml --create-namespace -n moon moon moon
```
