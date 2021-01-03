# Docker OfficealのRustイメージを使用
FROM rust:1.43

# /todoでビルドを行う
WORKDIR /todo

# ビルドに必要なファイルをイメージにコピ
COPY Cargo.toml Cargo.toml
COPY ./src ./src
COPY ./templates ./templates

# ビルド実行
RUN cargo build --release

# パスの通った場所にインストール
RUN cargo install --path .

# コンテナ起動時にWebアプリを実行
CMD ["todo"]
