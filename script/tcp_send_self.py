import os
import subprocess
import time
import termcolor as T
def log(s, col="green"):
    print (T.colored(s, col))
def main():
    filename = "data/tcp_self_test.txt"
    log("TCP test---")
    os.system("./clear_qos.sh")
    os.system("docker exec -i h1 iperf -s &")
    # 执行命令
    command = "docker exec -i h1 iperf -c 127.0.0.1"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    time.sleep(11)
    # 检查命令是否成功执行
    if result.returncode == 0:
       # 打印命令输出
       print("Command output:")
       print(result.stdout)

       # 保存输出到文件
       with open(filename, 'a') as f:
          f.write(result.stdout)
    else:
      # 打印错误信息
       print("Error executing command:")
       print(result.stderr)
    command = "docker exec -i h1 iperf -c 10.1.1.100"
    result = subprocess.run(command, shell=True, capture_output=True, text=True)
    time.sleep(11)
    # 检查命令是否成功执行
    if result.returncode == 0:
       # 打印命令输出
       print("Command output:")
       print(result.stdout)

       # 保存输出到文件
       with open(filename, 'a') as f:
          f.write(result.stdout)
    else:
      # 打印错误信息
       print("Error executing command:")
       print(result.stderr)
if __name__ == "__main__":
     main()