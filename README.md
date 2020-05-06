This application supports an [article](https://cosminsanda.com/posts/voice-recognition-with-mxnet-and-sagemaker/?utm_source=github&utm_medium=repository&utm_campaign=na) on my blog where I present how to build this application step by step. Full description and documentation can be found there.

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

### A note on model performance

One of the cells in the notebook allows you to control how many samples to use out of the 10K you have available.
The cell in question is this one:

```python
# This will take some time

# To move things faster we'll do "multi threading"
from multiprocessing.pool import ThreadPool

# We launch a maximum of 10 functions at a time for each sentence in the set
# To make the rest of tutorial reasonable fast, we'll use just 2000 sentences instead of the 10.000 we have available.
# This will, of course, have a negative impact on the final model.
with ThreadPool(processes=10) as pool:
    pool.starmap(process_input, enumerate(sentences[:2000]))
```

* If you choose something like 200 sentences, you will get close to real-time execution of all the cells in the notebook, but poor performance on inference of the model.
* If you choose something like 2000 sentences, you will get close to 95% accuracy, albeit some cells will take longer to execute. However, I have managed to run training using the provided Docker image on CPU.
* Using the full dataset will of course give you the best results, but it might be that you will not be able to complete the notebook using the provided Docker image running on CPU. I have used the full 10K dataset on GPU running in AWS SageMaker.
