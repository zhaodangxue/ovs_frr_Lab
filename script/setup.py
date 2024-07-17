# 这个函数用来帮助我们一键搭建环境
import os
import argparse
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    parser = argparse.ArgumentParser(description="Setup for the project")
    parser.add_argument('-a','--advertise',help='Advertisement time',type=int, default=5)
    args = parser.parse_args()
    log("Setting up network topology---")
    log("Setting spines and leaves---")
    os.system("./pull_and_start_container.sh")
    os.system("./config_start_container.sh")
    os.system("./create_ovs_br.sh")
    os.chdir("set_advertise_%d" % args.advertise)
    os.system("./set_frr-01.sh")
    os.system("./set_frr-02.sh")
    os.system("./set_frr-03.sh")
    os.system("./set_frr-04.sh")
    os.system("./set_frr-05.sh")
    os.system("./set_frr-06.sh")
    os.chdir("..")
    os.system("./ovs_br0_config.sh")
    log("Complete spines and leaves!")
    log("Setting up hosts---")
    os.chdir("set_host")
    os.system("./set_h1.sh")
    os.system("./set_h2.sh")
    os.system("./set_h3.sh")
    os.system("./set_h4.sh")
    os.system("./set_br0.sh")
    os.chdir("..")
    if not os.path.exists("data"):
      os.mkdir("data")
    log("Complete hosts!")
if __name__ == "__main__":
    main()
