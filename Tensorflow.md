### Tensorflow
- [Ubuntu install guide](https://www.tensorflow.org/install/install_linux)
- [Tensorflow object detection dependencies](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md)
- Tensorflow virtualenv: `source ~/tensorflow/bin/activate      # bash, sh, ksh, or zsh`
- [Update Tensorflow](https://stackoverflow.com/questions/42574476/update-tensorflow/47342614#47342614):
```
(tensorflow)$ pip install --upgrade pip  # for Python 2.7
(tensorflow)$ pip install --upgrade tensorflow      # for Python 2.7
(tensorflow)$ pip install --upgrade tensorflow-gpu  # for Python 2.7 and GPU
```
- Tensorflow version:
```
pip list | grep tensorflow
tensorflow                         1.7.0                 
You are using pip version 10.0.0b2, however version 10.0.1 is available.
You should consider upgrading via the 'pip install --upgrade pip' command.
```
- Quit: `(tensorflow)$ deactivate`
- [“TensorBoard - Visualize your learning.”](https://jhui.github.io/2017/03/12/TensorBoard-visualize-your-learning/)
- `http://localhost:6006`
- Tensorflow directory: `pip show tensorflow`

### Object detection training with Tensorflow with ssd_mobilenet_v1_coco
- references:
  - [TensorFlow Models](https://github.com/tensorflow/models)
  - Medium:
    - [How to train your own Object Detector with TensorFlow’s Object Detector API](https://towardsdatascience.com/how-to-train-your-own-object-detector-with-tensorflows-object-detector-api-bec72ecfe1d9)
    - Step by Step TensorFlow Object Detection API Tutorial: [Part1](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-1-selecting-a-model-a02b6aabe39e), 
[Part2](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-2-converting-dataset-to-tfrecord-47f24be9248d),
[Part3](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-3-creating-your-own-dataset-6369a4d30dfd),
[Part4](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-4-training-the-model-68a9e5d5a333),
[Part5](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-5-saving-and-deploying-a-model-8d51f56dbcf1)
  - [Train Tensorflow Object Detection on own dataset](https://stackoverflow.com/questions/44973184/train-tensorflow-object-detection-on-own-dataset/44973203#44973203)
- [install Tensorflow on Ubuntu](https://www.tensorflow.org/install/install_linux):
  - `source ~/tensorflow/bin/activate # bash, sh, ksh, or zsh`
- `cd research`
- `export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim`
- at some point [cocoapi](https://github.com/cocodataset/cocoapi) will be needed, see [also](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md#coco-api-installation):
  - `git clone https://github.com/cocodataset/cocoapi.git`
  - `cd cocoapi/PythonAPI`
  - `make`
  - `cp -r pycocotools <path_to_tensorflow>/models/research/`
  - add path to `cocoapi/PythonAPI` in `PYTHONPATH`?
- Protobuf Compilation, follow the [instructions](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md#protobuf-compilation) (issue is `from object_detection.protos import input_reader_pb2` `ImportError: cannot import name input_reader_pb2`):
  - `# From tensorflow/models/research/`
  - `protoc object_detection/protos/*.proto --python_out=.`
- [Manual protobuf-compiler installation and usage](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/installation.md#manual-protobuf-compiler-installation-and-usage) if issue with previous section:
  - `# From tensorflow/models/research/`
  - `wget -O protobuf.zip https://github.com/google/protobuf/releases/download/v3.0.0/protoc-3.0.0-linux-x86_64.zip`
  - `unzip protobuf.zip`
  - `./bin/protoc object_detection/protos/*.proto --python_out=.`
- Tool: [LabelImg](https://github.com/tzutalin/labelImg)
  - `git clone https://github.com/tzutalin/labelImg.git`
  - *copy-paste from the tutorial without knowing what was needed for me*
  - `sudo apt-get install pyqt5-dev-tools`
  - `sudo pip3 install lxml`
  - `make qt5py3`
  - *copy-paste from the tutorial without knowing what was needed for me*
  - *Python3 was needed for me:* `python3 labelImg.py`
  - weird issue with (after some ROS OpenCV uninstall, `sudo apt-get autoremove`, ...):
  - `~/src/labelImg$ python3 labelImg.py`
  - `Traceback (most recent call last):`
  - `File "labelImg.py", line 29, in <module>`
  - `import resources`
  - `File "/home/strinh/src/labelImg/resources.py", line 9, in <module>`
  - `from PyQt5 import QtCore`
  - `ImportError: /home/strinh/.local/lib/python3.5/site-packages/PyQt5/QtCore.so: undefined symbol: PySlice_AdjustIndices`
  - solved by downgrading PyQt5 version with ([see also](https://bugs.launchpad.net/rapid/+bug/1784236)): `pip3 install PyQt5==5.9.1`
  - now I have... `PyQt5`, `PyQt5-5.9.1.dist-info`, `PyQt5-5.11.2.dist-info`, `PyQt5_sip-4.19.12.dist-info` in `~/.local/lib/python3.5/site-packages`
- __Setup label directories:__ minimal structure should be:
  - `VOC2012`
    - `Annotations`
    - `ImageSets`
      - `Main`
    - `JPEGImages`
- split data between train and val: `python split_data.py`
- label: `python3 labelImg.py`:
  - `w`: Create a rect box
  - `d`: Next image
  - `a`: Previous image
  - __Set correct Change Save Dir__
- fix annotations: `./fix_annotation_folder_name.sh`
- create label class: `python create_class_label.py --class_name class_name`
- create label map: `object_detection/data/class_name_label_map.pbtxt` with only one class:
```
  item {
    id: 1
    name: 'class name'
  }
```
- in `object_detection/dataset_tools/create_pascal_tf_record.py`:
  - change line: `examples_path = os.path.join(data_dir, year, 'ImageSets', 'Main', 'class_name_' + FLAGS.set + '.txt')`
- Create TFRecord:
  - [Preparing Inputs](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/preparing_inputs.md)
  - TFRecord for training:
```
python object_detection/dataset_tools/create_pascal_tf_record.py \
  --label_map_path=object_detection/data/class_name_label_map.pbtxt \
  --data_dir=object_detection/VOCdevkit \
  --year=VOC2012 \
  --set=train \
  --output_path=class_name_train.record
```
  - TFRecord for evaluation:
```
python object_detection/dataset_tools/create_pascal_tf_record.py \
  --label_map_path=object_detection/data/class_name_label_map.pbtxt \
  --data_dir=object_detection/VOCdevkit \
  --year=VOC2012 \
  --set=val \
  --output_path=class_name_val.record
```
- select a network, e.g. `ssd_mobilenet_v1_coco.config`
- create directory structure:
  - `train_class_name`
    - `data`
      - `class_name_train.record`
      - `class_name_val.record`
    - `log`
    - `models`
      - `model.ckpt.data-00000-of-00001`
      - `model.ckpt.index`
      - `model.ckpt.meta`
      - `eval`
      - `train`
    - `class_name_label_map.pbtxt`
    - `ssd_mobilenet_v1_coco.config`
    - `export_inference_graph.py` (copied from `object_detection/export_inference_graph.py`)
    - `train.py` (copied from `object_detection/train.py`)
    - `eval.py` (copied from `object_detection/eval.py`)
- in `ssd_mobilenet_v1_coco.config`, changes should be:
  - number of object classes: `num_classes: 1`
  - batch size you want: `batch_size: 24`
  - `fine_tune_checkpoint: "models/model.ckpt"`
  - number of iterations (see also [Epoch vs iteration when training neural networks](https://stackoverflow.com/questions/4752626/epoch-vs-iteration-when-training-neural-networks/31842945#31842945), [Tradeoff batch size vs. number of iterations to train a neural network](https://stats.stackexchange.com/questions/164876/tradeoff-batch-size-vs-number-of-iterations-to-train-a-neural-network/236393#236393), [Batch gradient descent versus stochastic gradient descent](https://stats.stackexchange.com/questions/49528/batch-gradient-descent-versus-stochastic-gradient-descent/68326#68326)): `num_steps: 2000`
  - [What are possible values for data_augmentation_options in the TensorFlow Object Detection pipeline configuration?](https://stackoverflow.com/questions/44906317/what-are-possible-values-for-data-augmentation-options-in-the-tensorflow-object/46901051#46901051)
  - path for training
```
train_input_reader: {
  tf_record_input_reader {
    input_path: "data/class_name_train.record"
  }
  label_map_path: "class_name_label_map.pbtxt"
}
```
  - evaluation config
```
eval_config: {
  num_examples: 11
  # Note: The below line limits the evaluation process to 10 evaluations.
  # Remove the below line to evaluate indefinitely.
  # max_evals: 10
  # Number of visualization images to generate.
  num_visualizations: 5
}
```
  - path for evaluation
```
eval_input_reader: {
  tf_record_input_reader {
    input_path: "data/class_name_val.record"
  }
  label_map_path: "class_name_label_map.pbtxt"
  shuffle: false
  num_readers: 1
}
```
  - negative hard miner ([Object detection : hard negatives.](https://github.com/tensorflow/models/issues/2544), [Add purely negative images gets error when using object detection API to create tf records?](https://github.com/tensorflow/models/issues/3578), [PR to fix read XML annotations for hard negative images](https://github.com/tensorflow/models/pull/3744), [Best strategy to reduce false positives: Google's new Object Detection API on Satellite Imagery](https://stackoverflow.com/questions/45666499/best-strategy-to-reduce-false-positives-googles-new-object-detection-api-on-sa/45684700#45684700))?:
```
hard_example_miner {
  num_hard_examples: 3000
  iou_threshold: 0.99
  loss_type: CLASSIFICATION
  max_negatives_per_positive: 3
  min_negatives_per_image: 0
}
```
- open tensorboard: `http://localhost:6006 `
- run training: `run_training.sh`
- run evaluation: `run_eval.sh`
- run Tensorboard: `run_tensorboard.sh`
- [...]
- export inference graph: `run_export_inference_graph.sh`
```
python export_inference_graph.py \
    --input_type image_tensor \
    --pipeline_config_path ./ssd_mobilenet_v1_coco.config \
    --trained_checkpoint_prefix ./models/train/model.ckpt-2000 \
    --output_directory output_inference_graph
```
- [TensorFlow Object Detection API](https://github.com/opencv/opencv/wiki/TensorFlow-Object-Detection-API)
- OpenCV compatibility: `run_tf_text_graph_ssd.sh`
- test: `python test.py --config ssd_mobilenet_v1_coco_class_name.pbtxt --input`

### Run simultaneously train and eval on GPU
- [GPU memory error with train.py and eval.py running together #1854](https://github.com/tensorflow/models/issues/1854):
  - in `trainer.py`
  - add `session_config.gpu_options.per_process_gpu_memory_fraction = 0.8` after `session_config = tf.ConfigProto(allow_soft_placement=True, log_device_placement=False)`
- [How to train and evaluate simultaneously in Object Detection API ?](https://stackoverflow.com/questions/49033008/how-to-train-and-evaluate-simultaneously-in-object-detection-api#49380874): create another `virtualenv` with CPU Tensorflow

### Object detectection new API:
- [Running Locally](https://github.com/tensorflow/models/blob/master/research/object_detection/g3doc/running_locally.md)
- issue with non up-to-date tensorflow models: [TF object detection API detection model retraining: “object_detection.protos.SsdFeatureExtractor” has no field named “batch_norm_trainable”](https://stackoverflow.com/questions/49880939/tf-object-detection-api-detection-model-retraining-object-detection-protos-ssd#49883742)
- old API is in [legacy](https://github.com/tensorflow/models/tree/master/research/object_detection/legacy)

### CUDA / cuDNN
- [CUDA GPUs](https://developer.nvidia.com/cuda-gpus)
- [https://developer.nvidia.com/cuda-downloads](https://developer.nvidia.com/cuda-downloads)
- `sudo sh cuda_9.2.148_396.37_linux.run`, follow the instructions to install the graphics drivers, ...
- [https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download)
- [How can I install CuDNN on Ubuntu 16.04?](https://askubuntu.com/a/767270/707605)
  - `cd folder/extracted/contents`
  - `sudo cp include/cudnn.h /usr/local/cuda/include`
  - `sudo cp lib64/libcudnn* /usr/local/cuda/lib64`
  - `sudo chmod a+r /usr/local/cuda/lib64/libcudnn*`
- follow instructions in [NVIDIA CUDA Installation Guide for Linux](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/) to setup correctly the environment variables, ...
- to update the display drivers:
  - uninstall the ones from the distribution?
  - reboot in text mode to avoid X server loading?
  - to be tested on a fresh install
  - [Ubuntu 16.04 problem with cuda 9.1 + 390.30 driver!](https://devtalk.nvidia.com/default/topic/1030130/ubuntu-16-04-problem-with-cuda-9-1-390-30-driver-/)
  - [How to disable X server when installing CUDA8.0?](https://devtalk.nvidia.com/default/topic/1018078/cuda-setup-and-installation/how-to-disable-x-server-when-installing-cuda8-0-/)
- [How to get the cuda version?](https://stackoverflow.com/questions/9727688/how-to-get-the-cuda-version#9730706): `nvcc --version`
