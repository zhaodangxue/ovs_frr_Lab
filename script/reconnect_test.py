import os
import time
import termcolor as T
import subprocess
def log(s, col="green"):
    print (T.colored(s, col))
def count_routes(container_name):
    # 构造要执行的命令
    command = f"docker exec -i {container_name} route -n"

    # 执行命令并捕获输出
    result = subprocess.run(command, shell=True, capture_output=True, text=True)

    # 检查命令是否成功执行
    if result.returncode == 0:
        # 分割输出为行列表
        output_lines = result.stdout.splitlines()

        # 计算非空行的数量（每行代表一个路由条目）
        route_count = len([line for line in output_lines if line.strip() != ''])

        return route_count
    else:
        print(f"Error executing command: {result.stderr}")
        return None
def main():
    filename="data/reconnect_test.txt"
    log("Reconnect Test...")
    os.system("ovs-docker del-port br0 eth1 frr-02")
    os.system("ovs-docker del-port br0 eth2 frr-03")
    log("delink leaf1 and spine2")
    time_total = 0
    while True:
        spine1_size = count_routes("frr-01")
        spine2_size = count_routes("frr-02")
        leaf1_size = count_routes("frr-03")
        leaf2_size = count_routes("frr-04")
        leaf3_size = count_routes("frr-05")
        leaf4_size = count_routes("frr-06")
        time.sleep(0.5)
        time_total += 0.5
        if spine1_size == 22 and spine2_size == 22 and leaf1_size == 22 and leaf2_size == 22 and leaf3_size == 22 and leaf4_size == 22:
            break
    log("Routing protocol convergence time: %f s"%time_total)
    str = "Routing protocol convergence time: %f s\n"%time_total
    with open(filename, 'a') as f:
        f.write(str)
    os.system("ovs-docker add-port br0 eth1 frr-02 --ipaddress=100.2.1.1/30")
    os.system("ovs-docker add-port br0 eth2 frr-03 --ipaddress=100.2.1.2/30")
    log("relink leaf1 and spine2")
if __name__ == "__main__":
    main()