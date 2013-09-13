#!/bin/bash

PKG_VERSION="${1}"
if [[ "${PKG_VERSION}" == "" ]]
then
    echo "usage: ${0} <version>"
fi
PKG_NAME="android-multipart-entity"
PKG_PATH="../${PKG_NAME}-${PKG_VERSION}.zip"

zip -r "${PKG_PATH}" *

mvn deploy:deploy-file \
    -DgroupId=com.reallifeconnect.imported \
    -DartifactId="${PKG_NAME}" \
    -Dversion="${PKG_VERSION}" \
    -Dpackaging=apklib \
    -Dfile="${PKG_PATH}" \
    -DrepositoryId=nexus \
    -Durl=http://build.reallifeconnect.com:8081/nexus/content/repositories/thirdparty

rm -v "${PKG_PATH}"

echo "deployed ${PKG_NAME}-${PKG_VERSION} to nexus"
