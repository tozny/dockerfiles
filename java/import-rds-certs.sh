#! /bin/sh

# based on https://gist.github.com/steini/d40a59ae4a9036c4d5a4
# This script takes a .pem certificate chain file, and breaks it into individual
# certificate files, for easy ingestion into the java trustStore

OLDDIR="$PWD"

if [ -z "$CACERTS_FILE" ]; then
    CACERTS_FILE=$JAVA_HOME/jre/lib/security/cacerts
fi

mkdir /tmp/rds-ca && cd /tmp/rds-ca

echo "Downloading RDS certificates..."

curl https://s3.amazonaws.com/rds-downloads/rds-combined-ca-bundle.pem > rds-combined-ca-bundle.pem

csplit -sz rds-combined-ca-bundle.pem '/-BEGIN CERTIFICATE-/' '{*}'

# csplit outputs files in format xx00, xx01...etc
for CERT in xx*; do
    # extract a human-readable alias from the cert
    ALIAS=$(openssl x509 -noout -text -in $CERT | grep "Subject:" | sed 's/^.*CN=//')
    echo "importing $ALIAS"
    # import the cert into the default java keystore
    keytool -import \
            -keystore  $CACERTS_FILE \
            -storepass changeit -noprompt \
            -alias "$ALIAS" -file $CERT
done

cd "$OLDDIR"

rm -r /tmp/rds-ca
