#!/bin/bash

arg1="$(tr "[A-Z]" "[a-z]" <<< "$1")"

function portal_help {
	echo "Portal is an application that lets you easily go back to different directories in style."
	echo "Ussage:"
	echo "  portal to PORTAL_ALIAS/OPTIONAL_SUB-DIRECTORY | Is used to portal to a specific portal."
	echo "  portal -m/--make PORTAL_ALIAS | Is used to make a portal at that the current directory."
	echo "  portal -o/--overwrite | Is used to overwrite an existing portal."
	echo "  portal -r/--remove PORTAL_ALIAS | Is used to remove a portal."
	echo "  portal -l/--list | is used to list all portals."
	echo "  portal -c OPTIONAL_PARAMETER | If no parameter is given, it will list the content of the configuration file."
	echo "   else it will toggle the parameter in the configuration file."
	echo "  portal -h/--help | Is used to echo this message."
	echo "---conifguration file parameters---"
	echo " flavor_messages : If set to true, the flavor messages will be shown."
}

function make_portal {
	python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
	if [ $? -eq 0 ]; then
		echo "Hacking space time..."
	fi
	if [ -z "$1" ]; then
		python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
		if [ $? -eq 0 ]; then
			echo "Failed to hack space time: missing arguments."
		else
			echo "Failed to create portal: missing arguments."
		fi
	else
		python /bin/portal_bin/portalDB.py "-E" "$1"
		if [ $? -eq 1 ]; then
			echo "Portal exists already please use -o instead of -m to overwrite it."
		else
			python /bin/portal_bin/portalDB.py "-W" "$1" "$(pwd)"
		fi
	fi

}

function overwrite_portal {
	python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
	if [ $? -eq 0 ]; then
		echo "Hacking space time..."
	fi
	if [ -z "$1" ]; then
		python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
		if [ $? -eq 0 ]; then
			echo "Failed to hack space time: missing arguments."
		else
			echo "Failed to overwrite portal: missing arguments."
		fi
	else
		python /bin/portal_bin/portalDB.py "-E" "$1"
		if [ $? -eq 1 ]; then
			python /bin/portal_bin/portalDB.py "-W" "$1" "$(pwd)"
		else
			echo "Portal does not exist please use -m instead of -o to make it."
		fi
	fi

}

function remove_portal {
	python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
	if [ $? -eq 0 ]; then
		echo "Hacking space time..."
	fi
	if [ -z "$1" ]; then
		python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
		if [ $? -eq 0 ]; then
			echo "Failed to hack space time: missing arguments."
		else
			echo "Failed to remove portal: missing arguments."
		fi
	else
		python /bin/portal_bin/portalDB.py "-E" "$1"
		if [ $? -eq 1 ]; then
			python /bin/portal_bin/portalDB.py "-D" "$1"
		else
			echo "Portal does not exist."
		fi
	fi

}

function config_portal {
	if [ -z "$1" ]; then
		python /bin/portal_bin/portalCONFIG.py "-r"
	else
		python /bin/portal_bin/portalCONFIG.py "-e" "$1"
		if [ $? -eq 0 ]; then
			python /bin/portal_bin/portalCONFIG.py "$1"
		else
			echo "Failed to set parameter, parameter invalid."
		fi
	fi
}

if [ "$arg1" = "-m" ]; then
	make_portal "$2"
	
elif [ "$arg1" = "--make" ]; then
	make_portal "$2"
	
elif [ "$arg1" = "-o" ]; then
	overwrite_portal "$2"
elif [ "$arg1" = "-overwrite" ]; then
	overwrite_portal "$2"
elif [ "$arg1" = "-r" ]; then
	remove_portal "$2"
elif [ "$arg1" = "--remove" ]; then
	remove_portal "$2"
elif [ "$arg1" = "to" ]; then
	if [ -z "$2" ]; then
		echo "Failed to portal: missing arguments."
	else
		python /bin/portal_bin/portalCONFIG.py "-r" "flavor_messages"
		if [ $? -eq 0 ]; then
			echo "Entering portal..."
		fi
		pythonOut=$(python /bin/portal_bin/portalDB.py -R $2)
		if [ $? -eq 1 ]; then
			echo "Portal $2 does not exist."
		else
			python /bin/portal_bin/portalDB.py "-R" "$2"
			if [ $? -eq 2 ]; then
				echo "Directory after portal $2 does not exist."
			else
				cd ${pythonOut}
			fi
		fi
	fi
elif [ "$arg1" = "-c" ]; then
	config_portal "$2"
elif [ "$arg1" = "--config" ]; then
	config_portal "$2"
elif [ "$arg1" = "-l" ]; then
	python /bin/portal_bin/portalDB.py "-L"
elif [ "$arg1" = "--list" ]; then
	python /bin/portal_bin/portalDB.py "-L"
elif [ "$arg1" = "-h" ]; then
	portal_help
elif [ "$arg1" = "--help" ]; then
	portal_help	
else
	portal_help
fi

