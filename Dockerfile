FROM ruby:4.0.6-slim

WORKDIR /app

RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y \
      build-essential \
      curl \
      git \
      libpq-dev \
      libvips \
      libyaml-dev \
      pkg-config \
    && rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
# Gemfile.lock と厳密に一致したインストールを強制し、ビルドの再現性を確保する。
ENV BUNDLE_FROZEN="true"
RUN bundle install

COPY . .

EXPOSE 3000

# 開発用構成では docker-compose が `.:/app` をバインドマウントするため、
# アセット（tailwindcss:build）はビルド時に焼き込んでも上書きされる。
# そのため db:prepare とアセットビルドはコンテナ起動時に実行する。
CMD ["bash", "-c", "rails db:prepare && rails tailwindcss:build && rails server -b 0.0.0.0"]
