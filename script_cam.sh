output -c /dev/video0 -f yuyv -n 4 -s 320x240
 
ffmpeg -f video4linux2 -r 2 -s 320x240 -i /dev/video0 320x240.jpg
 

ffmpeg -f video4linux2 -r 2 -s 352x288 -i /dev/video0 352x288.jpg
 

ffmpeg -f video4linux2 -s 320x240 -i /dev/video0 -f alsa -ac 1 -i hw:1,0 -acodec libmp3lame -ab 96k -async 1 camera.m4v

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=320,height=240,framerate=30/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0 (Tested working) video preview on LCD

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=352,height=288,framerate=30/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=640,height=480,framerate=15/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0 (Tested working) video preview on LCD

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=352,height=288,framerate=30/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0 (Tested working) video preview on LCD

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=1280,height=720,framerate=15/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

gst-launch -e v4l2src ! video/x-raw-yuv,width=640,height=480,framerate=4/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

gst-launch -v v4l2src device=/dev/video2 ! 'video/x-raw-yuv,width=320,height=240' ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

gst-launch -v v4l2src device=/dev/video2 ! 'video/x-raw-yuv,width=640,height=480', framerate=15/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

 

 

gst-launch -v v4l2src device=/dev/video0 ! 'video/x-raw-yuv,width=320,height=240' ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

gst-launch -e v4l2src ! video/x-raw-yuv,width=352,height=288,framerate=30/1 ! ffmpegcolorspace ! fbdevsink device=/dev/ fb0

 

gst-launch -v v4l2src device=/dev/video0 ! 'video/x-raw-yuv,width=640,height=480', framerate=6/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0

 

 

./gtream-main -c /dev/video0 -f mjpg -n 4 -s 640x480
 

./gtream-main -c /dev/video0 -f yuyv -n 30 -s 2592x1944
 
gst-launch v4l2src always_copy=FALSE ! video/x-raw-yuv,width=640,height=480,framerate=7/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0
 
#./yavta --enum-formats -c /dev/video0 -s 2592x1944

 

We have test with resolution 176x144 to 2592x1944 on our DM385 its working fine for all supported resolution.

 
./yavta --enum-formats -c /dev/video0 -s 640x480

 
./yavta --enum-formats -c /dev/video0 -s 2592x1944

 
-S
 
gst-launch -e v4l2src ! video/x-raw-yuv,width=1280,height=720,framerate=5/1 ! ffmpegcolorspace ! fbdevsink device=/dev/fb0 !  filesink location=test.jpg
 
gst-launch v4l2camsrc device=/dev/video1 num-buffers=1 ! omx_jpegenc ! filesink location=test.jpg
