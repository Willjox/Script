echo "alias: "
read alias

openssl genrsa -out $alias.key -des3
openssl req -new -key $alias.key  -extensions v3_req -out $alias.csr
openssl x509 -in ./$alias.csr -out ./$alias.crt -req -CA ./server.crt -CAkey ./server.key -CAcreateserial -days 3650 -extfile /etc/ssl/openssl.cnf -extensions v3_req

