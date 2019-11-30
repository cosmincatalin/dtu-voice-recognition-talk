FROM matthewfeickert/docker-python3-ubuntu
WORKDIR /notebooks
COPY requirements.lock .
RUN sudo apt-get update
# ffmpeg allows working with sound
# tree is used for printing deep folder structures
RUN sudo apt-get install \
    ffmpeg \
    tree \
    -y
RUN pip install --user -r requirements.lock --disable-pip-version-check
CMD jupyter notebook --ip=0.0.0.0 --allow-root --no-browser --NotebookApp.token='' --NotebookApp.password=''
