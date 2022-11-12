# Independent Research Project


This repo contains code snippets and infra setup for the final project of University of York.

Repo Structure

- infra: All infrastructure setup (terraform)



Memory stress test for nginx server

```sh
stress-ng --vm 2 --vm-bytes 4G -t 120s --verify --metrics-brief --log-file memory/logs/memory-4G-1.log
stress-ng --cpu 2 --cpu-load 50 -t 120s --verify --metrics-brief --log-file cpu/logs/memory-2C50-2.log
while true; do 
    vmstat -s >> memory/stats/vmstats-4G-2.txt
    sleep 5
done
```


 stress-ng tests memory pressure on a system with 4GB of memory, which is less than the allocated buffer sizes, 2 x 2GB of vm stressor and 2 x 2GB of mmap stressor with --page-in enabled.


ec2

```sh
sudo apt-get update -y
sudo apt-get install stress-ng -y
sudo apt install nginx
sudo apt install apache2
```