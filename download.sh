#!/usr/bin/bash
OPENCV_YEAR=frc2025
OPENCV_VERSION=4.10.0-3
OPENCV_TYPE=""
OPENCV_ARCH=linuxarm64
ARTIFACT_NAME=opencv-cpp-$OPENCV_VERSION-$OPENCV_ARCH$OPENCV_TYPE.zip
HEADERS_ARTIFACT_NAME=opencv-cpp-$OPENCV_VERSION-headers.zip
wget -q https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/thirdparty/$OPENCV_YEAR/opencv/opencv-cpp/$OPENCV_VERSION/$ARTIFACT_NAME
wget -q https://frcmaven.wpi.edu/artifactory/release/edu/wpi/first/thirdparty/$OPENCV_YEAR/opencv/opencv-cpp/$OPENCV_VERSION/$HEADERS_ARTIFACT_NAME
unzip -o $ARTIFACT_NAME -d opencv
unzip -o $HEADERS_ARTIFACT_NAME -d opencv