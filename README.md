# Independent Research Project


This repo contains code snippets and infra setup for the final project of University of York.

Repo Structure

- infra: All infrastructure setup (terraform)



Memory stress test for nginx server

```sh
stress-ng --vm 2 --vm-bytes 4G -t 120s --verify --metrics-brief --log-file memory/logs/memory-4G-1.log

while true; do 
    vmstat -s >> memory/stats/vmstats-4G-2.txt
    sleep 5
done
```


 stress-ng tests memory pressure on a system with 4GB of memory, which is less than the allocated buffer sizes, 2 x 2GB of vm stressor.



CPU stress test for nginx server

```sh
stress-ng --cpu 2 --cpu-load 50 -t 120s --verify --metrics-brief --log-file cpu/logs/memory-2C50-2.log


vmstat 5 -w >> cpu/stats/txt/vmstats-2C50-1.txt

```
ec2

```sh
sudo apt-get update -y
sudo apt-get install stress-ng -y
sudo apt install nginx
sudo apt install apache2
```

# Response Time

Apache Benchmark

```sh
ab -n 5000 -c 1000 -e docker-nginx-n5000-c1000.csv -l -r -k http://localhost/
ab -n 25000 -c 5000 -e docker-nginx-n25000-c5000.csv -l -r -k http://localhost/
ab -n 50000 -c 10000 -e docker-nginx-n50000-c10000.csv -l -r -k http://localhost/

```
