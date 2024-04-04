FROM nvcr.io/nvidia/cuda:11.7.0-cudnn8-devel-ubuntu20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3.8 python3-pip python3.8-dev build-essential && \
    ln -s /usr/bin/python3.8 /usr/bin/python && \
    pip install --upgrade pip

RUN pip install torch==2.0.0+cu117 torchvision==0.15.0+cu117 torchaudio==2.0.0+cu117 -f https://download.pytorch.org/whl/torch_stable.html

COPY . /mesh-intersection
WORKDIR /mesh-intersection

RUN pip install -r requirements.txt
RUN chmod +x /mesh-intersection/run.sh
ENTRYPOINT ["/mesh-intersection/run.sh"]


