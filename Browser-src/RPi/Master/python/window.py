import cv2
import os

f  = open("../rtsp")
addr = f.read()
f.close
flag = True
try:
    vcap = cv2.VideoCapture("rtsp://camera:pw12345678@192.168.88.227:554/Streaming/Channels/101")
    while(1):
        ret, frame = vcap.read()
        if ret:
            if flag:
                print("cameara connected: %s " % addr)
                flag = False
                os.system("echo 1 > ../rtspConnected")
            fr = cv2.resize(frame, (900, 600))
            cv2.imshow('VIDEO', fr)
            cv2.waitKey(1)
        else:
            break
except:
    pass