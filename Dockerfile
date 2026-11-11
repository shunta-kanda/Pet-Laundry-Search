FROM ruby:3.2.0

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential libvips pkg-config

WORKDIR /myapp

# GemfileとGemfile.lockをコピーしてbundle installを実行
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install

# アプリケーションのコードをコピー
COPY . /myapp

# アセットプリコンパイル時に必要なダミーの secret_key_base を環境変数として渡して実行
RUN SECRET_KEY_BASE=dummy_secret_key_base_for_assets_precompile \
    RAILS_ENV=production \
    SECRET_KEY_BASE_DUMMY=1 \
    bundle exec rails assets:precompile

# サーバー起動コマンド（※起動時はRender側の Docker Command で制御するためCMDはデフォルトまたはそのまま）
CMD bundle exec rails server -b 0.0.0.0 -p ${PORT:-10000}