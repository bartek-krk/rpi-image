source ./utils.sh

is_connected_to_internet
if [ ! "$?" -eq 0 ];
then
    panic "No IC"
fi

is_python_installed