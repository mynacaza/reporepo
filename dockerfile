FROM python:3.12.3-slim as builder


WORKDIR /app
COPY app/ /app/
COPY pyproject.toml poetry.lock /app/


RUN python -m pip install --no-cache-dir poetry==1.8.5
RUN poetry config virtualenvs.create false
RUN poetry install --no-interaction --no-ansi --verbose
RUN rm -rf $(poetry config cache-dir)/{cache,artifacts}

EXPOSE 5000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0"]