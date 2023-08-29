output "output-ip-host" {
  value = <<OUTPUT

Application Load Balancer
external = ${yandex_alb_load_balancer.load-balancer.listener.0.endpoint.0.address.0.external_ipv4_address.0.address}

Bastion Host
internal = ${yandex_compute_instance.bastion-host.network_interface.0.ip_address}
external = ${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}

Nginx1
internal = ${yandex_compute_instance.nginx1.network_interface.0.ip_address}

Nginx2
internal = ${yandex_compute_instance.nginx2.network_interface.0.ip_address}

Zabbix
internal = ${yandex_compute_instance.zabbix.network_interface.0.ip_address}

ELK
internal = ${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

Kibana
internal = ${yandex_compute_instance.kibana.network_interface.0.ip_address}
external = ${yandex_compute_instance.kibana.network_interface.0.nat_ip_address}

OUTPUT
}

output "output-ansible-hosts" {
  value = <<OUTPUT

[bastionhost]
bastion-host ansible_host=${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address} ansible_ssh_user=mashkov

[webservers]
nginx1 ansible_host=${yandex_compute_instance.nginx1.network_interface.0.ip_address}
nginx2 ansible_host=${yandex_compute_instance.nginx2.network_interface.0.ip_address}

[zabbix]
zabbix-host ansible_host=${yandex_compute_instance.zabbix.network_interface.0.ip_address}

[elasticsearch]
elasticsearch-host ansible_host=${yandex_compute_instance.elasticsearch.network_interface.0.ip_address}

[kibana]
kibana-host ansible_host=${yandex_compute_instance.kibana.network_interface.0.ip_address}

[webservers:vars]
ansible_ssh_user=nazarenkooo
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p nazarenkooo@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[zabbix:vars]
ansible_ssh_user=nazarenkooo
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p nazarenkooo@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[elasticsearch:vars]
ansible_ssh_user=nazarenkooo
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p nazarenkooo@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

[kibana:vars]
ansible_ssh_user=nazarenkooo
ansible_ssh_common_args='-o ProxyCommand="ssh -W %h:%p nazarenkooo@${yandex_compute_instance.bastion-host.network_interface.0.nat_ip_address}"'

OUTPUT
}
