FROM ubuntu:20.04

# Instalação do Python e GDAL
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y python3.9 python3.9-distutils python3-pip gdal-bin libgdal-dev && \
    apt-get clean

RUN pip install GDAL

# Atualizando o pip
RUN python3.9 -m pip install --upgrade pip

# Copiando o requirements.txt
COPY requirements.txt .

# Instalando as dependências do Python
RUN python3.9 -m pip install -r requirements.txt

# Configurando variáveis de ambiente do GDAL
ENV GDAL_DATA=/usr/share/gdal

# Configurando o Jupyter sem autenticação
RUN mkdir -p /home/jovyan/.jupyter && \
    echo "c.NotebookApp.token = ''" >> /home/jovyan/.jupyter/jupyter_notebook_config.py

# Defina o comando para iniciar o JupyterLab
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]


