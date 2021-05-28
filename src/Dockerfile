FROM python:3.7-alpine

WORKDIR /app

ENV FLASK_RUN_HOST=0.0.0.0

# Optimisation
RUN apk add --no-cache gcc musl-dev linux-headers

COPY requirements.txt .

RUN pip install -r requirements.txt

# Copie du docker intermediaire vers le courant
COPY . .

# Regle de "pare-feu" => on expose le port 5000 => - ports : - 5000:5000 dans le docker-compose
EXPOSE 5000

CMD ["flask", "run"]