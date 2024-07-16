# ovs_frr_Lab

An experiment with the same network topology as MininetLab but implemented using OVS, FRR, and Docker。

本实验需要使用docker和ovs，linux系统下的安装方式：

```bash
apt install docker.io
apt install openvswitch-switch
```

这个Lab的script下的脚本目录介绍：

* **clear_all_qos.sh**:这个脚本负责清除所有已经存在的QoS策略。
* **clear_qos.sh**:清除当前所有已经存在的port上的QoS策略。
* **set_qos_xxxM.sh**:利用ovs设置指定带宽的QoS并利用到所有已经存在的port上。
* **clear_and_rm_container.sh**:清除我们指定的frr容器。
* **pull_and_start_container.sh**:拉取并启动我们的frr容器。
* **config_start_container.sh**:为我们的frr容器作出对应配置并重启这些容器。
* **create_ovs_br.sh**:创建对应的ovs网桥，并且进行验证。
* **ovs_br0_config.sh**:为对应的br0作相关配置，即用ovs-docker指令来增加相关port。
* **delete_ovs_br.sh**:删除对应port后再删除网桥，并且进行验证。
* **set_advertise_X目录**:这个目录下的脚本会为对应的容器进行对应的frr配置，唯一变量是advertisement Interval，这里的变量就是我们的X
