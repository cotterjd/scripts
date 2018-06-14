path=~/Development/dynos

update () {
	git stash
	git pull $1 $2
	git stash apply
}

cd $path/dynosio
update origin develop
cd $path/dynos_login
update upstream newbranch
cd $path/dynos_management_api
update upstream develop
cd $path/dynos_management_ui
update upstream newbranch
