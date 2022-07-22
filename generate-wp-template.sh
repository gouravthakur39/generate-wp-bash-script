printf "INFO: git need to be configured for this script to work\n"
printf "<---generating required empty files and folders--->\n"
>docker-compose.yml
>php.dockerfile
### To check if nginx directory doesn't exists
Directory_nginx="./nginx"
if [ ! -d "$Directory_nginx" ];
then 
	printf "nginx directory doesn't exists already\n"
	printf "generating nginx directory\n"
	mkdir nginx
fi

>nginx/default.conf

Directory_wordpress="./wordpress"
if [ ! -d "$Directory_wordpress" ];
then 
        printf "wordpress directory doesn't exists already\n"
        printf "generating wordpress directory\n"
        mkdir wordpress
fi

printf "<---generated empty files and folders--->\n"
printf "<--- cd into wordpress directory--->\n"
cd wordpress
printf "$PWD\n"
git --version
git clone https://github.com/gouravthakur39/wordpress-code.git .
printf "successfuly cloned repository\n"
printf "these files were downloaded into '$PWD'\n"
ls
cd ..
printf "$PWD\n"
read -p 'Please enter domain name ' domain_name
printf "You entered '$domain_name'\n"

mkdir temp
cd temp
printf "$PWD\n"
git clone https://github.com/gouravthakur39/wp-nginx-php-no-image-sample-templates.git .
printf "Templates copied into $PWD\n"
ls
cp docker-compose-sample.yml ../docker-compose.yml
cp php.dockerfile-sample ../php.dockerfile
cp default-sample.conf ../nginx/default.conf
printf "Templates renamed and copied into relavent directories\n"

printf "removing temp folder\n"
cd ..
rm -rf temp/

printf "replacing placeholder domain name(freekamaal.ml) with $domain_name\n"
cd nginx
sed -i "s/freekamaal.ml/$domain_name/" default.conf
cd ..
