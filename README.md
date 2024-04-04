# Detecting & Penalizing Mesh Intersections

This package provides a PyTorch module that can efficiently (1) detect and (2) penalize (self-)intersections for a triangular mesh. 
Tried and tested (April 2023) with Python 3.8, CUDA 11.7, CuDNN 8.4 and PyTorch 2.0.

## Table of Contents
  * [License](#license)
  * [Description](#description)
  * [Installation](#installation)
  * [Citation](#citation)
  * [Contact](#contact)

## License

Software Copyright License for **non-commercial scientific research purposes**.
Please read carefully the [terms and
conditions](https://github.com/vchoutas/torch-mesh-isect/blob/master/LICENSE) and any
accompanying documentation before you download and/or use the SMPL-X/SMPLify-X
model, data and software, (the "Model & Software"), including 3D meshes, blend
weights, blend shapes, textures, software, scripts, and animations. By
downloading and/or using the Model & Software (including downloading, cloning,
installing, and any other use of this github repository), you acknowledge that
you have read these terms and conditions, understand them, and agree to be bound
by them. If you do not agree with these terms and conditions, you must not
download and/or use the Model & Software. Any infringement of the terms of this
agreement will automatically terminate your rights under this
[License](./LICENSE).


## Description

This repository provides an easy to use containerized method for installing 
[torch-mesh-intersection](https://github.com/yl-1993/torch-mesh-isect/tree/master) on any Linux distribution.

The code, cortasy of [Vassilis Choutas](https://github.com/vchoutas) and [Lei Yang](https://github.com/yl-1993) 
builds a BVH tree given an input mesh for each one and queries it for self-intersections. Moreover, we
provide a conical 3D distance field based loss for resolving the interpenetrations, as in [Capturing Hands in Action using Discriminative Salient Points and Physics Simulation](https://doi.org/10.1007/s11263-016-0895-4).

Please note that in the current implementation, for batching one needs to provide meshes with the *same* number of faces. Moreover, the code by default works for self-penetrations of a body mesh. The module can be used also for inter-penetrations of different meshes - for this the easiest and naive approach (without additional bookkeeping) is to fuse all meshes in a single mesh and treat inter-penetrations as self-penetrations.


## Installation using Docker

Much of the installation process has be simplified by my contributions. For a more detailed installation process 
please feel free to visit [here](https://github.com/yl-1993/torch-mesh-isect/tree/master). 

**1. Clone this repository**
```Shell
git clone https://github.com/vchoutas/torch-mesh-isect
cd torch-mesh-interection
```

**2. Build the Container**
```Shell
# I am using cuda-11.7 with
# torch==2.0.0+cu117 torchvision==0.15.0+cu117 torchaudio==2.0.0+cu117 -f https://download.pytorch.org/whl/torch_stable.html
docker build -t mesh-intersection .
```

**3. Run the container with GPU access**
```Shell
# build instructs the container to run setup.py and build a python wheel file
docker run --gpus all -it -e WHEEL_OUTPUT_PATH=/output -v /local/path/on/host:/output mesh-intersection build
```

**4. Use pip to install the package as a dependency**
```Shell
pip install mesh_intersection-0.1.0-cp38-cp38-linux_x86_64.whl
```

## On Windows

You can also clone this repository directly if you are on windows. Be sure to install CUDA Toolkit 11.7 (cuda_11.7.0_516.01_windows.exe)
and cuDNN v8.4.0 (April 1st, 2022) for CUDA 11.x. 

Cuda samples, math headers and bvh_ops are already included in the repo. These resources where gathered from here: [samples](https://github.com/NVIDIA/cuda-samples.git), 
[headers](https://github.com/NVIDIA/cuda-samples/blob/master/Common/helper_math.h), [operations](https://gist.github.com/conorcodes/612f3358f0c2569f26e07c5fd86345fe). 

**1. Set up dependency**

Navigate to the directory of the project which requires this dependency. (In my case this was [smplify-x](https://github.com/vchoutas/smplify-x))

**2. Clone this repository**
```Shell
git clone https://github.com/vchoutas/torch-mesh-isect
cd torch-mesh-interection
pip install -r requirements.txt
```

**3. Run the setup**
```Shell
# This will run the build as normal
python setup.py install

OR
# This will build a windows .whl dist file
python setup.py install bdist_wheel
```

## Dependencies

1. [PyTorch](https://pytorch.org)

### Example dependencies

1. [SMPL-X](https://github.com/vchoutas/smplx)

### Optional Dependencies

1. [Trimesh](https://trimsh.org) for loading triangular meshes
2. [Pyrender](https://pyrender.readthedocs.io) for visualization

The code has been tested with Python 3.8, CUDA 11.7, CuDNN 8.4 and PyTorch 2.0.

## Citation

If you find this code useful in your research please cite the relevant work(s) of the following list, for detecting and penalizing mesh intersections accordingly:

```
@inproceedings{Karras:2012:MPC:2383795.2383801,
    author = {Karras, Tero},
    title = {Maximizing Parallelism in the Construction of BVHs, Octrees, and K-d Trees},
    booktitle = {Proceedings of the Fourth ACM SIGGRAPH / Eurographics Conference on High-Performance Graphics},
    year = {2012},
    pages = {33--37},
    numpages = {5},
    url = {https://doi.org/10.2312/EGGH/HPG12/033-037}, 
    doi = {10.2312/EGGH/HPG12/033-037},
    publisher = {Eurographics Association}
}
```

```
@article{Tzionas:IJCV:2016, title = {Capturing Hands in Action using Discriminative Salient Points and Physics Simulation},
    author = {Tzionas, Dimitrios and Ballan, Luca and Srikantha, Abhilash and Aponte, Pablo and Pollefeys, Marc and Gall, Juergen},
    journal = {International Journal of Computer Vision (IJCV)},
    volume = {118},
    number = {2},
    pages = {172--193},
    month = jun,
    year = {2016},
    url = {https://doi.org/10.1007/s11263-016-0895-4}, 
    month_numeric = {6} 
}
```

The original code was  developed for SMPL-X / SMPLify-X (CVPR 2019), you might be interested in having a look: [https://smpl-x.is.tue.mpg.de](https://smpl-x.is.tue.mpg.de).


## Contact
The code of this repository was implemented by [Vassilis Choutas](vassilis.choutas@tuebingen.mpg.de).

For commercial licensing (and all related questions for business applications), please contact [ps-licensing@tue.mpg.de](ps-licensing@tue.mpg.de). Please note that the method for this component has been [patented by NVidia](https://patents.google.com/patent/US9396512B2/en) and a license needs to be obtained also by them.
