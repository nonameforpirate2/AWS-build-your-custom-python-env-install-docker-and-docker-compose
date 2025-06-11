# AWS-build-your-custom-python-env-install-docker-and-docker-compose
Here is a sample .sh file lifecycle configuration to use when you need your instance with a custom python environment, docker and docker compose
1.- The `config_final.bash` file is a regular lifecycle configuration to put your custom python environment, docker and docker-compose in a sg instance.
2.- The `config_final_with_gcc9.sh` is a lifecycle configuration file that creates your custom python environment, installs docker, docker-compose and installs gcc9 by default in your aws sg instance. After you turn on the instance with that file, you need to run with the terminal on the sg instance the file `lifecycle_with_gcc9_terminal.sh` to finish loading the installed gcc9 into your system. 
