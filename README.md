# Using Myria3D + FRACTAL model for lidar point cloud classification

See resulting point cloud video here: https://youtu.be/z_7FhqLX5lo

See pipeline.sh for the steps to convert data from PASDA into something that Myria3D will take. You will need to install GDAL to reproject the orthophoto. I used lastools to set all the classes to 1 prior to inference, but PDAL can probably do the same thing, which is installed when you install the Myria3D repo per their instructions. 

The FRACTAL model can be downloaded on Hugging Face and is a huge improvement over the default model provided with Myria3D.

Myria3D + FRACTAL is meant to be used for the French lidar HD project, so performing inference on data from outside of France is going to be lackluster in terms of results. That said, the results of this quick experiment seem to be an okay starting point for a human to begin making edits. 

More in-depth commentary is on my LinkedIn. Feel free to reach out with any questions.

```
@misc{gaydon2022myria3d,
  title={Myria3D: Deep Learning for the Semantic Segmentation of Aerial Lidar Point Clouds},
  url={https://github.com/IGNF/myria3d},
  author={Charles Gaydon},
  year={2022},
  note={IGN (French Mapping Agency)},
}

@misc{gaydon2024fractal,
      title={FRACTAL: An Ultra-Large-Scale Aerial Lidar Dataset for 3D Semantic Segmentation of Diverse Landscapes}, 
      author={Charles Gaydon and Michel Daab and Floryne Roche},
      year={2024},
      eprint={TBD},
      archivePrefix={arXiv},
      url={https://arxiv.org/abs/TBD}
      primaryClass={cs.CV}
}

Lidar data and NAIP orthophoto courtesy of PASDA: https://www.pasda.psu.edu/contact.html
```