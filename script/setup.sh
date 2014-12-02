#!/bin/sh

dbname=${1:-intern_diary_$USER}
USE_CARTON=${USE_CARTON:-0}

if [ $USE_CARTON == 1 ]; then
  echo "Installing dependencies with Carton"
  carton install
else
  echo "Installing dependencies with cpanminus"
  PERL_AUTOINSTALL=--defaultdeps LANG=C cpanm --installdeps --notest . < /dev/null
fi

if [[ $(mysql -N -uroot -e "SELECT count(*) FROM mysql.user WHERE user = 'nobody'") -lt "1" ]]; then
  mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'nobody'@'localhost' IDENTIFIED BY 'nobody' WITH GRANT OPTION"
  echo "User nobody@localhost (nobody) created"
fi

mysqladmin -uroot drop $dbname -f > /dev/null 2>&1
mysqladmin -uroot create $dbname
echo "Database \"${dbname}\" created"
echo "Initializing \"$dbname\""
mysql -uroot $dbname < db/schema.sql

mysqladmin -uroot drop ${dbname}_test -f > /dev/null 2>&1
mysqladmin -uroot create ${dbname}_test
echo "Database \"${dbname}_test\" created"
echo "Initializing \"${dbname}_test\""
mysql -uroot ${dbname}_test < db/schema.sql

echo "Done."
