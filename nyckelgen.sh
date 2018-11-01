echo "alias: "
read alias
echo "Lösenord till kryptering, endast enter för att generera en okrypterad nyckel"
echo "lösen: "
read pwd
if [ -n $pwd]; then
	unencrytedkey 
 else
	 encryptedkey
fi

unencrytedkey() {
	#Generera en privat nyckel med namnet "alias".key
	openssl genrsa -out $alias.key -des3
	#generera en certificate signing request till den privata nyckeln
	openssl req -new -key $alias.key  -extensions v3_req -out $alias.csr
	#skapa ett signerat certifkat med CA nyckeln  från csren
	openssl x509 -in ./$alias.csr -out ./$alias.crt -req -CA ./server.crt -CAkey ./server.key -CAcreateserial -days 3650 -extfile /etc/ssl/openssl.cnf -extensions v3_req
}
encryptedkey() {
	#Generera en privat nyckel med namnet "alias".key och lösen pwd
	openssl genrsa -out $alias.key -des3 -passout $pwd
	#generera en certificate signing request till den privata nyckeln
	openssl req -new -key $alias.key  -extensions v3_req -out $alias.csr -passin $pwd
	#skapa ett signerat certifkat med CA nyckeln  från csren
	openssl x509 -in ./$alias.csr -out ./$alias.crt -req -CA ./server.crt -CAkey ./server.key -CAcreateserial -days 3650 -extfile /etc/ssl/openssl.cnf -extensions v3_req
}
