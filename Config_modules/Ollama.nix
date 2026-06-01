{pkgs, ...}:
{
  services.ollama = {
    enable = true;
    loadModels = [
      "llama3.1:8b-instruct-q4_K_M"
    ];
    package = pkgs.ollama-cuda;
  };
}
