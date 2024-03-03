FROM python:3.11-slim-buster

WORKDIR /

RUN pip3 install --upgrade pip

COPY requirements.txt requirements.txt

RUN pip3 install -r requirements.txt

COPY . ./api

CMD ["python3", "./api", "run"]