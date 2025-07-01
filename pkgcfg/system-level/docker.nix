{
  # Allows running docker without being root
  virtualisation.docker.rootless = {
    enable = true;
    setSocketVariable = true;
  };
}
