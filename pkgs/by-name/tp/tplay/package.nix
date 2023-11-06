{
  lib,
  pkg-config,
  openssl,
  opencv3,
  clang,
  libclang,
  ffmpeg_4,
  alsa-lib,
  fetchFromGitHub,
  rustPlatform
}:
rustPlatform.buildRustPackage rec {
  pname = "tplay";
  version = "0.45";

  src = fetchFromGitHub {
    owner = "maxcurzi";
    repo = pname;
    rev =  "v${version}";
    hash = "sha256-qt5I5rel88NWJZ6dYLCp063PfVmGTzkUUKgF3JkhLQk=";
  };

  cargoHash = "sha256-jgUKGV2Yg8+iF2wQZd1Z+QFfyJmywVTFVECUs+TK8zA=";
  #cargoLock = { lockFile = ./Cargo.lock; };
  cargoPatches = [ ./cargo.diff ];
  doCheck = false;

  buildInputs = [
    openssl.dev
    alsa-lib.dev
    libclang.lib
    ffmpeg_4.dev
    opencv3
  ];

  nativeBuildInputs = [
    pkg-config
    clang
  ];

  env.LIBCLANG_PATH = "${libclang.lib}/lib";

  meta = with lib; {
    description = "Terminal Media Player";
    homepage = "https://github.com/maxcurzi/tplay";
    platform = platforms.linux;
    license = with lib.licenses; [ mit ];
    maintainers = with maintainers; [ demine ];
  };
}
