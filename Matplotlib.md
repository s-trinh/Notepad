## Plot pose estimation from `vpPlot` format
```
#!/usr/bin/env python
# -*- coding: utf-8 -*-

from __future__ import print_function
import matplotlib.pyplot as plt
import numpy as np
import argparse

def plot_pose(tvec, rvec):
  # translation
  plt.subplot(2, 1, 1)
  plt.grid(True)
  for idx in range(0, tvec.shape[1], 3):
    plt.plot(tvec[:,idx], tvec[:,idx+1], '-')

  plt.xlim(xmin=0)
  plt.xlabel("Frame #")
  plt.ylabel("Translation (m)")
  plt.legend(['tx', 'ty', 'tz'])

  #thetau
  plt.subplot(2, 1, 2)
  plt.grid(True)
  for idx in range(0, rvec.shape[1], 3):
    plt.plot(rvec[:,idx], rvec[:,idx+1], '-')

  plt.xlim(xmin=0)
  plt.xlabel("Frame #")
  plt.ylabel("Rotation (deg)")
  plt.legend(['tux', 'tuy', 'tuz'])

def main():
  parser = argparse.ArgumentParser(description='Plot pose estimation.')
  parser.add_argument('--tvec', type=str, help='Translation vectors file')
  parser.add_argument('--rvec', type=str, help='Rotation vectors file')

  args = parser.parse_args()

  font = {'family' : 'normal',
        'weight' : 'normal',
        'size'   : 18}

  plt.rc('font', **font)

  # load data
  tvec = np.loadtxt(args.tvec[0], skiprows=1)
  rvec = np.loadtxt(args.rvec[0], skiprows=1)
  print("tvec: ", tvec.shape)
  print("rvec: ", rvec.shape)

  plot_pose(tvec, rvec)

  plt.show()

if __name__ == "__main__":
  main()
```
