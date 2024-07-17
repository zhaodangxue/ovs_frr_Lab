import os
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
    log("Counting routes...")
    container_name = "frr-01"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
    container_name = "frr-02"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
    container_name = "frr-03"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
    container_name = "frr-04"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
    container_name = "frr-05"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
    container_name = "frr-06"
    route_count = count_routes(container_name)
    if route_count is not None:
        log(f"Route count for {container_name}: {route_count}")
if __name__ == "__main__":
    main()