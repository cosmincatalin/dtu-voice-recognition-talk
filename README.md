### Prerequisites

* Docker [ref](https://docs.docker.com/install/)
* Configured AWS account profile [ref](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html)

Some familiarity with the Amazon Web Services ecosystem is desirable.

### How to run the notebook

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

Notice that the above command _mounts_ the typical location where AWS CLI credentials are located (`~/.aws`).
If you have your AWS credentials configuration somewhere else, modify accordingly.
Similar, the `AWS_PROFILE` env variable is set to the `default` profile.
You can modify this to use whichever account you desire.

Direct your browser to [http://localhost:8888/tree](http://localhost:8888/tree) and open the _Voice Recognition.ipynb_ notebook. Execute the cells one by one.
