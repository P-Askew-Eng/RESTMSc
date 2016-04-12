# -*- coding: utf-8 -*-
"""
Created on Thu Feb 25 20:47:03 2016

@author: Paul
"""

import numpy as np
import matplotlib.pyplot as plt

from matplotlib.sankey import Sankey

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1, xticks=[], yticks=[],
                     title="Flow Diagram of Food Waste")
sankey = Sankey(ax=ax, scale=0.01, offset=0.2, head_angle=180,
                format='%.0f', unit='mT')
sankey.add(flows=[22, 19, -3, -3.9, -0.92, -7, -26],
           labels=['Production', 'Import', 'Farm Waste', 'Processing Waste', 'HaFS Waste', 'Consumer Waste', 
                    'Consumer Use'],
           orientations=[0, 1, -1, -1, -1, -1, 0],
           pathlengths=[0.25, 0.25, 0.25, 0.5, 0.25, 0.7,
                        0.25],
           patchlabel="Food Production\nand Waste",
           alpha=0.2, lw=2.0)  # Arguments to matplotlib.patches.PathPatch()
diagrams = sankey.finish()
diagrams[0].patch.set_facecolor('#37c959')
diagrams[0].texts[-1].set_color('b')
diagrams[0].text.set_fontweight('bold')
diagrams[0].texts[4].set_color('r')
diagrams[0].text.set_fontweight('bold')