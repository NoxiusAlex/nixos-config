{ pkgs ? import <nixpkgs> {} }:

pkgs.rustPlatform.buildRustPackage rec {
  pname = "codeforces-extractor";
  version = "0.1.1";

  doCheck = false;

  # Указываем зависимости системы
  buildInputs = with pkgs; [ openssl ];
  nativeBuildInputs = with pkgs; [ pkg-config ];

  # Исходники из GitHub
  src = pkgs.fetchFromGitHub {
    owner = "Sinedka";
    repo = pname;
    rev = "main"; # Можно заменить на конкретный коммит
    hash = "sha256-/5WKKtDdy/n+bq4RC7hOg+2ioCjiYQiYA3Gv6jTgmDU="; # замените после первой сборки
  };

  # Cargo dependencies hash
  cargoHash = "sha256-iy2E1HHsZfsyGbd8P9qITRzdPqSORfX/xeG4tXy0OlM="; # замените после первой сборки

  meta = with pkgs.lib; {
    description = "Tool to extract Codeforces problems";
    homepage = "https://github.com/yunusey/codeforces-extractor";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}

