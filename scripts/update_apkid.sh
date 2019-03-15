script_path=$(dirname $0)
if [ "$script_path" != "scripts" ] && [ "$script_path" != "./scripts" ]; then
    echo 'Please run script from MobSF directory '
    echo './scripts/update_apkid.sh '
    exit  1
fi
current_dir=$(pwd)
virtualenv venv -p python3
source venv/bin/activate
virtual_env=$(echo $VIRTUAL_ENV)
apkid_dir="${virtual_env}/lib/python3.6/site-packages/apkid"
rules_dir="${apkid_dir}/rules/"
unamestr=`uname`
git clone https://github.com/rednaga/APKiD.git 
cd APKiD 
python3 prep-release.py 
cp apkid/rules/rules.yarc ${rules_dir}  
cd ..
if [[ "$unamestr" == 'Darwin' ]]; then
  sed -i ' ' "s#RULES_DIR =.*#RULES_DIR =  \"$rules_dir\"#" ${apkid_dir}/rules.py 
 else
  sed "s#RULES_DIR =.*#RULES_DIR =  \"$rules_dir\"#" ${apkid_dir}/rules.py
fi 
rm -fr APKiD