FROM centos:7

CMD while true; do echo "Hello World!"; sleep 1; done

ENTRYPOINT /bin/bash
