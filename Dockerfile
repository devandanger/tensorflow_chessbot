FROM gcr.io/tensorflow/tensorflow:latest
MAINTAINER Sam <elucidation@gmail.com>

# Install python and pip and use pip to install the python reddit api PRAW
RUN apt-get -y update && apt-get install -y \
  python-dev \
  libxml2-dev \
  libxslt1-dev \
  libjpeg-dev \
   && apt-get clean

# Install older version python reddit api related files
RUN pip install praw==3.5.0 beautifulsoup4==4.2.1 lxml==3.3.3 Pillow==2.3.0

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Remove jupyter related files
RUN rm -rf /notebooks /run_jupyter.sh

# Copy code over
COPY . /tcb/

WORKDIR /tcb

# Run chessbot by default
CMD ["/tcb/run_chessbot.sh"]

# Start up the docker instance with the proper auth file using
# <machine>$ docker run -dt --rm --name cfb -v <local_auth_file>:/tcb/auth_config.py elucidation/tensorflow_chessbot
