# Docker OfficealのRustイメージを使用
FROM rust:1.43

# /todoでビルドを行う
WORKDIR /todo

# Cargo.tomのみ先にイメージに追加
COPY Cargo.toml Cargo.toml

# ビルドするために何もしないソースコードを入れておく
RUN mkdir src
RUN echo "fn main(){}" > src/main.rs

# ビルド実行
RUN cargo build --release

# アプリケーションのコードをイメージにコピー
COPY ./src ./src
COPY ./templates ./templates

# 先ほどビルドした生成物のうち、アプリケーションのもののみを削除
RUN rm -f target/release/deps/todo*

# 改めてビルド実行
RUN cargo build --release

# パスの通った場所にインストール
RUN cargo install --path .

# コンテナ起動時にWebアプリを実行
CMD ["todo"]
