USER_NAME=ssi91

build_ui: ./src/ui/
	cd ./src/ui ;\
	USER_NAME=$(USER_NAME) bash ./docker_build.sh

build_comment: ./src/comment
	cd ./src/comment ;\
	USER_NAME=$(USER_NAME) bash ./docker_build.sh

build_post: ./src/post-py
	cd ./src/post-py ;\
	USER_NAME=$(USER_NAME) bash ./docker_build.sh

build_prometheus: ./monitoring/prometheus/prometheus.yml
	cd ./monitoring/prometheus ;\
	docker build -t $(USER_NAME)/prometheus .

build_blackbox_exporter: ./monitoring/blackbox_exporter/config.yml
	cd ./monitoring/blackbox_exporter ;\
	docker build -t $(USER_NAME)/blackbox_exporter .

build_app_services: build_comment build_ui build_post

build_monitoring_services: build_prometheus build_blackbox_exporter

push_ui:
	docker push $(USER_NAME)/ui

push_comment:
	docker push $(USER_NAME)/comment

push_post:
	docker push $(USER_NAME)/post

push_app_services: push_ui push_comment push_post

push_prometheus:
	docker push $(USER_NAME)/prometheus

push_blackbox_exporter:
	docker push $(USER_NAME)/blackbox_exporter

push_monitoring_services: push_prometheus push_blackbox_exporter

build_all: build_app_services build_monitoring_services

push_all: push_monitoring_services push_app_services
