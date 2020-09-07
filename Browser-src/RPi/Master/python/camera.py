import time
import threading
import os

flag = False;
def read():
    global flag
    while True:
        f = open("../rtsp")
        addr = f.read()
        f.close()

        if len(addr) > 1:
            if not flag:
                try:
                    os.system("python window.py &")
                    flag = True
                except:
                    pass
        else:
            if flag:
                print("disconnected.")
            os.system("pkill -f window.py &")
            f = open("../rtspConnected", "w")
            f.write("0")
            f.close
            flag = False

        time.sleep(0.1)

if __name__ == "__main__":
    print("Watcher started.")
    read()
