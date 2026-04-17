FROM ruby:3.3.0

# Instalar dependências essenciais
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Configurar o diretório de trabalho
WORKDIR /app

# Instalar as gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copiar o restante do código
COPY . .

# Script para resolver o problema do server.pid do Rails
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]