FROM openjdk:16-slim

ENV USER gitloganalyzer
ENV UID 1001
ENV HOME /home/$USER

WORKDIR $HOME

RUN apt-get update && apt install -y git

RUN adduser --system --uid $UID $USER

RUN chown -R $USER $HOME

USER $USER

COPY gitloganalyzer.jar $HOME

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash","/entrypoint.sh"]
