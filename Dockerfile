FROM python:3.13-slim-bookworm

RUN apt-get update
RUN apt-get -y install jq

COPY entrypoint.sh /action/entrypoint.sh
COPY autofill_description.py /action/autofill_description.py
COPY requirements.txt /action/requirements.txt

RUN pip3 install -r /action/requirements.txt

ENTRYPOINT ["/action/entrypoint.sh"]
