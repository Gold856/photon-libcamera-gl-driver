project('photonlibcamera', 'cpp', 'java')

java = import('java')

jni_dep = dependency('jni', version : '>=17', modules: ['jvm'])

cc = meson.get_compiler('cpp')
# Assert that the header can actually be found with the dependency.
cc.has_header('jni.h', dependencies: [jni_dep], required: true)
# Assert that the platform-specific include directory is included in the compiler arguments.
cc.has_header('jni_md.h', dependencies: [jni_dep], required: true)

native_headers = java.native_headers(
    'src/main/java/org/photonvision/raspi/LibCameraJNI.java',
    package: 'org.photonvision.raspi',
    classes: ['Outer']
)

subproject('libcamera', default_options: 'pycamera=disabled')
libcamera_dep = dependency('libcamera', required: true)
run_command('download.sh', check: true)
egl_dep = dependency('egl', required: true)
gbm_dep = dependency('gbm', required: true)
opengl_dep = dependency('opengl', required: true)
libdrm_dep = dependency('libdrm', required: true)
photonlibcamera = shared_library('photonlibcamera',
  'src/camera_grabber.cpp',
  'src/camera_manager.cpp',
  'src/camera_model.cpp',
  'src/camera_runner.cpp',
  'src/dma_buf_alloc.cpp',
  'src/gl_hsv_thresholder.cpp',
  'src/headless_opengl.cpp',
  'src/libcamera_jni.cpp',
  'src/libcamera_opengl_utility.cpp',
  native_headers,
  cpp_args: ['-DEGL_NO_X11=1', '-Wall', '-Wextra', '-Wpedantic', '-Werror', '-fPIC', '-ftree-vectorize', '-std=c++20'],
  dependencies: [libcamera_dep, egl_dep, gbm_dep, opengl_dep, libdrm_dep, jni_dep],
  include_directories: ['include/', 'opencv/'],
  link_args: [meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_core.so.4.10',
              meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_imgcodecs.so.4.10',
              meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_imgproc.so.4.10']
)

photonlibcamera_dep = declare_dependency(link_with : photonlibcamera,
  include_directories : ['include/', 'opencv/'])
executable('libcamera_meme',
  'main.cpp',
  dependencies: [photonlibcamera_dep, libcamera_dep, egl_dep, gbm_dep, opengl_dep, libdrm_dep, jni_dep],
  link_args: [meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_core.so.4.10',
              meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_imgcodecs.so.4.10',
              meson.current_source_dir() + '/opencv/linux/arm64/shared/libopencv_imgproc.so.4.10']
)