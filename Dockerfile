FROM python:3
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD www/requirements.txt /code/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt
COPY ./www/ /code/
