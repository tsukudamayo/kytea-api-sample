FROM python:3.6.9-buster

RUN mkdir -p /kytea/app
WORKDIR /kytea/app
COPY . .

RUN pip install -r requirements.txt \
    && wget http://www.phontron.com/kytea/download/kytea-0.4.7.tar.gz \
    && tar xzf kytea-0.4.7.tar.gz

WORKDIR kytea-0.4.7

RUN ./configure \
    && make \
    && make install \
    && ldconfig

RUN wget http://www.ar.media.kyoto-u.ac.jp/mori/research/topics/NER/2014-05-28-RecipeNE-sample.tar.gz \
    && tar xvf 2014-05-28-RecipeNE-sample.tar.gz

RUN mkdir -p model

WORKDIR model
RUN wget http://www.phontron.com/kytea/download/model/jp-0.4.7-1.mod.gz \
    && gzip -d jp-0.4.7-1.mod.gz

WORKDIR /kytea/app

EXPOSE 5000

CMD ["python", "kyteaapiserver.py"]
