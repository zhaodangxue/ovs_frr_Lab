import os
import argparse
import subprocess
import time
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    filename = "data/udp_arguement_test.txt"
    parser = argparse.ArgumentParser(description="udp test")
    log("UDP test---")
    parser.add_argument('--BW', '-B',type=int, help='Bandwidth of the links in Mbps', default=1000)
    parser.add_argument('--bw', '-b',type=int, help='Bandwidth of the iperf', default=1000)
    args = parser.parse_args()
    os.system("./clear_qos.sh")
    os.system("./set_qos_%dM.sh"% args.BW)
    os.system("docker exec -i h4 iperf -u -s &")
    # 执行命令
    command = "docker exec -i h1 iperf -u -c 10.4.4.100 -b %dM -t 10"%args.bw
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    time.sleep(11)
    information = "Link Bandwidth: %dMbps   Iperf Bandwidth: %dMbps\n"%(args.BW,args.bw)
    # 检查命令是否成功执行
    if result.returncode == 0:
       # 打印命令输出
       print("Command output:")
       print(result.stdout)

       # 保存输出到文件
       with open(filename, 'a') as f:
          f.write(information)
          f.write(result.stdout)
    else:
      # 打印错误信息
       print("Error executing command:")
       print(result.stderr)
if __name__ == "__main__":
     main()