#!/usr/bin/env bash

# Paths are hardcoded

# Download las point cloud + geotiff orthoimage from s3
aws s3 cp s3://ryans-website-thing-public/psu.las ./data/psu.las
aws s3 cp s3://ryans-website-thing-public/psu_ortho.tif ./data/psu_ortho.tif
echo "Point cloud + Orthoimage downloaded"
echo

# Reproject point cloud + orthoimage to EPSG: 6347 (meters)
gdalwarp -t_srs EPSG:6347 ./data/psu_ortho.tif ./data/psu_ortho_reproj.tif
pdal translate ./data/psu.las ./data/psu_reproj.las -f filters.reprojection \
  --filters.reprojection.out_srs="EPSG:6347"
echo "Reprojected PC + Ortho"
echo

# Colorize Point cloud - json file also has hardcoded paths
pdal pipeline /home/ryan/myria3d/colorize.json
echo "Colorized PC"
echo

# Clear out existing classifications
/home/ryan/lastools/bin/las2las64 -i /home/ryan/myria3d/data/psu_colorized.las \
    -set_classification 1 -o /home/ryan/myria3d/data/psu_stripped.las
echo "Stripped existing classifications"
echo

# Run inference
python run.py \
    task.task_name=predict \
    predict.src_las=/home/ryan/myria3d/data/psu_stripped.las \
    predict.output_dir=/home/ryan/myria3d/output \
    predict.gpus=1 \
    datamodule.batch_size=50
echo "Inference complete!"
echo