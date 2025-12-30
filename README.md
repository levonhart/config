# Hyprland setup

## Instalando pacotes

Execute o script `install`.
Pode passar parâmetros dos pacotes de programas que quer instalar (ver diretório `scripts`).
Exemplo:
```sh
$ ./install base waybar neovim --dry-run
```

Se tiver duvida, execute com a opção `--dry-run` para ver o que será modificado.
´
## Configuração

Depois de instalar os pacotes necessários, execute o script `setup`.
```sh
$ ./setup -h
Usage: setup [-n | --dry-run] [-h | --help] [-l | --log <file>] [-u | --update]
Arguments:
    -h, --help              print help
    -l, --log <file>        set log file path
    -u, --update            replace only files that are older
    --dry-run               do a trial run with no permanent changes
```

## Acknowledgements

Alguns scripts e arquivos foram inspirados (ou retirados) de
- [ThePrimeagen/dev](https://github.com/ThePrimeagen/dev)
- [HyDE project](https://github.com/HyDE-Project/HyDE/)
- [Catppuccin](https://github.com/orgs/catppuccin/repositories)
- [Lighthaus theme](https://github.com/lighthaus-theme)
entre outras fontes.
