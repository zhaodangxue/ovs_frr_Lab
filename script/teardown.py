#这个函数用来清理干净环境，删除所有的资源
import os
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    log("Tearing down network topology---")
    log("Tearing down qos---")
    os.system("./clear_qos.sh")
    os.system("./clear_all_qos.sh")
    log("Complete tearing down qos!")
    log("Tearing down hosts---")
    os.chdir("set_host")
    os.system("./del_br0.sh")
    os.system("./del_hosts.sh")
    log("Complete tearing down hosts!")
    os.chdir("..")
    log("Tearing down spines and leaves---")
    os.system("./delete_ovs_br.sh")
    os.system("./clear_and_rm_container.sh")
    log("Complete tearing down spines and leaves!")
if __name__ == "__main__":
    main()