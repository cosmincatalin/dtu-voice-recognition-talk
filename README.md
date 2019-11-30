### Prerequisites

* Docker

```
docker build . \
-t voice-recognition-python \
--no-cache
```

```
docker run \
-p 8888:8888 \
-v $(pwd):/notebooks \
-v $(pwd)/data:/notebooks/data \
-v ~/.aws:/home/docker/.aws \
--env AWS_PROFILE=default \
voice-recognition-python
```