import os
import argparse
import subprocess
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    filename = "data/tcp_arguement_test.txt"
    parser = argparse.ArgumentParser(description="tcp test")
    parser.add_argument('--bw', '-b',type=int, help='Bandwidth of the links in Mbps', default=1000)
    args = parser.parse_args()
    os.system("./clear_qos.sh")
    os.system("./set_qos_%dM.sh"% args.bw)
    os.system("docker exec -i h4 iperf -s &")
    # 执行命令
    command = "docker exec -i h1 iperf -c 10.4.4.100"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    information = "Bandwidth: %dMbps\n"%args.bw
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
