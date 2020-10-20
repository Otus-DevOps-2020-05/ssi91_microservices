#!/Users/ssi/yc_dynamic_inventory/bin/python
import json

import yandexcloud
from yandex.cloud.compute.v1.instance_service_pb2 import ListInstancesRequest
from yandex.cloud.compute.v1.instance_service_pb2_grpc import InstanceServiceStub


def find_by_labels(instances, labels):

    if len(labels) == 0:
        return instances

    res = []
    for inst in instances:
        for k, v in labels.items():
            lbls = v
            if isinstance(v, str):
                lbls = [v]
            if k in inst.labels and any(inst.labels[k] == lbl for lbl in lbls):
                res.append(inst)
    return res


config = {
    'token': 'AgAAAAAQeXEvAATuwRnxd96aXED4qJEm8iUwHMg',
    'cloud_id': 'b1gkjvr337abfviqtgvo',
    'folder_id': 'b1gk3lh4l14o2l4ujhc5',
    'compute_default_zone': 'ru-central1-a'
}

sdk = yandexcloud.SDK(token=config['token'])

c = sdk.client(InstanceServiceStub)

l = c.List(ListInstancesRequest(
    folder_id=config['folder_id']
))

filtered_app_instances = find_by_labels(l.instances, {'tags': ['reddit-monolith-app']})
filtered_db_instances = find_by_labels(l.instances, {'tags': ['reddit-db']})

output_format = {
    # 'db': {
    #     'hosts': [i.network_interfaces[0].primary_v4_address.one_to_one_nat.address for i in filtered_db_instances],
    # },
    'app': {
        'hosts': [i.network_interfaces[0].primary_v4_address.one_to_one_nat.address for i in filtered_app_instances],
        # 'vars': {
        #     'db_host': filtered_db_instances[0].network_interfaces[0].primary_v4_address.address
        # }
    }
}

print(json.dumps(output_format))
