{
  lib,
  buildGoModule,
  fetchFromGitHub,
}:
buildGoModule rec {
  pname = "c3-lsp";
  version = "0.4.0";
  src = fetchFromGitHub {
    owner = "pherrymason";
    repo = pname;
    tag = "v${version}";
    sha256 = "sha256-7Dmd7gjZ05WH4Og9ZkRPJKyaShBrm+i7J8eT10yshEs=";
  };
  vendorHash = "sha256-eT+Qirl0R1+di3JvXxggGK/nK9+nqw+8QEur+ldJXSc=";
  subPackages = ["cmd/lsp"];
  modRoot = "server";
  doCheck = false;
  # I use it with Zed so it should be renamed c3-lsp https://github.com/AineeJames/c3-zed/issues/1
  postInstall = ''
    # mv $out/bin/lsp $out/bin/c3-lsp
    install -Dm755 $out/bin/lsp $out/bin/c3-lsp
  '';
  meta = {
    description = "C3 language server";
    homepage = "https://github.com/pherrymason/c3-lsp";
    license = lib.licenses.gpl3;
    platforms = lib.platforms.all;
  };
}
