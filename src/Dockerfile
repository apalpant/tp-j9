FROM python:3.7-alpine

WORKDIR /app

ENV FLASK_RUN_HOST=0.0.0.0

# Optimisation
RUN apk add --no-cache gcc musl-dev linux-headers

COPY requirements.txt .

RUN pip install -r requirements.txt

# Copie du docker intermediaire vers le courant
COPY . .

CMD ["flask", "run"]