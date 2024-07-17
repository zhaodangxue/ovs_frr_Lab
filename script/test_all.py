import os
import argparse
import subprocess
import time
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    python3 = "python3 "
    if not os.path.exists("/home/ovs_data"):
      os.mkdir("/home/ovs_data")
    log("Testing Reconnect Test---")
    # advertise time = 5
    os.system(python3+"setup.py -a 5")
    time.sleep(5)
    os.system(python3+"reconnect_test.py")
    os.system(python3+"teardown.py")
    # advertise time = 10
    os.system(python3+"setup.py -a 10")
    time.sleep(5)
    os.system(python3+"reconnect_test.py")
    os.system(python3+"teardown.py")
    # advertise time = 15
    os.system(python3+"setup.py -a 15")
    time.sleep(5)
    os.system(python3+"reconnect_test.py")
    os.system(python3+"teardown.py")
    log("Complete Reconnect Test!")
    os.system(python3+"setup.py -a 5")
    time.sleep(5)
    log("Testing TCP Arguement Test---")
    os.system(python3+"tcp_test.py -b 1000")
    os.system(python3+"tcp_test.py -b 800")
    os.system(python3+"tcp_test.py -b 600")
    os.system(python3+"tcp_test.py -b 400")
    os.system(python3+"tcp_test.py -b 200")
    os.system(python3+"tcp_test.py -b 100")
    log("Complete TCP Arguement Test!")
    log("Testing Send Self Test---")
    os.system(python3+"tcp_send_self.py")
    os.system(python3+"udp_send_self.py")
    log("Complete Send Self Test!")
    log("Testing UDP Arguement Test---")
    os.system(python3+"udp_test.py -B 1000 -b 1000")
    os.system(python3+"udp_test.py -B 1000 -b 600")
    os.system(python3+"udp_test.py -B 1000 -b 200")
    os.system(python3+"udp_test.py -B 600 -b 1000")
    os.system(python3+"udp_test.py -B 600 -b 600")
    os.system(python3+"udp_test.py -B 600 -b 200")
    os.system(python3+"udp_test.py -B 200 -b 1000")
    os.system(python3+"udp_test.py -B 200 -b 600")
    os.system(python3+"udp_test.py -B 200 -b 200")
    log("Complete UDP Arguement Test!")
    log("Teardown---")
    os.system(python3+"teardown.py")
    log("Copy Data---")
    os.system("cp -r ./data /home/ovs_data")
if __name__ == "__main__":
    main()
