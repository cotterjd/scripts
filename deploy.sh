path=~/Development/dynos

deploy () {
	git stash
	git push $1 $2
	git stash apply
	./deploy.sh
}

if [[ $1 == editor ]]; then
	cd $path/Dynos
	deploy origin develop
fi

shift

if [[ $1 == login ]]; then 
	cd $path/LoginApp
	deploy origin newbranch
fi

shift 

if [[ $1 == api ]]; then
	cd $path/MgmtAPI
	deploy upstream develop
fi

shift 

if [[ $1 == ui ]]; then
	cd $path/MgmtApp
	deploy origin mui
fi
