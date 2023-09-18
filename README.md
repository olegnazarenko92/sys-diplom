
#  Дипломная работа по профессии «Системный администратор»

Файл с конфигурацией Terraform находится здесь:
#### (https://github.com/olegnazarenko92/sys-diplom/blob/main/terraform/main.tf) 
Ansible playbooks и остальные конфигурационные файлы находятся в папках terraform и ansible соответственно:
#### (https://github.com/olegnazarenko92/sys-diplom/tree/main/terraform)
#### (https://github.com/olegnazarenko92/sys-diplom/tree/main/ansible)

## Инфраструктура
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/%D0%98%D0%BD%D1%84%D1%80%D0%B0%D1%81%D1%82%D1%80%D1%83%D0%BA%D1%82%D1%83%D1%80%D0%B0.png)

## Подсети
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/subnets.png)

## Балансировщик
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/balancer.png)

## Работа виртуальных машин
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/nginx1.png)
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/nginx2.png)
## Zabbix
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/zabbix.png)
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/zabbix1.png)
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/zabbix2.png)
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/zabbix3.png)

## ELK
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/elk.png)

## Snapshots
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/snapshots.png)

# Работа над ошибками
## Исправление замечания №1
### Подключение к серверу:
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/elk.png)

### Работа сервера:
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/Logs.png)
## Исправление замечания №2
## Описание стратегии
#### Snapshot_count - максимальное количество хранимых снапшотов для каждого диска;
#### Shedule_policy - расписание снапшотов (один раз в сутки)
'''
resource "yandex_compute_snapshot_schedule" "default" {
  name = "default"

  schedule_policy {
    expression = "0 5 ? * *"
  }

  snapshot_count = 6

  snapshot_spec {
    description = "daily"
  }

  disk_ids = [yandex_compute_instance.nginx1.boot_disk[0].disk_id, 
              yandex_compute_instance.nginx2.boot_disk[0].disk_id, 
              yandex_compute_instance.zabbix.boot_disk[0].disk_id, 
              yandex_compute_instance.bastion.boot_disk[0].disk_id, 
              yandex_compute_instance.elk.boot_disk[0].disk_id, 
              yandex_compute_instance.kibana.boot_disk[0].disk_id, 
}
'''
![Monitoring](https://github.com/olegnazarenko92/sys-diplom/blob/main/screens/snapshots.png)
## Исправление замечания №3
(https://github.com/olegnazarenko92/sys-diplom/blob/main/corrections/script)
