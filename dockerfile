FROM python:3.12.3-slim as builder


WORKDIR /app
COPY app/ /app/
COPY pyproject.toml poetry.lock /app/

ENV PATH="/root/.local/bin:$PATH"

RUN apt-get update && apt-get install -y curl

RUN pip install poetry
RUN poetry config virtualenvs.create false

RUN touch README.md
RUN poetry install --no-interaction --no-ansi --verbose
RUN rm -rf $(poetry config cache-dir)/{cache,artifacts}



EXPOSE 5000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0"]