1.1 Getting started
	Start 3 containers from image that does not automatically exit, such as nginx, detached.
	Stop 2 of the containers leaving 1 up.
	Submitting the output for docker ps -a is enough to prove this exercise has been done.

1.2 Cleanup
	We’ve left containers and a image that won’t be used anymore and are taking space, as docker ps -as and docker images will reveal.
	Clean the docker daemon from all images and containers.
	Submit the output for docker ps -a and docker images

1.3
	Now that we’ve warmed up it’s time to get inside a container while it’s running!
	Start image devopsdockeruh/exec_bash_exercise, it will start a container with clock-like features and create a log. Go inside the container and use tail -f ./logs.txt to follow the logs. Every 15 seconds the clock will send you a “secret message”.
	Submit the secret message and command(s) given as your answer.

1.4
	Create a Dockerfile that starts with FROM devopsdockeruh/overwrite_cmd_exercise. Add a CMD line to the Dockerfile.
	The developer has poorly documented how the application works. Nevertheless once you will execute an application (run a container from an image) you will have some clues on how it works. Your task is to run an application so that it will simulate a number sequence.
	When you will build an image tag it as “docker-sequence” so that docker run docker-sequence starts the application.
	
1.5
	In this exercise we won’t create a new Dockerfile. Image devopsdockeruh/first_volume_exercise has instructions to create a log into /usr/app/logs.txt. Start the container with bind mount so that the logs are created into your filesystem.
	Submit your used commands for this exercise.

1.6
	In this exercise we won’t create a new Dockerfile. Image devopsdockeruh/ports_exercise will start a web service in port 80. Use -p flag to access the contents with your browser.
	Submit your used commands for this exercise.

1.7 (ONLY EXERCISE 1.10)
	A good developer creates well written READMEs that can be used to create Dockerfiles with ease.
	Clone, fork or download a project from https://github.com/docker-hy/frontend-example-docker.
	Create a Dockerfile for the project and give a command so that the project runs in a docker container with port 5000 exposed and published so when you start the container and navigate to http://localhost:5000 you will see message if you’re successful.
	Submit the Dockerfile.
	
1.8
	Lets create a Dockerfile for a Java Spring project: https://github.com/docker-hy/spring-example-project
	The setup should be straightforward with the README instructions. Tips to get you started:
	Use openjdk image FROM openjdk:_tag_ to get java instead of installing it manually. Pick the tag by using the README and dockerhub page.
	You’ve completed the exercise when you see a ‘Success’ message in your browser.
	