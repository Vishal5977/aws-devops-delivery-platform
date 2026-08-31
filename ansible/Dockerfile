FROM python:3.12-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends openssh-client \
    && pip install --no-cache-dir ansible-core==2.17.7 \
    && rm -rf /var/lib/apt/lists/*

COPY run-playbook.sh /usr/local/bin/run-playbook
RUN chmod +x /usr/local/bin/run-playbook

WORKDIR /workspace
ENTRYPOINT ["/usr/local/bin/run-playbook"]
