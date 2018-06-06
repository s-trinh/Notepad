### Object detection training
- references:
  - [TensorFlow Models](https://github.com/tensorflow/models)
  - Medium:
  [Part1](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-1-selecting-a-model-a02b6aabe39e), 
  [Part2](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-2-converting-dataset-to-tfrecord-47f24be9248d),
  [Part3](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-3-creating-your-own-dataset-6369a4d30dfd),
  [Part4](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-4-training-the-model-68a9e5d5a333),
  [Part5](https://medium.com/@WuStangDan/step-by-step-tensorflow-object-detection-api-tutorial-part-5-saving-and-deploying-a-model-8d51f56dbcf1)
  - [Train Tensorflow Object Detection on own dataset](https://stackoverflow.com/questions/44973184/train-tensorflow-object-detection-on-own-dataset/44973203#44973203)
- [install Tensorflow on Ubuntu](https://www.tensorflow.org/install/install_linux):
  - `source ~/tensorflow/bin/activate # bash, sh, ksh, or zsh`
- `cd research`
- `export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim`
- Tool: [LabelImg](https://github.com/tzutalin/labelImg)
  - `git clone https://github.com/tzutalin/labelImg.git`
  - *copy-paste from the tutorial without knowing what was needed for me*
  - `sudo apt-get install pyqt5-dev-tools`
  - `sudo pip3 install lxml`
  - `make qt5py3`
  - *copy-paste from the tutorial without knowing what was needed for me*
  - *Python3 was needed for me:* `python3 labelImg.py`
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
- create label map: `object_detection/dataclass_name_label_map.pbtxt` with only one class:
```
  item {
    id: 1
    name: 'class name'
  }
```
- in `object_detection/dataset_tools/create_pascal_tf_record.py`:
  - `examples_path = os.path.join(data_dir, year, 'ImageSets', 'Main', 'class_name_' + FLAGS.set + '.txt')`
- [...]
- open tensorboard: `http://localhost:6006 `
