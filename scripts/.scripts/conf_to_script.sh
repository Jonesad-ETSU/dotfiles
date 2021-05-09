#!/bin/bash

find() {
       	[ -f $SCRIPTS_FOLDER/templates/$1.template ] && return 0 || return 1
}

read() {
	if [ $# -lt 1 ]; then
	       	cat $SCRIPTS_FOLDER/templates/use
	else
		cat $1
	fi
}

generate() {
	old_file=$SCRIPTS_FOLDER/templates/$1.template
	new_file=$(realpath $(head -n1 $SCRIPTS_FOLDER/templates/$1.template | tr -d "\'"))
	cp $old_file $new_file
	sed -i '1d' $new_file	
	sed -i "s/#!\/template/#!\/bin\/bash/g" $new_file
	
	for i in $(grep -oP "(?<=\^<).*?(?=>)" $new_file); do
		( sed -i "s/\^<$i>/$($SCRIPTS_FOLDER/conf.sh $i)/g" $new_file ) 
	done

	for i in $(grep -oP "(?<=@<).*?(?=>)" $new_file); do
		( sed -i "s/@<$i>/$($SCRIPTS_FOLDER/get-symbol.sh $i)/g" $new_file ) 	
	done

	for i in $(grep -oP "(?<=\+<).*?(?=>)" $new_file); do
		( color=$($SCRIPTS_FOLDER/conf.sh $(echo $i | cut -d ':' -f1 )) ;
		shift=$(echo $i | cut -d ':' -f2)
		sed -i "s/\+<$i>/$( $SCRIPTS_FOLDER/chbright-color.sh $color $shift )/g" $new_file )
	done 

	chmod a+x $new_file

	#ln -s $new_file $link_file 
}

[ -d /tmp/conf/ ] && rm -rf /tmp/conf 

if [ $# -lt 1 ]; then
	for i in $(read); do
		 find $i && ( generate $i) \
			|| echo "$i not found in modules folder" 1>&2
	done
else
	for i in $(read $1); do
		find $i && ( generate $i) \
			|| echo "$i not found in modules folder" 1>&2
	done
fi
wait
cd -
