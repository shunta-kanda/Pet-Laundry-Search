FROM ruby:3.2-slim

# 1. 必要な前提パッケージをまとめてインストール
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    libvips \
    pkg-config \
    curl \
    gnupg \
    ca-certificates \
    git \
    && rm -rf /var/lib/apt/lists/*

# 2. NodeSourceのリポジトリをセットアップしてNode.jsとYarnをインストール
RUN mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && NODE_MAJOR=20 \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt-get update -qq \
    && apt-get install -y --no-install-recommends nodejs \
    && npm install --global yarn \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /myapp

# ★ package.json のみコピーして yarn install を実行する
COPY package.json ./
RUN yarn install --check-files

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# その他のアプリケーションコードをすべてコピー
COPY . /myapp

# アセットプリコンパイル時に必要なダミーの secret_key_base を環境変数として渡して実行
RUN SECRET_KEY_BASE=dummy_secret_key_base_for_assets_precompile \
    RAILS_ENV=production \
    SECRET_KEY_BASE_DUMMY=1 \
    bundle exec rails assets:precompile

# サーバー起動コマンド
CMD bundle exec rails db:migrate && bundle exec rails server -b 0.0.0.0 -p ${PORT:-10000}