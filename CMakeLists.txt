cmake_minimum_required (VERSION 2.8.12 FATAL_ERROR)

# DEFINE THE PROJECT
PROJECT(testOpenCVSfM)









# Find includes in corresponding build directories
set(CMAKE_INCLUDE_CURRENT_DIR ON)
# Instruct CMake to run moc automatically when needed.
set(CMAKE_AUTOMOC ON)
# Executables fail to build with Qt 5 in the default configuration
# without -fPIE. We add that here.
set(CMAKE_CXX_FLAGS "${Qt5Widgets_EXECUTABLE_COMPILE_FLAGS}")

SET(CMAKE_CXX_FLAGS "-std=c++11")



find_package(Qt5Widgets REQUIRED)



find_package(OpenCV 3.1 REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
link_directories(${OpenCV_LIBRARY_DIRS})
link_directories(${OpenCV_DEFINITIONS})
message(STATUS "Found OpenCV version ${OpenCV_VERSION}")

find_package(Ceres REQUIRED)
include_directories(${CERES_INCLUDE_DIRS})
link_directories(${CERES_LIBRARY_DIRS})
link_directories(${CERES_DEFINITIONS})


# find CUDA
find_package(CUDA REQUIRED)
#Include the FindCUDA script
INCLUDE(FindCUDA)
include_directories(${CUDA_INCLUDE_DIRS})
link_directories(${CUDA_LIBRARIES})
add_definitions(${CUDA_DEFINITIONS})


# include project
include_directories(../testOpenCVSfM) # include the project in se
#include_directories(../PCViewer-build) # include the project in se

if(Ceres_FOUND)
  add_definitions("-DCERES_FOUND=1")
  list(APPEND LIBMV_LIGHT_LIBS simple_pipeline)
else()
  add_definitions("-DCERES_FOUND=0")
  message(STATUS "CERES support is disabled. Ceres Solver for reconstruction API is required.")
endif()






# CameraMotionEstimation
ADD_EXECUTABLE(myCameraMotionEstimation myCameraMotionEstimation.cpp)
TARGET_LINK_LIBRARIES(myCameraMotionEstimation ${OpenCV_LIBS} ${CERES_LIBRARIES})

# CameraMotionEstimation
ADD_EXECUTABLE(CameraMotionEstimation CameraMotionEstimation.cpp)
TARGET_LINK_LIBRARIES(CameraMotionEstimation ${OpenCV_LIBS} ${CERES_LIBRARIES})

# CameraMotionEstimation
ADD_EXECUTABLE(SceneReconstruction SceneReconstruction.cpp)
TARGET_LINK_LIBRARIES(SceneReconstruction ${OpenCV_LIBS} ${CERES_LIBRARIES} ${Qt5Widgets_LIBRARIES})

